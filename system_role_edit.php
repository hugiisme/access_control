<?php 
include("db/db_config.php");

$id = $_GET['id']; // id dòng muốn edit

if ($_SERVER['REQUEST_METHOD'] == "POST"){
    // cập nhật db
    $role_name = $_POST['role_name'];
    $role_description = $_POST['role_description'];
    $org_id = $_POST['org_id'];
    $org_role_name = $_POST['org_role_name'];
    $max_users = ($_POST['max_users'] == '' || !is_numeric($_POST['max_users'])) ? 0 : $_POST['max_users'];

    $updateQuery = "UPDATE system_roles SET 
                        name = '$role_name',
                        description = '$role_description',
                        organization_id = $org_id,
                        system_role_type = '$org_role_name',
                        max_users = $max_users
                    WHERE id = $id";

    if (! mysqli_query($conn, $updateQuery)) {
        echo "Query failed: " . mysqli_error($conn);
        exit;
    }
    header("Location: system_roles.php");

    exit;
}

$organizations = mysqli_fetch_all(mysqli_query($conn,"SELECT id, name FROM organizations ORDER BY id ASC"), MYSQLI_ASSOC);
$role = mysqli_fetch_assoc(mysqli_query($conn,"SELECT * FROM system_roles WHERE id=$id"));
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Role Edit</title>
</head>
<body>
    <h1>Cập nhật Role</h1>
    <?php include("system_role_form.php"); ?>
</body>
</html>
