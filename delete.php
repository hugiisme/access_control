<?php
include("db/db_config.php");

$table = $_GET['table']; 
$id = (int)$_GET['id'];
$redirectLink = $_GET["redirectLink"] ?? "index.php";

if ($id && $table) {
    mysqli_query($conn, "DELETE FROM `$table` WHERE id=$id");

    header("Location: $redirectLink"); 
    exit;
}

 echo "<h1>Invalid id or table</h1>";

?>
