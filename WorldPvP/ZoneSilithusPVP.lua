--Gameobjects
local SILITHYST_MOUND = 181597
local SILITHYST_GEYSER = 181598

--Spells
local TRACES_OF_SILITHYST = 29534
local SILITHYST_SPELL = 29519
local SPELL_CENARION_FAVOR = 30754

--Areatriggers
local ALLIANCE_RETURN = 4162
local HORDE_RETURN = 4168

--Quests
local ALLIANCE_QUEST = 9419
local HORDE_QUEST = 9422

--Rewards
local REPUTATION_FACTION = 609
local REPUTATION_VALUE = 20
local HONOR_VALUE = 20

--Zone
local ZONE_SILITHUS = 1377

--WorldStates
local HORDE_COUNT = 2314
local ALLIANCE_COUNT = 2313
local TOTAL_COUNT = 2317
local TOTAL_COUNT_VAL = 200

--Other locals Requred for controlling the zone, because the player does not support the "GetWorldState" method.
local captureALLIANCE = 0
local captureHORDE = 0

function SilithysMound_OnUse(go,_,player)
if (player:HasAura(SILITHYST_SPELL) == false) then
	if (player:IsMounted() == true) then
		player:Dismount()
	end
	player:AddAura(SILITHYST_SPELL, -1)
	go:Despawn(1, -1) -- These respawn timers are not exact perhaps. I have no idea what is the blizzlike value. Set to 5 min.
else
	go:Despawn(1, -1) -- These respawn timers are not exact perhaps. I have no idea what is the blizzlike value. Set to 5 min.
end
end

function SilithysGeyser_OnUse(go,_,player)
if (player:HasAura(SILITHYST_SPELL) == false) then
	if (player:IsMounted() == true) then
		player:Dismount()
	end
	player:AddAura(SILITHYST_SPELL, -1)
	go:Despawn(1, 180000) -- These respawn timers are not exact perhaps. I have no idea what is the blizzlike value. Set to 5 min.
else
	go:Despawn(1, 180000) -- These respawn timers are not exact perhaps. I have no idea what is the blizzlike value. Set to 5 min.
end
end

function SilithusZoneReturn(event, player, AreaTriggerId)
local zoneid = player:GetZoneId()
if (zoneid == ZONE_SILITHUS) then
	local PLRrace = player:GetTeam()
	if (AreaTriggerId == ALLIANCE_RETURN) then
		if (player:HasAura(SILITHYST_SPELL) == true) then
			if (PLRrace == 0)then -- If horde are not winners yet
			if (captureHORDE < TOTAL_COUNT_VAL)then
				player:RemoveAura(SILITHYST_SPELL)
				if player:HasAura(TRACES_OF_SILITHYST) then
					player:RemoveAura(TRACES_OF_SILITHYST)
				end
				player:CastSpell(TRACES_OF_SILITHYST)
				if (player:GetQuestObjectiveCompletion(ALLIANCE_QUEST, 0) == 0) then
					player:AdvanceQuestObjective(ALLIANCE_QUEST, 0)
				end
				local repA = player:GetStanding(REPUTATION_FACTION)
				if (repA < 42000) then
					player:SetStanding(REPUTATION_FACTION, repA + REPUTATION_VALUE)
				end
				player:GiveHonor(HONOR_VALUE)
				if (captureALLIANCE == nil) then
					captureALLIANCE = 0
				end
				local captureALLIANCE1 = (captureALLIANCE + 1)
				if (captureALLIANCE1 < TOTAL_COUNT_VAL) then
					player:SetWorldStateForZone(ALLIANCE_COUNT, captureALLIANCE1)
					captureALLIANCE = captureALLIANCE1
				elseif (captureALLIANCE1 == TOTAL_COUNT_VAL) then
					player:SetWorldStateForZone(ALLIANCE_COUNT, TOTAL_COUNT_VAL)
					captureALLIANCE = TOTAL_COUNT_VAL
					for k,v in pairs(GetPlayersInWorld()) do
						if (v:GetZoneId() == ZONE_SILITHUS) then
							if (v:GetTeam() == 0) then
								v:AddAura(SPELL_CENARION_FAVOR, 0)
							end
						end
					end
				end
			end
			end
		end
	elseif(AreaTriggerId == HORDE_RETURN) then
	if (player:HasAura(SILITHYST_SPELL) == true) then
			if (PLRrace == 1)then
			if (captureALLIANCE < TOTAL_COUNT_VAL)then -- If alliance are not winners yet
				player:RemoveAura(SILITHYST_SPELL)
				if player:HasAura(TRACES_OF_SILITHYST) then
					player:RemoveAura(TRACES_OF_SILITHYST)
				end
				player:CastSpell(TRACES_OF_SILITHYST)
				if (player:GetQuestObjectiveCompletion(HORDE_QUEST, 0) == 0) then
					player:AdvanceQuestObjective(HORDE_QUEST, 0)
				end
				local repH = player:GetStanding(REPUTATION_FACTION)
				if (repH < 42000) then
					player:SetStanding(REPUTATION_FACTION, repH + REPUTATION_VALUE)
				end
				player:GiveHonor(HONOR_VALUE)
				if (captureHORDE == nil) then
					captureHORDE = 0
				end
				local captureHORDE1 = (captureHORDE + 1)
				if (captureHORDE1 < TOTAL_COUNT_VAL) then
					player:SetWorldStateForZone(HORDE_COUNT, captureHORDE1)
					captureHORDE = captureHORDE1
				elseif (captureHORDE1 == TOTAL_COUNT_VAL) then
					player:SetWorldStateForZone(HORDE_COUNT, TOTAL_COUNT_VAL)
					captureHORDE = TOTAL_COUNT_VAL
					for k,v in pairs(GetPlayersInWorld()) do
						if (v:GetZoneId() == ZONE_SILITHUS) then
							if (v:GetTeam() == 1) then
								v:AddAura(SPELL_CENARION_FAVOR, 0)
							end
						end
					end
				end
				end
			end
		end
	end
