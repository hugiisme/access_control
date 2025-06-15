<?php 
include("db/db_config.php");

if ($_SERVER['REQUEST_METHOD'] == "POST"){
    // thêm vào db
    $role_name = $_POST['role_name'];
    $role_description = $_POST['role_description'];
    $org_id = $_POST['org_id'];
    $org_role_name = $_POST['org_role_name'];
    $max_users = ($_POST['max_users'] == '' || !is_numeric($_POST['max_users'])) ? 0 : $_POST['max_users'];

    $createNewRoleQuery = "INSERT INTO system_roles (name, description, organization_id, system_role_type, max_users)
                            VALUES ('$role_name', '$role_description', $org_id, '$org_role_name', $max_users)";

    if (! mysqli_query($conn, $createNewRoleQuery)) {
        echo "Query failed: " . mysqli_error($conn);
        exit;
    }
    header("Location: system_roles.php");

    exit;
}

$organizations = mysqli_fetch_all(mysqli_query($conn,"SELECT id, name FROM organizations ORDER BY id ASC"), MYSQLI_ASSOC);
$role = [];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Role Create</title>
</head>
<body>
    <h1>Thêm Role</h1>
    <?php include("system_role_form.php"); ?>
</body>
</html>
