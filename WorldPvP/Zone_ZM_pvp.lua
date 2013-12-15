local WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL	= 2647
local WORLDSTATE_ZM_TWINSPIRE_GY_ALLIANCE	= 2648
local WORLDSTATE_ZM_TWINSPIRE_GY_HORDE		= 2649
local WORLDSTATE_ZM_A_FLAG_AVAILABLE		= 2655
local WORLDSTATE_ZM_A_FLAG_UNAVAILABLE		= 2656
local WORLDSTATE_ZM_H_FLAG_UNAVAILABLE		= 2657
local WORLDSTATE_ZM_H_FLAG_AVAILABLE		= 2658

local BAR_NEUTRAL =		80
local BAR_STATUS_1 =	(100 - BAR_NEUTRAL)/2
local add_banner = false
local h_t = 0
local a_t = 0
controll_team = 10

local ZM_BUFF =			33779
local ZM_STANDARD_A =	32430
local ZM_STANDARD_H =	32431
local ZM_AK =			32155
local ZM_HK =			32158

local HORDE_SCOUT =		18564
local ALLIANCE_SCOUT =	18581

local A_BANNER = 182527
local H_BANNER = 182528
local N_BANNER = 182529

local ZONE_ZM = 3521

local GAMEOBJECT_BYTES_1 = 0x0006+0x000B
local GAMEOBJECT_DYNAMIC = 0x0006+0x0008

local self = getfenv(1)

 --e,     p   A,    H,   N,    UIA,  UIH, UIN,   SD,   SN,   SV,    name
local capturepoint_data = {
{182522, 50, 2644, 2645, 2646, 2555, 2556, 2557, 2527, 2529, 2528, "West Beacon"}, -- W
{182523, 50, 2650, 2651, 2652, 2558, 2559, 2560, 2533, 2535, 2534, "East Beacon"}; -- E
};

local buff_zone = {3521, 3607, 3717, 3715, 3716};

PerformIngameSpawn(2,N_BANNER,530,253.54,7083.81,36.7728,-0.017453,200,0)

function OnLoad(pGO)
pGO:RegisterAIUpdateEvent(500)
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
		if(pGO:GetEntry() == capturepoint_data[i][1] and pGO:GetClosestPlayer())then
			for k,v in pairs (pGO:GetInRangePlayers())do
			if(v and v:IsPvPFlagged() and v:IsStealthed() == false and v:IsAlive())then
				if(pGO:GetDistanceYards(v) <= 60)then
					v:SetWorldStateForPlayer(capturepoint_data[i][9],1)
					v:SetWorldStateForPlayer(capturepoint_data[i][11],capturepoint_data[i][2])
					v:SetWorldStateForPlayer(capturepoint_data[i][10],BAR_NEUTRAL)
				elseif(pGO:GetDistanceYards(v) > 60)then
					v:SetWorldStateForPlayer(capturepoint_data[i][9],0)
					v:SetWorldStateForPlayer(capturepoint_data[i][11],0)
					v:SetWorldStateForPlayer(capturepoint_data[i][10],0)
				end
			else
				v:SetWorldStateForPlayer(capturepoint_data[i][9],0)
				v:SetWorldStateForPlayer(capturepoint_data[i][11],0)
				v:SetWorldStateForPlayer(capturepoint_data[i][10],0)
			end
			end
			if(capturepoint_data[i][2] + (vars.plrvall/2) < 100 and capturepoint_data[i][2] + (vars.plrvall/2) > 0)then
				capturepoint_data[i][2] = capturepoint_data[i][2] + (vars.plrvall/2)
			elseif(capturepoint_data[i][2] + (vars.plrvall/2) >= 100)then
				capturepoint_data[i][2] = 100
			elseif(capturepoint_data[i][2] + (vars.plrvall/2) <= 0)then
				capturepoint_data[i][2] = 0
			end
			if(capturepoint_data[i][2] >= 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][3])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][6],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][7],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][8],0)
				a_t = a_t + 1
				for k,v in pairs (GetPlayersInZone(ZONE_ZM))do
					v:SendBroadcastMessage("The "..capturepoint_data[i][12].." was taken by the alliance!|r")
				end
			elseif(capturepoint_data[i][2] <= BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][6],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][7],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][8],0)
				h_t = h_t + 1
				for k,v in pairs (GetPlayersInZone(ZONE_ZM))do
					v:SendBroadcastMessage("The "..capturepoint_data[i][12].." was taken by the horde!|r")
				end
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][3])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][5],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][6],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][7],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][8],1)
				a_t = a_t - 1
				for k,v in pairs (GetPlayersInZone(ZONE_ZM))do
					v:SendBroadcastMessage("The alliance lost the "..capturepoint_data[i][12].."!|r")
					if(v:HasAura(ZM_STANDARD_A))then
						v:RemoveAura(ZM_STANDARD_A)
					end
				end
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][5],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][6],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][7],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][8],1)
				h_t = h_t - 1
				for k,v in pairs (GetPlayersInZone(ZONE_ZM))do
					v:SendBroadcastMessage("The horde lost the "..capturepoint_data[i][12].."!|r")
					if(v:HasAura(ZM_STANDARD_H))then
						v:RemoveAura(ZM_STANDARD_H)
					end
				end
			end
		end
	end
