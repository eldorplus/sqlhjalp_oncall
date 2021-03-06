#!/usr/bin/perl
##################################################################################
#                                                                                #
#  Copyright (c) 2013, SQLHJALP.com All rights reserved.                         #
#                                                                                #
#  This program is free software; you can redistribute it and/or modify          #
#  it under the terms of the GNU General Public License as published by          #
#  the Free Software Foundation; version 2 of the License.                       #
#                                                                                #
#  This program is distributed in the hope that it will be useful,               #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of                #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 #
#  GNU General Public License for more details.                                  #
#                                                                                #
#  You should have received a copy of the GNU General Public License             #
#  along with this program; if not, write to the Free Software                   #
#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA      #
#                                                                                #
#  Programmer    Keith Larson                                                    #
#  Description   CRON JOB SSH Validation FOR THE SQLHJALP MONITOR	 	 #
#  https://github.com/keithlarson/sqlhjalp_oncall                                #
#                                                                                #
#                                                                                # 
##################################################################################
# MODULES 
use Net::SSH::Perl;
use File::Basename;
my ($dir) = $0 =~ m|^(/.+)/scripts/| ? $1 : "./";
$dir=$dir."/scripts/";



# REQUIREMENTS 
require "$dir/database_connection.pl" or die $!;
require "$dir/crons_sql.pm" or die $!;
require "$dir/db_cron_error.pm" or die $!;
require "$dir/db_cron_update.pm" or die $!;

# DEFINE VARIABLES
	my $database_handle = db();
	my $id = $ARGV[0];  
	my $code = "";
	my $content = "";
	my $ssh_string="";
	my $status_id=3;	
	my $hostname;
	my $debug=0;
	my $command_a;
	my $port=22;

	#Gather Cron information
	my %crons_ar = crons_sql_idtype($database_handle,'SSH',$id);	


	if($crons_ar{domain_ip} eq "ip"){
		$hostname=$crons_ar{ip_address};
	}else {
		$hostname=$crons_ar{domain};
	}



        my @command_array = split('\n',$crons_ar{command});
        foreach my $c (@command_array){

                my @key_val_array = split('===',$c);

                if($key_val_array[0] eq "DEBUG"){ $debug=$key_val_array[1];  }
                if($key_val_array[0] eq "COMMAND"){ $command_a=$key_val_array[1];  }
		if($key_val_array[0] eq "PORT"){ $port=$key_val_array[1];  }
           
        }


	my $ssh = Net::SSH::Perl->new($hostname, debug=>$debug , port => $port );
	$ssh->login($crons_ar{username},$crons_ar{password});
	my ($stdout,$stderr,$exit) = $ssh->cmd( $command_a );
#	print $stdout;



	if($content =~ m/$crons_ar{validate}/gs){ $status_id=1; } else { $status_id=2; } 


	if($status_id != 1) {
                db_cron_error($database_handle,$crons_ar{cron_id},2," $stdout  ");
        } else{
                db_cron_update($database_handle,$crons_ar{cron_id},$status_id);
        }


	
# Disconnect the primary db 
$database_handle->disconnect;
 
1;

