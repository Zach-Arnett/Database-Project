# Database Project - Food In a Flash
## Importing the database
1) Log in to https://dbdev.cs.kent.edu/phpMyAdmin/ <br>
    Or access through SSH: <br>
    a) open command line <br>
    b) type ssh (flashlineUsername)@dbdev.cs.kent.edu <br>
    c) type flashline password <br>
    c) type mysql FLASHLINEUSERNAME -p <br>
3) Drop all previous tables in your database
4) Open the directory Database-Project/sql/ <br>
5) Import `menu-ddl.sql` <br>
6) Import `menu-dml.sql` <br>

## Uploading Files to DBDev to be hosted
1) Download Filezilla (You can also use SSH but it's way more tedious)
2) Connect to DBDev <br>
   Host:     dbdev.cs.kent.edu <br>
   Username: (flashlineUsername) <br>
   Password: (flashlinePassword) <br>
   Port:     22 <br>
3) in the directory of your username, add a config file named `config.inc` <br>
    Once added, the file should be located at (flashlineUsername)/config.inc <br>
    The config file should be the following (replace X with your flashline username, and Y with your PHPMyAdmin password) <br>
```
<?php
$servername = "localhost";
$username = "X";
$password = "Y";
$dbname = "X";
?>
```
4) in public_html, import the whole folder Database-Project <br>
    Once added, the directory should be located at (flashlineUsername)/public_html/Database-Project <br>

## Accessing the Project
1) In order to access the project with your instances of the files, go to: <br>
    https://dbdev.cs.kent.edu/~(flashlineUsername)/Database-Project/pages/login.php <br>
    Example) https://dbdev.cs.kent.edu/~zarnett2/Database-Project/pages/login.php <br>

## Fixing "Permission Denied" Error
1) Open your Command Prompt <br>
2) Enter "ssh (flashlineUsername)@dbdev.cs.kent.edu" <br>
    a) Enter your password <br>
3) Enter "chmod +x $HOME" <br>
4) Enter "chmod 755 public_html" <br>

The permission issues should now be fixed. <br>
