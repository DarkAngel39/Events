local a_towers = 0
local h_towers = 0
local zone_captured = 0
local tenminute = 0
local hour = 6

local BAR_NEUTRAL = 80
local BAR_STATUS_1 = (100 - BAR_NEUTRAL)/2

local WORLDSTATE_TK_ZONE_CAPTURABLE_UI = 2620
local WORLDSTATE_TK_ALLIANCE_TOWER_COUNT = 2621
local WORLDSTATE_TK_HORDE_TOWER_COUNT = 2622
local WORLDSTATE_TK_NEUTRAL_TIMER = 2508
local WORLDSTATE_TK_ALLIANCE_TIMER = 2767
local WORLDSTATE_TK_HORDE_TIMER = 2768
local WORLDSTATE_TK_HOUR_TIMER_SET = 2509
  -- local WORLDSTATE_TK_MINUTE_X1_TIMER_SET = 2510 -- Obsolite?
local WORLDSTATE_TK_MINUTE_X10_TIMER_SET = 2512

local WORLDSTATE_CAPTUREBAR_DISPLAY =	2623
local WORLDSTATE_CAPTUREBAR_VALUE =		2625
local WORLDSTATE_CAPTUREBAR_VALUE_N =	2624

local SPELL_TF_BUFF = 33377

local GAMEOBJECT_BYTES_1 = 0x0006 + 0x000B

local QUEST_A = 11505
local QUEST_H = 11506

local ZONE_TK = 3519
local buff_zones = {
    ZONE_TK, -- Terokkar Forest
    3791, -- Sethekk Halls
    3789, -- Shadow Labyrinth
    3792, -- Mana-Tombs
    3790 -- Auchenai Crypts
};

 -- N,H,A
local capturepoint_data = {
{183104,50,2681,2682,2683,0},
{183411,50,2686,2685,2684,0},
{183412,50,2690,2689,2688,0},
{183413,50,2696,2695,2694,0},
{183414,50,2693,2692,2691,0};
};

local self = getfenv(1)

function OnLoad(pGO)
pGO:RegisterAIUpdateEvent(1000)
self[tostring(pGO)] = {
plrvall = 0
}
for i = 1, #capturepoint_data do
	if(pGO:GetEntry() == capturepoint_data[i][1] and capturepoint_data[i][2] >= 100 - BAR_STATUS_1)then
		pGO:SetByte(GAMEOBJECT_BYTES_1,2,2)
	elseif(pGO:GetEntry() == capturepoint_data[i][1] and capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1)then
		pGO:SetByte(GAMEOBJECT_BYTES_1,2,21)
	elseif(pGO:GetEntry() == capturepoint_data[i][1] and capturepoint_data[i][2] <= BAR_STATUS_1)then
		pGO:SetByte(GAMEOBJECT_BYTES_1,2,1)
	end
end
end

function AIUpdate(pGO)
if(pGO == nil)then
	pGO:RemoveAIUpdateEvent()
end
local vars = self[tostring(pGO)]
for k,m in pairs (pGO:GetInRangePlayers())do
if(m and m:IsPvPFlagged() and m:IsStealthed() == false and m:IsAlive() and zone_captured ~= 1)then
	if(pGO:GetDistanceYards(m) <= 60)then
		if(m:GetTeam() == 0)then
			vars.plrvall = vars.plrvall + 1
		elseif(m:GetTeam() == 1)then
			vars.plrvall = vars.plrvall - 1
		end
	end
