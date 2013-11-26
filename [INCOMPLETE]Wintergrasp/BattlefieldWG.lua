local TIME_TO_BATTLE = 9000 -- How much time there will be between the battles.
local BATTLE_TIMER = 1800 -- How long time will the battle last for. (if attacker towers are not destroyed)
local timer_nextbattle = os.time() + TIME_TO_BATTLE
local timer_battle = 0
local controll = math.random(1,2)
local jointimer_1 = 120 -- Send SMSG_BATTLEFIELD_MGR_ENTRY_INVITE
local jointimer_2 = 30 -- SMSG_BATTLEFIELD_MGR_QUEUE_INVITE
local battle = 0
local states = 0
local stateuiset = 0
local add_tokens = 1
local starttimer = 0
local spawnobjects = 0
local npcstarted = false
local south_towers = 3
local ATTACKER = " "
local DEFENDER = " "

local C_BAR_NEUTRAL = 80 -- the neutral vallue of the capture bar. MUST BE UNDER 100.
local C_BAR_CAPTURE = (100 - C_BAR_NEUTRAL)/2

GAMEOBJECT_FACTION = 0x0006 + 0x0009

 -- Factions
local FACTION_HORDE = 1735
local FACTION_ALLIANCE = 1732
local FACTION_NEUTRAL = 35

 -- vehicle workshops capture bar controllers
local eastspark_progress = 50
local westspark_progress = 50
local sunkenring_progress = 50
local brokentemple_progres = 50
 -- Max vehicle worldstate controllers (neutral, destroyed - 0, half destroyed (A/H) - 2, intact (A/H) - 4)
local A_V_EASTSPARK = 0
local H_V_EASTSPARK = 0
local A_V_WESTSPARK = 0
local H_V_WESTSPARK = 0
local A_V_SUNKENRING = 0
local H_V_SUNKENRING = 0
local A_V_BROKENTEMPLE = 0
local H_V_BROKENTEMPLE = 0
local A_V_FORTRESS_EAST = 0
local H_V_FORTRESS_EAST = 0
local A_V_FORTRESS_WEST = 0
local H_V_FORTRESS_WEST = 0
 -- UI STATES
WG_STATE_NEXT_BATTLE_TIME =	4354
WG_STATE_END_BATTLE_TIME = 3781
WG_HORDE_CONTROLLED = 3802
WG_ALLIANCE_CONTROLLED = 3803
WG_STATE_BATTLE_UI = 3710
WG_STATE_BATTLE_TIME = 3781
WG_STATE_NEXT_BATTLE_TIMER = 3801
WG_STATE_CURRENT_H_VEHICLES = 3490
WG_STATE_MAX_H_VEHICLES = 3491
WG_STATE_CURRENT_A_VEHICLES = 3680
WG_STATE_MAX_A_VEHICLES = 3681
 -- Map states:
WG_STATE_BATTLEFIELD_STATUS_MAP = 3804
WG_STATE_W_FORTRESS_WORKSHOP = 3698
WG_STATE_E_FORTRESS_WORKSHOP = 3699
WG_STATE_BT_WORKSHOP = 3700
WG_STATE_SR_WORKSHOP = 3701
WG_STATE_WS_WORKSHOP = 3702
WG_STATE_ES_WORKSHOP = 3703
WG_STATE_KEEP_GATE_ANDGY = 3773
 -- Dynamic capturebar states
WG_STATE_SOUTH_SHOW = 3501
WG_STATE_SOUTH_PROGRESS = 3502
WG_STATE_SOUTH_NEUTRAL = 3508

WG_STATE_NORTH_SHOW = 3466
WG_STATE_NORTH_PROGRESS = 3467
WG_STATE_NORTH_NEUTRAL = 3468

local NPC_DETECTION_UNIT = 27869
local NPC_GOBLIN_ENGINEER = 30400
local NPC_GNOME_ENGINEER = 30499
local NPC_NOT_IMMUNE_PC_NPC = 23472
local NPC_INVISIBLE_STALKER = 15214
local NPC_VEHICLE_CATAPULT = 27881
local NPC_VEHICLE_DEMOLISHER = 28094
local NPC_VEHICLE_SIEGE_ENGINE_H = 32627
local NPC_VEHICLE_SIEGE_ENGINE_A = 28312

GO_WINTERGRASP_TITAN_RELIC = 192829
GO_WINTERGRASP_VAULT_GATE = 191810
GO_WINTERGRASP_KEEP_COLLISION_WALL = 194162
GO_WINTERGRASP_WORKSHOP_E = 192029
GO_WINTERGRASP_WORKSHOP_W = 192028
GO_WINTERGRASP_FW_TOWER = 190358
GO_WINTERGRASP_WE_TOWER = 190357
GO_WINTERGRASP_SS_TOWER = 190356
GO_WINTERGRASP_DEFENDER_H = 190763
GO_WINTERGRASP_DEFENDER_A = 191575
GO_WINTERGRASP_DEFENDER_N = 192819
GO_WINTERGRASP_VEHICLE_TELEPORTER = 192951
 -- Eastspark
GO_WINTERGRASP_WORKSHOP_ES = 192033
GO_WINTERGRASP_CAPTUREPOINT_ES_100 = 194959
GO_WINTERGRASP_CAPTUREPOINT_ES_0 = 194960

GO_WINTERGRASP_WORKSHOP_WS = 192032
GO_WINTERGRASP_CAPTUREPOINT_WS_100 = 194962
GO_WINTERGRASP_CAPTUREPOINT_WS_0 = 194963

GO_WINTERGRASP_WORKSHOP_SR = 192031
GO_WINTERGRASP_CAPTUREPOINT_SR_100 = 190475
GO_WINTERGRASP_CAPTUREPOINT_SR_0 = 192626

GO_WINTERGRASP_WORKSHOP_BT = 192030
GO_WINTERGRASP_CAPTUREPOINT_BT_100 = 190487
GO_WINTERGRASP_CAPTUREPOINT_BT_0 = 192627
 -- Map info
local MAP_NORTHREND = 571
 -- Areass
local ZONE_WG = 4197
local AREA_FORTRESS = 4575
local AREA_EASTSPARK = 4612
local AREA_WESTSPARK = 4611
local AREA_BROKENTEMPLE = 4539
local AREA_SUNKENRING = 4538
local AREA_FLAMEWATCH_T = 4581
local AREA_WINTERSEDGE_T = 4582
local AREA_SHADOWSIGHT_T = 4583
local AREA_C_BRIDGE = 4576
local AREA_E_BRIDGE = 4557
local AREA_W_BRIDGE = 4578
 -- Spells
local SPELL_RECRUIT = 37795
local SPELL_CORPORAL = 33280
local SPELL_LIEUTENANT = 55629
local SPELL_TENACITY = 58549
local SPELL_TENACITY_VEHICLE = 59911
local SPELL_TOWER_CONTROL = 62064
local SPELL_SPIRITUAL_IMMUNITY = 58729
local SPELL_GREAT_HONOR = 58555
local SPELL_GREATER_HONOR = 58556
local SPELL_GREATEST_HONOR = 58557
local SPELL_ALLIANCE_FLAG = 14268
local SPELL_HORDE_FLAG = 14267
local SPELL_GRAB_PASSENGER = 61178
local SPELL_TELEPORT_DEFENDER = 54643
local SPELL_TELEPORT_VEHICLE = 49759
local SPELL_BUILD_CATAPULT = 56663
local SPELL_BUILD_DEMOLISHER = 56575
local SPELL_BUILD_ENGINE_A = 56661
local SPELL_BUILD_ENGINE_H = 61408
 -- Reward spells
local SPELL_VICTORY_REWARD = 56902
local SPELL_DEFEAT_REWARD = 58494
local SPELL_DAMAGED_TOWER = 59135
local SPELL_DESTROYED_TOWER = 59136
local SPELL_DAMAGED_BUILDING = 59201
local SPELL_INTACT_BUILDING = 59203
local SPELL_TELEPORT_BRIDGE = 59096
local SPELL_TELEPORT_FORTRESS = 60035
local SPELL_TELEPORT_DALARAN = 53360
local SPELL_VICTORY_AURA = 60044
local SPELL_WINTERGRASP_WATER = 36444
local SPELL_ESSENCE_OF_WINTERGRASP = 57940
local SPELL_WINTERGRASP_RESTRICTED_FLIGHT_AREA = 58730
 -- Phasing spells
local SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT = 56618 -- phase 16
local SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT = 56617 -- phase 32
local SPELL_HORDE_CONTROL_PHASE_SHIFT = 55773 -- phase 64
local SPELL_ALLIANCE_CONTROL_PHASE_SHIFT = 55774  -- phase 128

 -- achievements
local ACHIEVEMENT_VICTORY = 1717
local ACHIEVEMENT_WIN_OUR_GRASP = 1755
local ACHIEVEMENT_LEANING_T = 1727

 -- Quests
local QUEST_WG_VICTORY_A = 13181
local QUEST_WG_VICTORY_H = 13183
local QUEST_WG_TOPPING_TOWERS = 13539
local QUEST_WG_SOUTHEN_SABOTAGE = 13538
local QUEST_WG_DEFEND_SIEDGE_A = 13222
local QUEST_WG_DEFEND_SIEDGE_H = 13223

