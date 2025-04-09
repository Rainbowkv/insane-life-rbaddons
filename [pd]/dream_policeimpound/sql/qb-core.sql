CREATE TABLE police_impound_offence (
    `id` varchar(32) NOT NULL,
    `name` varchar(255) NOT NULL,
    `amount` int(11) DEFAULT 100,
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO police_impound_offence (`id`, `name`, `amount`) VALUES
('illegal_parking', '非法停车', 150),
('abandoned_vehicle', '废弃车辆', 200),
('unregistered_vehicle', '未注册车辆', 300),
('stolen_recovery', '被盗车辆追回', 500),
('obstructing_traffic', '阻碍交通', 250),
('illegal_mods', '非法改装', 400),
('crime_vehicle', '涉案车辆', 1000),
('driver_arrested', '驾驶员被捕', 300),
('evidence_seizure', '证据扣押', 500),
('noise_complaint', '噪音投诉', 100),
('reckless_driving', '鲁莽驾驶', 350),
('safety_issues', '车辆安全问题', 200),
('dui', '酒后驾驶', 700),
('hit_and_run', '肇事逃逸', 800);

CREATE TABLE police_impound_status (
    `id` int(1) NOT NULL,
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO police_impound_status (`id`, `name`) VALUES
(1, '已取出'),
(2, '被扣押'),
(3, '需解锁');

CREATE TABLE police_impound (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `officer` varchar(46) NOT NULL, -- Officer Identifier
    `officer_name` varchar(128) NOT NULL, 
    `status` int(1) DEFAULT 2,
    `duration` timestamp NULL DEFAULT NULL,
    `fine` int(11) DEFAULT 0,
    `offence` varchar(32) NOT NULL,
    `notes` LONGTEXT DEFAULT 'No extra notes',
    `vehicle` LONGTEXT NOT NULL,
    `vehicle_plate` varchar(64) DEFAULT 'Unknown',
    `vehicle_owner` varchar(46) NOT NULL, -- Owner Identifier
    `vehicle_owner_name` varchar(128) DEFAULT 'Unknown', -- Owner Name
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`status`) REFERENCES police_impound_status(id),
    FOREIGN KEY (`offence`) REFERENCES police_impound_offence(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;