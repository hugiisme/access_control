<?php

/**
 * Class PermissionChecker để kiểm tra quyền của người dùng.
 *
 * Hướng dẫn sử dụng:
 * 1. Khởi tạo kết nối mysqli.
 * 2. Tạo một instance của class: $checker = new PermissionChecker($db_connection);
 * 3. Gọi các phương thức:
 *    - $actions = $checker->allowedActionList($user_id, $organization_id, $resource_id);
 *    - $canPerform = $checker->hasPermission($user_id, 'Update', $resource_id, $organization_id);
 */
class PermissionChecker
{
    /**
     * @var mysqli
     */
    private $db;
    private $resource_type_cache = [];

    /**
     * Khởi tạo với đối tượng kết nối mysqli.
     * @param mysqli $db
     */
    public function __construct(mysqli $db)
    {
        $this->db = $db;
    }

    /**
     * Hàm chính: Lấy danh sách tất cả các action được phép trên một resource.
     *
     * @param int $user_id
     * @param int $organization_id
     * @param int $resource_id
     * @return array Danh sách các action name. Ví dụ: ['Read', 'Update']
     */
    public function allowedActionList($user_id, $organization_id, $resource_id)
    {
        $allowedActions = [];

        // Lấy resource_type_id một lần để tái sử dụng
        $resource_type_id = $this->_getResourceTypeId($resource_id);
        if (!$resource_type_id) {
            // Nếu không tìm thấy resource thì không có quyền nào cả
            return [];
        }

        // Bước 1: Check policies (quy tắc ngoại lệ)
        $policyActions = $this->_getActionsFromPolicies($user_id, $organization_id, $resource_type_id);
        $allowedActions = array_merge($allowedActions, $policyActions);

        // Bước 2: Check system role (quyền tổng thể trong tổ chức)
        $systemRoleActions = $this->_getActionsFromSystemRoles($user_id, $organization_id, $resource_type_id);
        $allowedActions = array_merge($allowedActions, $systemRoleActions);

        // Bước 3: Check resource role (quyền trực tiếp trên resource)
        $resourceRoleActions = $this->_getActionsFromResourceRoles($user_id, $resource_id);
        $allowedActions = array_merge($allowedActions, $resourceRoleActions);
        
        // Bước 4: Check quan hệ gián tiếp (quyền thừa kế từ resource cha)
        $indirectActions = $this->_getActionsFromIndirectRelations($user_id, $organization_id, $resource_id);
        $allowedActions = array_merge($allowedActions, $indirectActions);
        
        // Trả về danh sách các action duy nhất
        return array_values(array_unique($allowedActions));
    }

    /**
     * Hàm chính: Kiểm tra nhanh một quyền cụ thể.
     *
     * @param int $user_id
     * @param string $actionName Tên của action cần kiểm tra (ví dụ: 'Update', 'Delete')
     * @param int $resource_id
     * @param int $organization_id
     * @return bool True nếu có quyền, False nếu không.
     */
    public function hasPermission($user_id, $actionName, $resource_id, $organization_id)
    {
        $resource_type_id = $this->_getResourceTypeId($resource_id);
        if (!$resource_type_id) {
            return false;
        }

        // Chuyển tên action về chữ thường để so sánh không phân biệt hoa thường
        $actionNameLower = strtolower($actionName);

        // Bước 1: Check policies
        $policyActions = $this->_getActionsFromPolicies($user_id, $organization_id, $resource_type_id);
        if (in_array($actionNameLower, array_map('strtolower', $policyActions))) {
            return true;
        }

        // Bước 2: Check system roles
        $systemRoleActions = $this->_getActionsFromSystemRoles($user_id, $organization_id, $resource_type_id);
        if (in_array($actionNameLower, array_map('strtolower', $systemRoleActions))) {
            return true;
        }

        // Bước 3: Check resource roles
        $resourceRoleActions = $this->_getActionsFromResourceRoles($user_id, $resource_id);
        if (in_array($actionNameLower, array_map('strtolower', $resourceRoleActions))) {
            return true;
        }
        
        // Bước 4: Check quan hệ gián tiếp
        $indirectActions = $this->_getActionsFromIndirectRelations($user_id, $organization_id, $resource_id);
        if (in_array($actionNameLower, array_map('strtolower', $indirectActions))) {
            return true;
        }

        return false;
    }

    // ===================================================================
    // CÁC HÀM HELPER (PRIVATE)
    // ===================================================================