-- Opcodes
SMSG_PLAY_SOUND = 0x2D2
SMSG_BATTLEFIELD_MGR_ENTRY_INVITE = 0x4DE
CMSG_BATTLEFIELD_MGR_ENTRY_INVITE_RESPONSE = 0x4DF
SMSG_BATTLEFIELD_MGR_ENTERED = 0x4E0
SMSG_BATTLEFIELD_MGR_QUEUE_INVITE = 0x4E1
CMSG_BATTLEFIELD_MGR_QUEUE_INVITE_RESPONSE = 0x4E2
CMSG_BATTLEFIELD_MGR_QUEUE_REQUEST = 0x4E3
SMSG_BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE = 0x4E4
SMSG_BATTLEFIELD_MGR_EJECT_PENDING  = 0x4E5
SMSG_BATTLEFIELD_MGR_EJECTED = 0x4E6
CMSG_BATTLEFIELD_MGR_EXIT_REQUEST = 0x4E7
SMSG_BATTLEFIELD_MGR_STATE_CHANGE = 0x4E8
CMSG_BATTLEFIELD_MANAGER_ADVANCE_STATE = 0x4E9
CMSG_BATTLEFIELD_MANAGER_SET_NEXT_TRANSITION_TIME = 0x4EA
CMSG_START_BATTLEFIELD_CHEAT = 0x4CB
CMSG_END_BATTLEFIELD_CHEAT = 0x4CC
CMSG_LEAVE_BATTLEFIELD = 0x2E1
CMSG_BATTLEFIELD_PORT = 0x2D5
CMSG_BATTLEFIELD_STATUS = 0x2D3
SMSG_BATTLEFIELD_STATUS = 0x2D4
CMSG_BATTLEFIELD_LIST = 0x23C
SMSG_BATTLEFIELD_LIST = 0x23D
CMSG_BATTLEFIELD_JOIN = 0x23E
SMSG_BATTLEFIELD_PORT_DENIED = 0x14B
SMSG_AREA_SPIRIT_HEALER_TIME = 0x2E4

 -- Fortress destructable objects
local go_wall = {
{190219, 3749},
{190220, 3750},
{191802, 3751},
{191803, 3752},
{190369, 3753},
{190371, 3754},
{190374, 3755},
{190376, 3756},
{190372, 3757},
{190370, 3758},
{191807, 3759},
{191808, 3760},
{191809, 3761},
{191799, 3762},
{191795, 3764},
{191797, 3765},
{191800, 3766},
{191804, 3767},
{191805, 3768},
{191806, 3769},
{191801, 3770},
{191798, 3771},
{191796, 3772},
{192028, 3698},
{192029, 3699},
{190375, 3763};
};
 -- Fortress towers
local go_f_tower = {
{190221, 3711},
{190378, 3712},
{190373, 3713},
{190377, 3714};
};
 -- South towers
local go_s_tower = {
{190356, 3704},
{190357, 3705},
{190358, 3706};
};

local buff_areas = {
4494,
4277,
4100,
4723,
4196,
4416,
4820,
4813,
4809,
4265,
4228,
4415,
4272,
4264,
206,
1196,
3537,
2817,
4395,
65,
394,
495,
4742,
210,
3711,
67,
66;
};

function Aura()
for k,l in pairs(GetPlayersInWorld())do
if(l:GetZoneId() ~= ZONE_WG and l:GetAreaId() ~= ZONE_WG)then
	if(l:HasAura(SPELL_RECRUIT))then
		l:RemoveAura(SPELL_RECRUIT)
	end
	if(l:HasAura(SPELL_CORPORAL))then
		l:RemoveAura(SPELL_CORPORAL)
	end
	if(l:HasAura(SPELL_LIEUTENANT))then
		l:RemoveAura(SPELL_LIEUTENANT)
	end
	if(l:HasAura(SPELL_TOWER_CONTROL))then
		l:RemoveAura(SPELL_TOWER_CONTROL)
	end
	if(l:HasAura(SPELL_GREAT_HONOR))then
		l:RemoveAura(SPELL_GREAT_HONOR)
	end
	if(l:HasAura(SPELL_GREATER_HONOR))then
		l:RemoveAura(SPELL_GREATER_HONOR)
	end
	if(l:HasAura(SPELL_GREATEST_HONOR))then
		l:RemoveAura(SPELL_GREATEST_HONOR)
	end
	if(l:HasAura(SPELL_VICTORY_AURA))then
		l:RemoveAura(SPELL_VICTORY_AURA)
	end
end
if(l:GetAreaId() == AREA_EASTSPARK)then
	if(eastspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(eastspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and eastspark_progress > C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(eastspark_progress < C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	end
elseif(l:GetAreaId() == AREA_WESTSPARK)then
	if(westspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(westspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and westspark_progress > C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(westspark_progress < C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	end
elseif(l:GetAreaId() == AREA_SUNKENRING)then
	if(sunkenring_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(sunkenring_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and sunkenring_progress > C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(sunkenring_progress < C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	end
elseif(l:GetAreaId() == AREA_BROKENTEMPLE)then
	if(brokentemple_progres > C_BAR_CAPTURE + C_BAR_NEUTRAL)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(brokentemple_progres < C_BAR_CAPTURE + C_BAR_NEUTRAL and brokentemple_progres > C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	elseif(brokentemple_progres < C_BAR_CAPTURE)then
		if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT) == false)then
			l:CastSpell(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
		if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	end
else
	if(l:HasAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT)
		end
	if(l:HasAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT))then
			l:RemoveAura(SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT)
	end
end
if(l:GetZoneId() == ZONE_WG and controll == 1 and l:GetTeam() == 1 and battle == 1)then
	if(l:HasAura(SPELL_TOWER_CONTROL) == false and south_towers > 0)then
		l:CastSpell(SPELL_TOWER_CONTROL)
	elseif(l:HasAura(SPELL_TOWER_CONTROL) and south_towers > 0 and l:GetAuraStackCount(SPELL_TOWER_CONTROL) < south_towers)then
		l:CastSpell(SPELL_TOWER_CONTROL)
	elseif(l:HasAura(SPELL_TOWER_CONTROL) and south_towers < l:GetAuraStackCount(SPELL_TOWER_CONTROL))then
		l:RemoveAura(SPELL_TOWER_CONTROL)
	end
elseif(l:GetZoneId() == ZONE_WG and controll == 2 and l:GetTeam() == 0 and battle == 1)then
	if(l:HasAura(SPELL_TOWER_CONTROL) == false and south_towers > 0)then
		l:CastSpell(SPELL_TOWER_CONTROL)
	elseif(l:HasAura(SPELL_TOWER_CONTROL) and south_towers > 0 and l:GetAuraStackCount(SPELL_TOWER_CONTROL) < south_towers)then
		l:CastSpell(SPELL_TOWER_CONTROL)
	elseif(l:HasAura(SPELL_TOWER_CONTROL) and south_towers < l:GetAuraStackCount(SPELL_TOWER_CONTROL))then
		l:RemoveAura(SPELL_TOWER_CONTROL)
	end
elseif(l:GetZoneId() == ZONE_WG and battle == 0)then
	if(l:HasAura(SPELL_TOWER_CONTROL))then
		l:RemoveAura(SPELL_TOWER_CONTROL)
	end
end
end
end

function WGUpdate()
if(timer_nextbattle <= os.time() and timer_battle == 0)then
	timer_battle = os.time() + BATTLE_TIMER
	timer_nextbattle = 0
	battle = 1
	stateuiset = 0
	states = 0
	add_tokens = 0
	starttimer = os.time()
	if(controll == 1)then
		eastspark_progress = 0
		westspark_progress = 0
	elseif(controll == 2)then
		eastspark_progress = 100
		westspark_progress = 100
	end
	for k,v in pairs(GetPlayersInZone(ZONE_WG))do
	v:SendAreaTriggerMessage("Let the battle begin!")
	local packetssound = LuaPacket:CreatePacket(SMSG_PLAY_SOUND, 4)
	packetssound:WriteULong(3439)
	v:SendPacketToPlayer(packetssound)
	end
elseif(timer_nextbattle == 0 and timer_battle <= os.time())then
	timer_battle = 0
	timer_nextbattle = os.time() + TIME_TO_BATTLE
	battle = 0
	stateuiset = 0
	states = 0
	starttimer = 0
	south_towers = 3
	for k,v in pairs(GetPlayersInZone(ZONE_WG))do
	local packetseound = LuaPacket:CreatePacket(SMSG_PLAY_SOUND, 4)
	if(controll == 1)then
		packetseound:WriteULong(8455)
		v:SendPacketToPlayer(packetseound)
		v:SendAreaTriggerMessage("The Alliance has successfully defended the Wintergrasp fortress!")
	elseif(controll == 2)then
		packetseound:WriteULong(8454)
		v:SendPacketToPlayer(packetseound)
		v:SendAreaTriggerMessage("The Horde has successfully defended the Wintergrasp fortress!")
	end
	end
elseif(timer_nextbattle == os.time() + jointimer_1)then
		local p = LuaPacket:CreatePacket(SMSG_BATTLEFIELD_MGR_ENTRY_INVITE, 12)
		p:WriteULong(1)
		p:WriteULong(4197)
		p:WriteULong(timer_nextbattle)
		SendPacketToZone(p, ZONE_WG)
elseif(timer_nextbattle == os.time() + jointimer_2)then
		local p = LuaPacket:CreatePacket(SMSG_BATTLEFIELD_MGR_QUEUE_INVITE, 5)
		p:WriteULong(1)
		p:WriteUByte(1)
		SendPacketToZone(p, ZONE_WG)
end
for k,v in pairs(GetPlayersInMap(MAP_NORTHREND))do
if(v:GetZoneId() == ZONE_WG or v:GetAreaId() == ZONE_WG)then
if(south_towers == 0)then
	timer_battle = timer_battle - 600 -- if all southen towers are destroyed, the attackers loose 10 min.
	v:SetWorldStateForZone(WG_STATE_BATTLE_TIME, timer_battle)
	south_towers = -1
end
	if(v:IsPvPFlagged() ~= true)then
		v:FlagPvP()
	end
	if(battle == 1)then
		if(v:HasAura(SPELL_RECRUIT) == false)then
			if(v:HasAura(SPELL_CORPORAL) == false)then
				if(v:HasAura(SPELL_LIEUTENANT) == false)then
					v:AddAura(SPELL_RECRUIT,0)
				end
			end
		end
	elseif(battle == 0)then
		if(v:HasAura(SPELL_RECRUIT))then
			v:RemoveAura(SPELL_RECRUIT)
		end
		if(v:HasAura(SPELL_CORPORAL))then
			v:RemoveAura(SPELL_CORPORAL)
		end
		if(v:HasAura(SPELL_LIEUTENANT))then
			v:RemoveAura(SPELL_LIEUTENANT)
		end
	end
	if(controll == 1 and battle == 0 and add_tokens == 0)then
			if(v:GetTeam() == 0)then
				v:CastSpell(SPELL_VICTORY_REWARD)
				v:CastSpell(SPELL_VICTORY_AURA)
				if(v:HasQuest(QUEST_WG_VICTORY_A) and v:GetQuestObjectiveCompletion(QUEST_WG_VICTORY_A, 0) == 0)then
					v:AdvanceQuestObjective(QUEST_WG_VICTORY_A, 0)
				end
			elseif(v:GetTeam() == 1)then
				v:CastSpell(SPELL_DEFEAT_REWARD)
			end
			add_tokens = 1
	end
	if(controll == 2 and battle == 0 and add_tokens == 0)then
			if(v:GetTeam() == 1)then
				v:CastSpell(SPELL_VICTORY_REWARD)
				v:CastSpell(SPELL_VICTORY_AURA)
				if(v:HasQuest(QUEST_WG_VICTORY_H) and v:GetQuestObjectiveCompletion(QUEST_WG_VICTORY_H, 0) == 0)then
					v:AdvanceQuestObjective(QUEST_WG_VICTORY_H, 0)
				end
			elseif(v:GetTeam() == 0)then
				v:CastSpell(SPELL_DEFEAT_REWARD)
			end
			add_tokens = 1
	end
if(v:GetAreaId() == AREA_FORTRESS or v:GetAreaId() == AREA_FLAMEWATCH_T or v:GetAreaId() == AREA_WINTERSEDGE_T or v:GetAreaId() == AREA_SHADOWSIGHT_T or v:GetAreaId() == AREA_C_BRIDGE or v:GetAreaId() == AREA_W_BRIDGE or v:GetAreaId() == AREA_E_BRIDGE or v:GetAreaId() == ZONE_WG)then
	if(controll == 1)then
		if(v:HasAura(SPELL_HORDE_CONTROL_PHASE_SHIFT))then
			v:RemoveAura(SPELL_HORDE_CONTROL_PHASE_SHIFT)
		end
		v:CastSpell(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT)
	elseif(controll == 2)then
		if(v:HasAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT))then
			v:RemoveAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT)
		end
		v:CastSpell(SPELL_HORDE_CONTROL_PHASE_SHIFT)
	end
elseif(v:GetAreaId() ~= AREA_FORTRESS and v:GetAreaId() ~= AREA_FLAMEWATCH_T and v:GetAreaId() ~= AREA_WINTERSEDGE_T and v:GetAreaId() ~= AREA_SHADOWSIGHT_T and v:GetAreaId() ~= AREA_C_BRIDGE and v:GetAreaId() ~= AREA_W_BRIDGE and v:GetAreaId() ~= AREA_E_BRIDGE and v:GetAreaId() ~= ZONE_WG)then
	if(v:HasAura(SPELL_HORDE_CONTROL_PHASE_SHIFT))then
		v:RemoveAura(SPELL_HORDE_CONTROL_PHASE_SHIFT)
	end
	if(v:HasAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT))then
		v:RemoveAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT)
	end
end
if(stateuiset == 0)then
	if(battle == 1)then
		v:SetWorldStateForZone(WG_HORDE_CONTROLLED, 0)
		v:SetWorldStateForZone(WG_ALLIANCE_CONTROLLED, 0)
		v:SetWorldStateForZone(WG_STATE_BATTLE_UI, 1)
		v:SetWorldStateForZone(WG_STATE_BATTLE_TIME, timer_battle)
		v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIMER, 0)
		v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIME, 0)
		v:SetWorldStateForZone(WG_STATE_BATTLEFIELD_STATUS_MAP, 3)
		stateuiset = 1
	elseif(battle == 0 and controll == 1)then
		v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIMER, 1)
		v:SetWorldStateForZone(WG_ALLIANCE_CONTROLLED, 1)
		v:SetWorldStateForZone(WG_STATE_BATTLE_UI, 0)
		v:SetWorldStateForZone(WG_STATE_BATTLE_TIME, 0)
		v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIME, timer_nextbattle)
		v:SetWorldStateForZone(WG_STATE_BATTLEFIELD_STATUS_MAP, 2)
		stateuiset = 1
	elseif(battle == 0 and controll == 2)then
		v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIMER, 1)
		v:SetWorldStateForZone(WG_HORDE_CONTROLLED, 1)
		v:SetWorldStateForZone(WG_STATE_BATTLE_UI, 0)
		v:SetWorldStateForZone(WG_STATE_BATTLE_TIME, 0)
		v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIME, timer_nextbattle)
		v:SetWorldStateForZone(WG_STATE_BATTLEFIELD_STATUS_MAP, 1)
		stateuiset = 1
	end
