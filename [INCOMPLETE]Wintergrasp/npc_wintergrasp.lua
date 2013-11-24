local FACTION_HORDE = 1735
local FACTION_ALLIANCE = 1732

local NPC_VEHICLE_CATAPULT = 27881
local NPC_VEHICLE_DEMOLISHER = 28094
local NPC_VEHICLE_SIEGE_ENGINE_H = 32627
local NPC_VEHICLE_SIEGE_ENGINE_A = 28312

local WG_STATE_CURRENT_A_VEHICLES = 3680
local WG_STATE_CURRENT_H_VEHICLES = 3490

local SPELL_A_FLAG = 14268
local SPELL_H_FLAG = 14267

function OnSpawn(pUnit, event)
if(pUnit:GetFaction() == FACTION_HORDE)then
	pUnit:SetWorldStateForZone(WG_STATE_CURRENT_H_VEHICLES, pUnit:GetWorldStateForZone(WG_STATE_CURRENT_H_VEHICLES) + 1)
	pUnit:CastSpell(SPELL_H_FLAG)
elseif(pUnit:GetFaction() == FACTION_ALLIANCE)then
	pUnit:SetWorldStateForZone(WG_STATE_CURRENT_A_VEHICLES, pUnit:GetWorldStateForZone(WG_STATE_CURRENT_A_VEHICLES) + 1)
	pUnit:CastSpell(SPELL_A_FLAG)
end
end

function OnDied(pUnit, event, pLastTarget)
if(pUnit:GetFaction() == FACTION_HORDE)then
	pUnit:SetWorldStateForZone(WG_STATE_CURRENT_H_VEHICLES, pUnit:GetWorldStateForZone(WG_STATE_CURRENT_H_VEHICLES) - 1)
	pUnit:Despawn(15000,0)
elseif(pUnit:GetFaction() == FACTION_ALLIANCE)then
	pUnit:SetWorldStateForZone(WG_STATE_CURRENT_A_VEHICLES, pUnit:GetWorldStateForZone(WG_STATE_CURRENT_A_VEHICLES) - 1)
	pUnit:Despawn(15000,0)
end
end

RegisterUnitEvent(NPC_VEHICLE_CATAPULT,18,OnSpawn)
RegisterUnitEvent(NPC_VEHICLE_DEMOLISHER,18,OnSpawn)
RegisterUnitEvent(NPC_VEHICLE_SIEGE_ENGINE_H,18,OnSpawn)
RegisterUnitEvent(NPC_VEHICLE_SIEGE_ENGINE_A,18,OnSpawn)

RegisterUnitEvent(NPC_VEHICLE_CATAPULT,4,OnDied)
RegisterUnitEvent(NPC_VEHICLE_DEMOLISHER,4,OnDied)
RegisterUnitEvent(NPC_VEHICLE_SIEGE_ENGINE_H,4,OnDied)
RegisterUnitEvent(NPC_VEHICLE_SIEGE_ENGINE_A,4,OnDied)
