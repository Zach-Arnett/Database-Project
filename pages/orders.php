<!-- User Orders -->
<!-- List all orders of a given user -->

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
    <title>Orders</title>
    <link rel="stylesheet" type="text/css" href="../styles/orders.css">
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

    <h1>Orders</h1>

    <?php
    // Obtain info of customer's previous orders
    $customerID = $_SESSION["customer_ID"];
    $sql = $conn->prepare("SELECT p.customer_ID, oi.order_ID, oi.order_number, oi.ME_order, fb.location_name, co.item_name, co.quantity, fi.cost
            FROM places AS p
                JOIN order_info AS oi ON oi.order_ID = p.order_ID
                JOIN fulfilled_by AS fb ON oi.order_ID = fb.order_ID
                JOIN consists_of AS co ON oi.order_ID = co.order_ID
                JOIN food_items AS fi ON co.item_name = fi.item_name
            WHERE p.customer_ID = ?
            ORDER BY oi.order_ID DESC");
    $sql->bind_param("i", $customerID); // Insert variables into above statement
    $sql->execute();// Execute the query
    $result = $sql->get_result(); //return the results
    $sql->close();

    $totalCost = 0;
    if ($result->num_rows > 0) {
        // Setup the container
        echo "<div class=\"container center\">";
            // output data of each row
            $prev_order = null;
            while($row = $result->fetch_assoc()) {
                //Check for new order
                if ($row["order_ID"] != $prev_order) {
                    // Close Div upon new order (Skips first check)
                    if ($prev_order !== null) {
                        // Close previous option
                        if(!$orderME){
                            echo "<h3>Total: $" . $totalCost . "</h3>";
                        } else {
                            echo "<h3>Meal Exchange</h3>";
                        }
                        $totalCost = 0;
                        $orderME = $row["ME_order"];
                        echo "</div>";
                    } else {
                        $orderME = $row["ME_order"];
                    }
                    // Make Div for each unique Item
                    echo "<div class=\"option\">";
                    echo "<h3>" . $row["location_name"] . "</h3>";
                    echo "<h3>" . $row["order_number"] . "</h3>";
                    echo $row["item_name"] . " (x" . $row["quantity"] . ")<br>";
                    if(!$orderME){
                        echo "$" . $row["cost"] . "<br>";
                    }
                    //echo "------------------------------- CORRECT NUMBER HERE: " . $row["ME_order"] . "<br>";
                    $prev_order = $row["order_ID"];
                } else {
                    echo $row["item_name"] . " (x" . $row["quantity"] . ")<br>";
                    if(!$orderME){
                        echo "$" . $row["cost"] . "<br>";
                    }
                }
                $totalCost += ($row['cost'] * $row['quantity']);
            }
            //Close last option
            if(!$orderME){
                echo "<h3>Total: $" . $totalCost . "</h3>";
            }  else {
                echo "<h3>Meal Exchange</h3>";
            }
            echo "</div>";
        echo "</div>";  // close the container
    } else {
        echo "<h2>No Orders Found</h2>";
    }





    $conn->close();
    ?>

    <footer>
        <div style="height: 2em;"></div>
    </footer>
</body>
</html>
