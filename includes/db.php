<?php
// Database configuration
$db_host = 'localhost';
$db_user = 'yaswanth'; // or 'root' if using XAMPP default
$db_pass = '@Mallela15960'; // or '' if using XAMPP default
$db_name = 'user_auth';

// Create connection
$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>