end
end
	for i = 1, #capturepoint_data do
	if(pGO:GetEntry() == capturepoint_data[i][1])then
		for k,v in pairs (pGO:GetInRangePlayers())do
		if(v and v:IsPvPFlagged() and v:IsStealthed() == false and v:IsAlive())then
			if(pGO:GetDistanceYards(v) <= 60)then
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_DISPLAY,1)
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE,capturepoint_data[i][2])
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE_N,BAR_NEUTRAL)
			elseif(pGO:GetDistanceYards(v) > 60 and pGO:GetDistanceYards(v) < 180)then
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_DISPLAY,0)
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE,0)
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE_N,0)
			end
		end
		end
		if(capturepoint_data[i][2] + (vars.plrvall/2) < 100 and capturepoint_data[i][2] + (vars.plrvall/2) > 0)then
			capturepoint_data[i][2] = capturepoint_data[i][2] + (vars.plrvall/2)
		elseif(capturepoint_data[i][2] + (vars.plrvall/2) >= 100)then
			capturepoint_data[i][2] = 100
		elseif(capturepoint_data[i][2] + (vars.plrvall/2) <= 0)then
			capturepoint_data[i][2] = 0
		end
		if(pGO:GetClosestPlayer())then
			if(capturepoint_data[i][2] >= 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][5])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				a_towers = a_towers + 1
				pGO:SetWorldStateForZone(WORLDSTATE_TK_ALLIANCE_TOWER_COUNT,a_towers)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,2)
				for k,v in pairs (pGO:GetInRangePlayers())do
					if(pGO:GetDistanceYards(v) <= 60 and v:GetQuestObjectiveCompletion(QUEST_A, 0) and v:GetTeam() == 0)then
						v:AdvanceQuestObjective(QUEST_A, 0)
					end
				end
				capturepoint_data[i][6] = 1
			elseif(capturepoint_data[i][2] <= BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				h_towers = h_towers + 1
				pGO:SetWorldStateForZone(WORLDSTATE_TK_HORDE_TOWER_COUNT,h_towers)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,1)
				for k,v in pairs (pGO:GetInRangePlayers())do
					if(pGO:GetDistanceYards(v) <= 60 and v:GetQuestObjectiveCompletion(QUEST_H, 0) and v:GetTeam() == 1)then
						v:AdvanceQuestObjective(QUEST_H, 0)
					end
				end
				capturepoint_data[i][6] = 1
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				h_towers = h_towers - 1
				pGO:SetWorldStateForZone(WORLDSTATE_TK_HORDE_TOWER_COUNT,h_towers)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,21)
				capturepoint_data[i][6] = 0
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][5])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				a_towers = a_towers - 1
				pGO:SetWorldStateForZone(WORLDSTATE_TK_ALLIANCE_TOWER_COUNT,a_towers)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,21)
				capturepoint_data[i][6] = 0
			end
		end
	end
end
vars.plrvall = 0
if(zone_captured == 3)then
	local reset = true
	for i = 1, #capturepoint_data do
		if(capturepoint_data[i][6] == 1)then
			reset = false
		end
	end
	if(reset == true)then
		zone_captured = 0
	end
end
if((h_towers == 5 or a_towers == 5) and zone_captured == 0)then
	zone_captured = 1
	tenminute = 0
	hour = 6
	pGO:SetWorldStateForZone(WORLDSTATE_TK_ZONE_CAPTURABLE_UI,0)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X10_TIMER_SET,tenminute)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_HOUR_TIMER_SET,hour)
	if(h_towers == 5)then
		pGO:SetWorldStateForZone(WORLDSTATE_TK_HORDE_TIMER,1)
	elseif(a_towers == 5)then
		pGO:SetWorldStateForZone(WORLDSTATE_TK_ALLIANCE_TIMER,1)
	end
	for f = 1,#buff_zones do
		for k,g in pairs(GetPlayersInZone(buff_zones[f]))do
			if((g:GetTeam() == 0 and a_towers == 5) or (g:GetTeam() == 1 and h_towers == 5))then
				if not(g:HasAura(SPELL_TF_BUFF))then
					g:CastSpell(SPELL_TF_BUFF)
				end
			end
		end
	end
	RegisterTimedEvent("TKUpdate", 60000, 0)
end
end

function TKUpdate()
if(hour > 0 and tenminute > 0)then
	tenminute = tenminute - 1
