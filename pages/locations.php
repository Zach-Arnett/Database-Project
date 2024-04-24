<!-- Dining Locations -->
<!-- List of Dining Locations and their current hours -->
<!-- Access through https://dbdev.cs.kent.edu/~zarnett2/Database-Project/pages/locations.php -->


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
    <title>Dining Locations</title>
    <link rel="stylesheet" type="text/css" href="../styles/locations.css">
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
    <h1>Dining Locations</h1>


    <?php // this line starts PHP Code

    // Clear cart 
    unset($_SESSION['cart']);
    unset($_SESSION['order_number']);
    unset($_SESSION['location']);

    // Redirect user to location's menu
    if(isset($_POST["ME_location_selected"])){
        $_SESSION['location'] = $_POST["ME_location_selected"];
        header("Location: ../pages/MEmenu.php");
    }
    if(isset($_POST["location_selected"])){
        $_SESSION['location'] = $_POST["location_selected"];
        header("Location: ../pages/menu.php");
    }

    // Get Current Day + Interval Days (0 for today)
    $sqlstatement = "SELECT DAYNAME(NOW() + INTERVAL 0 DAY) AS current_day";
    $result = $conn->query($sqlstatement);
    $row = $result->fetch_assoc();
    $current_day = $row["current_day"];
    // Get Dining Locations and their current status and times 
    $sqlstatement = "SELECT
                dl.location_name, 
                dl.ME_location,
                DATE_FORMAT(h.open_time, '%l:%i %p') AS neat_open_time, 
                DATE_FORMAT(h.close_time, '%l:%i %p') AS neat_close_time,
                h.status
            FROM dining_location AS dl
                JOIN hours AS h ON dl.location_name = h.location_name
            WHERE h.day = '" . $current_day . "'";
    $result = $conn->query($sqlstatement);
    if ($result->num_rows > 0) {
        // Setup the container for each option
        echo "<div class=\"container center\">";
    	    // output data of each row as an option
    	    while($row = $result->fetch_assoc()) {
                $location = $row["location_name"];
                if ($row["status"] == 'Open'){ // If location open
                    echo "<div class=\"option\">";
                    echo "<h3>" . $location . "</h3>";
                    echo "Today's Hours: " . $row["neat_open_time"] . " - " . $row["neat_close_time"];
                    // Buttons to select location and payment type
                    echo "<div class=\"button-row\">";
                        // Meal Exchange 
                        if($row["ME_location"]){
                            echo "<form method=\"post\">";
                                echo "<input class=\"option-button\" type=\"submit\" value=\"Meal Exchange\">";
                                echo "<input type=\"hidden\" name=\"ME_location_selected\" value=\"$location\">";
                            echo "</form>";
                        }
                        // Declining Balance / Credit / Debit
                        echo "<form method=\"post\">";
                            echo "<input class=\"option-button\" type=\"submit\" value=\"Declining Balance / Credit\">";
                            echo "<input type=\"hidden\" name=\"location_selected\" value=\"$location\">";
                        echo "</form>";
                    echo "</div>";
                } else { // If location closed
                    echo "<div class=\"closed-option\">";
                    echo "<h3>" . $location . "</h3>";
                    echo "Closed Today";
                }
                // Purchase option buttons
            echo "</div>";
    	    }
    	echo "</div>"; // close the container
    } else { // If no dining locations found
        echo "<h1>No Dining Locations Found</h1>";
    }
    $conn->close();

    ?> <!-- end of php code -->

    <footer>
        <div style="height: 2em;"></div>
    </footer>

</body>
</html>
