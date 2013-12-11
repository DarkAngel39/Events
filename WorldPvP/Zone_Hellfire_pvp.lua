 -- Controllers
local brokenhill_val =	50
local stadium_val =		50
local overlook_val =	50
local alliance_tower =	0
local horde_tower =		0
local BAR_NEUTRAL =		20
local BAR_STATUS_1 =	(100 - BAR_NEUTRAL)/2
local rebuff = false
 -- UI Worldstates.
local WORLDSTATE_HF_SHOW_ALLIANCE_COUNT =	2476
local WORLDSTATE_HF_SHOW_HORDE_COUNT =		2478
local WORLDSTATE_HF_SHOW_HORDE_TOWERS =		2489
local WORLDSTATE_HF_SHOW_ALLIANCE_TOWERS =	2490
local WORLDSTATE_HF_C_BAR_SHOW =			2473
local WORLDSTATE_HF_C_BAR_PROGRESS =		2474
local WORLDSTATE_HF_C_BAR_NEUTRAL =			2475
 -- Quests
local questsH =	{13411,13409,10110};
local questsA = {13410,13408,10106};
 -- map info
local ZONE_HF = 3483
local HPBuffZones = {3483,3563,3562,3713,3714,3836};
 -- Spells
local KILL_A = 32155
local KILL_H = 32158
local A_BUFF = 32071
local H_BUFF = 32049
local GAMEOBJECT_BYTES_1 = 0x0006 + 0x000B
 -- entry id, controller,  neutral worldstate, horde worldstate, alliance worldstate, kill credit id, name, anim a, anim n, anim h, gobber id, kill credit id
local capturepoint_data = {
{182175, brokenhill_val, 2485, 2484, 2483, 19032, 3671, "Broken Hill", 65, 66, 64, 183514, 2},
{182173, stadium_val, 2472, 2470, 2471, 19029, 3669, "The Stadium", 67, 69, 68, 183515, 1},
{182174, overlook_val, 2482, 2481, 2480, 19028, 3670, "The Overlook", 62, 63, 61, 182525, 0};
};

local self = getfenv(1)

function OnLoadBanner(pGO)
for i = 1, #capturepoint_data do
	if(pGO:GetEntry() == capturepoint_data[i][12] and pGO:GetWorldStateForZone(capturepoint_data[i][5])==1)then
		pGO:SetByte(GAMEOBJECT_BYTES_1,2,capturepoint_data[i][9])
	elseif(pGO:GetEntry() == capturepoint_data[i][12] and pGO:GetWorldStateForZone(capturepoint_data[i][4])==1)then
		pGO:SetByte(GAMEOBJECT_BYTES_1,2,capturepoint_data[i][11])
	elseif(pGO:GetEntry() == capturepoint_data[i][12] and pGO:GetWorldStateForZone(capturepoint_data[i][3])==1)then
		pGO:SetByte(GAMEOBJECT_BYTES_1,2,capturepoint_data[i][10])
	end
