<?php 
    include("db/db_config.php");
    $id = $_GET['id']; 
    if ($_SERVER['REQUEST_METHOD'] == "POST"){
        $org_name = $_POST["org_name"];
        $parent_org_id = ($_POST["parent_org_id"] == "NULL") ? "" : $_POST["parent_org_id"];
        $org_level = $_POST["org_level"];

        $updateQuery = "UPDATE organizations SET 
                            name = '$org_name'
                            parent_org_id = '$parent_org_id'
                            organization_level = '$org_level'
                        WHERE id = $id";
        if (! mysqli_query($conn, $updateQuery)) {
            echo "Query failed: " . mysqli_error($conn);
            exit;
        }
        header("Location: system_roles.php");

        exit;
    }
    $organizations = mysqli_fetch_all(mysqli_query($conn,"SELECT id, name FROM organizations ORDER BY id ASC"), MYSQLI_ASSOC);
    $org = mysqli_fetch_assoc(mysqli_query($conn,"SELECT * FROM organizations WHERE id=$id"));

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organizations Edit</title>
</head>
<body>
    <h1>Cập nhật Tổ chức</h1>
    <?php include("organization_form.php"); ?>
</body>
</html>