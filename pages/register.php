<!-- TEST Register Page -->
<!-- Create New User -->

<html>
<?php // Create connection
include '/users/kent/student/zarnett2/config.inc';
$conn = new mysqli($servername, $username, $password, $dbname); 
if ($conn->connect_error) { // Check connection
    die("Connection failed: " . $conn->connect_error);
}

// Define variables and initialize with empty values
$email = $password = $confirm_password = "";
$email_err = $password_err = $confirm_password_err = "";
 
// Processing form data when form is submitted
if($_SERVER["REQUEST_METHOD"] == "POST"){
 
    // Validate email
    if(empty(trim($_POST["email"]))){
        $email_err = "Please enter an Email.";
    } elseif(!preg_match('/^[a-zA-Z0-9_]+@[a-zA-Z0-9_]+\.[a-zA-Z]{2,}$/', trim($_POST["email"]))){
        $email_err = "Invalid Email.";
    } else{
        // Prepare a select statement
        $sql = "SELECT customer_ID FROM customer WHERE email = ?";
        
        if($stmt = $conn->prepare($sql)){
            // Bind variables to the prepared statement as parameters
            $stmt->bind_param("s", $param_email);
            
            // Set parameters
            $param_email = trim($_POST["email"]);
            
            // Attempt to execute the prepared statement
            if($stmt->execute()){
                // store result
                $stmt->store_result();
                
                if($stmt->num_rows == 1){
                    $email_err = "This email is already taken.";
                } else{
                    $email = trim($_POST["email"]);
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            // Close statement
            $stmt->close();
        }
    }

    
    // Validate password
    if(empty(trim($_POST["password"]))){
        $password_err = "Please enter a password.";     
    } elseif(strlen(trim($_POST["password"])) < 6){
        $password_err = "Password must have atleast 6 characters.";
    } else{
        $password = trim($_POST["password"]);
    }
    
    // Validate confirm password
    if(empty(trim($_POST["confirm_password"]))){
        $confirm_password_err = "Please confirm password.";     
    } else{
        $confirm_password = trim($_POST["confirm_password"]);
        if(empty($password_err) && ($password != $confirm_password)){
            $confirm_password_err = "Password did not match.";
        }
    }

    
    // Check input errors before inserting in database
    if(empty($email_err) && empty($password_err) && empty($confirm_password_err)){

        $kent_ID = $_POST["kent_ID"];
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $phone_number = $_POST["phone_number"];
        $payment_token = '';
        // Generate random payment token
        $PTcharacters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        for ($i = 0; $i < 9; $i++) {
            $payment_token .= $PTcharacters[rand(0, strlen($PTcharacters) - 1)];
        }
        
        // Prepare an insert statement
        $sql = "INSERT INTO customer (email, password, kent_ID, first_name, last_name, phone_number, payment_token) VALUES (?, ?, ?, ?, ?, ?, ?)";

        if($stmt = $conn->prepare($sql)){
            // Bind variables to the prepared statement as parameters
            $stmt->bind_param("sssssss", $param_email, $param_password, $kent_ID, $first_name, $last_name, $phone_number, $payment_token);
            
            // Set parameters
            $param_email = $email;
            $param_password = password_hash($password, PASSWORD_DEFAULT); // Creates a password hash
            
            // Attempt to execute the prepared statement
            if($stmt->execute()){
                // Redirect to login page
                header("location: login.php");
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            // Close statement
            $stmt->close();
        }
    }
    
    // Close connection
    $conn->close();
}
?>
 
 <head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="../styles/login.css">
    <link rel="stylesheet" type="text/css" href="../styles/global.css">
    <meta charset="UTF-8">
</head>
<body>
    <header>
            <p>Food In A Flash</p>
            <hr>
            <nav>
            </nav>
    </header>
    <h1>Register New User</h1>

    <div class="container center">
        <p>Please fill this form to create an account.</p>
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <div class="form-group">
                <label>First Name</label>
                <input type="text" name="first_name" maxlength="30" class="form-control" value="<?php echo $first_name; ?>">
            </div>    
            <div class="form-group">
                <label>Last Name</label>
                <input type="text" name="last_name" maxlength="30" class="form-control" value="<?php echo $last_name; ?>">
            </div>    
            <div class="form-group">
                <label>Kent ID</label>
                <input type="text" name="kent_ID" minlength="9" maxlength="9" class="form-control" value="<?php echo $kent_ID; ?>">
            </div>    
            <div class="form-group">
                <label>Phone Number (XXX-XXX-XXXX)</label>
                <input type="text" name="phone_number" pattern="\d{3}-\d{3}-\d{4}" class="form-control" value="<?php echo $phone_number; ?>">
            </div>    
            <div class="form-group">
                <label>Email</label>
                <input type="text" name="email" class="form-control <?php echo (!empty($email_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $email; ?>">
                <span class="invalid-feedback"><?php echo $email_err; ?></span>
            </div>    
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control <?php echo (!empty($password_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $password; ?>">
                <span class="invalid-feedback"><?php echo $password_err; ?></span>
            </div>
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirm_password" class="form-control <?php echo (!empty($confirm_password_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $confirm_password; ?>">
                <span class="invalid-feedback"><?php echo $confirm_password_err; ?></span>
            </div>
            <input class="submit-button" type="submit" class="btn btn-primary" value="Submit"> <br>
            <input class="submit-button" type="reset" class="btn btn-secondary ml-2" value="Reset">
            <p>Already have an account? <a href="login.php">Login here</a>.</p>
        </form>
    </div>

    <footer>
        <div style="height: 2em;"></div>
    </footer>
</body>
</html>
