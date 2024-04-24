<!-- Purchase Screen -->
<!-- Allow the user to review and finalize purchase -->

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
    <title>Purchase</title>
    <link rel="stylesheet" type="text/css" href="../styles/purchase.css">
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

    <h1>Purchase</h1>
    <?php
    // Display Location Name
    $location = $_SESSION['location'];
    $sqlstatement = $conn->prepare("SELECT location_name FROM dining_location WHERE location_name = ?"); // Prepare the statement
    $sqlstatement->bind_param("s", $location); // Insert variables into above statement
    $sqlstatement->execute(); // Execute the query
    $result = $sqlstatement->get_result(); //return the results
    $sqlstatement->close();
    if($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $location = $row['location_name'];
        echo "<h3 class=\"center\">$location</h3>";
    } else {
        echo "<h1>No location found</h1>";
        $location = null;
    }

    // Generate random order number
    $randomNumber = $_SESSION['order_number'];
    if(!isset($_SESSION['order_number'])){
        $randomNumber = mt_rand(0, 999);
        $randomNumber = str_pad($randomNumber, 3, '0', STR_PAD_LEFT);
        $_SESSION['order_number'] = $randomNumber;
    }

    // Calculate the total cost
    $totalCost = 0;
    if (!empty($_SESSION['cart'])) {
        foreach ($_SESSION['cart'] as $itemName => $item) {
            // Fetch product details from the database using item name
            $sqlstatement = $conn->prepare("SELECT * FROM food_items WHERE item_name = ?");
            $sqlstatement->bind_param("s", $itemName);
            $sqlstatement->execute();
            $result = $sqlstatement->get_result();
        
            // Calculate the total cost for this item
            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $totalCost += ($row['cost'] * $item['quantity']);
            }
        }
    }

    // Display Cart
    echo "<div class=\"cart-area center\">";
        echo "<h3>Order</h3>";
        if(!$_SESSION['ME']){
            echo "<h3>Total: $$totalCost</h3>";
        }
        if (!empty($_SESSION['cart'])) {
            $itemNames = array_keys($_SESSION['cart']); // Get the item names from the cart
            sort($itemNames); // Sort the item names alphabetically
            foreach ($itemNames as $itemName) {
                // Get item details from the database
                $sqlstatement = $conn->prepare("SELECT * FROM food_items WHERE item_name = ?");
                $sqlstatement->bind_param("s", $itemName);
                $sqlstatement->execute();
                $result = $sqlstatement->get_result();
            
                // Output item information
                if($result->num_rows > 0) {
                    $row = $result->fetch_assoc();
                    echo "<div class=\"option\">";
                        echo "<h4>" . $row['item_name'] . " (x" . $_SESSION['cart'][$itemName]['quantity'] . ")</h4>";
                        if(!$_SESSION['ME']){
                            echo "$" . $row['cost'] . "<br>";
                        }
                    echo "</div>";
                }
            }
            if ($_SESSION['ME']){
                // Meal Exchange Purchase Button
                echo "<div class=\"option-button center\" id=\"ME-order-button\">Meal Exchange</div>";
            } else { 
                // Other Purchase Options
                echo "<div class=\"option-button center\" id=\"DB-order-button\">Declining Balance</div>";
                echo "<div class=\"option-button center\" id=\"CR-order-button\">Credit / Debit</div>";
            }
        } else {
            echo "Your cart is empty";
        }   
        // Place order button
    echo "</div>";
    ?>

    <footer>
        <div style="height: 2em;"></div>
    </footer>
    
    <?php
    // Handle pressing "Continue" button after ordering
    if (isset($_POST['place_order'])) {
        $orderME = $_SESSION['ME'];

        // Record Order in Database
        $sql = $conn->prepare("INSERT INTO order_info (order_number, ME_order) VALUES (?, ?)"); // Prepare the statement
        $sql->bind_param("si", $randomNumber, $orderME); // Insert variables into above statement
        $sql->execute(); // Execute the statement

        // Get generated order ID 
        $orderID = $conn->insert_id;
        // Get customer ID (Must be an existing customer ID)
        $customerID = $_SESSION["customer_ID"];

        $sql = $conn->prepare("INSERT INTO places VALUES (?, ?)"); // Prepare the statement
        $sql->bind_param("ii", $customerID, $orderID); // Insert variables into above statement
        $sql->execute(); // Execute the statement

        $sql = $conn->prepare("INSERT INTO fulfilled_by VALUES (?, ?)"); // Prepare the statement
        $sql->bind_param("is", $orderID, $location); // Insert variables into above statement
        $sql->execute(); // Execute the statement

        foreach ($_SESSION['cart'] as $itemName => $item) {
            // Fetch product details from the database using item name
            $sqlstatement = $conn->prepare("SELECT * FROM food_items WHERE item_name = ?");
            $sqlstatement->bind_param("s", $itemName);
            $sqlstatement->execute();
            $result = $sqlstatement->get_result();
        
            // Add each item to the order
            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $currentItemName = $row['item_name'];
                $currentItemQuantity = $item['quantity'];

                $sql = $conn->prepare("INSERT INTO consists_of VALUES (?, ?, ?)"); // Prepare the statement
                $sql->bind_param("isi", $orderID, $currentItemName, $currentItemQuantity); // Insert variables into above statement
                $sql->execute(); // Execute the statement
            }
        }

        //Redirect User
        header("Location: ../pages/locations.php");
    }

    // Confirmation menu for orders
    echo "<div class=\"screen-darken hidden\" id=\"confirmation-menu\">";
        echo "<div class=\"order-confirmation\">";
            echo "<div class=\"confirmation-text\" id=\"complete\">";
                echo "Order Confirmed<br>";
                echo "<p style=\"font-size: 0.5em; margin: 0;\">$location</p>";
                echo "<p style=\"font-size: 1.5em; margin: 0;\">$randomNumber</p>"; 
                echo "<form class=\"button-row\" method=\"post\">";
                    echo "<input class=\"continue-button\" type=\"submit\" value=\"Continue\">";
                    echo "<input type=\"hidden\" name=\"place_order\" value=1>";
                echo "</form>";
            echo "</div>";
        echo "</div>";
    echo "</div>";

    // Form for credit/debit
    echo "<div class=\"screen-darken hidden\" id=\"credit-form\">";
        echo "<div class=\"payment-info\">";
            echo "Name on Card: <br><input type=text><br>";
            echo "Card Number: <br><input type=text><br>";
            echo "Expiration Date: <br><input type=text><br>";
            echo "Security Code: <br><input type=text><br>";
            echo "ZIP/Postal Code: <br><input type=text><br>";
            echo "<div class=\"option-button center\" id=\"submit-info\">Submit</div>";
        echo "</div>";
    echo "</div>";
    ?>

    <script src="../scripts/purchase.js"></script>
</body>
</html>
