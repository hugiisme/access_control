<?php 
    function isAllowed($user_id, $action, $resource_id, $org_id){
        // return true/false
    }

    function allowedActionList($conn, $user_id, $resource_id, $org_id){
        $allowedActions = [];
        $resource_type = getResourceType($conn, $resource_id);
        if (!$resource_type){
            return [];
        }

        return $allowedActions;
        // return [read, view,...]
    }

    function getActionFromPolicy(){

    }

    function getActionFromSystemRole($conn, $system_role, $resource_type){
        $query = "SELECT a.name
                FROM permissions p
                JOIN system_role_permissions srp ON p.id = srp.permission_id
                JOIN system_roles sr ON sr.id = srp.role_id
                JOIN actions a ON p.action_id = a.id
                JOIN resource_types rt ON p.resource_type_id = rt.id
                WHERE rt.name = '$resource_type' AND sr.name = '$system_role'";
        $result = mysqli_query($conn, $query);
        if (!$result) {
            echo "Query failed: " . mysqli_error($conn) . "<br>";
            echo $query;
            exit;
        }
        return mysqli_fetch_assoc($result);
    }

    function getActionFromResourceRole($conn, $resource_role){
        // TODO: Chưa query về role kế thừa
        $contained = [];
        
        $contained = getAllContainedRoles($conn, $resource_role);
        $contained[] = $resource_role;


        $query = "SELECT a.name
                FROM resource_role_actions rra
                JOIN resource_role rr ON rr.id = rra.resource_role_id
                JOIN actions a ON a.id = rra.action_id
                WHERE rr.name IN '$contained'";
        $result = mysqli_query($conn, $query);
        if (!$result) {
            echo "Query failed: " . mysqli_error($conn) . "<br>";
            echo $query;
            exit;
        }
        return mysqli_fetch_assoc($result);
    }

    function getActionFromResourceInheritance($conn, $user_id, $resource_id){
        // query ngược ra tất cả resource là resource cha của resource được truyền vào
        $parents = []; 
        $current = $resource_id;

        do {
            $query = "SELECT first_resource_id 
                    FROM resource_relations 
                    WHERE relation_type_id = 
                            (SELECT id 
                            FROM resource_relation_types 
                            WHERE name='contains') 
                        AND second_resource_id = '$current'";

            $result = mysqli_query($conn, $query);
            if (!$result) {
                echo "Query failed: " . mysqli_error($conn);
                echo "<br>" . $query;
                exit;
            }

            $found = mysqli_fetch_assoc($result);
            if ($found) {
                $current = $found['first_resource_id'];
                $parents[] = $current;
            } else {
                $current = 0;
            }
        } while ($current > 0);

        $actions = [];

        foreach ($parents as $parentId) {
            $roles = getResourceRoles($conn, $user_id, $parentId);
            foreach ($roles as $role) {
                $actions = array_merge($actions, getActionFromResourceRole($conn, $role));
            }
        }

        return array_unique($actions);
    }

    function getResourceType($conn, $resource_id){
        $query = "SELECT rt.name 
                FROM resource_types rt
                JOIN resources r ON rt.id = r.resource_type_id
                WHERE r.id = '$resource_id';";
        $result = mysqli_query($conn, $query);
        if (!$result) {
            echo "Query failed: " . mysqli_error($conn) . "<br>";
            echo $query;
            exit;
        }
        return mysqli_fetch_assoc($result);
    }

    function getResourceRoles($conn, $user_id, $resource_id){
        $query = "SELECT rr.name
                FROM user_resources ur
                JOIN resource_roles rr ON ur.resource_role_id = rr.id
                WHERE ur.user_id = '$user_id' AND ur.resource_id = '$resource_id'";
        $result = mysqli_query($conn, $query);
        if (!$result) {
            echo "Query failed: " . mysqli_error($conn) . "<br>";
            echo $query;
            exit;
        }
        return mysqli_fetch_assoc($result);    
    }

    function getAllContainedRoles($conn, $roleName, &$contained = []){
        // Thêm chính role này vào
        if (in_array($roleName, $contained)) {
            return;
        }
        $contained[] = $roleName;

        // Tìm những role mà role này chứa
        $query = "SELECT rr2.name AS child_name
                FROM resource_role_relations r
                JOIN resource_roles rr1 ON r.resource_role_1_id = rr1.id
                JOIN resource_roles rr2 ON r.resource_role_2_id = rr2.id
                WHERE r.relation_type='contains' AND rr1.name = '$roleName';";

        $result = mysqli_query($conn, $query);
        if (!$result) {
            echo "Query failed: " . mysqli_error($conn);
            echo "<br>" . $query;
            exit;
        }

        while ($row = mysqli_fetch_assoc($result)) {
            $child = $row['child_name'];
            if (!in_array($child, $contained)) {
                getAllContainedRoles($conn, $child, $contained);
            }
        }

        return $contained;
    }
?>