end
if(controll == 1)then
	if(states == 0)then
		v:SetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP, 7)
		v:SetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP, 7)
		v:SetWorldStateForZone(3704, 4)
		v:SetWorldStateForZone(3705, 4)
		v:SetWorldStateForZone(3706, 4)
		v:SetWorldStateForZone(3711, 7)
		v:SetWorldStateForZone(3712, 7)
		v:SetWorldStateForZone(3713, 7)
		v:SetWorldStateForZone(3714, 7)
		v:SetWorldStateForZone(3749, 7)
		v:SetWorldStateForZone(3750, 7)
		v:SetWorldStateForZone(3751, 7)
		v:SetWorldStateForZone(3752, 7)
		v:SetWorldStateForZone(3753, 7)
		v:SetWorldStateForZone(3754, 7)
		v:SetWorldStateForZone(3755, 7)
		v:SetWorldStateForZone(3756, 7)
		v:SetWorldStateForZone(3757, 7)
		v:SetWorldStateForZone(3758, 7)
		v:SetWorldStateForZone(3759, 7)
		v:SetWorldStateForZone(3760, 7)
		v:SetWorldStateForZone(3761, 7)
		v:SetWorldStateForZone(3762, 7)
		v:SetWorldStateForZone(3764, 7)
		v:SetWorldStateForZone(3765, 7)
		v:SetWorldStateForZone(3766, 7)
		v:SetWorldStateForZone(3767, 7)
		v:SetWorldStateForZone(3768, 7)
		v:SetWorldStateForZone(3769, 7)
		v:SetWorldStateForZone(3770, 7)
		v:SetWorldStateForZone(3771, 7)
		v:SetWorldStateForZone(3772, 7)
		v:SetWorldStateForZone(3763, 7)
		v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 7)
		v:SetWorldStateForZone(WG_STATE_WS_WORKSHOP, 4)
		v:SetWorldStateForZone(WG_STATE_ES_WORKSHOP, 4)
		v:SetWorldStateForZone(WG_STATE_BT_WORKSHOP, 4)
		v:SetWorldStateForZone(WG_STATE_SR_WORKSHOP, 4)
		eastspark_progress =  0
		westspark_progress =  0
		sunkenring_progress = 0
		brokentemple_progres = 0
		states = 1
		ATTACKER = "Horde"
		DEFENDER = "Alliance"
	end
elseif(controll == 2)then
	if(states == 0)then
		v:SetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP, 4)
		v:SetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP, 4)
		v:SetWorldStateForZone(3704, 7)
		v:SetWorldStateForZone(3705, 7)
		v:SetWorldStateForZone(3706, 7)
		v:SetWorldStateForZone(3711, 4)
		v:SetWorldStateForZone(3712, 4)
		v:SetWorldStateForZone(3713, 4)
		v:SetWorldStateForZone(3714, 4)
		v:SetWorldStateForZone(3749, 4)
		v:SetWorldStateForZone(3750, 4)
		v:SetWorldStateForZone(3751, 4)
		v:SetWorldStateForZone(3752, 4)
		v:SetWorldStateForZone(3753, 4)
		v:SetWorldStateForZone(3754, 4)
		v:SetWorldStateForZone(3755, 4)
		v:SetWorldStateForZone(3756, 4)
		v:SetWorldStateForZone(3757, 4)
		v:SetWorldStateForZone(3758, 4)
		v:SetWorldStateForZone(3759, 4)
		v:SetWorldStateForZone(3760, 4)
		v:SetWorldStateForZone(3761, 4)
		v:SetWorldStateForZone(3762, 4)
		v:SetWorldStateForZone(3764, 4)
		v:SetWorldStateForZone(3765, 4)
		v:SetWorldStateForZone(3766, 4)
		v:SetWorldStateForZone(3767, 4)
		v:SetWorldStateForZone(3768, 4)
		v:SetWorldStateForZone(3769, 4)
		v:SetWorldStateForZone(3770, 4)
		v:SetWorldStateForZone(3771, 4)
		v:SetWorldStateForZone(3772, 4)
		v:SetWorldStateForZone(3763, 4)
		v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 4)
		v:SetWorldStateForZone(WG_STATE_WS_WORKSHOP, 7)
		v:SetWorldStateForZone(WG_STATE_ES_WORKSHOP, 7)
		v:SetWorldStateForZone(WG_STATE_BT_WORKSHOP, 7)
		v:SetWorldStateForZone(WG_STATE_SR_WORKSHOP, 7)
		eastspark_progress = 100
		westspark_progress = 100
		sunkenring_progress = 100
		brokentemple_progres = 100
		states = 1
		ATTACKER = "Alliance"
		DEFENDER = "Horde"
	end
end
end
end
end

function DetectionUnitOnSpawn(pUnit, event)
if(pUnit:GetMapId() == MAP_NORTHREND)then
	pUnit:RegisterAIUpdateEvent(1000)
end
end

function DetectionUnitAIUpdate(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
if(pUnit:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) == 0 or pUnit:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) == 1)then
	if(npcstarted == false)then
		stateuiset = 0
		states = 0
		npcstarted = true
	end