elseif(hour > 0 and tenminute == 0)then
	hour = hour - 1
	tenminute = 59
elseif(hour == 0 and tenminute == 0)then
	zone_captured = 2
end
	for k,l in pairs(GetPlayersInZone(ZONE_TK))do
		if(zone_captured == 2)then
			zone_captured = 3
			l:SetWorldStateForZone(WORLDSTATE_TK_ZONE_CAPTURABLE_UI,1)
			l:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X10_TIMER_SET,0)
			l:SetWorldStateForZone(WORLDSTATE_TK_HOUR_TIMER_SET,0)
			l:SetWorldStateForZone(WORLDSTATE_TK_ALLIANCE_TIMER,0)
			l:SetWorldStateForZone(WORLDSTATE_TK_HORDE_TIMER,0)
			l:SetWorldStateForZone(WORLDSTATE_TK_HORDE_TOWER_COUNT,h_towers)
			l:SetWorldStateForZone(WORLDSTATE_TK_ALLIANCE_TOWER_COUNT,a_towers)
			zone_captured = 0
			tenminute = 0
			hour = 6
			for f = 1,#buff_zones do
				for k,g in pairs(GetPlayersInZone(buff_zones[f]))do
					if(g:HasAura(SPELL_TF_BUFF))then
						g:RemoveAura(SPELL_TF_BUFF)
					end
				end
			end
			RemoveTimedEvent("TKUpdate")
		else
			l:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X10_TIMER_SET,tenminute)
			l:SetWorldStateForZone(WORLDSTATE_TK_HOUR_TIMER_SET,hour)
		end
	end
end

function OnZone(event, pPlayer, ZoneId, OldZoneId)
if(zone_captured == 1)then
	if(ZoneId == ZONE_TK)then
		pPlayer:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X10_TIMER_SET,tenminute)
		pPlayer:SetWorldStateForZone(WORLDSTATE_TK_HOUR_TIMER_SET,hour)
	end
	local buffme = false
	for i = 1,#buff_zones do
		if(ZoneId == buff_zones[i])then
			buffme = true
		end
	end
	if(buffme == true and ((pPlayer:GetTeam() == 0 and a_towers == 5) or (pPlayer:GetTeam() == 1 and h_towers == 5)))then
		if not(pPlayer:HasAura(SPELL_TF_BUFF))then
			pPlayer:CastSpell(SPELL_TF_BUFF)
		end
	else
		if(pPlayer:HasAura(SPELL_TF_BUFF))then
			pPlayer:RemoveAura(SPELL_TF_BUFF)
		end
	end
end
end

function OnLogin(event, pPlayer)
local ZoneId = pPlayer:GetZoneId()
if(zone_captured == 1)then
	if(ZoneId == ZONE_TK)then
		pPlayer:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X10_TIMER_SET,tenminute)
		pPlayer:SetWorldStateForZone(WORLDSTATE_TK_HOUR_TIMER_SET,hour)
	end
	local buffme = false
	for i = 1,#buff_zones do
		if(ZoneId == buff_zones[i])then
			buffme = true
		end
	end
	if(buffme == true and ((pPlayer:GetTeam() == 0 and a_towers == 5) or (pPlayer:GetTeam() == 1 and h_towers == 5)))then
		if not(pPlayer:HasAura(SPELL_TF_BUFF))then
			pPlayer:CastSpell(SPELL_TF_BUFF)
		end
	else
		if(pPlayer:HasAura(SPELL_TF_BUFF))then
			pPlayer:RemoveAura(SPELL_TF_BUFF)
		end
	end
end
end

for i = 1, #capturepoint_data do
RegisterGameObjectEvent(capturepoint_data[i][1],5,AIUpdate)
RegisterGameObjectEvent(capturepoint_data[i][1],2,OnLoad)
end

RegisterServerHook(15,OnZone)
RegisterServerHook(3,OnLogin)