if(a_t == 2 and pGO:GetWorldStateForZone(WORLDSTATE_ZM_A_FLAG_AVAILABLE) ~= 1)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_A_FLAG_AVAILABLE,1)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_A_FLAG_UNAVAILABLE,0)
elseif(a_t ~= 2 and pGO:GetWorldStateForZone(WORLDSTATE_ZM_A_FLAG_AVAILABLE) == 1)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_A_FLAG_AVAILABLE,0)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_A_FLAG_UNAVAILABLE,1)
elseif(h_t == 2 and pGO:GetWorldStateForZone(WORLDSTATE_ZM_H_FLAG_AVAILABLE) ~= 1)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_H_FLAG_UNAVAILABLE,0)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_H_FLAG_AVAILABLE,1)
elseif(h_t ~= 2 and pGO:GetWorldStateForZone(WORLDSTATE_ZM_H_FLAG_AVAILABLE) == 1)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_H_FLAG_UNAVAILABLE,1)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_H_FLAG_AVAILABLE,0)
end
vars.plrvall = 0
end

function BannerOnLoad(pGO)
pGO:SetByte(GAMEOBJECT_BYTES_1, 0, 1)
pGO:SetByte(GAMEOBJECT_BYTES_1, 3, 100)
pGO:SetUInt32Value(GAMEOBJECT_DYNAMIC, 1)
if(pGO:GetEntry()==A_BANNER and pGO:GetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_ALLIANCE)~=1)then
	pGO:Despawn(1,0)
elseif(pGO:GetEntry()==H_BANNER and pGO:GetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_HORDE)~=1)then
	pGO:Despawn(1,0)
elseif(pGO:GetEntry()==N_BANNER and pGO:GetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL)~=1)then
	pGO:Despawn(1,0)
end
end

local ZM_STANDARD_A =	32430
local ZM_STANDARD_H =	32431

function OnUse(pGO, event, pPlayer)
pPlayer:SendAreaTriggerMessage("1111")
rebuff = false
if(pGO:GetEntry() == N_BANNER and pPlayer:HasAura(ZM_STANDARD_H) and pGO:GetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL)==1 and h_t == 2)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_ALLIANCE,0)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_HORDE,1)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL,0)
	PerformIngameSpawn(2,H_BANNER,530,253.54,7083.81,36.7728,-0.017453,200,0)
	controll_team = 1
	rebuff = true
	pGO:Despawn(1,0)
	pPlayer:SendAreaTriggerMessage("2222")
elseif(pGO:GetEntry() == N_BANNER and pPlayer:HasAura(ZM_STANDARD_A) and pGO:GetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL)==1 and a_t == 2)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_ALLIANCE,1)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_HORDE,0)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL,0)
	PerformIngameSpawn(2,A_BANNER,530,253.54,7083.81,36.7728,-0.017453,200,0)
	controll_team = 0
	rebuff = true
	pGO:Despawn(1,0)
