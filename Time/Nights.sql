CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event` IN (62,63);
INSERT INTO `active_event_id` (`active_event`, `name`) VALUES (63,"Night Time");

UPDATE `creature_spawns` SET `entry`=1892,`displayid`=574,`slot1item`=0, `slot2item`=0, `slot3item`=0 WHERE `entry`=1891;
UPDATE `creature_spawns` SET `entry`=1893,`displayid`=564,`slot1item`=0, `slot2item`=0, `slot3item`=0 WHERE `entry`=1894;
UPDATE `creature_spawns` SET `entry`=1896,`displayid`=729,`slot1item`=0, `slot2item`=0, `slot3item`=0 WHERE `entry`=1895;
UPDATE `creature_spawns` SET `entry`=3529,`displayid`=729,`slot1item`=0, `slot2item`=0, `slot3item`=0 WHERE `entry`=3528;
UPDATE `creature_spawns` SET `entry`=3531,`displayid`=729,`slot1item`=0, `slot2item`=0, `slot3item`=0 WHERE `entry`=3530;
UPDATE `creature_spawns` SET `entry`=3533,`displayid`=729,`slot1item`=0, `slot2item`=0, `slot3item`=0 WHERE `entry`=3532;


UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=143,`slot3item`=0 WHERE `entry`=68;
UPDATE `creature_spawns` SET `slot1item`=1905,`slot2item`=2715,`slot3item`=2551 WHERE `entry`=424;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2557,`slot3item`=2552 WHERE `entry`=727;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=143,`slot3item`=0 WHERE `entry`=1423;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=1735;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=1738;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=1742;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=1743;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=1744;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=1745;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=1746;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=143,`slot3item`=0 WHERE `entry`=1976;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=2209;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=2210;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3212;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3215;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3217;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3218;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3219;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3220;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3221;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3222;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3223;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=3224;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=5289,`slot3item`=0 WHERE `entry`=3296;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=3361,`slot3item`=2552 WHERE `entry`=3502;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=5598,`slot3item`=2550 WHERE `entry`=3571;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=5598,`slot3item`=2550 WHERE `entry`=4262;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=3361,`slot3item`=2552 WHERE `entry`=4624;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=6254,`slot3item`=0 WHERE `entry`=5595;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=5725;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=5289,`slot3item`=0 WHERE `entry`=5953;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=5291,`slot3item`=2552 WHERE `entry`=9460;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=11586,`slot3item`=2552 WHERE `entry`=11190;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2557,`slot3item`=2552 WHERE `entry`=13076;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=14882,`slot3item`=5261 WHERE `entry`=15184;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=16221;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=16222;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=24331,`slot3item`=0 WHERE `entry`=16733;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=5291,`slot3item`=2552 WHERE `entry`=16863;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=2023,`slot3item`=0 WHERE `entry`=16980;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=24331,`slot3item`=0 WHERE `entry`=18038;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=29124,`slot3item`=0 WHERE `entry`=18549;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=18568;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=29640,`slot3item`=30580 WHERE `entry`=19687;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=1905,`slot3item`=0 WHERE `entry`=21859;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32676;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32677;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32678;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32679;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32680;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32681;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32683;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32684;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32685;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32686;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32687;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32688;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32689;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32690;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32691;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32692;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=0,`slot3item`=0 WHERE `entry`=32693;
UPDATE `creature_spawns` SET `slot1item`=2715,`slot2item`=49198,`slot3item`=0 WHERE `entry`=36213;
