<?php 
    include("db/db_config.php");
    include("table_renderer.php");
    $query = "SELECT 
                o.id,
                o.name,
                (SELECT p.name FROM organizations p WHERE p.id = o.parent_org_id) AS parent_name,
                o.organization_level
            FROM
                organizations o";

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
    <title>Organizations</title>
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
    echo "<a href = 'organization_create.php'><button>Tạo tổ chức mới</button></a>";
    TableRenderer($result, "organizations", "organization_edit.php", "organizations.php");
    renderPagination($currentPage, $totalPages);
    mysqli_close($conn);
    ?>
</body>
</html>