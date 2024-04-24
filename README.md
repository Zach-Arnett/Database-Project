# Database Project - Food In a Flash
## Importing the database
1) Log in to https://dbdev.cs.kent.edu/phpMyAdmin/
    a) open command line
    b) type ssh yourFlashlineUsername@dbdev.cs.kent.edu
    c) type flashline password
    c) type mysql FLASHLINEUSERNAME -p
3) Drop all previous tables in your databse
4) Import menu-ddl.sql
5) Import menu-dml.sql

## Uploading Files to DBDev to be hosted
1) Download Filezilla (You can also just use SSH but it's way more tedious)
2) Connect to DBDev
   Host:     dbdev.cs.kent.edu
   Username: (your kent username)
   Password: (your kent password)
   Port:     22
3) in the directory of your username, add a config file named config.inc
   The config file should be the following where X is your kent username and Y is your PHPMyAdmin password
```
<?php
$servername = "localhost";
$username = "X";
$password = "Y";
$dbname = "X";
?>
```
4) in public_html, import the whole folder Database-Project