end
end

function OnZoneSI(event, player, ZoneId, OldZoneId)
local PlayerZone = player:GetZoneId() -- Am i in Silithus?
local team = player:GetTeam() -- What team am i? (alliance = 0, horde = 1)
if (PlayerZone == ZONE_SILITHUS) then
	player:SetWorldStateForZone(TOTAL_COUNT, TOTAL_COUNT_VAL)
	if (team == 1) then
		if (captureHORDE == TOTAL_COUNT_VAL) then
			if (player:HasAura(SPELL_CENARION_FAVOR) == false) then
				player:AddAura(SPELL_CENARION_FAVOR, 0)
			end
		else
			if (player:HasAura(SPELL_CENARION_FAVOR) == true) then
				player:RemoveAura(SPELL_CENARION_FAVOR)
			end
		end
	elseif (team == 0) then
		if (captureALLIANCE == TOTAL_COUNT_VAL) then
			if (player:HasAura(SPELL_CENARION_FAVOR) == false) then
				player:AddAura(SPELL_CENARION_FAVOR, 0)
			end
		else
			if (player:HasAura(SPELL_CENARION_FAVOR) == true) then
				player:RemoveAura(SPELL_CENARION_FAVOR)
			end
		end
	end
end
end

function OnSiJoin(event, player)
local team = player:GetTeam()
local logzone = player:GetZoneId()
if (logzone == ZONE_SILITHUS) then
	player:SetWorldStateForZone(TOTAL_COUNT, TOTAL_COUNT_VAL)
		if (team == 1) then
		if (captureHORDE == TOTAL_COUNT_VAL) then
			if (player:HasAura(SPELL_CENARION_FAVOR) == false) then
				player:AddAura(SPELL_CENARION_FAVOR, 0)
			end
		else
			if (player:HasAura(SPELL_CENARION_FAVOR) == true) then
				player:RemoveAura(SPELL_CENARION_FAVOR)
			end
		end
	elseif (team == 0) then
		if (captureALLIANCE == TOTAL_COUNT_VAL) then
			if (player:HasAura(SPELL_CENARION_FAVOR) == false) then
				player:AddAura(SPELL_CENARION_FAVOR, 0)
			end
		else
			if (player:HasAura(SPELL_CENARION_FAVOR) == true) then
				player:RemoveAura(SPELL_CENARION_FAVOR)
			end
		end
	end
end
end

RegisterGameObjectEvent(SILITHYST_MOUND, 4, SilithysMound_OnUse)
RegisterGameObjectEvent(SILITHYST_GEYSER, 4, SilithysGeyser_OnUse)
RegisterServerHook(26, SilithusZoneReturn)
RegisterServerHook(15, OnZoneSI)
RegisterServerHook(4, OnSiJoin)