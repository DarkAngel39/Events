CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event` IN(57,58,59);
INSERT INTO `active_event_id` (`active_event`, `name`) VALUES (57,"Leader of Jin'Alai, Kutube'sa");

DELETE FROM `creature_spawns` WHERE `entry` IN (28494,28495,28496);
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `movetype`, `displayid`, `faction`, `flags`, `bytes0`, `bytes1`, `bytes2`, `emote_state`, `npc_respawn_link`, `channel_spell`, `channel_target_sqlid`, `channel_target_sqlid_creature`, `standstate`, `death_state`, `mountdisplayid`, `slot1item`, `slot2item`, `slot3item`, `CanFly`, `phase`) VALUES
	(137869,28494,571,5582.36,-3511.86,350.328,2.19524,0,27833,2069,0,16777472,0,0,0,0,0,0,0,0,0,0,14879,0,0,0,1);
