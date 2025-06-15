<?php
    // local
    $db_server = "localhost";
    $db_user = "root";
    $db_password = "";
    $db_name = "access_control";

    // host
    // $db_server = "nvme.h2cloud.vn:2083";
    // $db_user = "diemdanh_ctd_root";
    // $db_password = "@cntt2025";
    // $db_name = "diemdanh_doan_v1";

    $conn = mysqli_connect($db_server, $db_user, $db_password, $db_name);
    if (!$conn) {
        die("Không thể kết nối với cơ sở dữ liệu: " . mysqli_connect_error());
    }
    date_default_timezone_set('Asia/Ho_Chi_Minh');
?>