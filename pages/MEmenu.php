<!-- ME Food Menu -->
<!-- List of all food items (with ingredients) at a given location -->

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
    <title>Food Menu</title>
    <link rel="stylesheet" type="text/css" href="../styles/menu.css">
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

    <?php
    unset($_SESSION['order_number']);
    $_SESSION['ME'] = true;

    // Clear Cart
    if (isset($_POST['clear_cart'])) {
        unset($_SESSION['cart']);
    }
    // Create Cart
    if(isset($_POST['add_item'])) {
        $addItemName = $_POST['add_item'];
        
        // Check if product already exists in cart
        if(isset($_SESSION['cart'][$addItemName])) {
            // If yes, clear cart and return to start
            unset($_SESSION['cart']);
            header("Refresh:0;url=MEmenu.php");
        } else {
            // If not, add product to cart
            $_SESSION['cart'][$addItemName] = array('quantity' => 1,);
        }
    }

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
        echo "<h1>$location</h1>";
    } else {
        echo "<h1>No location found</h1>";
        $location = null;
    }

    // Display specified Location's menu with ingredients and allergens
    $sqlstatement = $conn->prepare(
        "SELECT dl.location_name, fi.item_name, fi.item_type, i.ingredient_name, a.allergen
        FROM dining_location AS dl
            JOIN offers AS o ON dl.location_name = o.location_name
            JOIN food_items AS fi ON o.item_name = fi.item_name
            LEFT JOIN contains AS c ON c.item_name = o.item_name
            LEFT JOIN ingredients AS i ON i.ingredient_name = c.ingredient_name
            LEFT JOIN allergens AS a ON a.ingredient_name = i.ingredient_name
        WHERE dl.location_name = ?
        AND fi.ME_item = true");
    $sqlstatement->bind_param("s", $location); // Insert variables into above statement
    $sqlstatement->execute(); // Execute the query
    $result = $sqlstatement->get_result(); //return the results
    $sqlstatement->close();
    
    // Sort the items into arrays by type
    $mainItems = array();
    $sideItems = array();
    $drinkItems = array();
    while ($row = $result->fetch_assoc()) {
        switch ($row['item_type']) {
            case 'Main':
                $mainItems[] = $row;
                break;
            case 'Side':
                $sideItems[] = $row;
                break;
            case 'Drink':
                $drinkItems[] = $row;
                break;
            default:
                break;
        }
    }


    // Function to output the given items with "add to order" button
    function outputItems($items){
        if (count($items) > 0) {
            // Setup the container
            echo "<div class=\"container\">";
                $itemType = $items[0]["item_type"];
                // output data of each row
                $previousItem = null;
                foreach ($items as $item) {
                    //Check for new item name
                    if ($item["item_name"] != $previousItem) {
                        if($previousAllergen !== NULL){
                            echo ")<br>"; // Close previous allergens
                        }
                        // Close Div upon new Item (Skips first check)
                        if ($previousItem !== null) {
                            echo "</div>";
                            // Add to Order Button
                            echo "<form class=\"button-row\" method=\"post\">";
                                echo "<input class=\"option-button\" type=\"submit\" value=\"Add to Order\">";
                                echo "<input type=\"hidden\" name=\"add_item\" value=\"$previousItem\">";
                                echo "<input type=\"hidden\" name=\"prev_type\" value=\"$itemType\">";
                            echo "</form>";
                            // Close previous option
                            echo "</div>";
                        }
                        // Make Div for each unique Item
                        echo "<div class=\"option\"><h3>" . $item["item_name"] . "</h3>";
                        echo "<button class=\"ingredient-toggle\">Ingredients</button>";
                        echo "<div style=\"width: 100%; margin-bottom: 0.6em;\" class=\"hidden\">";
                        $previousItem = $item["item_name"];
                        $newItem = True;
                        echo "<hr class=\"ingredient-hr\">";
                    }
                    // Handle displaying ingredients and allergens
                    $currentIngredient = $item["ingredient_name"];
                    $currentAllergen = $item["allergen"];
                    if($currentIngredient !== NULL){
                        if($currentIngredient != $previousIngredient && !$newItem){
                            if($previousAllergen !== NULL){
                                echo ")<br>"; // Close previous allergens
                            }
                            if ($currentAllergen !== NULL){ 
                                echo "$currentIngredient ($currentAllergen"; // New ingredient with allergens
                            } else {
                                echo "$currentIngredient<br>"; // New ingredient with no allergens 
                            }
                        } elseif($currentAllergen !== NULL && !$newItem){
                            echo ", $currentAllergen"; // Continued ingredient with new allergen
                        } elseif($newItem){
                            if ($currentAllergen !== NULL){ 
                                echo "$currentIngredient ($currentAllergen"; // New item, new ingredient, allergens
                            } else {
                                echo "$currentIngredient<br>"; // New Item, new ingredient, no allergens 
                            }
                        } 
                    } else {
                        echo "No Ingredients Found<br>";
                    }
                    $newItem = false;
                    $previousIngredient = $currentIngredient;
                    $previousAllergen = $currentAllergen;
                }
                //Close last option
                if($previousAllergen !== NULL){
                    echo ")<br>"; // Close last allergen
                }
                echo "</div>";
                echo "<form class=\"button-row\" method=\"post\">";
                    echo "<input class=\"option-button\" type=\"submit\" value=\"Add to Order\">";
                    echo "<input type=\"hidden\" name=\"add_item\" value=\"$previousItem\">";
                    echo "<input type=\"hidden\" name=\"prev_type\" value=\"$itemType\">";
                echo "</form>";
                echo "</div>";
            echo "</div>";  // close the container
        } else {
            echo "<h2>No Meal Exchange Items Found</h2>"; 
        }
    }
    
    //Start Displaying Menu
    echo "<div class=\"container-row center\">";
        if ($result->num_rows > 0) {
            // Output all items at selected location
            echo "<div class=\"output-types\">";
                if ($_POST["prev_type"] == NULL) {
                    echo "<h2>Select a Main Item</h2>";
                    outputItems($mainItems);
                }
                if ($_POST["prev_type"] == "Main") {
                    echo "<h2>Select a Side</h2>";
                    outputItems($sideItems);
                }
                if ($_POST["prev_type"] == "Side") {
                    echo "<h2>Select a Drink</h2>";
                    outputItems($drinkItems);
                }
                if ($_POST["prev_type"] == "Drink") {
                    echo "<h2>Please Review Order</h2>";
                }
            echo "</div>";
        // If no results found
        } else {
            echo "<h2 class=\"center\">No Meal Exchange Items Found</h2>";
        }

        // Display Cart
        echo "<div class=\"cart-area\">";
            echo "<h3>Current Order</h3>";
            if (!empty($_SESSION['cart'])) {
                // Clear Cart Button
                echo "<form method=\"post\">";
                    echo "<button class=\"clear-button\" type=\"submit\" name=\"clear_cart\">Clear Order</button>";
                echo "</form>";
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
                        echo "</div>";
                    }
                }
                if ($_POST["prev_type"] == "Drink") {
                    echo "<button class=\"checkout-button\" onclick=\"location.href='https://dbdev.cs.kent.edu/~zarnett2/Database-Project/pages/purchase.php'\">Checkout</button>";
                }
            } else {
                echo "Your cart is empty";
            }
        echo "</div>";
    echo "</div>"; // End Menu Display

    $conn->close();
    ?>

    <footer>
        <div style="height: 2em;"></div>
    </footer>
    <script src="../scripts/menu.js"></script>
</body>
</html>