else
	npcstarted = true
end
for k,m in pairs(GetPlayersInZone(ZONE_WG))do
	if(m:HasAura(SPELL_VICTORY_AURA))then
		if(m:HasAchievement(ACHIEVEMENT_VICTORY) == false)then
			m:AddAchievement(ACHIEVEMENT_VICTORY)
		end
		m:RemoveAura(SPELL_VICTORY_AURA)
	end
end
if(spawnobjects == 0 and battle == 1)then
	PerformIngameSpawn(2,GO_WINTERGRASP_TITAN_RELIC,MAP_NORTHREND,5439.66,2840.83,430.282,6.20393,100,2300000)
	PerformIngameSpawn(2,GO_WINTERGRASP_KEEP_COLLISION_WALL,MAP_NORTHREND,5397.11,2841.54,425.901,3.14159,100,2300000)
	spawnobjects = 1
end
if(battle == 0 and spawnobjects == 1)then
	spawnobjects = 0
	local relick = pUnit:GetGameObjectNearestCoords(5439.66,2840.83,430.282,GO_WINTERGRASP_TITAN_RELIC)
	local collision = pUnit:GetGameObjectNearestCoords(5397.11,2841.54,425.901,GO_WINTERGRASP_KEEP_COLLISION_WALL)
	if(relick ~= nil)then
		relick:Despawn(1,0)
	end
	if(collision ~= nil)then
		collision:Despawn(1,0)
	end
end
if(pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 4)then
	A_V_FORTRESS_WEST = 0
	H_V_FORTRESS_WEST = 4
elseif(pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 5)then
	A_V_FORTRESS_WEST = 0
	H_V_FORTRESS_WEST = 2
elseif(pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 0 or pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 1 or pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 2 or pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 3 or pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 6 or pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 9)then
	A_V_FORTRESS_WEST = 0
	H_V_FORTRESS_WEST = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 7)then
	A_V_FORTRESS_WEST = 4
	H_V_FORTRESS_WEST = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_W_FORTRESS_WORKSHOP) == 8)then
	A_V_FORTRESS_WEST = 2
	H_V_FORTRESS_WEST = 0
end
if(pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 4)then
	A_V_FORTRESS_EAST = 0
	H_V_FORTRESS_EAST = 4
elseif(pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 5)then
	A_V_FORTRESS_EAST = 0
	H_V_FORTRESS_EAST = 2
elseif(pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 0 or pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 1 or pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 2 or pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 3 or pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 6 or pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 9)then
	A_V_FORTRESS_EAST = 0
	H_V_FORTRESS_EAST = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 7)then
	A_V_FORTRESS_EAST = 4
	H_V_FORTRESS_EAST = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_E_FORTRESS_WORKSHOP) == 8)then
	A_V_FORTRESS_EAST = 2
	H_V_FORTRESS_EAST = 0
end
if(pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 4)then
	A_V_BROKENTEMPLE = 0
	H_V_BROKENTEMPLE = 4
elseif(pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 5)then
	A_V_BROKENTEMPLE = 0
	H_V_BROKENTEMPLE = 2
elseif(pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 0 or pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 1 or pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 2 or pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 3 or pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 6 or pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 9)then
	A_V_BROKENTEMPLE = 0
	H_V_BROKENTEMPLE = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 7)then
	A_V_BROKENTEMPLE = 4
	H_V_BROKENTEMPLE = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) == 8)then
	A_V_BROKENTEMPLE = 2
	H_V_BROKENTEMPLE = 0
end
if(pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 4)then
	A_V_SUNKENRING = 0
	H_V_SUNKENRING = 4
elseif(pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 5)then
	A_V_SUNKENRING = 0
	H_V_SUNKENRING = 2
elseif(pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 0 or pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 1 or pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 2 or pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 3 or pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 6 or pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 9)then
	A_V_SUNKENRING = 0
	H_V_SUNKENRING = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 7)then
	A_V_SUNKENRING = 4
	H_V_SUNKENRING = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) == 8)then
	A_V_SUNKENRING = 2
	H_V_SUNKENRING = 0
end
if(pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 4)then
	A_V_WESTSPARK = 0
	H_V_WESTSPARK = 4
elseif(pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 5)then
	A_V_WESTSPARK = 0
	H_V_WESTSPARK = 2
elseif(pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 0 or pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 1 or pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 2 or pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 3 or pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 6 or pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 9)then
	A_V_WESTSPARK = 0
	H_V_WESTSPARK = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 7)then
	A_V_WESTSPARK = 4
	H_V_WESTSPARK = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) == 8)then
	A_V_WESTSPARK = 2
	H_V_WESTSPARK = 0
end
if(pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 4)then
	A_V_EASTSPARK = 0
	H_V_EASTSPARK = 4
elseif(pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 5)then
	A_V_EASTSPARK = 0
	H_V_EASTSPARK = 2
elseif(pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 0 or pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 1 or pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 2 or pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 3 or pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 6 or pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 9)then
	A_V_EASTSPARK = 0
	H_V_EASTSPARK = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 7)then
	A_V_EASTSPARK = 4
	H_V_EASTSPARK = 0
elseif(pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) == 8)then
	A_V_EASTSPARK = 2
	H_V_EASTSPARK = 0
end
local alliancevehicles = A_V_EASTSPARK + A_V_WESTSPARK + A_V_SUNKENRING + A_V_BROKENTEMPLE + A_V_FORTRESS_EAST + A_V_FORTRESS_WEST
local hordevehicles = H_V_EASTSPARK + H_V_WESTSPARK + H_V_SUNKENRING + H_V_BROKENTEMPLE + H_V_FORTRESS_EAST + H_V_FORTRESS_WEST
pUnit:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES, alliancevehicles)
pUnit:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES, hordevehicles)
for k,v in pairs(pUnit:GetInRangeObjects())do
if(v:GetHP() ~= nil)then -- filter all non destructable objects.
	if(battle == 0 and v:GetHP() < v:GetMaxHP())then -- rebuild all if there is no battle and anything is damaged.
		v:Rebuild()
	end
	if(v:GetEntry() == GO_WINTERGRASP_VAULT_GATE)then
		if(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) ~= 5)then
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 5)
		elseif(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) ~= 8)then
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 8)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) ~= 4)then
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 4)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) ~= 7)then
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 7)
		elseif(v:GetHP() == 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) ~= 6)then
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 6)
			for k,m in pairs(v:GetInRangeObjects())do
				if(m:GetEntry() == GO_WINTERGRASP_KEEP_COLLISION_WALL)then
					m:Activate()
				end
			end
		elseif(v:GetHP() == 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) ~= 9)then
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 9)
			for k,m in pairs(v:GetInRangeObjects())do
				if(m:GetEntry() == GO_WINTERGRASP_KEEP_COLLISION_WALL)then
					m:Activate()
				end
			end
		end
	end
	if(v:GetUInt32Value(GAMEOBJECT_FACTION) ~= FACTION_HORDE and battle == 1 and controll == 2 and v:GetAreaId() == AREA_FORTRESS)then -- this changes the faction of the objects but for some reason they can not be damaged as they should by the vehicles.
		v:SetUInt32Value(GAMEOBJECT_FACTION,FACTION_HORDE)
	elseif(battle == 1 and v:GetUInt32Value(GAMEOBJECT_FACTION) ~= FACTION_NEUTRAL)then
		v:SetUInt32Value(GAMEOBJECT_FACTION,FACTION_NEUTRAL)
	elseif(v:GetUInt32Value(GAMEOBJECT_FACTION) ~= FACTION_ALLIANCE and battle == 1 and controll == 1 and v:GetAreaId() == AREA_FORTRESS)then
		v:SetUInt32Value(GAMEOBJECT_FACTION,FACTION_ALLIANCE)
	elseif((v:GetAreaId() == AREA_FLAMEWATCH_T or v:GetAreaId() == AREA_WINTERSEDGE_T or v:GetAreaId() == AREA_SHADOWSIGHT_T))then
		if(battle == 1 and controll == 2 and v:GetUInt32Value(GAMEOBJECT_FACTION) ~= FACTION_ALLIANCE)then
			v:SetUInt32Value(GAMEOBJECT_FACTION,FACTION_ALLIANCE)
		elseif(battle == 1 and controll == 1 and v:GetUInt32Value(GAMEOBJECT_FACTION) ~= FACTION_HORDE)then
			v:SetUInt32Value(GAMEOBJECT_FACTION,FACTION_HORDE)
		elseif(battle == 0 and v:GetUInt32Value(GAMEOBJECT_FACTION) ~= FACTION_NEUTRAL)then
			v:SetUInt32Value(GAMEOBJECT_FACTION,FACTION_NEUTRAL)
		end
	end
end
end
if(pUnit:GetEntry() == NPC_NOT_IMMUNE_PC_NPC)then
local XT = pUnit:GetX()
local YT = pUnit:GetY()
	if(XT >= 5245.92 and XT <= 5247.92 and YT >= 2977.32 and YT <= 2979.32)then
		pUnit:TeleportCreature(5316.25,2977.04,409.274)
	elseif(XT >= 5248.89 and XT <= 5250.89 and YT >= 2702.11 and YT <= 2704.11)then
		pUnit:TeleportCreature(5314.51,2703.11,409.275)
	elseif(XT >= 5400.92 and XT <= 5402.92 and YT >= 2828.91 and YT <= 2830.91)then
		pUnit:TeleportCreature(5391.28,2828.09,418.675)
	elseif(XT >= 5391.81 and XT <= 5393.81 and YT >= 2853.02 and YT <= 2855.02)then
		pUnit:TeleportCreature(5401.63,2853.67,418.675)
	end
