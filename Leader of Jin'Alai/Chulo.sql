CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event` IN(57,58,59);
INSERT INTO `active_event_id` (`active_event`, `name`) VALUES (59,"Leader of Jin'Alai, Chulo");

DELETE FROM `creature_spawns` WHERE `entry` IN (28494,28495,28496);
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `movetype`, `displayid`, `faction`, `flags`, `bytes0`, `bytes1`, `bytes2`, `emote_state`, `npc_respawn_link`, `channel_spell`, `channel_target_sqlid`, `channel_target_sqlid_creature`, `standstate`, `death_state`, `mountdisplayid`, `slot1item`, `slot2item`, `slot3item`, `CanFly`, `phase`) VALUES
	(137869,28496,571,5495.51,-3426.83,350.5,5.53712,0,25485,2069,0,131584,0,0,0,0,0,0,0,0,0,0,2827,2827,0,0,1);
