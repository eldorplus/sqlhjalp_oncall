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
#  Description   CRON JOB DIRECTOR FOR THE SQLHJALP MONITOR			 #
#  https://code.launchpad.net/~klarson/+junk/sqlhjalp_monitor			 #
#                                                                                #
#                                                                                # 
##################################################################################
use Cwd;
# use Sys::Hostname;
use Net::Address::IP::Local;

# Get the local system's IP address that is "en route" to "the internet" I use this for mysql permissions later. 
my $ipaddress= Net::Address::IP::Local->public;

# my $hostname = hostname;
# Cwd & Sys::Hostname are  required. If you need this installed you can use the command below 
# perl -MCPAN -e 'install Net::Address::IP::Local'

# Clear Screen and get started. 
system("clear");

print "THIS IS NOT PRODUCTION READY. UNDER DEVELOPMENT ONLY. SEE README File for concepts \n";


# INTRODUCTION 
print "Welcome to the SQLHAJLP.com Monitor script\n
Code is available at https://code.launchpad.net/~klarson/+junk/sqlhjalp_monitor \n 
This system currently uses email and txt and voice for notifications. \n 
For fast and easy txt and voice we use www.twilio.com \n
You can create a free account at www.twilio.com for testing purposes.\n 
Overall rather cheap but pricing can be found here https://www.twilio.com/voice/pricing \n 
\n\n
This script will evaluate and start the installations for the required PERL modules via cpan. \n
You will need to have valid permissions to install CPAN modules and create database a user. \n
What user this monitor is executed as is up to you. \n
Since you could want to monitor local logs, execute scripts and etc either a strong sudo user or other options will have to be considered.\n 
Since I am unsure of your current Perl installation... I will use wget to start the configuration while I build out your perl install. \n
If you do not have wget installed, please do so first. 'yum -y install wget' \n
Do you want to continue? (Y|N): 
";

