<?php 
    include("db/db_config.php");
    include("table_renderer.php");
    $query = "SELECT * FROM system_roles";

    $rowsPerPage = 16;
    $currentPage = max(1, $_GET['page'] ?? 1);

    $totalResults = totalResults($conn, $query);
    $query = buildQuery($query, $rowsPerPage, $currentPage);
    $result = mysqli_query($conn, $query);
    if (!$result) {
        echo "Query failed: " . mysqli_error($conn) . "<br>";
        echo $query;
        exit;
    }

    
    $totalPages = ceil($totalResults/$rowsPerPage);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System roles</title>
    <style>
        table, tr, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 5px;
        }
        table {
            width: 100%;
        }
    </style>
</head>
<body>
    <?php
    include("navigations.php");
    echo "<a href = 'system_role_create.php'><button>Tạo role mới</button></a>";
    TableRenderer($result, "system_roles", "system_role_edit.php", "system_roles.php");
    renderPagination($currentPage, $totalPages);
    mysqli_close($conn);
    ?>
</body>
</html>