DELETE FROM `creature_quest_starter` WHERE `id` IN ('279', '5204', '6740', '6741') AND `quest` IN ('9025', '8980', '9027', '8983');
DELETE FROM `creature_quest_finisher` WHERE `id` IN ('279', '5204', '6740', '6741') AND `quest` IN ('9025', '8980', '9027', '8983');
DELETE FROM `creature_spawns` WHERE `id` BETWEEN '400059' AND '400075';
DELETE FROM `gameobject_spawns` WHERE `entry` IN ('181014', '181015', '181016', '181017', '181018', '181019', '181020', '181021', '181022', '181025', '181027', '181055', '181060');