end
if(C_BAR_CAPTURE >= 1 and battle == 1)then
	if(pUnit:GetAreaId() == AREA_EASTSPARK)then
	local esshop = pUnit:GetGameObjectNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),GO_WINTERGRASP_WORKSHOP_ES)
	if(esshop ~= nil)then
		if(esshop:GetHP() ~= nil)then
			if(esshop:GetHP() > esshop:GetMaxHP()/2)then
				if(eastspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 7)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,7)
				elseif(eastspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and eastspark_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 1)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,1)
				elseif(eastspark_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 4)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,4)
				end
			elseif(esshop:GetHP() < esshop:GetMaxHP()/2 and esshop:GetHP() > 0)then
				if(eastspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL  and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 8)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,8)
				elseif(eastspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and eastspark_progress > C_BAR_CAPTURE  and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 2)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,2)
				elseif(eastspark_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 5)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,5)
				end
			elseif(esshop:GetHP() == 0)then
				if(eastspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 9)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,9)
				elseif(eastspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and eastspark_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 3)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,3)
				elseif(eastspark_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_ES_WORKSHOP) ~= 6)then
					pUnit:SetWorldStateForZone(WG_STATE_ES_WORKSHOP,6)
				end
			end
		end
	end
	elseif(pUnit:GetAreaId() == AREA_WESTSPARK)then
	local wsshop = pUnit:GetGameObjectNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),GO_WINTERGRASP_WORKSHOP_WS)
	if(wsshop ~= nil)then
		if(wsshop:GetHP() ~= nil)then
			if(wsshop:GetHP() > wsshop:GetMaxHP()/2)then
				if(westspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 7)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,7)
				elseif(westspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and westspark_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 1)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,1)
				elseif(westspark_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 4)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,4)
				end
			elseif(wsshop:GetHP() < wsshop:GetMaxHP()/2 and wsshop:GetHP() > 0)then
				if(westspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 8)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,8)
				elseif(westspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and westspark_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 2)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,2)
				elseif(westspark_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 5)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,5)
				end
			elseif(wsshop:GetHP() == 0)then
				if(westspark_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 9)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,9)
				elseif(westspark_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and westspark_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 3)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,3)
				elseif(westspark_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_WS_WORKSHOP) ~= 6)then
					pUnit:SetWorldStateForZone(WG_STATE_WS_WORKSHOP,6)
				end
			end
		end
	end
	elseif(pUnit:GetAreaId() == AREA_SUNKENRING)then
	local srshop = pUnit:GetGameObjectNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),GO_WINTERGRASP_WORKSHOP_SR)
	if(srshop ~= nil)then
		if(srshop:GetHP() ~= nil)then
			if(srshop:GetHP() > srshop:GetMaxHP()/2)then
				if(sunkenring_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 7)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,7)
				elseif(sunkenring_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and sunkenring_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 1)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,1)
				elseif(sunkenring_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 4)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,4)
				end
			elseif(srshop:GetHP() < srshop:GetMaxHP()/2 and srshop:GetHP() > 0)then
				if(sunkenring_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 8)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,8)
				elseif(sunkenring_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and sunkenring_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 2)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,2)
				elseif(sunkenring_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 5)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,5)
				end
			elseif(srshop:GetHP() == 0)then
				if(sunkenring_progress > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 9)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,9)
				elseif(sunkenring_progress < C_BAR_CAPTURE + C_BAR_NEUTRAL and sunkenring_progress > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 3)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,3)
				elseif(sunkenring_progress < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_SR_WORKSHOP) ~= 6)then
					pUnit:SetWorldStateForZone(WG_STATE_SR_WORKSHOP,6)
				end
			end
		end
	end
	elseif(pUnit:GetAreaId() == AREA_BROKENTEMPLE)then
	local srshop = pUnit:GetGameObjectNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),GO_WINTERGRASP_WORKSHOP_BT)
	if(srshop ~= nil)then
		if(srshop:GetHP() ~= nil)then
			if(srshop:GetHP() > srshop:GetMaxHP()/2)then
				if(brokentemple_progres > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 7)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,7)
				elseif(brokentemple_progres < C_BAR_CAPTURE + C_BAR_NEUTRAL and brokentemple_progres > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 1)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,1)
				elseif(brokentemple_progres < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 4)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,4)
				end
			elseif(srshop:GetHP() < srshop:GetMaxHP()/2 and srshop:GetHP() > 0)then
				if(brokentemple_progres > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 8)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,8)
				elseif(brokentemple_progres < C_BAR_CAPTURE + C_BAR_NEUTRAL and brokentemple_progres > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 2)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,2)
				elseif(brokentemple_progres < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 5)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,5)
				end
			elseif(srshop:GetHP() == 0)then
				if(brokentemple_progres > C_BAR_CAPTURE + C_BAR_NEUTRAL and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 9)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,9)
				elseif(brokentemple_progres < C_BAR_CAPTURE + C_BAR_NEUTRAL and brokentemple_progres > C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 3)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,3)
				elseif(brokentemple_progres < C_BAR_CAPTURE and pUnit:GetWorldStateForZone(WG_STATE_BT_WORKSHOP) ~= 6)then
					pUnit:SetWorldStateForZone(WG_STATE_BT_WORKSHOP,6)
				end
			end
		end
	end
	end
end
end

function TitanRelickOnUse(pGO, event, pPlayer)
if(battle == 1)then
local timebattle = os.time() - starttimer
	if(controll == 1 and pPlayer:GetTeam() == 1 and pGO:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) == 9)then
		timer_battle = 0
		timer_nextbattle = os.time() + TIME_TO_BATTLE
		battle = 0
		controll = 2
		states = 0
		pGO:Despawn(1,0)
		stateuiset = 0
		starttimer = 0
		south_towers = 3
		for k,v in pairs (GetPlayersInZone(ZONE_WG))do
		v:SendAreaTriggerMessage("The Wintergrasp fortress has been captured by the Horde!")
		local packetseound = LuaPacket:CreatePacket(SMSG_PLAY_SOUND, 4)
		packetseound:WriteULong(8454)
		v:SendPacketToPlayer(packetseound)
			if(v:GetTeam() == 1)then
				v:CastSpell(SPELL_VICTORY_REWARD)
				v:CastSpell(SPELL_VICTORY_AURA)
				if(timebattle <= 600)then
					if(v:HasAchievement(ACHIEVEMENT_WIN_OUR_GRASP) == false)then
						v:AddAchievement(ACHIEVEMENT_WIN_OUR_GRASP)
					end
				end
				if(v:HasQuest(QUEST_WG_VICTORY_H) and v:GetQuestObjectiveCompletion(QUEST_WG_VICTORY_H, 0) == 0)then
					v:AdvanceQuestObjective(QUEST_WG_VICTORY_H, 0)
				end
			elseif(v:GetTeam() == 0)then
				v:CastSpell(SPELL_DEFEAT_REWARD)
			end
		end
		end
	if(controll == 2 and pPlayer:GetTeam() == 0 and pGO:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) == 6)then
		timer_battle = 0
		timer_nextbattle = os.time() + TIME_TO_BATTLE
		battle = 0
		controll = 1
		states = 0
		pGO:Despawn(1,0)
		stateuiset = 0
		starttimer = 0
		south_towers = 3
		for k,v in pairs (GetPlayersInZone(ZONE_WG))do
		v:SendAreaTriggerMessage("The Wintergrasp fortress has been captured by the Alliance!")
		local packetseound = LuaPacket:CreatePacket(SMSG_PLAY_SOUND, 4)
		packetseound:WriteULong(8455)
		v:SendPacketToPlayer(packetseound)
			if(v:GetTeam() == 0)then
				v:CastSpell(SPELL_VICTORY_REWARD)
				v:CastSpell(SPELL_VICTORY_AURA)
				if(timebattle <= 600)then
					if(v:HasAchievement(ACHIEVEMENT_WIN_OUR_GRASP) == false)then
						v:AddAchievement(ACHIEVEMENT_WIN_OUR_GRASP)
					end
				end
				if(v:HasQuest(QUEST_WG_VICTORY_A) and v:GetQuestObjectiveCompletion(QUEST_WG_VICTORY_A, 0) == 0)then
					v:AdvanceQuestObjective(QUEST_WG_VICTORY_A, 0)
				end
			elseif(v:GetTeam() == 1)then
				v:CastSpell(SPELL_DEFEAT_REWARD)
			end
		end
	end
end
end

function DebugWG(event, pPlayer, message, type, language)
if(pPlayer:IsGm() and pPlayer:GetZoneId() == ZONE_WG and battle == 0)then
	if(message == "#debug WG")then
		timer_nextbattle = os.time() + 10
		for k,v in pairs(GetPlayersInWorld())do
			v:SendBroadcastMessage("Wintergrasp battle starts after 10 sec. Battlefield started by GM "..pPlayer:GetName()..".|r")
		end
		local p = LuaPacket:CreatePacket(SMSG_BATTLEFIELD_MGR_QUEUE_INVITE, 5)
		p:WriteULong(1)
		p:WriteUByte(1)
		SendPacketToZone(p, ZONE_WG)
		pPlayer:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIME, timer_nextbattle)
	end
end
end

function PortalOnUse(pGO, event, pPlayer)
if(pGO:GetMapId() == MAP_NORTHREND)then
	if(pPlayer:HasAura(SPELL_TELEPORT_DEFENDER) == false)then
		local teleportunit = pGO:GetCreatureNearestCoords(pGO:GetX(),pGO:GetY(),pGO:GetZ(),NPC_NOT_IMMUNE_PC_NPC)
		if(teleportunit ~= nil)then
			local xu,yu,zu,ou = teleportunit:GetSpawnLocation()
			pPlayer:Teleport(MAP_NORTHREND,xu,yu,zu,ou)
			pPlayer:CastSpell(SPELL_TELEPORT_DEFENDER)
		end
	else
		pPlayer:SendAreaTriggerMessage("You can't do that yet!")
	end
else
	pPlayer:CastSpell(54640)
end
end

function OnLoadVehicleTeleporter(pGO)
pGO:RegisterAIUpdateEvent(1000)
end

