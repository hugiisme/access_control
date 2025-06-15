<?php 
    include("db/db_config.php");
    include("table_renderer.php");
    $query = "SELECT 
                permissions.id AS id,
                actions.name AS action_name,
                resource_types.name AS resource_name
            FROM permissions
            JOIN actions ON permissions.action_id = actions.id
            JOIN resource_types ON permissions.resource_type_id = resource_types.id
            ORDER BY permissions.id ASC";

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
    <title>permissions</title>
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
    TableRenderer($result, "permissions", "", ""); // TODO thêm edit link
    renderPagination($currentPage, $totalPages);
    mysqli_close($conn);
    ?>
</body>
</html>