end
end

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
	if(pGO:GetEntry() == capturepoint_data[i][1])then
		for k,v in pairs (pGO:GetInRangePlayers())do
		if(v and v:IsPvPFlagged() and v:IsStealthed() == false and v:IsAlive())then
			if(v:GetAreaId() == capturepoint_data[i][7] and pGO:GetDistanceYards(v) <= 60)then
				v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_SHOW,1)
				v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_PROGRESS,capturepoint_data[i][2])
				v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_NEUTRAL,BAR_NEUTRAL)
			elseif(v:GetAreaId() == capturepoint_data[i][7] and pGO:GetDistanceYards(v) > 60)then
				v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_SHOW,0)
				v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_PROGRESS,0)
				v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_NEUTRAL,0)
			end
		else
			v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_SHOW,0)
			v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_PROGRESS,0)
			v:SetWorldStateForPlayer(WORLDSTATE_HF_C_BAR_NEUTRAL,0)
		end
		end
		if(capturepoint_data[i][2] + (vars.plrvall/2) < 100 and capturepoint_data[i][2] + (vars.plrvall/2) > 0)then
			capturepoint_data[i][2] = capturepoint_data[i][2] + (vars.plrvall/25)
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
				alliance_tower = alliance_tower + 1
				if(alliance_tower == 3)then
					rebuff = true
				end
				pGO:SetWorldStateForZone(WORLDSTATE_HF_SHOW_ALLIANCE_COUNT,alliance_tower)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,2)
				for k, plr in pairs (pGO:GetInRangePlayers())do
					if(plr and plr:IsPvPFlagged() and plr:IsStealthed() == false and plr:IsAlive() and pGO:GetDistanceYards(plr) <= 60)then
						for m = 1, #questsA do
							if(plr:HasQuest(questsA[m]))then
								if(plr:GetTeam() == 0 and plr:GetQuestObjectiveCompletion(questsA[m],capturepoint_data[i][13]) == 0 and plr:GetAreaId() == capturepoint_data[i][7])then
									plr:AdvanceQuestObjective(questsA[m],capturepoint_data[i][13])
								end
							end
						end
					end
				end
				for k,flag in pairs (pGO:GetInRangeObjects())do
				if(flag and flag:GetEntry() == capturepoint_data[i][12])then
					flag:SetByte(GAMEOBJECT_BYTES_1,2,capturepoint_data[i][9])
				end
				end
				for k,v in pairs (GetPlayersInZone(ZONE_HF))do
					v:SendBroadcastMessage(""..capturepoint_data[i][8].." was taken by the alliance!|r")
				end
			elseif(capturepoint_data[i][2] <= BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])~=1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],1)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],0)
				horde_tower = horde_tower + 1
				if(horde_tower == 3)then
					rebuff = true
				end
				pGO:SetWorldStateForZone(WORLDSTATE_HF_SHOW_HORDE_COUNT,horde_tower)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,1)
				for k, plr in pairs (pGO:GetInRangePlayers())do
					if(plr and plr:IsPvPFlagged() and plr:IsStealthed() == false and plr:IsAlive() and pGO:GetDistanceYards(plr) <= 60)then
						for m = 1, #questsH do
							if(plr:HasQuest(questsH[m]))then
								if(plr:GetTeam() == 1 and plr:GetQuestObjectiveCompletion(questsH[m],capturepoint_data[i][13]) == 0 and plr:GetAreaId() == capturepoint_data[i][7])then
									plr:AdvanceQuestObjective(questsH[m],capturepoint_data[i][13])
								end
							end
						end
					end
				end
				for k,flag in pairs (pGO:GetInRangeObjects())do
				if(flag and flag:GetEntry() == capturepoint_data[i][12])then
					flag:SetByte(GAMEOBJECT_BYTES_1,2,capturepoint_data[i][11])
				end
				end
				for k,v in pairs (GetPlayersInZone(ZONE_HF))do
					v:SendBroadcastMessage(""..capturepoint_data[i][8].." was taken by the horde!|r")
				end
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][5])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				rebuff = true
				alliance_tower = alliance_tower - 1
				pGO:SetWorldStateForZone(WORLDSTATE_HF_SHOW_ALLIANCE_COUNT,alliance_tower)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,21)
				for k,flag in pairs (pGO:GetInRangeObjects())do
				if(flag and flag:GetEntry() == capturepoint_data[i][12])then
					flag:SetByte(GAMEOBJECT_BYTES_1,2,capturepoint_data[i][10])
				end
				end
				for k,v in pairs (GetPlayersInZone(ZONE_HF))do
					v:SendBroadcastMessage("The alliance lost "..capturepoint_data[i][8].."!|r")
				end
			elseif(capturepoint_data[i][2] > BAR_STATUS_1 and capturepoint_data[i][2] < 100 - BAR_STATUS_1 and pGO:GetWorldStateForZone(capturepoint_data[i][4])==1 and pGO:GetDistanceYards(pGO:GetClosestPlayer()) < 60)then
				pGO:SetWorldStateForZone(capturepoint_data[i][5],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][4],0)
				pGO:SetWorldStateForZone(capturepoint_data[i][3],1)
				rebuff = true
				horde_tower = horde_tower - 1
				pGO:SetWorldStateForZone(WORLDSTATE_HF_SHOW_HORDE_COUNT,horde_tower)
				pGO:SetByte(GAMEOBJECT_BYTES_1,2,21)
				for k,flag in pairs (pGO:GetInRangeObjects())do
				if(flag and flag:GetEntry() == capturepoint_data[i][12])then
					flag:SetByte(GAMEOBJECT_BYTES_1,2,capturepoint_data[i][10])
				end
				end
				for k,v in pairs (GetPlayersInZone(ZONE_HF))do
					v:SendBroadcastMessage("The horde lost "..capturepoint_data[i][8].."!|r")
				end
			end
		end
	end
