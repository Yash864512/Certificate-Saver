<?php
session_start();
if (!isset($_SESSION['rollno'])) {
    header("Location: index.html");
    exit();
}

include 'includes/db.php';

if (!isset($_GET['id'])) {
    header("Location: dashboard.php");
    exit();
}

$certificate_id = $_GET['id'];
$rollno = $_SESSION['rollno'];

// Verify the certificate belongs to the logged-in user
$stmt = $conn->prepare("SELECT file_path, certificate_name FROM certificates WHERE id = ? AND rollno = ?");
$stmt->bind_param("is", $certificate_id, $rollno);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    header("Location: dashboard.php");
    exit();
}

$certificate = $result->fetch_assoc();
$file_path = $certificate['file_path'];
$file_name = $certificate['certificate_name'];
$file_extension = strtolower(pathinfo($file_path, PATHINFO_EXTENSION));

// Check if file exists
if (!file_exists($file_path)) {
    header("Location: dashboard.php?error=file_not_found");
    exit();
}

// Set appropriate headers based on file type
switch ($file_extension) {
    case 'pdf':
        header('Content-Type: application/pdf');
        break;
    case 'jpg':
    case 'jpeg':
        header('Content-Type: image/jpeg');
        break;
    case 'png':
        header('Content-Type: image/png');
        break;
    default:
        header('Content-Type: application/octet-stream');
}

header('Content-Disposition: inline; filename="' . $file_name . '"');
header('Content-Length: ' . filesize($file_path));

readfile($file_path);
exit();
?>