function OnAIUpdateVehicleTeleporter(pGO)
if(pGO == nil)then
	pGO:RemoveAIUpdateEvent()
end
for k,v in pairs(pGO:GetInRangeUnits()) do
if(v:IsCreature())then
	if(pGO:GetDistance(v) < 10 and battle == 1)then
		if((v:GetFaction() == FACTION_ALLIANCE and controll == 1) or (v:GetFaction() == FACTION_HORDE and controll == 2))then
			if(v:HasAura(SPELL_TELEPORT_VEHICLE) == false)then
				if(v:GetEntry() == NPC_VEHICLE_CATAPULT or v:GetEntry() == NPC_VEHICLE_DEMOLISHER or v:GetEntry() == NPC_VEHICLE_SIEGE_ENGINE_H or v:GetEntry() == NPC_VEHICLE_SIEGE_ENGINE_A)then
					local teleportunit = pGO:GetCreatureNearestCoords(pGO:GetX(),pGO:GetY(),pGO:GetZ(),NPC_NOT_IMMUNE_PC_NPC)
					if(teleportunit ~= nil)then
						local xu,yu,zu = teleportunit:GetSpawnLocation()
						v:TeleportCreature(xu,yu,zu)
						v:CastSpell(SPELL_TELEPORT_VEHICLE)
					end
				end
			end
		end
	end
end
end
end

function OnSP_Cpoint(pGO)
pGO:RegisterAIUpdateEvent(1500)
end

function AIUpdate_Cpoint(pGO)
if(battle == 1)then
ES_P = 0
WS_P = 0
SR_P = 0
BT_P = 0
if(pGO == nil)then
	pGO:RemoveAIUpdateEvent()
end
for k,m in pairs(pGO:GetInRangePlayers())do
if(battle == 1 and m:IsPvPFlagged() and m:IsStealthed() == false and m:IsAlive())then
	if(m:GetAreaId() == AREA_EASTSPARK and pGO:GetDistance(m) <= 5500)then
		ES_A = 0
		ES_H = 0
		if(m:GetTeam() == 0)then
			ES_A = ES_A + 1
		elseif(m:GetTeam() == 1)then
			ES_H = ES_H + 1
		end
		ES_P = ES_A - ES_H
		if(eastspark_progress < 100 and eastspark_progress > 0)then
			if(ES_P < 0)then
				eastspark_progress = eastspark_progress - 1
			elseif(ES_P > 0)then
				eastspark_progress = eastspark_progress + 1
			end
		elseif(eastspark_progress == 0)then
			if(ES_P > 0)then
				eastspark_progress = eastspark_progress + 1
			end
		elseif(eastspark_progress == 100)then
			if(ES_P < 0)then
				eastspark_progress = eastspark_progress - 1
			end
		end
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_SHOW,1)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_PROGRESS,eastspark_progress)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_NEUTRAL,C_BAR_NEUTRAL)
	elseif(m:GetAreaId() == AREA_WESTSPARK and pGO:GetDistance(m) <= 5500)then
		WS_A = 0
		WS_H = 0
		if(m:GetTeam() == 0)then
			WS_A = WS_A + 1
		elseif(m:GetTeam() == 1)then
			WS_H = WS_H + 1
		end
		WS_P = WS_A - WS_H
		if(westspark_progress < 100 and westspark_progress > 0)then
			if(WS_P < 0)then
				westspark_progress = westspark_progress - 1
			elseif(WS_P > 0)then
				westspark_progress = westspark_progress + 1
			end
		elseif(westspark_progress == 0)then
			if(WS_P > 0)then
				westspark_progress = westspark_progress + 1
			end
		elseif(westspark_progress == 100)then
			if(WS_P < 0)then
				westspark_progress = westspark_progress - 1
			end
		end
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_SHOW,1)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_PROGRESS,westspark_progress)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_NEUTRAL,C_BAR_NEUTRAL)
	else
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_SHOW,0)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_PROGRESS,0)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_NEUTRAL,0)
	end
	if(m:GetAreaId() == AREA_SUNKENRING and pGO:GetDistance(m) <= 5500)then
		SR_A = 0
		SR_H = 0
		if(m:GetTeam() == 0)then
			SR_A = SR_A + 1
		elseif(m:GetTeam() == 1)then
			SR_H = SR_H + 1
		end
		SR_P = SR_A - SR_H
		if(sunkenring_progress < 100 and sunkenring_progress > 0)then
			if(SR_P < 0)then
				sunkenring_progress = sunkenring_progress - 1
			elseif(SR_P > 0)then
				sunkenring_progress = sunkenring_progress + 1
			end
		elseif(sunkenring_progress == 0)then
			if(SR_P > 0)then
				sunkenring_progress = sunkenring_progress + 1
			end
		elseif(sunkenring_progress == 100)then
			if(SR_P < 0)then
				sunkenring_progress = sunkenring_progress - 1
			end
		end
		m:SetWorldStateForPlayer(WG_STATE_NORTH_SHOW,1)
		m:SetWorldStateForPlayer(WG_STATE_NORTH_PROGRESS,sunkenring_progress)
		m:SetWorldStateForPlayer(WG_STATE_NORTH_NEUTRAL,C_BAR_NEUTRAL)
	elseif(m:GetAreaId() == AREA_BROKENTEMPLE and pGO:GetDistance(m) <= 5500)then
		BT_A = 0
		BT_H = 0
		if(m:GetTeam() == 0)then
			BT_A = BT_A + 1
		elseif(m:GetTeam() == 1)then
			BT_H = BT_H + 1
		end
		BT_P = BT_A - BT_H
		if(brokentemple_progres < 100 and brokentemple_progres > 0)then
			if(BT_P < 0)then
				brokentemple_progres = brokentemple_progres - 1
			elseif(BT_P > 0)then
				brokentemple_progres = brokentemple_progres + 1
			end
		elseif(brokentemple_progres == 0)then
			if(BT_P > 0)then
				brokentemple_progres = brokentemple_progres + 1
			end
		elseif(brokentemple_progres == 100)then
			if(BT_P < 0)then
				brokentemple_progres = brokentemple_progres - 1
			end
		end
		m:SetWorldStateForPlayer(WG_STATE_NORTH_SHOW,1)
		m:SetWorldStateForPlayer(WG_STATE_NORTH_PROGRESS,brokentemple_progres)
		m:SetWorldStateForPlayer(WG_STATE_NORTH_NEUTRAL,C_BAR_NEUTRAL)
	else
		m:SetWorldStateForPlayer(WG_STATE_NORTH_SHOW,0)
		m:SetWorldStateForPlayer(WG_STATE_NORTH_PROGRESS,0)
		m:SetWorldStateForPlayer(WG_STATE_NORTH_NEUTRAL,0)
	end
else
	m:SetWorldStateForPlayer(WG_STATE_NORTH_SHOW,0)
	m:SetWorldStateForPlayer(WG_STATE_NORTH_PROGRESS,0)
	m:SetWorldStateForPlayer(WG_STATE_NORTH_NEUTRAL,0)
	m:SetWorldStateForPlayer(WG_STATE_SOUTH_SHOW,0)
	m:SetWorldStateForPlayer(WG_STATE_SOUTH_PROGRESS,0)
	m:SetWorldStateForPlayer(WG_STATE_SOUTH_NEUTRAL,0)
end
end
end
end

function KillCreature(pUnit, event, pLastTarget)
	if(battle == 1)then
		for k,v in pairs(pUnit:GetInRangePlayers())do
			if(v:IsPlayer())then
				if(v:HasAura(SPELL_RECRUIT))then
					if(v:GetAuraStackCount(SPELL_RECRUIT) < 5)then
						v:CastSpell(SPELL_RECRUIT)
					else
						pUnit:SendChatMessageToPlayer(42, 0, "You have reached Rank 1: Corporal", v)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:CastSpell(SPELL_CORPORAL)
					end
				elseif(v:HasAura(SPELL_CORPORAL))then
					if(v:GetAuraStackCount(SPELL_CORPORAL) < 5)then
						v:CastSpell(SPELL_CORPORAL)
					else
						pUnit:SendChatMessageToPlayer(42, 0, "You have reached Rank 2: Lieutenant", v)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:AddAura(SPELL_LIEUTENANT,0)
					end
				end
			end
		end
	end
end

function KillPlayer(event, pKiller, pVictim)
if(battle == 1)then
	for k,v in pairs(pVictim:GetInRangePlayers())do
		if(pVictim:GetTeam() ~= v:GetTeam())then
			if(v:HasAura(SPELL_RECRUIT))then
					if(v:GetAuraStackCount(SPELL_RECRUIT) < 5)then
						v:CastSpell(SPELL_RECRUIT)
					else
						v:SendAreaTriggerMessage("You have reached Rank 1: Corporal")
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:RemoveAura(SPELL_RECRUIT)
						v:CastSpell(SPELL_CORPORAL)
					end
				elseif(v:HasAura(SPELL_CORPORAL))then
					if(v:GetAuraStackCount(SPELL_CORPORAL) < 5)then
						v:CastSpell(SPELL_CORPORAL)
					else
						v:SendAreaTriggerMessage("You have reached Rank 2: Lieutenant")
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:RemoveAura(SPELL_CORPORAL)
						v:AddAura(SPELL_LIEUTENANT,0)
					end
				end
		end
	end
end
end