elseif(pGO:GetEntry() == H_BANNER and pPlayer:HasAura(ZM_STANDARD_A) and pGO:GetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_HORDE)==1 and a_t == 2)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_ALLIANCE,1)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_HORDE,0)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL,0)
	PerformIngameSpawn(2,A_BANNER,530,253.54,7083.81,36.7728,-0.017453,200,0)
	controll_team = 0
	rebuff = true
	pGO:Despawn(1,0)
elseif(pGO:GetEntry() == A_BANNER and pPlayer:HasAura(ZM_STANDARD_H) and pGO:GetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_ALLIANCE)==1 and h_t == 2)then
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_ALLIANCE,0)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_HORDE,1)
	pGO:SetWorldStateForZone(WORLDSTATE_ZM_TWINSPIRE_GY_NEUTRAL,0)
	PerformIngameSpawn(2,H_BANNER,530,253.54,7083.81,36.7728,-0.017453,200,0)
	controll_team = 1
	rebuff = true
	pGO:Despawn(1,0)
end
if(rebuff == true)then
	for i = 1, #buff_zone do
		for k,v in pairs(GetPlayersInZone(buff_zone[i]))do
			if(v:GetTeam() == controll_team and not v:HasAura(ZM_BUFF))then
				v:AddAura(ZM_BUFF,0)
			elseif(v:GetTeam() ~= controll_team and v:HasAura(ZM_BUFF))then
				RemoveAura()
			end
			if(v:HasAura(ZM_STANDARD_H))then
				v:RemoveAura(ZM_STANDARD_H)
			end
		end
	end
rebuff = false
end
end

function OnZone(event, pPlayer, ZoneId, OldZoneId)
buffed_zm = false
for i = 1, #buff_zone do
if(ZoneId == buff_zone[i])then
	buffed_zm = true
end
end
if(buffed_zm == true and not pPlayer:HasAura(ZM_BUFF) and pPlayer:GetTeam() == controll_team)then
	pPlayer:AddAura(ZM_BUFF,0)
elseif((buffed_zm == false or pPlayer:GetTeam() ~= controll_team) and pPlayer:HasAura(ZM_BUFF))then
	pPlayer:RemoveAura(ZM_BUFF)
end
buffed_zm = false
end

function OnEnter(event, pPlayer)
ZoneId = pPlayer:GetZoneId()
buffed_zm = false
for i = 1, #buff_zone do
if(ZoneId == buff_zone[i])then
	buffed_zm = true
end
end
if(buffed_zm == true and not pPlayer:HasAura(ZM_BUFF) and pPlayer:GetTeam() == controll_team)then
	pPlayer:AddAura(ZM_BUFF,0)
elseif((buffed_zm == false or pPlayer:GetTeam() ~= controll_team) and pPlayer:HasAura(ZM_BUFF))then
	pPlayer:RemoveAura(ZM_BUFF)
end
buffed_zm = false
end

function CastSpell(event, pPlayer, SpellId, pSpellObject)
if(SpellId == 32433 or SpellId == 32438)then
	pPlayer:SendAreaTriggerMessage("2222")
end
end

for i = 1, #capturepoint_data do
RegisterGameObjectEvent(capturepoint_data[i][1],5,AIUpdate)
RegisterGameObjectEvent(capturepoint_data[i][1],2,OnLoad)
end
RegisterGameObjectEvent(A_BANNER,2,BannerOnLoad)
RegisterGameObjectEvent(H_BANNER,2,BannerOnLoad)
RegisterGameObjectEvent(N_BANNER,2,BannerOnLoad)
RegisterGameObjectEvent(A_BANNER,4,OnUse)
RegisterGameObjectEvent(H_BANNER,4,OnUse)
RegisterGameObjectEvent(N_BANNER,4,OnUse)
RegisterServerHook(15,OnZone)
RegisterServerHook(4,OnEnter)
RegisterServerHook(10,CastSpell)
