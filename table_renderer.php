<?php 
    function renderPagination($currentPage, $totalPages) {
        echo "<form id='pagination-form' method='GET' style='width: 100%; display: flex; justify-content: center; margin: 20px 0px'>";
        echo "<label for='page'>Select page: </label>";
        echo "<select id='page' name='page' onchange='this.form.submit()'>";
        for ($i = 1; $i <= $totalPages; $i++) {
            echo "<option value='{$i}' " . ($i == $currentPage ? "selected" : '') . ">";
            echo "Page " . $i;
            echo "</option>";
        }
        echo "</select>";
        echo "</form>";
    }

    function totalResults($conn, $query){
        $result = mysqli_query($conn, $query);
        $totalResult = mysqli_num_rows($result); 
        return $totalResult;
    }

    function TableRenderer($result, $tableName, $editLink, $redirectLink){
        echo "<table>";
        // Table header
        echo "<thead><tr>";
        $fieldNames = mysqli_fetch_fields($result);
        foreach($fieldNames as $fieldName){
            echo "<th>" . $fieldName->name . "</th>";
        }
        echo !empty($editLink) ? "<th>Edit</th>" : "";
        echo !empty($redirectLink) ? "<th>Edit</th>" : "";     
        echo "</tr></thead>";

        // Table contents
        while ($row = mysqli_fetch_assoc($result)) {
            echo "<tr>";
            foreach ($fieldNames as $field) {
                echo "<td>" . htmlentities($row[$field->name]) . "</td>";
            }
             // Edit button
            if($editLink){
                echo "<td>";
                echo "<a href='$editLink?id=" . $row['id'] . "&table=$tableName'>";
                echo "<button>Edit</button>";
                echo "</a>";
                echo "</td>";
            }
            

            // Delete button
            if($redirectLink){
                echo "<td>";
                echo "<a href='delete.php?id=" . $row['id'] . "&redirectLink=$redirectLink" . "&table=$tableName' onclick='return confirm(\"Are you sure you want to delete this row?\");'>";
                echo "<button>Delete</button>";
                echo "</a>";
                echo "</td>";
            }
            

            echo "</tr>";
        }
        echo "</table>";

        mysqli_free_result($result); // Xóa bộ nhớ
    }

    function buildQuery($query, $rowsPerPage, $currentPage){
        $offset = ($currentPage - 1) * $rowsPerPage;
        $query .= " LIMIT $rowsPerPage OFFSET $offset";
        return $query;
    }
?>