<!-- Hours of Operation -->
<!-- List of all Dining Hours at Each Location -->

<html>
<?php // Create connection
include '/users/kent/student/zarnett2/config.inc';
$conn = new mysqli($servername, $username, $password, $dbname); 
if ($conn->connect_error) { // Check connection
    die("Connection failed: " . $conn->connect_error);
}
session_start();
// Checks if the user is logged in, if not then redirect them to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}
?>
<head>
    <title>Hours of Operation</title>
    <link rel="stylesheet" type="text/css" href="../styles/hours.css">
    <link rel="stylesheet" type="text/css" href="../styles/global.css">
    <meta charset="UTF-8">
</head>
<body>
    <header>
        <p>Food In A Flash</p>
        <hr>
        <nav>
            <ul>
                <li><a href="logout.php">Log Out</a></li>
                <li><a href="locations.php">Dining Locations</a></li>
                <li><a href="hours.php">All Hours</a></li>
                <li><a href="orders.php">Previous Orders</a></li>
                <li><a href="admin.php">Admin Menu</a></li>
            </ul>
        </nav>
    </header>
    <h1>Hours of Operation</h1>

    <?php
    $sql = "SELECT 
                dl.location_name, 
                DATE_FORMAT(h.open_time, '%l:%i %p') AS neat_open_time, 
                DATE_FORMAT(h.close_time, '%l:%i %p') AS neat_close_time,
                h.day,
                h.status
            FROM dining_location AS dl
                JOIN hours AS h ON dl.location_name = h.location_name";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Setup the container
        echo "<div class=\"container center\">";
    	// output data of each row
        $prev_location_name = null;
    	while($row = $result->fetch_assoc()) {
    		//Check for new location name
            if ($row["location_name"] != $prev_location_name) {
                // Close Div upon new location
                if ($prev_location_name !== null) {
                    echo "</div>";
                }
                // Make Div for each unique location
                echo "<div class=\"option\"><h3>" . $row["location_name"] . "</h3><br>";
                $prev_location_name = $row["location_name"];
            }
            //Display hours
            if ($row["status"] == 'Open'){
                echo  "<div>" . $row["day"] . ": " . $row["neat_open_time"] . " - " . $row["neat_close_time"] . "</div>";
            } else {
                echo  "<div>" . $row["day"] . ": " . $row["status"] . "</div>";
            }
    	}
        // Close the Last Div
        if ($prev_location_name !== null) {
            echo "</div>";
        }
        
    	echo "</div>"; // close the container

    // If no results found
    } else {
        echo "0 results";
    }
    $conn->close();
    ?>

    <footer>
        <div style="height: 2em;"></div>
    </footer>

</body>
</html>
