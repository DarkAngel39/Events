local ALLY_QUEST = 11505
local HORDE_QUEST = 11506

local progress1 = 50
local progress2 = 50
local progress3 = 50
local progress4 = 50
local progress5 = 50

local a_towers = 0
local h_towers = 0

local zone_captured = 0
local minute = 0
local tenminute = 0
local hour = 6

local BAR_NEUTRAL =		80
local BAR_STATUS_1 =	(100 - BAR_NEUTRAL)/2

local WORLDSTATE_TK_ZONE_CAPTURABLE_UI = 2620
local WORLDSTATE_TK_ALLIANCE_TOWER_COUNT = 2621
local WORLDSTATE_TK_HORDE_TOWER_COUNT = 2622
local WORLDSTATE_TK_NEUTRAL_TIMER = 2508
local WORLDSTATE_TK_HOUR_TIMER_SET = 2509
local WORLDSTATE_TK_MINUTE_X1_TIMER_SET = 2510
local WORLDSTATE_TK_MINUTE_X10_TIMER_SET = 2512

local WORLDSTATE_CAPTUREBAR_DISPLAY =	2623
local WORLDSTATE_CAPTUREBAR_VALUE =		2625
local WORLDSTATE_CAPTUREBAR_VALUE_N =	2624

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
{183104,progress1,2681,2682,2683},
{183411,progress2,2686,2685,2684},
{183412,progress3,2690,2689,2688},
{183413,progress4,2696,2695,2694},
{183414,progress5,2693,2692,2691};
};


local self = getfenv(1)

function OnLoad(pGO)
pGO:RegisterAIUpdateEvent(1000)
self[tostring(pGO)] = {
plrvall = 0
}
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
				for k,v in pairs (pGO:GetInRangePlayers())do
					if(pGO:GetDistanceYards(v) <= 60 and v:GetQuestObjectiveCompletion(QUEST_A, 0) and v:GetTeam() == 0)then
						v:AdvanceQuestObjective(QUEST_A, 0)
					end
				end
			elseif(capturepoint_data[i][2] <= BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				h_towers = h_towers + 1
				pGO:SetWorldStateForZone(WORLDSTATE_TK_HORDE_TOWER_COUNT,h_towers)
				for k,v in pairs (pGO:GetInRangePlayers())do
					if(pGO:GetDistanceYards(v) <= 60 and v:GetQuestObjectiveCompletion(QUEST_H, 0) and v:GetTeam() == 1)then
						v:AdvanceQuestObjective(QUEST_H, 0)
					end
				end
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				h_towers = h_towers - 1
				pGO:SetWorldStateForZone(WORLDSTATE_TK_HORDE_TOWER_COUNT,h_towers)
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][5])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				a_towers = a_towers - 1
				pGO:SetWorldStateForZone(WORLDSTATE_TK_ALLIANCE_TOWER_COUNT,a_towers)
			end
		end
	end
end
vars.plrvall = 0
if(h_towers == 5 and zone_captured == 0)then
	zone_captured = 1
	minute = 0
	tenminute = 0
	hour = 6
	pGO:SetWorldStateForZone(WORLDSTATE_TK_ZONE_CAPTURABLE_UI,0)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X1_TIMER_SET,minute)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X10_TIMER_SET,tenminute)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_HOUR_TIMER_SET,hour)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_NEUTRAL_TIMER,1) -- This will be changed
elseif(a_towers == 5 and zone_captured == 0)then
	zone_captured = 1
	minute = 0
	tenminute = 0
	hour = 6
	pGO:SetWorldStateForZone(WORLDSTATE_TK_ZONE_CAPTURABLE_UI,0)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X1_TIMER_SET,minute)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_MINUTE_X10_TIMER_SET,tenminute)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_HOUR_TIMER_SET,hour)
	pGO:SetWorldStateForZone(WORLDSTATE_TK_NEUTRAL_TIMER,1) -- This will be changed
end
end

for i = 1, #capturepoint_data do
RegisterGameObjectEvent(capturepoint_data[i][1],5,AIUpdate)
RegisterGameObjectEvent(capturepoint_data[i][1],2,OnLoad)
end
