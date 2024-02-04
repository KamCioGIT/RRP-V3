CREATE TABLE `player_sickness` (
	`citizenid` VARCHAR(255) NOT NULL COLLATE 'utf8_general_ci',
	`sickness` TEXT NOT NULL COLLATE 'utf8_general_ci',
	PRIMARY KEY (`citizenid`) USING BTREE
);