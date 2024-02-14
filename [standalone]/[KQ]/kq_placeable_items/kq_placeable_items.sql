CREATE TABLE IF NOT EXISTS `kq_placeable_items` (
                                                    `id` int(11) NOT NULL AUTO_INCREMENT,
    `materialize_id` varchar(50) NOT NULL DEFAULT '0',
    `prop` int(11) DEFAULT NULL,
    `item` varchar(50) NOT NULL DEFAULT '0',
    `label` varchar(50) NOT NULL DEFAULT '0',
    `amount` int(11) NOT NULL DEFAULT 0,
    `pos_x` varchar(50) NOT NULL DEFAULT '0',
    `pos_y` varchar(50) NOT NULL DEFAULT '0',
    `pos_z` varchar(50) NOT NULL DEFAULT '0',
    `rot_x` varchar(50) NOT NULL DEFAULT '0',
    `rot_y` varchar(50) NOT NULL DEFAULT '0',
    `rot_z` varchar(50) NOT NULL DEFAULT '0',
    `bucket` int(11) DEFAULT NULL,
    `created_at` datetime DEFAULT current_timestamp(),
    PRIMARY KEY (`id`),
    KEY `loot_id` (`materialize_id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
