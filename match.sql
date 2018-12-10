PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE `matches` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `match_id` VARCHAR(255), `home_team` VARCHAR(255), `away_team` VARCHAR(255), `home_logo` VARCHAR(255), `away_logo` VARCHAR(255), `home_score` VARCHAR(255), `away_score` VARCHAR(255), `half` VARCHAR(255), `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL);
INSERT INTO matches VALUES(1,'101','CC A','SMAN 31','','','0','0','1st','','');
INSERT INTO matches VALUES(2,'102','CC B','SMAN 47','','','0','0','1st','','');
INSERT INTO matches VALUES(3,'103','SMA SANTA URSULA BSD','SMAK 2','','','0','0','1st','','');
INSERT INTO matches VALUES(4,'104','SMA TARAKANITA 2','SMA METHODIST','','','0','0','1st','','');
INSERT INTO matches VALUES(5,'201','SMA SANTA URSULA BSD','SMKN 34','','','0','0','1st','','');
INSERT INTO matches VALUES(6,'202','CC B','SMAN 8','','','0','0','1st','','');
INSERT INTO matches VALUES(7,'203','CC A','SMA MAKARIOS','','','0','0','1st','','');
INSERT INTO matches VALUES(8,'204','SMA MARSUDIRINI BEKASI','SMA METHODIST','','','0','0','1st','','');
INSERT INTO matches VALUES(9,'301','SMAK 2','SMKN 34','','','0','0','1st','','');
INSERT INTO matches VALUES(10,'302','SMAN 47','SMAN 8','','','0','0','1st','','');
INSERT INTO matches VALUES(11,'303','SMAN 31','SMA MAKARIOS','','','0','0','1st','','');
INSERT INTO matches VALUES(13,'304','SMA MARSUDIRINI BEKASI','SMA TARAKANITA 2','','','0','0','1st','','');
COMMIT;