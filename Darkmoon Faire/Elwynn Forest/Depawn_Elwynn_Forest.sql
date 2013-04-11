DELETE FROM `creature_spawns` WHERE `id` BETWEEN '400078' AND '400104';
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN '505018' AND '505135';
DELETE FROM `creature_waypoints` WHERE `spawnid` IN (400098,400099);