function AGengineerOnGossip(pUnit, event, pPlayer)
if(pUnit:GetWorldStateForZone(WG_STATE_MAX_A_VEHICLES) > pUnit:GetWorldStateForZone(WG_STATE_CURRENT_A_VEHICLES))then
	if(pPlayer:HasAura(SPELL_CORPORAL) or pPlayer:HasAura(SPELL_LIEUTENANT) and battle == 1)then
		if(pPlayer:HasAura(SPELL_CORPORAL))then
			pUnit:GossipCreateMenu(13798, pPlayer, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a catapult.", 1, 0)
			pUnit:GossipSendMenu(pPlayer)
		elseif(pPlayer:HasAura(SPELL_LIEUTENANT))then
			pUnit:GossipCreateMenu(13798, pPlayer, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a catapult.", 1, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a demolisher.", 2, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a siege engine.", 3, 0)
			pUnit:GossipSendMenu(pPlayer)
		else
			pUnit:GossipCreateMenu(14172, pPlayer, 0)
			pUnit:GossipSendMenu(pPlayer)
		end
	end
else
	pUnit:GossipCreateMenu(14172, pPlayer, 0)
	pUnit:GossipSendMenu(pPlayer)
end
end

function AOnSelect(pUnit, event, pPlayer, id, intid, code)
if(pUnit:GetWorldStateForZone(WG_STATE_MAX_A_VEHICLES) > pUnit:GetWorldStateForZone(WG_STATE_CURRENT_A_VEHICLES))then
local arms = pPlayer:GetCreatureNearestCoords(pPlayer:GetX(),pPlayer:GetY(),pPlayer:GetZ(),NPC_NOT_IMMUNE_PC_NPC)
	if(intid == 1)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_CATAPULT, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_ALLIANCE, 3300000, 35, 0, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_CATAPULT)
		pPlayer:GossipComplete()
	elseif(intid == 2)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_DEMOLISHER, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_ALLIANCE, 3300000, 35, 0, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_DEMOLISHER)
		pPlayer:GossipComplete()
	elseif(intid == 3)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_SIEGE_ENGINE_A, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_ALLIANCE, 3300000, 35, 0, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_ENGINE_A)
		pPlayer:GossipComplete()
	end
end
end

function HGengineerOnGossip(pUnit, event, pPlayer)
if(pUnit:GetWorldStateForZone(WG_STATE_MAX_H_VEHICLES) > pUnit:GetWorldStateForZone(WG_STATE_CURRENT_H_VEHICLES))then
	if(pPlayer:HasAura(SPELL_CORPORAL) or pPlayer:HasAura(SPELL_LIEUTENANT) and battle == 1)then
		if(pPlayer:HasAura(SPELL_CORPORAL))then
			pUnit:GossipCreateMenu(13798, pPlayer, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a catapult.", 1, 0)
			pUnit:GossipSendMenu(pPlayer)
		elseif(pPlayer:HasAura(SPELL_LIEUTENANT))then
			pUnit:GossipCreateMenu(13798, pPlayer, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a catapult.", 1, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a demolisher.", 2, 0)
			pUnit:GossipMenuAddItem(0, "I'd like to build a siege engine.", 3, 0)
			pUnit:GossipSendMenu(pPlayer)
		else
			pUnit:GossipCreateMenu(14172, pPlayer, 0)
			pUnit:GossipSendMenu(pPlayer)
		end
	end
else
	pUnit:GossipCreateMenu(14172, pPlayer, 0)
	pUnit:GossipSendMenu(pPlayer)
end
end

function HOnSelect(pUnit, event, pPlayer, id, intid, code)
if(pUnit:GetWorldStateForZone(WG_STATE_MAX_H_VEHICLES) > pUnit:GetWorldStateForZone(WG_STATE_CURRENT_H_VEHICLES))then
	if(intid == 1)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_CATAPULT, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_HORDE, 3300000, 35, 0, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_CATAPULT)
		pPlayer:GossipComplete()
	elseif(intid == 2)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_DEMOLISHER, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_HORDE, 3300000, 35, 0, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_DEMOLISHER)
		pPlayer:GossipComplete()
	elseif(intid == 3)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_SIEGE_ENGINE_H, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_HORDE, 3300000, 35, 0, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_ENGINE_H)
		pPlayer:GossipComplete()
	end
end
end

function OnZoneEnter(event, pPlayer, ZoneId, OldZoneId)
if(ZoneId == ZONE_WG)then
	if(battle == 0)then
		if(timer_nextbattle <= os.time() + jointimer_1 and timer_nextbattle >= os.time() + jointimer_2)then
			local p = LuaPacket:CreatePacket(SMSG_BATTLEFIELD_MGR_ENTRY_INVITE, 12)
			p:WriteULong(1)
			p:WriteULong(4197)
			p:WriteULong(timer_nextbattle)
			pPlayer:SendPacketToPlayer(p)
		elseif(timer_nextbattle <= os.time() + jointimer_2)then
			local p = LuaPacket:CreatePacket(SMSG_BATTLEFIELD_MGR_QUEUE_INVITE, 5)
			p:WriteULong(1)
			p:WriteUByte(1)
			pPlayer:SendPacketToPlayer(p)
		end
	elseif(battle == 1)then
	end
end
function zonecheck(buff_areas, ZoneId)
	for key, value in pairs(buff_areas) do
		if(value == ZoneId)then
			-- if(controll == pPlayer:GetTeam() + 1)then
				if not(pPlayer:HasAura(SPELL_ESSENCE_OF_WINTERGRASP))then
					if(controll == pPlayer:GetTeam()+1)then
						pPlayer:AddAura(SPELL_ESSENCE_OF_WINTERGRASP,0)
					end
				end
			-- end
		 return true end
	end
	if(pPlayer:HasAura(SPELL_ESSENCE_OF_WINTERGRASP))then
		pPlayer:RemoveAura(SPELL_ESSENCE_OF_WINTERGRASP)
	end
	return false
end
print(zonecheck(buff_areas, ZoneId))
end
 --[[
function OnZoneEnterBuff(event, pPlayer, ZoneId, OldZoneId)

end
]]--
function OnEnterBuff(event, pPlayer)
local ZoneId = pPlayer:GetZoneId()
function zonecheck(buff_areas, ZoneId)
	for key, value in pairs(buff_areas) do
		if(value == ZoneId)then
			-- if(controll == pPlayer:GetTeam() + 1)then
				if not(pPlayer:HasAura(SPELL_ESSENCE_OF_WINTERGRASP))then
					if(controll == pPlayer:GetTeam()+1)then
						pPlayer:AddAura(SPELL_ESSENCE_OF_WINTERGRASP,0)
					end
				end
			-- end
		 return true end
	end
	if(pPlayer:HasAura(SPELL_ESSENCE_OF_WINTERGRASP))then
		pPlayer:RemoveAura(SPELL_ESSENCE_OF_WINTERGRASP)
	end
	return false
end
print(zonecheck(buff_areas, ZoneId))
end

function WallOnDamage(pGO, damage)
for i = 1, #go_wall do
	if(pGO:GetEntry() == go_wall[i][1])then
		if(pGO:GetHP() < pGO:GetMaxHP()/2 and (pGO:GetWorldStateForZone(go_wall[i][2])== 1 or pGO:GetWorldStateForZone(go_wall[i][2])== 4 or pGO:GetWorldStateForZone(go_wall[i][2])== 7))then
			pGO:SetWorldStateForZone(go_wall[i][2],pGO:GetWorldStateForZone(go_wall[i][2])+1)
		end
	end
end
end

function WallOnDestroy(pGO)
for i = 1, #go_wall do
	if(pGO:GetEntry() == go_wall[i][1])then
		if(pGO:GetWorldStateForZone(go_wall[i][2])== 2 or pGO:GetWorldStateForZone(go_wall[i][2])== 5 or pGO:GetWorldStateForZone(go_wall[i][2])== 8)then
			pGO:SetWorldStateForZone(go_wall[i][2],pGO:GetWorldStateForZone(go_wall[i][2])+1)
		end
	end
end
end

function FTOnDamage(pGO, damage)
for i = 1, #go_f_tower do
	if(pGO:GetEntry() == go_f_tower[i][1])then
		if(pGO:GetHP() < pGO:GetMaxHP()/2 and (pGO:GetWorldStateForZone(go_f_tower[i][2])== 1 or pGO:GetWorldStateForZone(go_f_tower[i][2])== 4 or pGO:GetWorldStateForZone(go_f_tower[i][2])== 7))then
			pGO:SetWorldStateForZone(go_f_tower[i][2],pGO:GetWorldStateForZone(go_f_tower[i][2])+1)
		end
	end
end
end

function FTOnDestroy(pGO)
for i = 1, #go_f_tower do
	if(pGO:GetEntry() == go_f_tower[i][1])then
		if(pGO:GetWorldStateForZone(go_f_tower[i][2])== 2 or pGO:GetWorldStateForZone(go_f_tower[i][2])== 5 or pGO:GetWorldStateForZone(go_f_tower[i][2])== 8)then
			pGO:SetWorldStateForZone(go_f_tower[i][2],pGO:GetWorldStateForZone(go_f_tower[i][2])+1)
		end
	end
	for k,g in pairs(pGO:GetInRangePlayers())do
	if(DEFENDER == "Horde")then
			if(g:GetTeam() == 0)then
				if not(g:HasAchievement(ACHIEVEMENT_LEANING_T))then
					g:AddAchievement(ACHIEVEMENT_LEANING_T)
				end
			end
	elseif(DEFENDER == "Alliance")then
			if(g:GetTeam() == 1)then
				if not(g:HasAchievement(ACHIEVEMENT_LEANING_T))then
					g:AddAchievement(ACHIEVEMENT_LEANING_T)
				end
			end
		end
	end
end
end


function STOnDamage(pGO, damage)
for i = 1, #go_s_tower do
	if(pGO:GetEntry() == go_s_tower[i][1])then
		if(pGO:GetHP() < pGO:GetMaxHP()/2 and (pGO:GetWorldStateForZone(go_s_tower[i][2])== 1 or pGO:GetWorldStateForZone(go_s_tower[i][2])== 4 or pGO:GetWorldStateForZone(go_s_tower[i][2])== 7))then
			pGO:SetWorldStateForZone(go_s_tower[i][2],pGO:GetWorldStateForZone(go_s_tower[i][2])+1)
		end
	end
end
end

