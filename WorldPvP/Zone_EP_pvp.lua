local WORLDSTATE_CAPTUREBAR_DISPLAY =	2426
local WORLDSTATE_CAPTUREBAR_VALUE =		2427
local WORLDSTATE_CAPTUREBAR_VALUE_N =	2428
local WORLDSTATE_TOWER_COUNT_A =		2327
local WORLDSTATE_TOWER_COUNT_H =		2328
local GO_T_FLAG = 182106
local NPC_
local ZONE_EP = 139

local BAR_NEUTRAL =		20
local BAR_STATUS_1 =	(100 - BAR_NEUTRAL)/2

local bar_et = 50
local bar_nt = 50
local bar_tp = 50
local bar_cg = 50

local a_tower_num = 0
local h_tower_num = 0

local buffs = {
{11413, 30880, 1},
{11414, 30683, 2},
{11415, 30682, 3},
{1386, 29520, 4};
};

 -- Entry, controller,  N,  A,  H,   AN,  HN
local capturepoint_data = {
{182097, bar_et, 2361, 2354, 2356, 2359, 2360, 17690, 2271}, -- Eastwall Tower
{181899, bar_nt, 2352, 2372, 2373, 2362, 2363, 17696, 2275}, -- Northpass Tower
{182098, bar_tp, 2353, 2370, 2371, 2366, 2353, 17698, 4067}, -- Plaugewood Tower
{182096, bar_cg, 2355, 2378, 2379, 2374, 2375, 17689, 2263}; -- Crown Guard Tower
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
if( m and m:IsPvPFlagged() and m:IsStealthed() == false and m:IsAlive())then
	if(pGO:GetDistanceYards(m) <= 80)then
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
			if(v:GetAreaId() == capturepoint_data[i][9] and pGO:GetDistanceYards(v) <= 80)then
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_DISPLAY,1)
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE,capturepoint_data[i][2])
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE_N,BAR_NEUTRAL)
			elseif(v:GetAreaId() == capturepoint_data[i][9] and pGO:GetDistanceYards(v) > 80)then
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_DISPLAY,0)
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE,0)
				v:SetWorldStateForPlayer(WORLDSTATE_CAPTUREBAR_VALUE_N,0)
			end
		end
		end
		if(capturepoint_data[i][2] + (vars.plrvall/2) < 100 and capturepoint_data[i][2] + (vars.plrvall/2) > 0)then
			capturepoint_data[i][2] = capturepoint_data[i][2] + (vars.plrvall/20)
		elseif(capturepoint_data[i][2] + (vars.plrvall/2) >= 100)then
			capturepoint_data[i][2] = 100
		elseif(capturepoint_data[i][2] + (vars.plrvall/2) <= 0)then
			capturepoint_data[i][2] = 0
		end
		if(pGO:GetClosestPlayer())then
			if(capturepoint_data[i][2] >= 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 80)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				a_tower_num = a_tower_num + 1
				pGO:SetWorldStateForZone(WORLDSTATE_TOWER_COUNT_A,a_tower_num)
			elseif(capturepoint_data[i][2] <= BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][5])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 80)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				h_tower_num = h_tower_num + 1
				pGO:SetWorldStateForZone(WORLDSTATE_TOWER_COUNT_H,h_tower_num)
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][5])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 80)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				a_tower_num = a_tower_num - 1
				pGO:SetWorldStateForZone(WORLDSTATE_TOWER_COUNT_A,a_tower_num)
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 80)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				h_tower_num = h_tower_num - 1
				pGO:SetWorldStateForZone(WORLDSTATE_TOWER_COUNT_H,h_tower_num)
			end
		end
	end
end
vars.plrvall = 0
end

for i = 1, #capturepoint_data do
RegisterGameObjectEvent(capturepoint_data[i][1],5,AIUpdate)
RegisterGameObjectEvent(capturepoint_data[i][1],2,OnLoad)
end
