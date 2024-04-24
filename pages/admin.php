<!-- Admin Menu -->
<!-- Administrative menu to easily query and alter the database -->

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
    <title>Admin Menu</title>
    <link rel="stylesheet" type="text/css" href="../styles/admin.css">
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

    <h1>Administrator Menu</h1>
    

    <!-- Form Submission Checks -->
    <!-- Come First Due to Order of Operations -->
    <?php
        // Form Feedback
        if (isset($_SESSION["feedback"])) {
            echo "<h3>" . $_SESSION["feedback"] . "</h3>";
            unset($_SESSION["feedback"]);
        }

        //Add New Item
        if (isset($_POST["I_submitted"]) && !empty($_POST["I_name"])) {
            // Get all Dining Locations
            $dlquery = "SELECT location_name FROM dining_location";
            $diningLocations = $conn->query($dlquery);
            // Get all Ingredients
            $ingredientQuery = "SELECT ingredient_name FROM ingredients";
            $ingredients = $conn->query($ingredientQuery);

            // SQL Statement to add item
            $itemName = $_POST['I_name']; // Get name from the form
            $itemCost = $_POST['I_cost']; // Get cost from the form
            $itemType = $_POST['I_type']; // Get type from the form
            $mealExchange = isset($_POST['I_meal_exchange']) ? 1 : 0; // Get ME status from form (T/F)
            $sqlstatement = $conn->prepare("INSERT INTO food_items (item_name, cost, item_type, ME_item) VALUES (?, ?, ?, ?)"); // Prepare the statement
            $sqlstatement->bind_param("sdsi", $itemName, $itemCost, $itemType, $mealExchange); // Insert variables into above statement
            if($sqlstatement->execute()){ // Execute the query, checking if it is successful
                if ($sqlstatement->affected_rows > 0) { // Check if any rows were affected
                    // Add item 
                    // Handle selected ingredients
                    $ingredients = $conn->query($ingredientQuery);
                    while($row = $ingredients->fetch_assoc()) {
                        $currentIngredient = ($row["ingredient_name"]);
                        if (isset($_POST["I_" . urlencode($currentIngredient)])) { //Check if current ingredient is selected
                            $sql = $conn->prepare("INSERT INTO contains (item_name, ingredient_name) VALUES (?, ?)"); // Prepare the statement
                            $sql->bind_param("ss", $itemName, $currentIngredient); // Insert variables into above statement
                            $sql->execute(); // Execute the query
                        }
                    }
                    // Handle selected locations
                    $diningLocations = $conn->query($dlquery);
                    while($row = $diningLocations->fetch_assoc()) {
                        $currentLocation = ($row["location_name"]);
                        if (isset($_POST["I_" . urlencode($currentLocation)])) { //Check if current location is selected
                            $sql = $conn->prepare("INSERT INTO offers (location_name, item_name) VALUES (?, ?)"); // Prepare the statement
                            $sql->bind_param("ss", $currentLocation, $itemName); // Insert variables into above statement
                            $sql->execute(); // Execute the query
                        }
                    }
                    // Feedback on item added
                    $_SESSION["feedback"] = "\"$itemName\" successfully added";

                } else {
                    $_SESSION["feedback"] = "Error adding: \"$itemName\"";
                }
            } else { // Unsuccessful query
                $_SESSION["feedback"] =  "Error adding \"$itemName\"";
            }
            header("Refresh:0;url=admin.php");
        }

        // Delete Food Item
        if (isset($_POST["I_deleted"])) {
            // SQL Statement to delete item
            $food_item = $_POST['delete_item'];
            $sqlstatement = $conn->prepare("DELETE FROM food_items WHERE item_name = ?"); // Prepare the statement
            $sqlstatement->bind_param("s", $food_item); // Insert variables into above statement
            $sqlstatement->execute(); // Execute the query
            if ($sqlstatement->affected_rows > 0) { // Check if any rows were affected
                $_SESSION["feedback"] =  "\"$food_item\" deleted successfully";
            } else {
                $_SESSION["feedback"] =  "Error deleting \"$food_item\"";
            }
            header("Refresh:0;url=admin.php");
        }

        // Add Ingredient
        if(isset($_POST["ing_submitted"])){
            $ingredientName = $_POST['ing_name'];
            $sqlstatement = $conn->prepare("INSERT INTO ingredients VALUES (?)");
            $sqlstatement->bind_param("s", $ingredientName);
            if($sqlstatement->execute()){
                if ($sqlstatement->affected_rows > 0) { 
                    // Handle selected allergens
                    $allergenQuery = "SELECT DISTINCT allergen FROM allergens ORDER BY allergen ASC";
                    $allergens = $conn->query($allergenQuery);
                    while($row = $allergens->fetch_assoc()) {
                        $currentAllergen = ($row["allergen"]);
                        if (isset($_POST["ing_" . urlencode($currentAllergen)])) { //Check if current ingredient is selected
                            $sql = $conn->prepare("INSERT INTO allergens VALUES (?, ?)"); // Prepare the statement
                            $sql->bind_param("ss", $ingredientName, $currentAllergen); // Insert variables into above statement
                            $sql->execute(); // Execute the query
                        }
                    }
                    // Feedback on item added
                    $_SESSION["feedback"] =  "\"$ingredientName\" Successfully Added";
                } else {
                    $_SESSION["feedback"] =  "Error Adding: \"$ingredientName\"";
                }
            } else {
                $_SESSION["feedback"] =  "Error Adding: \"$ingredientName\"";
            }
            header("Refresh:0;url=admin.php");
        }

        // Delete Ingredient
        if (isset($_POST["ing_deleted"])) {
            // SQL Statement to delete item
            $ingredient = $_POST['delete_ingredient'];
            $sqlstatement = $conn->prepare("DELETE FROM ingredients WHERE ingredient_name = ?");
            $sqlstatement->bind_param("s", $ingredient);
            $sqlstatement->execute();
            if ($sqlstatement->affected_rows > 0) {
                $_SESSION["feedback"] =  "Ingredient \"$ingredient\" deleted successfully";
            } else {
                $_SESSION["feedback"] =  "Error deleting ingredient \"$ingredient\"";
            }
            header("Refresh:0;url=admin.php");
        }

        // Add Dining Location
        function addLocationDay($locationName, $day) { // Function to add status and hours to a location for a given day
            global $conn;
            $dayLower = strtolower($day);
            if(isset($_POST[$dayLower . "_closed"])){
                $status = "Closed";
                $openTime = NULL;
                $closeTime = NULL;
            } else {
                $status = "Open";
                $openTime = $_POST[$dayLower . "_open_time"];
                $closeTime = $_POST[$dayLower . "_close_time"];
            }
            $sqlstatement = $conn->prepare("INSERT INTO hours VALUES (?, ?, ?, ?, ?)");
            $sqlstatement->bind_param("sssss", $locationName, $day, $status, $openTime, $closeTime);
            $sqlstatement->execute();
        }
        if(isset($_POST["location_submitted"])){
            $locationName = $_POST['location_name'];
            $locationME = isset($_POST['location_ME']) ? 1 : 0;
            $sql = $conn->prepare("INSERT INTO dining_location VALUES (?, ?)");
            $sql->bind_param("si", $locationName, $locationME);
            if($sql->execute()){
                if ($sql->affected_rows > 0) { 
                    addLocationDay($locationName, "Sunday");
                    addLocationDay($locationName, "Monday");
                    addLocationDay($locationName, "Tuesday");
                    addLocationDay($locationName, "Wednesday");
                    addLocationDay($locationName, "Thursday");
                    addLocationDay($locationName, "Friday");
                    addLocationDay($locationName, "Saturday");
                    // Feedback on item added
                    $_SESSION["feedback"] =  "\"$locationName\" Successfully Added";
                } else {
                    $_SESSION["feedback"] =  "Error Adding: \"$locationName\"";
                }
            } else {
                $_SESSION["feedback"] =  "Error Adding: \"$locationName\"";
            }
            header("Refresh:0;url=admin.php");
        }
    ?>


    <!-- Forms -->
    <div class="container center">
        <!-- Add New Item -->
        <div class="option">
            <h3>Add New Food Item:</h3><br>
            <?php 
            
            // Get all Dining Locations
            $dlquery = "SELECT location_name FROM dining_location";
            $diningLocations = $conn->query($dlquery);
            // Get all Ingredients
            $ingredientQuery = "SELECT ingredient_name FROM ingredients";
            $ingredients = $conn->query($ingredientQuery);

            // This part is confusing because the from formats weird
            echo "<div class=\"add-items\">";
                echo "<div class=\"add-item-col\">"; // First Column
                    echo "<form method=post>"; // Form start
                        echo "<h4>Enter Item Details:</h4>";
	            	    echo "Item Name: <input type=text name=\"I_name\" required><br>";
                        echo "Cost: <input type=number step=0.01 name=\"I_cost\"><br>";
                        echo "Type: <select name=\"I_type\">";
                            echo "<option value=\"Main\">Main</option>";
                            echo "<option value=\"Side\">Side</option>";
                            echo "<option value=\"Drink\">Drink</option>";
                        echo "</select><br>";
                        echo "<input type=checkbox name=\"I_meal_exchange\">Meal Exhange Item?";
                echo "</div>";
                echo "<div class=\"add-item-col\">"; // Second Column
                        if ($ingredients->num_rows > 0) {
                            echo "<h4>Select Ingredients:</h4>";
                            echo "<div class=\"scroll-box\">";
                            while($row = $ingredients->fetch_assoc()) {
                                echo "<input type=checkbox name=\"I_" . urlencode($row["ingredient_name"]) . "\">" . $row["ingredient_name"] . "<br>";
                            }
                            echo "</div>";
                        }  
                echo "</div>";
                echo "<div class=\"add-item-col\">"; // Third Column
                        if ($diningLocations->num_rows > 0) {
                            echo "<h4>Select Locations:</h4>";
                            echo "<div class=\"scroll-box\">";
                            while($row = $diningLocations->fetch_assoc()) {
                                echo "<input type=checkbox name=\"I_" . urlencode($row["location_name"]) . "\">" . $row["location_name"] . "<br>";
                            }
                            echo "</div>";
                        }  
                echo "</div>";
                    
            echo "</div>";
                        echo "<br><input class=\"submit-button\" type=submit value=\"Submit\"><br>"; // Submit Button
                        echo "<input type=\"hidden\" name=\"I_submitted\" value=1 >";
                    echo "</form>"; // Form end
            ?>
        </div>

        <!-- Delete Food Item -->
        <div class="option">
            <h3>Delete Food Item:</h3><br>
            <?php 
            // Create Form with all food items
            $sql = "SELECT item_name FROM food_items";
            $result = $conn->query($sql);
            echo "<form method=post style=\"width: 100%;\">";
            echo "<select name=\"delete_item\">";
            echo "<option value=\"\">Select an Option</option>";
            while($row = $result->fetch_assoc()) {
                echo "<option value=\"" . $row['item_name'] . "\">" . $row['item_name'] . "</option>";
            }
            echo "</select><br><br>";
            echo "<input class=\"submit-button\" type=\"submit\" value=\"Submit\">";
            echo "<input type=\"hidden\" name=\"I_deleted\" value=\"1\" >";
            echo "</form>";
            ?>
        </div>

        <!-- Add Ingredient -->
        <div class="option">
            <h3>Add Ingredient:</h3><br>
            <?php

            $allergenQuery = "SELECT DISTINCT allergen FROM allergens ORDER BY allergen ASC";
            $allergens = $conn->query($allergenQuery);

            echo "<form method=post style=\"width: 100%;\">";
	            echo "Ingredient Name: <input type=text name=\"ing_name\" required><br><br>";
                //echo "Allergens (optional): <input type=text name=\"ing_allergen\"><br>";
                if ($diningLocations->num_rows > 0) {
                    echo "Select Allergens";
                    echo "<div class=\"scroll-box center\" style=\"width: 25%; height: 7em;\">";
                    while($row = $allergens->fetch_assoc()) {
                        echo "<input type=checkbox name=\"ing_" . urlencode($row["allergen"]) . "\">" . $row["allergen"] . "<br>";
                    }
                    echo "</div>";
                }  
                echo "<br><input class=\"submit-button\" type=submit value=\"Submit\"><br>";
                echo "<input type=\"hidden\" name=\"ing_submitted\" value=1 >";
            echo "</form>";
            ?>
        </div>

        <!-- Delete Ingredient -->
        <div class="option">
            <h3>Delete Ingredient:</h3><br>
            <?php
            // Create Form with all ingredients
            $sql = "SELECT ingredient_name FROM ingredients";
            $result = $conn->query($sql);
            echo "<form method=post style=\"width: 100%;\">";
            echo "<select name=\"delete_ingredient\">";
            echo "<option value=\"\">Select an Option</option>";
            while($row = $result->fetch_assoc()) {
                echo "<option value=\"" . $row['ingredient_name'] . "\">" . $row['ingredient_name'] . "</option>";
            }
            echo "</select><br><br>";
            echo "<input class=\"submit-button\" type=\"submit\" value=\"Submit\">";
            echo "<input type=\"hidden\" name=\"ing_deleted\" value=\"1\" >";
            echo "</form>";
            ?>
        </div>

        <!-- Add Dining Location -->
        <div class="option">
            <h3>Add Dining Location:</h3><br>
            <form method="post" style="width: 100%;">
                    Location Name: <input type="text" name="location_name" maxlength="50" required><br>
                    <input type=checkbox name="location_ME">Meal Exhange Location?<br><br>
                <table class="center">
                    <tr>
                        <td><h4>Day</h4></td>
                        <td><h4>Closed?</h4></td>
                        <td><h4>Open Time</h4></td>
                        <td><h4>Close Time</h4></td>
                    </tr>
                        <td>Sunday</td>
                        <td><input type="checkbox" name="sunday_closed"></td>
                        <td><input type="time" name="sunday_open_time" value="00:00"></td>
                        <td><input type="time" name="sunday_close_time" value="00:00"></td>
                    </tr>
                    </tr>
                        <td>Monday</td>
                        <td><input type="checkbox" name="monday_closed"></td>
                        <td><input type="time" name="monday_open_time" value="00:00"></td>
                        <td><input type="time" name="monday_close_time" value="00:00"></td>
                    </tr>
                    </tr>
                        <td>Tuesday</td>
                        <td><input type="checkbox" name="tuesday_closed"></td>
                        <td><input type="time" name="tuesday_open_time" value="00:00"></td>
                        <td><input type="time" name="tuesday_close_time" value="00:00"></td>
                    </tr>
                    </tr>
                        <td>Wednesday</td>
                        <td><input type="checkbox" name="wednesday_closed"></td>
                        <td><input type="time" name="wednesday_open_time" value="00:00"></td>
                        <td><input type="time" name="wednesday_close_time" value="00:00"></td>
                    </tr>
                    </tr>
                        <td>Thursday</td>
                        <td><input type="checkbox" name="thursday_closed"></td>
                        <td><input type="time" name="thursday_open_time" value="00:00"></td>
                        <td><input type="time" name="thursday_close_time" value="00:00"></td>
                    </tr>
                    </tr>
                        <td>Friday</td>
                        <td><input type="checkbox" name="friday_closed"></td>
                        <td><input type="time" name="friday_open_time" value="00:00"></td>
                        <td><input type="time" name="friday_close_time" value="00:00"></td>
                    </tr>
                    </tr>
                        <td>Saturday</td>
                        <td><input type="checkbox" name="saturday_closed"></td>
                        <td><input type="time" name="saturday_open_time" value="00:00"></td>
                        <td><input type="time" name="saturday_close_time" value="00:00"></td>
                    </tr>
                </table><br>
                <input class="submit-button" type="submit" value="Submit">
                <input type="hidden" name="location_submitted" value="1">
            </form>
        </div>
    </div>

    <footer>
        <div style="height: 2em;"></div>
    </footer>
    <script src="../scripts/admin.js"></script>
</body>
</html>
