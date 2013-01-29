DELETE FROM `creature_quest_starter` WHERE `id` IN ('279', '5204', '6740', '6741') AND `quest` IN ('9025', '8980', '9027', '8983');
DELETE FROM `creature_quest_finisher` WHERE `id` IN ('279', '5204', '6740', '6741') AND `quest` IN ('9025', '8980', '9027', '8983');
DELETE FROM `creature_spawns` WHERE `id` BETWEEN '400059' AND '400181';
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN '210001' AND '211444';