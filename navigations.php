<?php
    $navItems = [
        ["label" => "Home", "link" => "index.php"],
        ["label" => "Permissions", "link" => "permissions.php"],
        ["label" => "System role", "link" => "system_roles.php"],
        ["label" => "Organizations", "link" => "organizations.php"]
    ]
?>

<nav style="width: 100%; background: #f5f5f5; padding: 20px;">
    <ul style="width: 100%; list-style: none; padding: 0; display: flex;">
        <?php foreach ($navItems as $item): ?>
            <li style="margin-bottom: 10px; margin-left: 10px;">
                <a 
                    href="<?php echo $item['link']; ?>" 
                    style="text-decoration: none; color: #333">
                    <?php echo $item['label']; ?>
                </a>
            </li>
        <?php endforeach; ?>
    </ul>
</nav>
