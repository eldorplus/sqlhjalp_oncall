-- MySQL dump 10.13  Distrib 5.6.10, for Linux (i686)
--
-- Host: localhost    Database: sqlhjalp_monitor
-- ------------------------------------------------------
-- Server version	5.6.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `documentation`
--

LOCK TABLES `documentation` WRITE;
/*!40000 ALTER TABLE `documentation` DISABLE KEYS */;
INSERT INTO `documentation` VALUES (1,1.00,1,'Overview',' This is a LAMP stack monitoring application. Alterations for web servers other than APACHE on LINUX are up to you.\n\nThis application is designed for an Intranet. If you would like to place this on the public web I would recommend HTTP Password protection.\n\nThe application does the following:\n--Schedules on call rotations for users.\n--Notifications via email\n--Notifications via a phone call\n--So you do not sleep through another txt message overnight\n--Notifications via a txt message\n--Allows dynamic cron creation for dynamic monitoring options.\n--Monitor MySQL connections\n--Monitor MySQL performance\n--Monitor HTTP results\n--Monitor HTTP results\n--Monitor results via SSH command\n--Monitor results via MySQL query\n--Monitor results from shell command\n\n\nThe install.pl script is designed to install via modules. So if you need to reinstall a certain aspect you can rerun the script and just execute the desired section.\n\nTo begin: ./install.pl\n\nDocumentation is available via txt files in the docs folder, within the dashboard and also available online: https://code.launchpad.net/~klarson/+junk/sqlhjalp_monitor \n\n','2013-04-06 16:09:01'),(2,1.20,1,'Audience',' The extended audience for this software includes LAMP stack developers, administrators and MySQL DBAs or anyone who is on-call. \n\nUsers of Nagios and other notification systems could use this product as well. \n\nThe smart phone changes the world, it also changed how on-call personal are notified. \n\nIn the past, a pager was used to alert and/or awaken someone so that they could address a situation. Now with the smart phones, people get txt notifications but those can easily be missed or slept through. People can turn up the volume on their phone so a txt message would alert them but this is currently not addressed per address contact but just overall volume. This product solves that concern and will notify the on-call personal via email, txt message as well as a phone call. \n\nWith a Twilo.com account (which is free to test) and this software you can get voice notifications about a problem. This allows on-call personal to also set distinct ringtones for a call from the Twilo.com or another service number. \n\nThis software is not dependent on Twilo.com. I use this service to allow others to get up and running fast and easily. People can feel free to use wvdial to at least get a phone to alert the on-call user, or build out other voice systems. \n','2013-04-06 16:09:01'),(3,2.00,2,'Installation',' \nInstallation is handled by a prebuilt Perl script. \n\nThis script will evaluate and start the installations for the required PERL modules via cpan if you allow it. \n\nYou will need to have valid permissions to install CPAN modules and create database a users. \n\nSince I am unsure of your current Perl installation... I will use wget to start the configuration while I build out your perl install. \n\nWhat MySQL username and password is used for this monitor to execute as is up to you. I suggest a new user and password. This installation will create and grant a user for just the required database. If you need additional database permissions that is up to you.\n\nIf you do not have wget installed, please do so first. \'yum -y install wget\'\n','2013-04-06 16:09:01'),(4,2.10,2,'Configuration File',' \nThe Configuration File is referenced and parsed by PHP and PERL for related account information. \n\nIt is created by the installation script but values can be changed at any time after created. Keep in mind if you alter the encryption key or iv after it has been used those values would be invalid and have to be reentered.\n\nThis file needs to remain secure.\n\nSQLMOT_HOST===< HOST INFO HERE > # example www.sqlhjalp.com\n\nSQLMOT_DB_USER===< USERINFO HERE > # MySQL Username here \n\nSQLMOT_DB_PASS===< PASSWORD HERE > # MySQL Password here\n\nSQLMOT_ADMIN_EMAIL===< ADMIN EMAIL HERE > # Email used for notifications if required. \n\nSQLMOT_DB_DATABASE===sqlhjalp_monitor # This is the default database\n\nSQLMOT_LOCATION_HTTP===< LOCATION HERE > # Example: /sqlhjalp_monitor/ \n\n# THE FOLLOWING KEY IS USED TO ENCRYPT passwords.\n# Please to change this during install. Once you enter a value, changing it will require you to update all passwords in this system. \n# Note that the IV must match the chosen key block size bytes in length\n\nSQLMOT_KEY===< KEY HERE > # I recommend you change the default value that is put into place here before proceeding with saving username and password information in the system. These items are encrypted so would have to be reserved if this key is changed at a later date. \n\nSQLMOT_IV===< IV HERE > # I recommend you change the default value that is put into place here before proceeding with saving username and password information in the system. These items are encrypted so would have to be reserved if this IV is changed at a later date. the IV must match the chosen key block size \n\n# SMTP SERVER INFO BELOW\n\nSMTP_SERVER===< LOCATION HERE > # Example: smtp.gmail.com\n\nSMTP_USER===< LOCATION HERE > # Example: john@doe.com\n\nSMTP_PASS===< LOCATION HERE > # Example: not password\n\n# www.twilio.com Account info below\n\nACCOUNTSID===< ACCOUNTSID HERE > Example: AC0a6c105...\n\nAUTHTOKEN===< AUTHTOKEN HERE > Example: 140ef63898b...\n\nPHONE===< AUTHTOKEN HERE > Example: 15555555555 Full phone number is require for use with www.twilio.com. If you alter system to use wvdial or other methods for local calls that is up to you.\n\n# http://www.markleith.co.uk/ps_helper/ \n\nLEITH_HOST===< LEITH_HOST HERE > Example: localhost or masterhost\n\nLEITH_USER===< LEITH_USER HERE > Example: not root\n\nLEITH_PASS===< LEITH_PASS HERE > Example: not password or blank\n\nLEITH===1 # This is just an binary value to notify if LEITH is enabled or not.\n','2013-04-06 16:09:01'),(5,3.00,3,'Dashboard Overview',' \nThe Dashboard displays the current status of all active cron jobs and their status after they have ran. \n\nAt first this page will be blank. Once you create and have an active cron job running this page will give you the latest results, PASS OR FAIL. \n','2013-04-06 16:09:01'),(6,3.01,3,'Dashboard Default',' \nThe Dashboard is set as the default page of the system. While this is a blank page at the start it is default so that you will have easy access to the latest information once you log in. \n\nThis page will also auto refresh every 15 minutes. \n','2013-04-06 16:09:01'),(7,3.02,3,'Dashboard General Tab',' \nThe Dashboard General Tab is the navigational location for dashboard information. This page is for informational purposes only.\n','2013-04-06 16:09:01'),(8,3.03,3,'Dashboard Documentation Tab',' \nThe \'Dashboard\' page displays the current status of all active cron jobs. \n\nThe Tab: [General] Displays the current status of all active cron jobs. \n\nResults are displayed by CRON ID Name Status Threshold Last Ran and last Response\n\nThe Tab: [Documentation] Contains related Documentation to the Dashboard.\n','2013-04-06 16:09:01'),(9,3.04,3,'Dashboard Cron Page',' \nThe Dashboard Cron Page displays the current crons that have been created, active or inactive. \n\nThis page is made of up 3 different tabs, General, Add New Cron and Documentation.\n\n','2013-04-06 16:09:02'),(10,3.05,3,'Cron General Tab',' \nThe Tab: [General] contains cron jobs listed by ID, Name and last updated status. The cron id is a hyperlink that allows you to go to the \'details page\', more information is available on the \'details page\' documentation section.\n\n','2013-04-06 16:09:02'),(11,3.06,3,'Add New Cron Tab ',' \nThe Tab: [ADD NEW CRON] is how you create new cron jobs. Enter the desired name and select the check button. This will create the cron job and allow you to continue edits via the \'General\' tab and cron id hyperlink.\n','2013-04-06 16:09:02'),(12,3.07,3,'Cron Documentation Tab',' \nThe \'Cron Jobs\' page lists current crons created.\n\nThe Tab: [General] contains cron jobs listed by ID, Name and last updated status. The cron id is a hyperlink that allows you to go to the \'details page,\' more information is available on the \'details page\' documentation section.\n\nThe Tab: [ADD NEW CRON] is how you create new cron jobs. Enter the desired name and select the check button. This will create the cron job and allow you to continue edits via the \'General\' tab and cron id hyperlink. \n\nThe Tab: [Documentation] Contains related Documentation to the Cron jobs.\n','2013-04-06 16:09:02'),(13,3.08,3,'Cron Details ',' \nCron Details page lists current details about the cron job created. \n\nAll page contacts items that are editable per field. \n\nThe Tab: [General] contains the required information to execute the cron job as you require. \n\nThe Tab: [Command||Execute||SQL] contains documentation about the dynamic values used. \n\nThe Tab: [Documentation] Contains related Documentation to the Cron jobs.\n','2013-04-06 16:09:02'),(14,3.09,3,'Cron Details General Tab  ',' \nCron Details page lists current details about the cron job created. \n\nAll page contacts items that are editable per field. \n\nThe Tab: General contains the required information to execute the cron job as you require. \n\nThe Field: Name Is for user reference only. \n\nThe Field: Type Includes the Cron job protocol options which includes (\'HTTP\',\'HTTPS\',\'SSH\',\'MySQL\',\'WGET\',\'FTP\',\'SHELL\') or the option \'OFF\' will disable the cron job. \n\nThe Field: Domain Allows DNS reference to related the cron job. \n\nThe Field: IP Address Allows IP address reference to related the cron job.\n\nThe Field: Domain or IP Allows you to choose which reference will be used, Domain or IP .\n\nThe Field: Validate Is the value used for validation of a positive result. For example if validating a html page the reference /html could be used to show a valid page completed. \n\nThe Field: Threshold Is an integer value that represents how many times a failed cron job can fail within the Threshold Ratio before notifications are engaged.\n\nThe Field: Threshold Ratio is the allowed time range to include Threshold failures before notifications are engaged.\n\nThe Field: UserName Is the username value for required protocols, SSH , FTP , HTTPS\n\nThe Field: Password Is the password value for required protocols, SSH , FTP , HTTPS\n\nThe Field: Command||Execute||SQL Please review the Command||Execute||SQL documentation section. This field allows dynamic override and commands for cron jobs. \n\nThe Field: Cron Times These fields encompass runtimes for each cron job. These values are based on crontab values. \n','2013-04-06 16:09:02'),(15,3.10,3,'Cron Details Extras Tab',' \n\nAdditional options are available via the Command||Execute||SQL section. \nBelow are some examples.\nAlways separate items with === and newline for each item.\n\nFTP variable examples and overrides\nPORT===21\nPASSIVE===1\nCWD===/home/username\nDEBUG===1\n\nMySQL variable examples and overrides\nPORT===3306\nDATABASE===test\nQUERY===SELECT 1 as value\n\nSSH variable examples and overrides\nPORT===22\nDEBUG===1\nCOMMAND===/tmp/script_with_result.sh\n','2013-04-06 16:09:02'),(16,3.11,3,'Cron Details Documentation Tab ',' \nThe \'Cron Jobs\' Details page lists current details about the cron job created. \n\nThe Tab: [General] contains the required information to execute the cron job as you require. \n\nThe Tab: [Command||Execute||SQL] contains documentation about the dynamic values used. \n\nThe Tab: [Documentation] Contains related Documentation to the Cron jobs.\n\nThe Field: [Name] Is for user reference only. \n\nThe Field: [Type] Includes the Cron job protocol options which includes (\'HTTP\',\'HTTPS\',\'SSH\',\'MySQL\',\'WGET\',\'FTP\',\'SHELL\') or the option \'OFF\' will disable the cron job. \n\nThe Field: [Domain] Allows DNS reference to related the cron job. \n\nThe Field: [IP Address] Allows IP address reference to related the cron job.\n\nThe Field: [Domain or IP] Allows you to choose which reference will be used, Domain or IP .\n\nThe Field: [Validate] Is the value used for validation of a positive result. For example if validating a html page the reference /html could be used to show a valid page completed. \n\nThe Field: [Threshold] Is an integer value that represents how many times a failed cron job can fail within the Threshold Ratio before notifications are engaged.\n\nThe Field: [Threshold Ratio] is the allowed time range to include Threshold failures before notifications are engaged.\n\nThe Field: [UserName] Is the username value for required protocols, SSH , FTP , HTTPS\n\nThe Field: [Password] Is the password value for required protocols, SSH , FTP , HTTPS\n\nThe Field: [Command||Execute||SQL] Please review the Command||Execute||SQL documentation section. This field allows dynamic override and commands for cron jobs. \n\nThe Field: [Cron Times] These fields encompass runtimes for each cron job. These values are based on crontab values. \n','2013-04-06 16:09:02'),(17,3.12,3,'Contacts Page ',' \nThe \'Contacts\' page lists current contacts. \n\nAll contacts are then made available for on-call status under the Schedule Page. \n\nThe Tab: General contains contact used for notifications. They are listed by ID, Email, Name and last updated status. \n\nThe id is a hyperlink that allows you to go to the \'details page,\' more information is available on the \'details page\' documentation section.\n\nThe Tab: ADD NEW CONTACT is how you create new contact. Enter the desired email and select the check button. This will create a new contact and allow you to continue edits via the \'General\' tab and contacts id hyperlink. \n\nThe Tab: Documentation Contains related Documentation to contacts.\n','2013-04-06 16:09:02'),(18,3.13,3,'Contacts General Tab',' \nThe Tab: General contains contact used for notifications. They are listed by ID, Email, Name and last updated status. \n\nThe id is a hyperlink that allows you to go to the \'Contact details page,\' more information is available on the \'details page\' documentation section.\n','2013-04-06 16:09:02'),(19,3.14,3,'Add New Contact',' \nThe Tab: ADD NEW CONTACT is how you create new contact. Enter the desired email and select the check button. This will create a new contact and allow you to continue edits via the \'General\' tab and contacts id hyperlink. \n','2013-04-06 16:09:02'),(20,3.15,3,'Contacts Documentation Tab   ',' \nThe \'Contacts\' page lists current contacts.\n\nThe Tab: [General] contains contact used for notifications. They are listed by ID, Email, Name and last updated status. \n\nThe id is a hyperlink that allows you to go to the \'details page,\' more information is available on the \'details page\' documentation section.\n\nThe Tab: [ADD NEW CONTACT] is how you create new contact. Enter the desired email and select the check button. This will create a new contact and allow you to continue edits via the \'General\' tab and contacts id hyperlink. \n\nThe Tab: [Documentation] Contains related Documentation to contacts.\n','2013-04-06 16:09:02'),(21,3.16,3,'Contacts Details Page',' \nThe \'Contacts Details\' page lists current contact information.\n\nThe Tab: [General] contains contact information available for edit. Each field is editable dynamically. \n\nThe Tab: [Documentation] Contains related Documentation to contacts. \n','2013-04-06 16:09:02'),(22,3.17,3,'Contacts Details General Tab',' \nThe Tab: [General] contains contact information available for edit. Each field is editable dynamically. \n\nThe Field: Email Is non editable. \n\nThe Field: First Name Is editable.\n\nThe Field: Last Name Is editable.\n\nThe Field: Mobile Phone Number Is the full phone number use for voice notifications. \nAn example is : 13035555555\n\nThe Field: Mobile Email Domain Can be used for SMS messages. Since we are currently using Twilio.com they can handle the SMS for us. If you override Twilio.com use can use your mobile phone and this field for SMS emails. \n','2013-04-06 16:09:02'),(23,3.18,3,'Contacts Details Documentation Tab',' \nThe \'Contacts Details\' page lists current contact information.\n\nThe Tab: [General] contains contact information available for edit. Each field is editable dynamically. \n\nThe Field: Email Is non editable. \n\nThe Field: First Name Is editable.\n\nThe Field: Last Name Is editable.\n\nThe Field: Mobile Phone Number Is the full phone number use for voice notifications. \nAn example is : 13035555555\n\nThe Field: Mobile Email Domain Can be used for SMS messages. Since we are currently using Twilio.com they can handle the SMS for us. If you override Twilio.com use can use your mobile phone and this field for SMS emails. \n\nThe Tab: Documentation Contains related Documentation to contacts.\n','2013-04-06 16:09:02'),(24,3.19,3,'Schedule Page ',' \n\nThe Tab: [General] Displays the calendar and on call contacts. \n\nThe Tab: [Add event] Allows you to add a contact for on call status during a given time range.\n\nThe Tab: [Documentation] Contains related Documentation to the Schedule. \n','2013-04-06 16:09:02'),(25,3.20,3,'Schedule General Tab',' \n\nThe Tab: [General] Displays the calendar and on call contacts. \n\n','2013-04-06 16:09:03'),(26,3.21,3,'Schedule Add New Event ',' \n\nThe Tab: [Add event] Allows you to add a contact for on call status during a given time range. \n\nThe Field: Contact Allows you to select a contact name. \n\nThe Field: Start Date Is the start date for a given event or on call period.\n\nThe Field: End Date Is the end date for a given event or on call period.\n\nThe Field: Primary Contact Allows you to designate a contact as the primary contact. Notifications will contact this person first. \n\n','2013-04-06 16:09:03'),(27,3.22,3,'Schedule Documentation',' \nThe \'Schedule\' page displays a calendar and the ability to add new on call contacts to the calendar. \n\nThe Tab: [General] Displays the calendar and on call contacts. \n\nTo Add a new contact select on an empty day or double click on a populate day. \nA box will open for you to enter the following information: \n\nThe Field: Contact Allows you to select a contact name. \n\nThe Field: Start Date Is the start date for a given event or on call period.\n\nThe Field: End Date Is the end date for a given event or on call period.\n\nThe Field: Primary Contact Allows you to designate a contact as the primary contact. Notifications will contact this person first. \n\nTo Edit an event \n\nSelect the name of event \nYou can then change the contact name of the user.\n\nTo Delete an event \n\nSelect the name of event \nYou can then select to delete the selected event and will have to confirm this choice. \n\nThe Tab: [Documentation] Contains related Documentation to the Schedule.\n Contact Allows you to designate a contact as the primary contact. Notifications will contact this person first. \n\n','2013-04-18 15:49:09'),(28,3.23,3,'History Page',' \nThe \'History\' page displays the history of all previous cron jobs. \n\nThe Tab: [General] Displays the history of all previous cron jobs. History is displayed by CRON ID Name Status and Last Ran \n\nThe Tab: [Documentation] Contains related Documentation to the History.\n\n','2013-04-06 16:09:03'),(29,3.24,3,'History General Tab',' \nThe Tab: [General] Displays the history of all previous cron jobs. History is displayed by CRON ID Name Status and Last Ran \n\n','2013-04-06 16:09:03'),(30,3.25,3,'History Documentation Tab ',' \nThe \'History\' page displays the history of all previous cron jobs. \n\nThe Tab: [General] Displays the history of all previous cron jobs. History is displayed by CRON ID Name Status and Last Ran \n\nThe Tab: [Documentation] Contains related Documentation to the History.\n','2013-04-06 16:09:03'),(31,3.26,3,'Database Page ',' \nThe \'Database Details\' page displays information related to the given databases. \n\nThe Tab: [General] Displays the current important MySQL Variables. If the variable event_scheduler is OFF documentation to enable will be displayed. \n\nThe Tab: [Graphs] Displays graphical historical recommendations for Innodb Log File Size and the Innodb Buffer Pool Size.\n\nThe Tab: [Mark Leith\'s pshelper] If enabled display MySQL information derived from Mark Leith\'s DB Performance procedures. ','2013-04-06 16:09:03'),(32,3.27,3,'Database General Tab',' \nThe \'Database Details\' page displays information related to the given databases. \n\nThe Tab: [General] Displays the current important MySQL Variables. If the variable event_scheduler is OFF documentation to enable will be displayed. \n','2013-04-06 16:09:03'),(33,3.28,3,'Database Graphs Tab ',' \nThe Tab: [Graphs] Displays graphical historical recommendations for Innodb Log File Size and the Innodb Buffer Pool Size.\n','2013-04-06 16:09:03'),(34,3.29,3,'Database PS Helper Tab ',' \nThe \'Mark Leith\'s pshelper tab displays information related to the enabled procedures. \n\nMore information available here http://www.markleith.co.uk/ps_helper/\n\nThe Tab: [Top Global Consumers by Total Latency Displays] the top wait classes by total latency.\n\nThe Tab: [Top Global Consumers by Average Latency] Displays the top wait classes by average latency.\n\nThe Tab: [Statements with runtimes in 95th%] Displays the top 10 statements who\'s average runtime, in microseconds, is in the top 95th percentile.\n\nThe Tab: [Statements with Full Table Scans] Displays the top 10 normalized statements that use have done a full table scan ordered by the percentage of times a full scan was done, then by the number of times the statement executed.\n\nThe Tab: [Top IO by Thread] Displays the top IO consumers by thread, ordered by total latency.\n\nThe Tab: Documentation Contains related Documentation to the Mark Leith\'s pshelper.\n','2013-04-06 16:09:03'),(35,3.30,3,'Database Documentation Tab',' \nThe \'Database Details\' page displays information related to the given databases. \n\nThe Tab: [General] Displays the current important MySQL Variables. If the variable event_scheduler is OFF documentation to enable will be displayed. \n\nThe Tab: [Graphs] Displays graphical historical recommendations for Innodb Log File Size and the Innodb Buffer Pool Size.\n\nThe Tab: [Mark Leith\'s pshelper] If enabled display MySQL information derived from Mark Leith\'s DB Performance procedures. \n\nMore information is available at http://www.markleith.co.uk/ps_helper/\n\nAdditional documentation available under the Mark Leith\'s pshelper documentation tab.\n\nThe Tab: Documentation Contains related Documentation to the Mark Leith\'s pshelper.\n','2013-04-06 16:09:04'),(36,4.00,4,'Javascript Files','\nThe following javascript packages are used with this application.\nBy allowing me to download them for you, you agree to the license provided per package via their website.\n\nAll rights are maintained by the package author. \n','2013-04-06 16:50:10'),(37,4.10,4,'CalendarPopup.js','\nCalendar Popup files and documentation is available via: \n \nhttp://www.mattkruse.com/javascript/calendarpopup/\n','2013-04-06 16:47:59'),(38,4.20,4,'FullCalendar','\n\nFullCalendar files and documentation is available via:\n\nhttp://arshaw.com/fullcalendar/\n\n','2013-04-06 16:47:59'),(39,4.30,4,'inplaceselect.js','\nIs available via http://anotherraid.googlecode.com/svn-history/r190/trunk/ar/tools/\n','2013-04-06 16:47:59'),(40,4.40,4,'Jquery-1.9.1.js','\njQuery code files and documentation is available via:\nhttp://code.jquery.com/ \n','2013-04-06 16:47:59'),(41,4.50,4,'Jquery.tools.min.js','\njQuery code files and documentation is available via:\nhttp://code.jquery.com/ \n','2013-04-06 16:47:59'),(42,4.60,4,'Jquery-ui.js ','\njQuery code files and documentation is available via:\nhttp://code.jquery.com/ \n','2013-04-06 16:47:59'),(43,4.70,4,'Scriptaculous','\nScriptaculous code files and documentation is available via:\nhttp://script.aculo.us/\n','2013-04-06 16:47:59'),(44,4.80,4,'Jquery.selectchain.js','\nCode files and documentation is available via:\nhttp://remysharp.com/2007/09/18/auto-populate-multiple-select-boxes/\n','2013-04-06 16:47:59'),(45,4.90,4,'Tabpane 1.02','\nCode files and documentation is available via:\nhttp://webfx.eae.net/dhtml/tabpane/tabpane.html\n','2013-04-06 16:47:59'),(46,5.00,5,'CSS Files','\n\nCSS Files are either custom built or referenced via javascript packages. \nAll rights are maintained by the package author. \n\n','2013-04-06 16:53:27'),(47,5.01,5,'layout.css','\nThis is a CSS file developed by Keith Larson of sqlhjalp.com. \n','2013-04-06 16:53:27'),(48,5.02,5,'sqlhjalp.css','\nThis is a CSS file developed by Keith Larson of sqlhjalp.com.  \nNo Longer Used.\n','2013-04-06 16:53:27'),(49,5.03,5,'cupertino_theme.css','\nThis is a CSS file developed via the javascript package  http://jqueryui.com\n','2013-04-06 16:53:27'),(50,5.04,5,'fullcalendar.css','\nThis is a CSS file developed via the javascript package  http://arshaw.com/fullcalendar/\n\n','2013-04-06 16:53:27'),(51,5.05,5,'tab.webfx.css','\nThis is a CSS file developed via the javascript package  http://webfx.eae.net/dhtml/tabpane/tabpane.html\n','2013-04-06 16:53:27'),(52,6.00,6,'Perl Scripts Overview','\n\nThe Perl scripts used by the SQLHJALP Monitor \n\nThe Perl scripts include:\n\ncron_director.pl\ncron_monitor_ftp.pl\ncron_monitor_http.pl\ncron_monitor_https.pl\ncron_monitor_mysql.pl\ncron_monitor.pl\ncron_monitor_shell.pl\ncron_monitor_ssh.pl\ncrons_sql.pm\ndatabase_connection.pl\ndb_cron_error.pm\ndb_cron_update.pm\nsmtp_email.pm\ntwilio.pm\n\n','2013-04-06 19:28:58'),(53,6.01,6,'Cron Director ','The Cron Director (cron_director.pl) file is executed via the system crontab. \n\nThis script will review all of the active monitor application cron jobs. \nThe script will then execute the related protocol script to evaluate for Pass or Failure based on job settings. \n\nThe script will also then execute the cron_monitor.pl for notifications. \n\n\n\n','2013-04-06 19:28:58'),(54,6.02,6,'Cron Monitor','\nThe Cron Monitor (cron_monitor.pl) evaluates the latest failed status within the given dynamic time ranges. \n\nIf it finds that notifications are in order it will use the smtp_email.pm and twilio.pm for notifications. \n\nThis script uses the Net::SMTP::SSL and WWW::Twilio::API\n\n','2013-04-06 19:28:58'),(55,6.03,6,'Cron FTP Checks ','\n\nThe cron_monitor_ftp.pl file will check ftp status of a given site. \nYou can set additional settings via the following variables via the Command||Execute||SQL field:\n\nPORT===21\nPASSIVE===1\nCWD===/home/foobar\nDEBUG===1\n\nThis script uses the Net::FTP module\n\n','2013-04-06 19:28:58'),(56,6.04,6,'Cron HTTP Checks','\nThe cron_monitor_http.pl script takes given domain or ip address information to validate if the site is active. \n\nThe entire URL string can be placed in either of those fields. \n\nDo not place http:// that is added. \n\nThis script uses the LWP::UserAgent , LWP::RobotUA , HTML::LinkExtor and URI::URL modules. \n\n\n','2013-04-06 19:28:58'),(57,6.05,6,'Cron HTTPS Checks','\nThe cron_monitor_https.pl script checks a url much like the cron_monitor_http.pl\n\nDo not place https:// that is added. \n\nIf a username and password is given the site will add this into the url. \n\nThis script uses the LWP::Protocol::https , LWP::UserAgent , LWP::RobotUA , HTML::LinkExtor and URI::URL modules. \n\n','2013-04-06 19:28:58'),(58,6.07,6,'Cron MySQL Checks ','\n\nThe cron_monitor_mysql.pl script is dependent on the additional options allowed via the Command||Execute||SQL field:\n\nYou can set override the PORT if needed\nPORT===3306\n\nOtherwise the database and query used is set via these options\n\nDATABASE===test \nQUERY===SELECT 1\n\nThe host is set by the domain or ip fields. \n\nThis script uses the DBI:mysql module.\n\n','2013-04-06 19:28:58'),(59,6.08,6,'Cron SSH Checks ','\n\nThe cron_monitor_ssh.pl will execute whatever command is given via the Command||Execute||SQL with the COMMAND variable on the given host.\n\nExample COMMAND===/tmp/test.sh \n\nThe username and password are required for this script unless ssh keys are already enabled. \n\nOverride options allowed via the Command||Execute||SQL field:\nDEBUG===1\nPORT===\n\nThis script uses the Net::SSH::Perl Modules\n\n','2013-04-06 19:28:58'),(60,6.09,6,'Cron Shell Checks','\n\nThe cron_monitor_shell.pl will execute what ever command is in the  Command||Execute||SQL field on the localhost. \n\nThis script uses the  Cwd module.\n\n','2013-04-06 19:28:58'),(61,6.10,6,'Crons SQL','\n\nThe crons_sql.pm is a subroutine query that is used across all or most of these perl scripts to gather cron jobs. \n\nMIME::Base64 is used for password decryption. \n','2013-04-06 19:28:59'),(62,6.11,6,'DB Cron Update ','\n\nThe db_cron_update.pm is a subroutine that is used by many of the scripts and updates cron status in the sqlmot_cron_history and sqlmot_dashboard tables. \n\n','2013-04-06 19:28:59'),(63,6.12,6,'DB Cron Error','\n\nThe db_cron_error.pm is a subroutine that is used by many of the scripts and updates cron status in the sqlmot_cron_failed_response , sqlmot_cron_history and sqlmot_dashboard tables.  \n\n','2013-04-06 19:28:59'),(64,6.13,6,'SMTP Email','\n\nThe smtp_email.pm is a subroutine that uses Net::SMTP::SSL to process mail notifications. \n\n\n','2013-04-06 19:28:59'),(65,6.14,6,'Twilo','\n\n\nThe twilio.pm is a subroutine that uses the WWW::Twilio::API for notifications started via the cron_monitor.pl script. \n\n\n\n','2013-04-06 19:28:59'),(66,7.00,7,'PHP Overview','\n\nThe monitor dashboard and user interface is built with a couple of PHP classes, html files, CSS , Javascript and an index.php file. \n\nconfig_parse_class.php\ngraphs.php\nindex.php\nsqlmot_class.php\nsqlmot_pages_class.php\n\nhtml_files/\ncontacts_details.html\ncontacts.html\ncron_details.html\ncrons.html\ndashboard_details.html\ndashboard.html\ndatabase.html\ndocumentation.html\nhistory.html\nschedule.html ','2013-04-06 19:56:00'),(67,7.01,7,'index.php','\n\nThe index.php handles all input from the site. \nThis script engages the class files and handles POST information.. \n\n\n','2013-04-06 19:56:13'),(68,7.03,7,'config_parse_class','\n\nThe config_parse_class.php parses the config.info file to set variables within the class files. \n\n\n','2013-04-06 19:56:13'),(69,7.04,7,'sqlmot_class','\n\nThe sqlmot_class.php is the primary class file. This handles all the AJAX and API calls. \nThe header and footer information as well as page case statement is within this. \nThis file also contains the query_db function which organizes all database query interactions. \n\n','2013-04-06 19:56:13'),(70,7.05,7,'sqlmot_pages_class','\n\nThe sqlmot_pages_class.php extends the sqlmot_class.php class for use within the HTML pages. \n\nMySQL queries can be found here that are related to the different specific html pages. \n\n\n','2013-04-06 19:56:13'),(71,7.06,7,'graphs','\n\nThe graphs.php file uses the jpgraph  package from http://jpgraph.net. \nThis package is downloaded at installation time and installed. \nCode and documentation is available via the http://jpgraph.net site. \nTheir documentation is also available after download under your dashboard directory. \nExample - /dashboard/3rd_party_software/jpgraph/docs/\n\n','2013-04-06 19:56:14'),(72,8.00,8,'MySQL Stored Procedures','\n\nThe monitoring application uses the following Stored Procedures:\n\n[day_of_month] This procedure is used to quickly populate the jquery/ajax select box for month values in cron times\n[day_of_week]  This procedure is used to quickly populate the jquery/ajax select box for day of the week values in cron times\n[hour]  This procedure is used to quickly populate the jquery/ajax select box for hour values in cron times\n[minutes] This procedure is used to quickly populate the jquery/ajax select box for minutes values in cron times\n[month] This procedure is used to quickly populate the jquery/ajax select box for month values in cron times\n[innodb_buffer_pool_size] This procedure is called via events to keep a history of recommended buffer pool size hourly, results are available on the graphs tab under databases.\n[innodb_log_file_size]  This procedure is called via events to keep a history of recommended log file size hourly, results are available on the graphs tab under databases.\n \nMark Leith\'s performance procedures are documented here http://www.markleith.co.uk/ps_helper/\n','2013-04-06 20:14:04'),(73,8.10,8,'MySQL Events','\n\nTwo recurring events used by the sqlhjalp monitor. \n\nThe innodb_buffer_pool_size  and the innodb_log_file_size events call the related procedures. \n\nTo enable events you set the variable via SET GLOBAL event_scheduler=ON;\n\n','2013-04-06 20:14:20'),(74,8.20,8,'MySQL Triggers ','\n\nCurrently the monitor is only utilizing one trigger to ensure the cron times table is updated when a new cron is created. \n\nTo see triggers; mysql> show triggers G\n\n','2013-04-06 21:09:21'),(75,8.30,8,'MySQL Performance','\n\nOptimizing your MySQL performance is dependent on numerous things. The databases page help gather data and recommendations for you evaluate. \n\nThe Mark Leith\'s performance procedures help you evaluate options. \n\nRecommend my.cnf edits can be done or checked against the my.cnf created via the Pecona tools at tools.percona.com\n\n','2013-04-06 20:14:20'),(77,8.40,8,'MySQL Events Scheduler','The MySQL Events Scheduler is required to be enabled. \n\nTo enable this you set the variable via SET GLOBAL event_scheduler=ON;\n\nThis is required for the related EVENTS which active stored routines. ','2013-04-06 16:33:56'),(78,6.15,6,'Database Connection','\n\nThe database_connection.pl script uses the DBI module for the MySQL Connections. \n\nAll Database information ( HOST, USERNAME , PASSWORD ) is parsed from the config.info file.  \n\n','2013-04-06 19:40:36');
/*!40000 ALTER TABLE `documentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'PASS','green'),(2,'FAILED','red'),(3,'CAUTION','yellow');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-18 18:07:48
