--Gameobjects
local SILITHYST_MOUND = 181597
local SILITHYST_GEYSER = 181598
--Spells
local TRACES_OF_SILITHYST = 29534
local SILITHYST_SPELL = 29519
local SPELL_CENARION_FAVOR = 30754
 -- atrigger, team, vallue, quest, worldstate
local areatrigger_data = {
{4162, 0, 0, 9419, 2313},
{4168, 1, 0, 9422, 2314};
};
local buff_zones = {1377, 3428, 3429};
--Rewards
local REPUTATION_FACTION = 609
local REPUTATION_VALUE = 20
local HONOR_VALUE = 20
local zone_started = false
local captured = false
local TOTAL_COUNT_VAL = 200
--Zone
local ZONE_SILITHUS = 1377
--WorldStates
local TOTAL_COUNT = 2317
function Silithys_OnUse(go,_,player)
if(player:HasAura(SILITHYST_SPELL) == false)then
	if (player:IsMounted() == true) then
		player:Dismount()
	end
	player:AddAura(SILITHYST_SPELL, -1)
end
if(go:GetEntry() == SILITHYST_GEYSER)then
	go:Despawn(1, 180000)
else
	go:Despawn(1, -1)
end
end

function SilithusZoneReturn(event, player, AreaTriggerId)
for i = 1, #areatrigger_data do
	if(AreaTriggerId == areatrigger_data[i][1] and player:GetTeam() == areatrigger_data[i][2] and player:HasAura(SILITHYST_SPELL) and areatrigger_data[i][3] <= TOTAL_COUNT_VAL and captured == false)then
		player:CastSpell(TRACES_OF_SILITHYST)
		player:GiveHonor(HONOR_VALUE)
		player:RemoveAura(SILITHYST_SPELL)
			-- player:SetPlayerStanding(REPUTATION_FACTION,REPUTATION_VALUE)
		if(player:GetQuestObjectiveCompletion(areatrigger_data[i][4], 0) == 0)then
			player:AdvanceQuestObjective(areatrigger_data[i][4], 0)
		end
		if(areatrigger_data[i][3] < TOTAL_COUNT_VAL - 1)then
			areatrigger_data[i][3] = areatrigger_data[i][3] + 1
			player:SetWorldStateForZone(areatrigger_data[i][5],areatrigger_data[i][3])
		elseif(areatrigger_data[i][3] == TOTAL_COUNT_VAL - 1)then
			areatrigger_data[i][3] = areatrigger_data[i][3] + 1
			player:SetWorldStateForZone(areatrigger_data[i][5],areatrigger_data[i][3])
			captured = true
			for l = 1, #buff_zones do
				for k,v in pairs(GetPlayersInZone(buff_zones[l])) do
					if (v:GetTeam() == areatrigger_data[i][2]) then
						v:AddAura(SPELL_CENARION_FAVOR, 0)
					end
				end
			end
		end
	end
end
end

function OnZoneSI(event, player, ZoneId, OldZoneId)
if(zone_started == false and ZoneId == ZONE_SILITHUS)then
	player:SetWorldStateForZone(TOTAL_COUNT,TOTAL_COUNT_VAL)
	zone_started = true
end
buff = false
for l = 1, #buff_zones do
	if(ZoneId == buff_zones[l]) then
		buff = true
	end
	for i = 1, #areatrigger_data do
		if(player:GetTeam() == areatrigger_data[i][2] and areatrigger_data[i][3] == TOTAL_COUNT_VAL and buff == true)then
			player:AddAura(SPELL_CENARION_FAVOR, 0)
		else
			if(player:HasAura(SPELL_CENARION_FAVOR))then
				player:RemoveAura(SPELL_CENARION_FAVOR)
			end
		end
	end
end
buff = false
end

function OnSiJoin(event, player)
if(zone_started == false and player:GetZoneId() == ZONE_SILITHUS)then
	player:SetWorldStateForZone(TOTAL_COUNT,TOTAL_COUNT_VAL)
	zone_started = true
end
buff = false
for l = 1, #buff_zones do
	if(player:GetZoneId() == buff_zones[l]) then
		buff = true
		for i = 1, #areatrigger_data do
			if(player:GetTeam() == areatrigger_data[i][2] and areatrigger_data[i][3] == TOTAL_COUNT_VAL and buff == true)then
				player:AddAura(SPELL_CENARION_FAVOR, 0)
			end
		end
	end
end
buff = false
end

RegisterGameObjectEvent(SILITHYST_MOUND, 4, Silithys_OnUse)
RegisterGameObjectEvent(SILITHYST_GEYSER, 4, Silithys_OnUse)
RegisterServerHook(26, SilithusZoneReturn)
RegisterServerHook(15, OnZoneSI)
RegisterServerHook(4, OnSiJoin)