    /**
     * Helper - Bước 1: Lấy các action từ policies.
     * Lưu ý: Phiên bản đơn giản, bỏ qua việc xử lý các điều kiện phức tạp trong `policy_conditions`.
     */
    private function _getActionsFromPolicies($user_id, $organization_id, $resource_type_id)
    {
        // TODO: Mở rộng để xử lý các điều kiện trong `policy_conditions_groups` và `policy_conditions`
        $query = "
            SELECT a.name
            FROM policies pol
            JOIN actions a ON pol.action_id = a.id
            WHERE pol.organization_id = {$organization_id}
              AND pol.resource_type_id = {$resource_type_id}
        ";
        
        return $this->_fetchActionNames($query);
    }

    /**
     * Helper - Bước 2: Lấy các action từ vai trò hệ thống của người dùng.
     */
    private function _getActionsFromSystemRoles($user_id, $organization_id, $resource_type_id)
    {
        // Do CSDL thiếu bảng liên kết trực tiếp, hàm này tạm thời trả về rỗng.
        // Bạn cần bổ sung logic/bảng để liên kết system_role với permissions.
        return [];
    }
    
    /**
     * Helper - Bước 3: Lấy các action từ vai trò được gán trực tiếp trên resource.
     */
    private function _getActionsFromResourceRoles($user_id, $resource_id)
    {
        $query = "
            SELECT a.name
            FROM user_resources ur
            JOIN system_role_permissions srp ON ur.resource_role_id = srp.role_id
            JOIN permissions p ON srp.permission_id = p.id
            JOIN actions a ON p.action_id = a.id
            WHERE ur.user_id = {$user_id}
              AND ur.resource_id = {$resource_id}
        ";

        return $this->_fetchActionNames($query);
    }
    
    /**
     * Helper - Bước 4: Lấy các action từ quyền thừa kế của các resource cha.
     */
    private function _getActionsFromIndirectRelations($user_id, $organization_id, $resource_id)
    {
        $allParentIds = $this->_getAllParentResourceIds($resource_id);
        
        if (empty($allParentIds)) {
            return [];
        }
        
        $actions = [];
        $parentIdsString = implode(',', $allParentIds);
        
        // Lấy quyền từ vai trò trực tiếp trên các resource cha
        $queryResourceRoles = "
            SELECT a.name
            FROM user_resources ur
            JOIN system_role_permissions srp ON ur.resource_role_id = srp.role_id
            JOIN permissions p ON srp.permission_id = p.id
            JOIN actions a ON p.action_id = a.id
            WHERE ur.user_id = {$user_id}
              AND ur.resource_id IN ({$parentIdsString})
        ";
        $actions = array_merge($actions, $this->_fetchActionNames($queryResourceRoles));
        
        // Lấy quyền từ vai trò hệ thống (áp dụng cho các resource cha)
        foreach ($allParentIds as $parentId) {
            $parentResourceType = $this->_getResourceTypeId($parentId);
            if ($parentResourceType) {
                 $systemRoleActions = $this->_getActionsFromSystemRoles($user_id, $organization_id, $parentResourceType);
                 $actions = array_merge($actions, $systemRoleActions);
            }
        }
        
        return array_unique($actions);
    }

    /**
     * Helper: Tìm tất cả các ID của resource cha một cách đệ quy.
     */
    private function _getAllParentResourceIds($resource_id, &$visited = [])
    {
        if (in_array($resource_id, $visited)) {
            return [];
        }
        $visited[] = $resource_id;

        $parentIds = [];
        $query = "SELECT first_resource_id FROM resource_relations WHERE second_resource_id = {$resource_id}";
        $result = $this->db->query($query);

        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $parentId = $row['first_resource_id'];
                $parentIds[] = $parentId;
                $grandParentIds = $this->_getAllParentResourceIds($parentId, $visited);
                $parentIds = array_merge($parentIds, $grandParentIds);
            }
        }

        return array_unique($parentIds);
    }

    /**
     * Helper: Lấy `resource_type_id` từ `resource_id`. Có cache để tăng tốc.
     */
    private function _getResourceTypeId($resource_id)
    {
        if (isset($this->resource_type_cache[$resource_id])) {
            return $this->resource_type_cache[$resource_id];
        }

        $query = "SELECT resource_type_id FROM resources WHERE id = " . intval($resource_id);
        $result = $this->db->query($query);
        if ($row = $result->fetch_assoc()) {
            $this->resource_type_cache[$resource_id] = $row['resource_type_id'];
            return $row['resource_type_id'];
        }
        return null;
    }
    
    /**
     * Helper: Thực thi một câu query và trả về một mảng chứa tên các action.
     */
    private function _fetchActionNames($query)
    {
        $actions = [];
        $result = $this->db->query($query);
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $actions[] = $row['name'];
            }
        }
        return $actions;
    }
}