function STOnDestroy(pGO)
for i = 1, #go_s_tower do
	if(pGO:GetEntry() == go_s_tower[i][1])then
		if(pGO:GetWorldStateForZone(go_s_tower[i][2])== 2 or pGO:GetWorldStateForZone(go_s_tower[i][2])== 5 or pGO:GetWorldStateForZone(go_s_tower[i][2])== 8)then
			pGO:SetWorldStateForZone(go_s_tower[i][2],pGO:GetWorldStateForZone(go_s_tower[i][2])+1)
		end
	end
end
for k,g in pairs(pGO:GetInRangePlayers())do
	if(DEFENDER == "Alliance")then
		if(g:GetTeam() == 0)then
			if not(g:HasAchievement(ACHIEVEMENT_LEANING_T))then
				g:AddAchievement(ACHIEVEMENT_LEANING_T)
			end
			if(g:HasQuest(QUEST_WG_SOUTHEN_SABOTAGE) and g:GetQuestObjectiveCompletion(QUEST_WG_SOUTHEN_SABOTAGE, 0) == 0)then
				g:AdvanceQuestObjective(QUEST_WG_SOUTHEN_SABOTAGE, 0)
			end
		end
	elseif(DEFENDER == "Horde")then
		if(g:GetTeam() == 1)then
			if not(g:HasAchievement(ACHIEVEMENT_LEANING_T))then
				g:AddAchievement(ACHIEVEMENT_LEANING_T)
			end
			if(g:HasQuest(QUEST_WG_TOPPING_TOWERS) and g:GetQuestObjectiveCompletion(QUEST_WG_TOPPING_TOWERS, 0) == 0)then
				g:AdvanceQuestObjective(QUEST_WG_TOPPING_TOWERS, 0)
			end
		end
	end
if(pGO:GetEntry() == GO_WINTERGRASP_SS_TOWER)then
	south_towers = south_towers - 1
	for k,g in pairs(GetPlayersInZone(ZONE_WG))do
		g:SendBroadcastMessage("The Shadowsight Tower was destroyed by the "..DEFENDER.."!")
		g:SendAreaTriggerMessage("The Shadowsight Tower was destroyed by the "..DEFENDER.."!")
	end
elseif(pGO:GetEntry() == GO_WINTERGRASP_WE_TOWER)then
	south_towers = south_towers - 1
	for k,g in pairs(GetPlayersInZone(ZONE_WG))do
		g:SendBroadcastMessage("The Winter's Edge Tower was destroyed by the "..DEFENDER.."!")
		g:SendAreaTriggerMessage("The Winter's Edge Tower was destroyed by the "..DEFENDER.."!")
	end
elseif(pGO:GetEntry() == GO_WINTERGRASP_FW_TOWER)then
	south_towers = south_towers - 1
	for k,g in pairs(GetPlayersInZone(ZONE_WG))do
		g:SendBroadcastMessage("The Flamewatch Tower was destroyed by the "..DEFENDER.."!")
		g:SendAreaTriggerMessage("The Flamewatch Tower was destroyed by the "..DEFENDER.."!")
	end
end
end
end

RegisterUnitGossipEvent(NPC_GOBLIN_ENGINEER,2,HOnSelect)
RegisterUnitGossipEvent(NPC_GOBLIN_ENGINEER,1,HGengineerOnGossip)
RegisterUnitGossipEvent(NPC_GNOME_ENGINEER,2,AOnSelect)
RegisterUnitGossipEvent(NPC_GNOME_ENGINEER,1,AGengineerOnGossip)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_WS_100,5,AIUpdate_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_WS_100,2,OnSP_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_ES_100,5,AIUpdate_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_ES_100,2,OnSP_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_BT_100,5,AIUpdate_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_BT_100,2,OnSP_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_SR_100,5,AIUpdate_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_CAPTUREPOINT_SR_100,2,OnSP_Cpoint)
RegisterGameObjectEvent(GO_WINTERGRASP_VEHICLE_TELEPORTER,5,OnAIUpdateVehicleTeleporter)
RegisterGameObjectEvent(GO_WINTERGRASP_VEHICLE_TELEPORTER,2,OnLoadVehicleTeleporter)
RegisterGameObjectEvent(GO_WINTERGRASP_DEFENDER_A,4,PortalOnUse)
RegisterGameObjectEvent(GO_WINTERGRASP_DEFENDER_H,4,PortalOnUse)
RegisterGameObjectEvent(GO_WINTERGRASP_DEFENDER_N,4,PortalOnUse)
RegisterGameObjectEvent(GO_WINTERGRASP_TITAN_RELIC,4,TitanRelickOnUse)
RegisterUnitEvent(NPC_DETECTION_UNIT,18,DetectionUnitOnSpawn)
RegisterUnitEvent(NPC_DETECTION_UNIT,21,DetectionUnitAIUpdate)
RegisterUnitEvent(NPC_NOT_IMMUNE_PC_NPC,18,DetectionUnitOnSpawn)
RegisterUnitEvent(NPC_NOT_IMMUNE_PC_NPC,21,DetectionUnitAIUpdate)
RegisterTimedEvent("WGUpdate", 1000, 0)
RegisterTimedEvent("Aura", 1000, 0)
RegisterServerHook(16, "DebugWG")
RegisterServerHook(2,KillPlayer)
RegisterServerHook(15,OnZoneEnter)
 -- RegisterServerHook(15,OnZoneEnterBuff)
RegisterServerHook(4,OnEnterBuff)
RegisterUnitEvent(30739,4,KillCreature)
RegisterUnitEvent(30740,4,KillCreature)
RegisterGameObjectEvent(190219,7,WallOnDamage)
RegisterGameObjectEvent(190220,7,WallOnDamage)
RegisterGameObjectEvent(191802,7,WallOnDamage)
RegisterGameObjectEvent(191803,7,WallOnDamage)
RegisterGameObjectEvent(190369,7,WallOnDamage)
RegisterGameObjectEvent(190371,7,WallOnDamage)
RegisterGameObjectEvent(190374,7,WallOnDamage)
RegisterGameObjectEvent(190376,7,WallOnDamage)
RegisterGameObjectEvent(190372,7,WallOnDamage)
RegisterGameObjectEvent(190370,7,WallOnDamage)
RegisterGameObjectEvent(191807,7,WallOnDamage)
RegisterGameObjectEvent(191808,7,WallOnDamage)
RegisterGameObjectEvent(191809,7,WallOnDamage)
RegisterGameObjectEvent(191799,7,WallOnDamage)
RegisterGameObjectEvent(191795,7,WallOnDamage)
RegisterGameObjectEvent(191797,7,WallOnDamage)
RegisterGameObjectEvent(191800,7,WallOnDamage)
RegisterGameObjectEvent(191804,7,WallOnDamage)
RegisterGameObjectEvent(191805,7,WallOnDamage)
RegisterGameObjectEvent(191806,7,WallOnDamage)
RegisterGameObjectEvent(191801,7,WallOnDamage)
RegisterGameObjectEvent(191798,7,WallOnDamage)
RegisterGameObjectEvent(191796,7,WallOnDamage)
RegisterGameObjectEvent(192028,7,WallOnDamage)
RegisterGameObjectEvent(192029,7,WallOnDamage)
RegisterGameObjectEvent(190375,7,WallOnDamage)
RegisterGameObjectEvent(190219,8,WallOnDestroy)
RegisterGameObjectEvent(190220,8,WallOnDestroy)
RegisterGameObjectEvent(191802,8,WallOnDestroy)
RegisterGameObjectEvent(191803,8,WallOnDestroy)
RegisterGameObjectEvent(190369,8,WallOnDestroy)
RegisterGameObjectEvent(190371,8,WallOnDestroy)
RegisterGameObjectEvent(190374,8,WallOnDestroy)
RegisterGameObjectEvent(190376,8,WallOnDestroy)
RegisterGameObjectEvent(190372,8,WallOnDestroy)
RegisterGameObjectEvent(190370,8,WallOnDestroy)
RegisterGameObjectEvent(191807,8,WallOnDestroy)
RegisterGameObjectEvent(191808,8,WallOnDestroy)
RegisterGameObjectEvent(191809,8,WallOnDestroy)
RegisterGameObjectEvent(191799,8,WallOnDestroy)
RegisterGameObjectEvent(191795,8,WallOnDestroy)
RegisterGameObjectEvent(191797,8,WallOnDestroy)
RegisterGameObjectEvent(191800,8,WallOnDestroy)
RegisterGameObjectEvent(191804,8,WallOnDestroy)
RegisterGameObjectEvent(191805,8,WallOnDestroy)
RegisterGameObjectEvent(191806,8,WallOnDestroy)
RegisterGameObjectEvent(191801,8,WallOnDestroy)
RegisterGameObjectEvent(191798,8,WallOnDestroy)
RegisterGameObjectEvent(191796,8,WallOnDestroy)
RegisterGameObjectEvent(192028,8,WallOnDestroy)
RegisterGameObjectEvent(192029,8,WallOnDestroy)
RegisterGameObjectEvent(190375,8,WallOnDestroy)
RegisterGameObjectEvent(190221,7,FTOnDamage)
RegisterGameObjectEvent(190378,7,FTOnDamage)
RegisterGameObjectEvent(190373,7,FTOnDamage)
RegisterGameObjectEvent(190377,7,FTOnDamage)
RegisterGameObjectEvent(190221,8,FTOnDestroy)
RegisterGameObjectEvent(190378,8,FTOnDestroy)
RegisterGameObjectEvent(190373,8,FTOnDestroy)
RegisterGameObjectEvent(190377,8,FTOnDestroy)
RegisterGameObjectEvent(190356,7,STOnDamage)
RegisterGameObjectEvent(190357,7,STOnDamage)
RegisterGameObjectEvent(190358,7,STOnDamage)
RegisterGameObjectEvent(190356,8,STOnDestroy)
RegisterGameObjectEvent(190357,8,STOnDestroy)
RegisterGameObjectEvent(190358,8,STOnDestroy)
