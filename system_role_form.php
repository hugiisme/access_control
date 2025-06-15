<form action="" method="POST">
    <div>
        <label for="">Tên role</label>
        <input type="text" name="role_name" value="<?= htmlentities($role['name'] ?? '') ?>"> 
    </div>
    <div>
        <label for="">Mô tả</label>
        <input type="text" name="role_description" value="<?= htmlentities($role['description'] ?? '') ?>"> 
    </div>

    <div>
        <label for="">Role này thuộc tổ chức nào</label>
        <select name="org_id">
            <?php foreach ($organizations as $item) : ?>
                <option value="<?= $item['id']; ?>" <?= (!empty($role) && $role['organization_id'] == $item['id']) ? 'selected' : '' ?>>
                    <?= $item['name']; ?>
                </option>
            <?php endforeach; ?>
        </select>
    </div>

    <div>
        <label for="">Loại vai trò trong tổ chức</label>
        <select name="org_role_name">
            <option value="Trưởng" <?= (!empty($role) && $role['system_role_type'] == "Trưởng") ? "selected" : '' ?>>Trưởng</option>
            <option value="Phó" <?= (!empty($role) && $role['system_role_type'] == "Phó") ? "selected" : '' ?>>Phó</option>
            <option value="Thành viên" <?= (!empty($role) && $role['system_role_type'] == "Thành viên") ? "selected" : '' ?>>Thành viên</option>
        </select>
    </div>

    <div>
        <label for="">Số lượng slot tối đa cho role này</label>
        <input type="number" name="max_users" value="<?= htmlentities($role['max_users'] ?? '') ?>"> 
    </div>

    <div>
        <button type="button" onclick="location.href='system_roles.php'">Hủy</button>
        <input type="submit" value="<?= $role ? 'Cập nhật' : 'Thêm' ?>"> 
    </div>
</form>