my $start = <>;
chomp($start);
$start=uc($start);
if($start eq "Y"){
system("clear");

print "Great, then let us getstarted with the CPAN MODULES..... \n";
print "You will need Permission to install CPAN modules. Do you have permission and can we install the required CPAN MODULES ? (Y|N): ";
my $cpan = <>;
chomp($cpan);
$cpan=uc($cpan);





# PERL MODULES
if($cpan eq "Y"){
	system("clear");

	print "\n";
	print "Installing WWW::Twilio::TwiML\n \n ";
	`perl -MCPAN -e 'install WWW::Twilio::TwiML'`;

	print "Installing WWW::Twilio::API\n \n ";
	`perl -MCPAN -e 'install WWW::Twilio::API'`;

	print "Installing MIME::Base64\n \n ";
	`perl -MCPAN -e 'install MIME::Base64'`;

	print "Installing MIME::Entity \n \n ";
	`perl -MCPAN -e 'install MIME::Entity'`;

	print "Installing DBI\n \n ";
	`perl -MCPAN -e 'install DBI'`;

	print "Installing Net::SMTP::SSL \n \n ";
	`perl -MCPAN -e 'install Net::SMTP::SSL'`;

	print "Installing Net::SSH::Perl \n \n ";
	`perl -MCPAN -e 'install Net::SSH::Perl'`;

	print "Installing Net::FTP \n \n ";
	`perl -MCPAN -e 'install Net::FTP'`;

	print "Installing Net::SFTP \n \n ";
        `perl -MCPAN -e 'install Net::SFTP'`;	

	print "Installing HTML::Entities \n \n ";
	`perl -MCPAN -e 'install HTML::Entities'`;

	print "Installing HTML::LinkExtor \n \n ";
	`perl -MCPAN -e 'install HTML::LinkExtor'`;
	
	print "Installing LWP::Protocol::https \n \n ";
	`perl -MCPAN -e 'install LWP::Protocol::https'`;

	print "Installing URI::URL \n \n ";
	`perl -MCPAN -e 'install URI::URL'`;


}
 
system("clear"); 
# CREATE CONFIG FILE 
print "Now we must ask you some questions to help build your configuration file. \n
I will ask for SMTP HOST,USER,PASSWORD as well as twilio account information. \n 
If you do not know this information yet, you can edit the config.info file that I create later \n 
";
print "Are you ready to create the config file ? (Y|N): ";

my $config = <>;
chomp($config);

if(uc($config) eq "Y"){

	print "OK now we will proceed in building out the config file now. \n ";
	print "It could be wise to use a different database for the SQLHJALP monitor \n than what you possibly could be monitoring. Afterall you want to have your monitor up in case of trouble. \n";

	# Create the config file
	open(FILE,'+>','./config/config.info') or die $!;
	print FILE ("# THIS IS A FILE THAT IS PARSED BY ALL SCRIPTS OF THE SQLMOT SYSTEM \n");


	print "Will this application be running under HTTPS: (Y|N) ";
        my $https= <>;
        chomp($https);
        print "\n";
	if(uc($https) eq "Y"){ $https=1; } else { $https=0; }
        print FILE ("SQLMOT_HTTPS===".$https." \n");


	system("rm -f /tmp/mysql.sql");
        open(MYSQLFILE,'+>', '/tmp/mysql.sql') or die $!;
 
	print "What database host will we use for the SQLHJALP MONITOR? ie: localhost...  ";
	my $host= <>;
	chomp($host);
	print "\n"; 
	print FILE ("SQLMOT_HOST===".$host." \n");
	
        
	$hostname= Net::Address::IP::Local->public;

   

		print "Enter a new username to be used for this application: "; 
		my $username= <>;
		chomp($username);
		print "\n";
		print FILE ("SQLMOT_DB_USER===$username \n");

		print "Enter a password for $username ? ";
		my $password= <>;
		chomp($password);
		print "\n";
		print FILE ("SQLMOT_DB_PASS===$password \n");

        
		$hostname = Net::Address::IP::Local->public;

		print MYSQLFILE ("CREATE DATABASE IF NOT EXISTS sqlhjalp_monitor DEFAULT CHARACTER SET latin1;\n");
        	print MYSQLFILE ("CREATE USER '$username'\@'$hostname' IDENTIFIED BY '$password'; \n");
		print MYSQLFILE ("CREATE USER '$username'\@'$host' IDENTIFIED BY '$password'; \n");
		print MYSQLFILE ("CREATE USER '$username'\@'localhost' IDENTIFIED BY '$password'; \n");

		print MYSQLFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `sqlhjalp_monitor`.* TO '$username'\@'$hostname' IDENTIFIED BY '$password'; \n ");
		print MYSQLFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `sqlhjalp_monitor`.* TO '$username'\@'localhost' IDENTIFIED BY '$password'; \n ");
		print MYSQLFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `sqlhjalp_m
onitor`.* TO '$username'\@'$host' IDENTIFIED BY '$password';  \n");
		print MYSQLFILE ("FLUSH PRIVILEGES;");

        close (MYSQLFILE);

	print "What is the preferred Admil email Account? ";
	my $admin_email= <>;
	chomp($admin_email);
	print "\n";
	print FILE ("SQLMOT_ADMIN_EMAIL===$admin_email \n");


	print FILE ("SQLMOT_DB_DATABASE===sqlhjalp_monitor \n");
        print FILE ("SQLMOT_LOCATION_HTTP===/sqlhjalp_monitor/ \n");
        print FILE ("# THE FOLLOWING KEY IS USED TO ENCRYPT passwords. \n");
        print FILE ("# Please to change this during install. Once you enter a value, changing it will require you to update all passwords in this system. \n");
        print FILE ("# Note that the IV must match the chosen cipher's blocksize bytes in length \n");
        print FILE ("SQLMOT_KEY===sqlhjalp_monitor \n");
        print FILE ("SQLMOT_IV===8329223266731539 \n");
        print FILE ("# SMTP SERVER INFO BELOW \n");

	print "Enter your SMTP server? ";
	my $smtp_server= <>;
	chomp($smtp_server);
	print "\n";
	print FILE ("SMTP_SERVER===$smtp_server \n");

	print "Enter a SMTP Server USER NAME: ";
	my $smtp_user= <>;
	chomp($smtp_user);
	print "\n";
	print FILE ("SMTP_USER===$smtp_user \n");

	print "Enter a  SMTP Server USER PASSWORD:  ";
	my $smtp_pass= <>;
	chomp($smtp_pass);
	print "\n";
	print FILE ("SMTP_PASS===$smtp_pass \n");

	print "Do you have a www.twilio.com Account? (Y|N) ";
	my $twilio= <>;
	chomp($twilio);
	print "\n";
	print FILE ("# #www.twilio.com Account info below \n");

	if(uc($twilio) eq 'Y'){

		print "Enter your www.twilio.com ACCOUNTSID: ";
		my $twilio_id= <>;
		chomp($twilio_id);
		print "\n";
		print FILE ("ACCOUNTSID===$twilio_id \n");

		print "Enter your www.twilio.com TOKEN: ";
		my $twilio_token= <>;
		chomp($twilio_token);
		print "\n";
 		print FILE ("AUTHTOKEN===$twilio_token \n");

		print "Enter your www.twilio.com PHONE NUMBER: ";
		my $twilio_phone= <>;
		chomp($twilio_phone);
		print "\n";
		print FILE ("PHONE===$twilio_phone \n");

	} else {

		print FILE ("ACCOUNTSID===\n");
		print FILE ("AUTHTOKEN===\n");
		print FILE ("PHONE===\n");

	}

	my $leith;
	print "Would you like to install and enable Mark Leith's DB Performance procedures? \n  More information can be found here http://www.markleith.co.uk/ps_helper/ \n We will enable graphs related to these if enabled. (Y|N) ";
	$leith= <>;
	chomp($leith);
	print FILE ("# http://www.markleith.co.uk/ps_helper/ \n");

	if(uc($leith) eq 'Y'){ 
		$leith=1;
		system("rm -f /tmp/create_leith.sql");
		open(LEITHFILE,'+>', '/tmp/create_leith.sql') or die $!; 
		print "What database host will we install Mark Leith's DB Performance procedures onto? (ie: master database) ";
		my $leith_host= <>;
		chomp($leith_host);
		print "\n";
		print FILE ("LEITH_HOST===$leith_host \n");

		print "What MySQL username, we will use it for Mark Leith's DB Performance procedures? ";
		my $leith_username= <>;
		chomp($leith_username);
		print "\n";
		print FILE ("LEITH_USER===$leith_username \n");	
	
		print "What is the password for $leith_username ? ";
		my $leith_password= <>;
		chomp($leith_password);
		print "\n";
		print FILE ("LEITH_PASS===$leith_password \n");
               
		
		$hostname= Net::Address::IP::Local->public;	
 
                print LEITHFILE ("CREATE DATABASE IF NOT EXISTS ps_helper DEFAULT CHARACTER SET utf8;\n");
                print LEITHFILE ("CREATE USER '$leith_username'\@'$hostname' IDENTIFIED BY '$leith_password'; \n");
		print LEITHFILE ("CREATE USER '$leith_username'\@'localhost' IDENTIFIED BY '$leith_password'; \n");

                print LEITHFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER, CREATE TABLESPACE ON 'ps_helper'.* TO '$leith_username'\@'$hostname' IDENTIFIED BY '$leith_password';  \n");
                print LEITHFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER, CREATE TABLESPACE ON 'information_schema'.* TO '$leith_username'\@'$hostname' IDENTIFIED BY '$leith_password'; \n");
                print LEITHFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER, CREATE TABLESPACE ON 'performance_schema'.* TO '$leith_username'\@'$hostname' IDENTIFIED BY '$leith_password'; \n");
		
		print LEITHFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER, CREATE TABLESPACE ON 'ps_helper'.* TO '$leith_username'\@'localhost' IDENTIFIED BY '$leith_password';  \n");                
		print LEITHFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER, CREATE TABLESPACE ON 'information_schema'.* TO '$leith_username'\@'localhost' IDENTIFIED BY '$leith_password'; \n");                
		print LEITHFILE ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER, CREATE TABLESPACE ON 'performance_schema'.* TO '$leith_username'\@'localhost' IDENTIFIED BY '$leith_password'; \n");

		print MYSQLFILE ("FLUSH PRIVILEGES;"); 

                close (LEITHFILE);


	} else {
		$leith=0;
		my $leith_host;
		my $leith_username;
		my $leith_password;

		print FILE ("LEITH_HOST===$leith_host \n");
        	print FILE ("LEITH_USER===$leith_user \n");
        	print FILE ("LEITH_PASS===$leith_password \n");
	}	
	print "\n";
	print FILE ("LEITH===$leith \n");

}# End of config file
 close (FILE);



# LEITH MODULE is dependent on the config file module 
if($leith == 1){ 
	print "Do you want me to create the $leith_username account and database on $leith_host ? (Y|N) ";
	my $leith_create= <>;
	chomp($leith_create);
	print "\n";
	if(uc($leith_create) eq 'Y'){

		print "What database host will we install Mark Leith's DB Performance procedures onto? (ie: master database) ";
                my $leith_host= <>;
                chomp($leith_host);
                print "\n";


		print "What MySQL username, can I use to create the $leith_username account on $leith_host ? ";
		my $leith_a_username= <>;
		chomp($leith_a_username);
		print "\n";

		print "What Version of MySQL are you using with Mark Leith's DB Performance procedures? [5.5 or 5.6] \n";	    
		my $version= <>;
                chomp($version);	
		my $leith_file='ps_helper_56.sql_.txt';
		if($version == 5.5){ $leith_file='ps_helper_55.sql_.txt';  }

		print "\n Creating user.....\n";
		
		print "You will be prompted for the $leith_a_username password to create the user and grants  .....\n";
		system("mysql --host=$leith_host --user=$leith_a_username -p < /tmp/create_leith.sql ");
		#system("rm -f /tmp/create_leith.sql");
	
	 
		print "Downloading the sql and building the ps_helper database .....\n";
		system("wget http://www.markleith.co.uk/wp-content/uploads/2012/07/$version --output-document=/tmp/ps_helper.sql");

		print "You will be prompted for the $leith_a_username password to install the ps_helper database  .....\n";
		system("mysql --host=$leith_host --user=$leith_a_username -p < /tmp/ps_helper.sql");
		system("rm -f /tmp/ps_helper_56.sql_.txt");
	}
}







 
system("clear");
# JAVASCRIPT MODULE
print "The following javascript packages are required for this application. \n
By allowing me to download for you, you agree to the license provided per package.\n
Feel free to review before continuing otherwise links to all packages are in the documentation\n
http://www.mattkruse.com/javascript/calendarpopup/combined-compact/CalendarPopup.js \n
http://arshaw.com/fullcalendar/downloads/fullcalendar-1.6.0.zip\n
http://anotherraid.googlecode.com/svn-history/r190/trunk/ar/tools/inplaceselect.js \n
http://code.jquery.com/jquery-1.9.1.js\n
http://builder.jquerytools.org/v1.2.7/jquery.tools.min.js \n
http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js \n
http://script.aculo.us/dist/scriptaculous-js-1.9.0.zip \n
http://reig-email-image-generator.googlecode.com/svn-history/r2/trunk/js/jquery.selectchain.js \n
http://webfx.eae.net/download/tabpane102.zip \n
http://jpgraph.net/download/download.php?p=5 \n
\n
Can I download them for you? (Y|N) ";
my $js= <>;
chomp($js);
print "\n";

if(uc($js) eq 'Y'){

	my $location="dashboard/javascript";
	print "Downloading and unpacking the javascript files. \n";

	system("wget http://script.aculo.us/dist/scriptaculous-js-1.9.0.zip  --output-document=$location/scriptaculous-js-1.9.0.zip");
        system("cd $location/; unzip scriptaculous-js-1.9.0.zip; ln -s scriptaculous-js-1.9.0 scriptaculous; ");

        system("wget http://webfx.eae.net/download/tabpane102.zip --output-document=$location/tabpane102.zip ");
        system("cd $location/; unzip tabpane102.zip;  ln -s ./tabpane/js/tabpane.js tabpane.js;");

        system("wget http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js --output-document=$location/jquery-ui.min.js");

        system("wget http://arshaw.com/fullcalendar/downloads/fullcalendar-1.6.0.zip --output-document=$location/fullcalendar-1.6.0.zip");
        system("cd $location/; unzip fullcalendar-1.6.0.zip; ln -s ./fullcalendar-1.6.0/fullcalendar/fullcalendar.js fullcalendar.js; ln -s ./fullcalendar-1.6.0/fullcalendar/fullcalendar.min.js fullcalendar.min.js; ");

        system("wget http://code.jquery.com/jquery-1.9.1.min.js --output-document=$location/jquery-1.9.1.min.js " );
        system("wget http://code.jquery.com/jquery-1.9.1.js --output-document=$location/jquery-1.9.1.js ");
        system("wget http://builder.jquerytools.org/v1.2.7/jquery.tools.min.js  --output-document=$location/jquery.tools.min.js ");
        system("wget http://www.mattkruse.com/javascript/calendarpopup/combined-compact/CalendarPopup.js --output-document=$location/CalendarPopup.js ");
        system("wget http://anotherraid.googlecode.com/svn-history/r190/trunk/ar/tools/inplaceselect.js --output-document=$location/inplaceselect.js ");
        system("wget http://reig-email-image-generator.googlecode.com/svn-history/r2/trunk/js/jquery.selectchain.js --output-document=$location/selectchain.js ");

	system("wget http://jpgraph.net/download/download.php?p=5 --output-document=dashboard/3rd_party_software/jpgraph-3.5.0b1.tar.gz");
	system("cd dashboard/3rd_party_software/; tar -vxzf jpgraph-3.5.0b1.tar.gz; ln -s jpgraph-3.5.0b1 jpgraph; ");


	system("cd dashboard/css; ln -s ../javascript/fullcalendar-1.6.0/fullcalendar/fullcalendar.css fullcalendar.css");
	system("cd dashboard/css; ln -s ../javascript/fullcalendar-1.6.0/fullcalendar/fullcalendar.print.css fullcalendar.print.css");
	system("cd dashboard/css; ln -s ../javascript/fullcalendar-1.6.0/demos/cupertino/theme .css cupertino_theme.css");
	system("cd dashboard/css; ln -s ../javascript/tabpane/css/tab.webfx.css tab.webfx.css");

}









system("clear");
# DATABASE MODULE
 print "You must have created the configuration file module already.\n Can I create the Database user and schema now? {Y|N} ";
 my $db_process= <>;
 chomp($db_process);

 if(uc($db_process) eq 'Y'){

	print "Enter a current mysql account username, we will use it for this install only? ";
	my $a_username= <>;
	chomp($a_username);
	print "\n";


	if($host eq ''){

		print "What database host will we use? ";
		$host= <>;
		chomp($host);
		print "\n";

 	}


	print " Creating db accounts and add schema \n ";
        print "You will be prompted 3 times for the $a_username password \n";
	system("mysql --host=$host --user=$a_username  -p < /tmp/mysql.sql");
	system("mysql --host=$host --user=$a_username  -p sqlhjalp_monitor < ./sql/sqlhjalp_monitor.sql");
	system("mysql --host=$host --user=$a_username  -p sqlhjalp_monitor < /tmp/sqlhjalp_monitor_status.sql");
	system("rm -f /tmp/mysql.sql");



 }




if($https == 1){ 

print " I NEED TO ADD HTTPS INFO HERE \n";

} else {
print " I NEED TO ADD HTTP INFO HERE, if any \n";

}





 
system("clear");
# CRONTAB MODULE
print "Can I create or add to you current cron file? {Y|N} ";
my $crontab= <>;
chomp($crontab);
$crontab=uc($crontab);
if($crontab eq 'Y'){ 
	my $dir = getcwd;
	system("rm -f /tmp/crontab.file");
	system("crontab -l > /tmp/crontab.file ; ");
	system("echo '* * * * * $dir/scripts/cron_director.pl > /dev/null 2>&1' >> /tmp/crontab.file;");
	system("crontab /tmp/crontab.file");
	system("rm -f /tmp/crontab.file");
}










} else {
	print " Sorry to see you go. Maybe we work again in the future. \n ";
}



1;
