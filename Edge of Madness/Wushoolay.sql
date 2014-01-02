CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event` IN(53,54,55,56);
INSERT INTO `active_event_id` (`active_event`, `name`) VALUES (56,"Edge of Madness, Wushoolay");

DELETE FROM `creature_spawns` WHERE `entry` IN (15082,15083,15084,15085);
INSERT INTO `creature_spawns` (`id`, `entry`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `movetype`, `displayid`, `faction`, `flags`, `bytes0`, `bytes1`, `bytes2`, `emote_state`, `npc_respawn_link`, `channel_spell`, `channel_target_sqlid`, `channel_target_sqlid_creature`, `standstate`, `death_state`, `mountdisplayid`, `slot1item`, `slot2item`, `slot3item`, `CanFly`, `phase`) VALUES
	(137859,15085,309,-11850.8,-1891.27,64.09,2.96,0,15269,14,0,16777472,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1);

DELETE FROM `gameobject_spawns` WHERE `Entry`=180327;
INSERT INTO `gameobject_spawns` (`id`, `Entry`, `map`, `position_x`, `position_y`, `position_z`, `Facing`, `orientation1`, `orientation2`, `orientation3`, `orientation4`, `State`, `Flags`, `Faction`, `Scale`, `stateNpcLink`, `phase`, `overrides`) VALUES
	(79999,180327,309,-11887.1,-1889.8,63.5037,0.855211,0,0,0.414693,0.909961,1,0,0,2,0,1,0);