// ===================================================================
// CÁCH SỬ DỤNG
// ===================================================================

// 1. Thiết lập kết nối CSDL (Sử dụng MySQLi)
$servername = "127.0.0.1";
$username = "root";
$password = ""; // Mật khẩu của bạn
$dbname = "access_control";

$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8mb4");

if ($conn->connect_error) {
    die("MySQLi Connection failed: " . $conn->connect_error);
}

// Giả sử chúng ta có các dữ liệu sau để test
// Bạn cần INSERT dữ liệu này vào CSDL để test
/*
-- User
INSERT INTO `users` (`id`, `name`) VALUES (1, 'Nguyễn Văn A');
-- Organization
-- ID=15 là Chi đoàn khoa CNTT
-- Resource Types
-- ID=9 là 'Hoạt động'
-- Resources
INSERT INTO `resources` (`id`, `name`, `resource_type_id`) VALUES (101, 'Hoạt động A (cha)', 9), (102, 'Hoạt động B (con của A)', 9);
-- Resource Roles
-- ID=3 là 'Editor'
-- Actions
-- ID=3 là 'Update'
-- Permissions
-- Giả sử permission ID=200 là 'Update' cho resource type 'Hoạt động' (ID=9)
INSERT INTO `permissions` (`id`, `action_id`, `resource_type_id`) VALUES (200, 3, 9);
-- Gán quyền 'Update Hoạt động' cho vai trò 'Editor'
INSERT INTO `system_role_permissions` (`role_id`, `permission_id`) VALUES (3, 200);
-- Gán vai trò 'Editor' cho user 1 trên resource 101
INSERT INTO `user_resources` (`user_id`, `resource_id`, `resource_role_id`) VALUES (1, 101, 3);
-- Tạo quan hệ cha-con
INSERT INTO `resource_relations` (`first_resource_id`, `second_resource_id`) VALUES (101, 102);
*/

// 2. Khởi tạo đối tượng PermissionChecker
$checker = new PermissionChecker($conn);

// 3. Các biến đầu vào
$test_user_id = 1;
$test_organization_id = 15; // Chi đoàn khoa CNTT
$test_resource_id_parent = 101; // Hoạt động cha
$test_resource_id_child = 102; // Hoạt động con

echo "<h3>Kiểm tra quyền trên Resource CHA (ID: {$test_resource_id_parent})</h3>";

// Gọi hàm allowedActionList cho resource cha
$allowedActionsParent = $checker->allowedActionList($test_user_id, $test_organization_id, $test_resource_id_parent);
echo "Các action được phép trên resource #{$test_resource_id_parent}: <pre>" . print_r($allowedActionsParent, true) . "</pre>";

// Gọi hàm hasPermission cho resource cha
$canUpdateParent = $checker->hasPermission($test_user_id, 'Update', $test_resource_id_parent, $test_organization_id);
echo "User có quyền 'Update' trên resource #{$test_resource_id_parent} không? " . ($canUpdateParent ? '<b>Có</b>' : 'Không') . "<br>";
$canDeleteParent = $checker->hasPermission($test_user_id, 'Delete', $test_resource_id_parent, $test_organization_id);
echo "User có quyền 'Delete' trên resource #{$test_resource_id_parent} không? " . ($canDeleteParent ? '<b>Có</b>' : 'Không') . "<br>";


echo "<hr>";
echo "<h3>Kiểm tra quyền trên Resource CON (ID: {$test_resource_id_child}) - Thừa kế từ cha</h3>";

// Gọi hàm allowedActionList cho resource con
$allowedActionsChild = $checker->allowedActionList($test_user_id, $test_organization_id, $test_resource_id_child);
echo "Các action được phép trên resource #{$test_resource_id_child}: <pre>" . print_r($allowedActionsChild, true) . "</pre>";

// Gọi hàm hasPermission cho resource con
$canUpdateChild = $checker->hasPermission($test_user_id, 'update', $test_resource_id_child, $test_organization_id); // test chữ thường
echo "User có quyền 'update' trên resource #{$test_resource_id_child} không? " . ($canUpdateChild ? '<b>Có</b>' : 'Không') . "<br>";


// Đóng kết nối
$conn->close();

?>