end
vars.plrvall = 0
if(rebuff == true)then
	if(alliance_tower == 3)then
		for i = 1, #HPBuffZones do
			for k,v in pairs(GetPlayersInZone(HPBuffZones[i]))do
				if(v:GetTeam() == 0 and not v:HasAura(A_BUFF))then
					v:AddAura(A_BUFF,0)
				end
			end
		end
	elseif(horde_tower == 3 and rebuff == true)then
		for i = 1, #HPBuffZones do
			for k,v in pairs(GetPlayersInZone(HPBuffZones[i]))do
				if(v:GetTeam() == 1 and not v:HasAura(H_BUFF))then
					v:AddAura(H_BUFF,0)
				end
			end
		end
	elseif(alliance_tower ~= 3 and horde_tower ~= 3 and rebuff == true)then
		for i = 1, #HPBuffZones do
			for k,v in pairs(GetPlayersInZone(HPBuffZones[i]))do
				if(v:GetTeam() == 1 and v:HasAura(H_BUFF))then
					v:RemoveAura(H_BUFF)
				end
				if(v:GetTeam() == 0 and v:HasAura(A_BUFF))then
					v:RemoveAura(A_BUFF)
				end
			end
		end
	end
rebuff = false
end
end

function OnZone(event, pPlayer, ZoneId, OldZoneId)
buffed = false
for i = 1, #HPBuffZones do
if(ZoneId == HPBuffZones[i])then
	buffed = true
end
end
if(buffed == true and not pPlayer:HasAura(A_BUFF) and pPlayer:GetTeam()==0 and alliance_tower == 3)then
	pPlayer:AddAura(A_BUFF,0)
elseif(buffed == false and pPlayer:HasAura(A_BUFF))then
	pPlayer:RemoveAura(A_BUFF)
elseif(buffed == true and not pPlayer:HasAura(H_BUFF) and pPlayer:GetTeam()==1 and horde_tower == 3)then
	pPlayer:AddAura(H_BUFF,0)
elseif(buffed == false and pPlayer:HasAura(H_BUFF))then
	pPlayer:RemoveAura(H_BUFF)
end
buffed = false
end

function OnEnter(event, pPlayer)
ZoneId = pPlayer:GetZoneId()
buffed = false
for i = 1, #HPBuffZones do
if(ZoneId == HPBuffZones[i])then
	buffed = true
end
end
if(buffed == true and not pPlayer:HasAura(A_BUFF) and pPlayer:GetTeam()==0 and alliance_tower == 3)then
	pPlayer:AddAura(A_BUFF,0)
elseif(buffed == false and pPlayer:HasAura(A_BUFF))then
	pPlayer:RemoveAura(A_BUFF)
elseif(buffed == true and not pPlayer:HasAura(H_BUFF) and pPlayer:GetTeam()==1 and horde_tower == 3)then
	pPlayer:AddAura(H_BUFF,0)
elseif(buffed == false and pPlayer:HasAura(H_BUFF))then
	pPlayer:RemoveAura(H_BUFF)
end
buffed = false
end

function PvpKill(event, pPlayer, pKilled)
if(pPlayer:GetZoneId() == ZONE_HF)then
	for i = 1, #capturepoint_data do
		if(pPlayer:GetAreaId() == capturepoint_data[i][7])then
			if(pPlayer:GetTeam() == 0)then
				pPlayer:CastSpell(KILL_A)
			else
				pPlayer:CastSpell(KILL_H)
			end
		end
	end
end
end

for i = 1, #capturepoint_data do
RegisterGameObjectEvent(capturepoint_data[i][1],5,AIUpdate)
RegisterGameObjectEvent(capturepoint_data[i][1],2,OnLoad)
RegisterGameObjectEvent(capturepoint_data[i][12],2,OnLoadBanner)
end
RegisterServerHook(23,PvpKill)
RegisterServerHook(15,OnZone)
RegisterServerHook(4,OnEnter)
