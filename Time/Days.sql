CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event` IN (62,63);
INSERT INTO `active_event_id` (`active_event`, `name`) VALUES (62,"Day Time");

UPDATE `creature_spawns` SET `entry`=1891,`displayid`=2565,`slot1item`=1896,`slot2item`=1961,`slot3item`=5258 WHERE `entry`=1892;
UPDATE `creature_spawns` SET `entry`=1894,`displayid`=3551,`slot1item`=1899,`slot2item`=1957,`slot3item`=0 WHERE `entry`=1893;
UPDATE `creature_spawns` SET `entry`=1895,`displayid`=2535,`slot1item`=5303, `slot2item`=0, `slot3item`=0 WHERE `entry`=1896;
UPDATE `creature_spawns` SET `entry`=3528,`displayid`=3349,`slot1item`=1903, `slot2item`=0, `slot3item`=0 WHERE `entry`=3529;
UPDATE `creature_spawns` SET `entry`=3530,`displayid`=3352,`slot1item`=5280, `slot2item`=0, `slot3item`=0 WHERE `entry`=3531;
UPDATE `creature_spawns` SET `entry`=3532,`displayid`=3365,`slot1item`=5284, `slot2item`=0, `slot3item`=0 WHERE `entry`=3533;


UPDATE `creature_spawns` SET `slot1item`=1899,`slot2item`=143,`slot3item`=0 WHERE `entry`=68;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=2551 WHERE `entry`=424;
UPDATE `creature_spawns` SET `slot1item`=2557,`slot2item`=0,`slot3item`=2552 WHERE `entry`=727;
UPDATE `creature_spawns` SET `slot1item`=1899,`slot2item`=143,`slot3item`=0 WHERE `entry`=1423;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=1735;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=1738;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=1742;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=1743;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=1744;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=1745;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=1746;
UPDATE `creature_spawns` SET `slot1item`=1899,`slot2item`=143,`slot3item`=0 WHERE `entry`=1976;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=2209;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=2210;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3212;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3215;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3217;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3218;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3219;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3220;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3221;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3222;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3223;
UPDATE `creature_spawns` SET `slot1item`=2023,`slot2item`=0,`slot3item`=0 WHERE `entry`=3224;
UPDATE `creature_spawns` SET `slot1item`=5289,`slot2item`=0,`slot3item`=0 WHERE `entry`=3296;
UPDATE `creature_spawns` SET `slot1item`=3361,`slot2item`=0,`slot3item`=2552 WHERE `entry`=3502;
UPDATE `creature_spawns` SET `slot1item`=5598,`slot2item`=0,`slot3item`=2550 WHERE `entry`=3571;
UPDATE `creature_spawns` SET `slot1item`=5598,`slot2item`=0,`slot3item`=0 WHERE `entry`=4262;
UPDATE `creature_spawns` SET `slot1item`=3361,`slot2item`=0,`slot3item`=2552 WHERE `entry`=4624;
UPDATE `creature_spawns` SET `slot1item`=5286,`slot2item`=6254,`slot3item`=0 WHERE `entry`=5595;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=0,`slot3item`=0 WHERE `entry`=5725;
UPDATE `creature_spawns` SET `slot1item`=5289,`slot2item`=0,`slot3item`=0 WHERE `entry`=5953;
UPDATE `creature_spawns` SET `slot1item`=5291,`slot2item`=0,`slot3item`=2552 WHERE `entry`=9460;
UPDATE `creature_spawns` SET `slot1item`=5291,`slot2item`=11586,`slot3item`=2552 WHERE `entry`=11190;
UPDATE `creature_spawns` SET `slot1item`=2557,`slot2item`=0,`slot3item`=2552 WHERE `entry`=13076;
UPDATE `creature_spawns` SET `slot1item`=14882,`slot2item`=20417,`slot3item`=5261 WHERE `entry`=15184;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=16221;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=16222;
UPDATE `creature_spawns` SET `slot1item`=24332,`slot2item`=24331,`slot3item`=0 WHERE `entry`=16733;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=16863;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=16980;
UPDATE `creature_spawns` SET `slot1item`=24332,`slot2item`=24331,`slot3item`=0 WHERE `entry`=18038;
UPDATE `creature_spawns` SET `slot1item`=29124,`slot2item`=0,`slot3item`=0 WHERE `entry`=18549;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=18568;
UPDATE `creature_spawns` SET `slot1item`=29707,`slot2item`=29640,`slot3item`=30580 WHERE `entry`=19687;
UPDATE `creature_spawns` SET `slot1item`=29655,`slot2item`=0,`slot3item`=30580 WHERE `entry`=21859;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32676;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32677;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32678;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32679;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32680;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32681;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32683;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32684;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32685;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32686;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32687;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32688;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32689;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32690;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32691;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32692;
UPDATE `creature_spawns` SET `slot1item`=0,`slot2item`=0,`slot3item`=0 WHERE `entry`=32693;
UPDATE `creature_spawns` SET `slot1item`=49198,`slot2item`=0,`slot3item`=0 WHERE `entry`=36213;
