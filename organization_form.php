<form action="" method="POST">
    <div>
        <label for="">Tên tổ chức</label>
        <input type="text" name="org_name" value="<?php echo !empty($org) ? htmlentities($org['name']) : '' ?>"> 

    </div>
    <div>
        <label for="">Chọn tổ chức cha</label>
        <select name="parent_org_id">
            <option value="">NULL</option>
            <?php foreach ($organizations as $item) : ?>
                <option value="<?php echo $item['id']; ?>" 
                    <?php echo (!empty($org) && $org['parent_org_id'] == $item['id']) ? 'selected' : '' ?>>
                    <?php echo htmlentities($item['name']); ?>
                </option>
            <?php endforeach; ?>
        </select>
    </div>

    <div>
        <label for="">Chọn cấp tổ chức</label>
        <select name="org_level">
            <option value="1" <?php echo (!empty($org) && $org['organization_level'] == 1) ? 'selected' : '' ?>>Cấp 1</option>
            <option value="2" <?php echo (!empty($org) && $org['organization_level'] == 2) ? 'selected' : '' ?>>Cấp 2</option>
            <option value="3" <?php echo (!empty($org) && $org['organization_level'] == 3) ? 'selected' : '' ?>>Cấp 3</option>
        </select>
    </div>

    <div>
        <button type="button" onclick="location.href='organizations.php'">Hủy</button>
        <input type="submit" value="<?= $org ? 'Cập nhật' : 'Thêm' ?>"> 
    </div>
</form>