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

 -- Old capture bar controller. Will be removed or reused
local C_BAR_NEUTRAL = 80 -- the neutral vallue of the capture bar. MUST BE UNDER 100.
local C_BAR_CAPTURE = (100 - C_BAR_NEUTRAL)/2

 -- GO FACTION (not working for now)
local GAMEOBJECT_FACTION = 0x0006 + 0x0009

 -- Factions
local FACTION_HORDE = 1735
local FACTION_ALLIANCE = 1732
local FACTION_NEUTRAL = 35

 -- vehicle workshops capture bar controllers
local eastspark_progress = 0
local westspark_progress = 0
local sunkenring_progress = 0
local brokentemple_progres = 0

 -- Worldstate workshop controllers
local vehicle_vallue_a = 0
local vehicle_vallue_h = 0

if(controll == 2)then
	eastspark_progress = 100
	westspark_progress = 100
	sunkenring_progress = 100
	brokentemple_progres = 100
	vehicle_vallue_h = 8
	vehicle_vallue_a = 16
else
	eastspark_progress = 0
	westspark_progress = 0
	sunkenring_progress = 0
	brokentemple_progres = 0
	vehicle_vallue_h = 16
	vehicle_vallue_a = 8
end

 -- UI STATES
local WG_STATE_NEXT_BATTLE_TIME =	4354
local WG_STATE_END_BATTLE_TIME = 3781
local WG_HORDE_CONTROLLED = 3802
local WG_ALLIANCE_CONTROLLED = 3803
local WG_STATE_BATTLE_UI = 3710
local WG_STATE_BATTLE_TIME = 3781
local WG_STATE_NEXT_BATTLE_TIMER = 3801
local WG_STATE_CURRENT_H_VEHICLES = 3490
local WG_STATE_MAX_H_VEHICLES = 3491
local WG_STATE_CURRENT_A_VEHICLES = 3680
local WG_STATE_MAX_A_VEHICLES = 3681
local WG_STATE_BATTLEFIELD_STATUS_MAP = 3804
 -- Map states:
local WG_STATE_KEEP_GATE_ANDGY = 3773

 -- Dynamic capturebar states
local WG_STATE_SOUTH_SHOW = 3501
local WG_STATE_SOUTH_PROGRESS = 3502
local WG_STATE_SOUTH_NEUTRAL = 3508

 -- Npc's
local NPC_DETECTION_UNIT = 27869
local NPC_GOBLIN_ENGINEER = 30400
local NPC_GNOME_ENGINEER = 30499
local NPC_NOT_IMMUNE_PC_NPC = 23472
local NPC_INVISIBLE_STALKER = 15214
local NPC_VEHICLE_CATAPULT = 27881
local NPC_VEHICLE_DEMOLISHER = 28094
local NPC_VEHICLE_SIEGE_ENGINE_H = 32627
local NPC_VEHICLE_SIEGE_ENGINE_A = 28312

 -- Objects
local GO_WINTERGRASP_TITAN_RELIC = 192829
local GO_WINTERGRASP_VAULT_GATE = 191810
local GO_WINTERGRASP_KEEP_COLLISION_WALL = 194162
local GO_WINTERGRASP_FW_TOWER = 190358
local GO_WINTERGRASP_WE_TOWER = 190357
local GO_WINTERGRASP_SS_TOWER = 190356
local GO_WINTERGRASP_DEFENDER_H = 190763
local GO_WINTERGRASP_DEFENDER_A = 191575
local GO_WINTERGRASP_DEFENDER_N = 192819
local GO_WINTERGRASP_VEHICLE_TELEPORTER = 192951

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
local SMSG_PLAY_SOUND = 0x2D2
local SMSG_BATTLEFIELD_MGR_ENTRY_INVITE = 0x4DE
local CMSG_BATTLEFIELD_MGR_ENTRY_INVITE_RESPONSE = 0x4DF
local SMSG_BATTLEFIELD_MGR_ENTERED = 0x4E0
local SMSG_BATTLEFIELD_MGR_QUEUE_INVITE = 0x4E1
local CMSG_BATTLEFIELD_MGR_QUEUE_INVITE_RESPONSE = 0x4E2
local CMSG_BATTLEFIELD_MGR_QUEUE_REQUEST = 0x4E3
local SMSG_BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE = 0x4E4
local SMSG_BATTLEFIELD_MGR_EJECT_PENDING  = 0x4E5
local SMSG_BATTLEFIELD_MGR_EJECTED = 0x4E6
local CMSG_BATTLEFIELD_MGR_EXIT_REQUEST = 0x4E7
local SMSG_BATTLEFIELD_MGR_STATE_CHANGE = 0x4E8
local CMSG_BATTLEFIELD_MANAGER_ADVANCE_STATE = 0x4E9
local CMSG_BATTLEFIELD_MANAGER_SET_NEXT_TRANSITION_TIME = 0x4EA
local CMSG_START_BATTLEFIELD_CHEAT = 0x4CB
local CMSG_END_BATTLEFIELD_CHEAT = 0x4CC
local CMSG_LEAVE_BATTLEFIELD = 0x2E1
local CMSG_BATTLEFIELD_PORT = 0x2D5
local CMSG_BATTLEFIELD_STATUS = 0x2D3
local SMSG_BATTLEFIELD_STATUS = 0x2D4
local CMSG_BATTLEFIELD_LIST = 0x23C
local SMSG_BATTLEFIELD_LIST = 0x23D
local CMSG_BATTLEFIELD_JOIN = 0x23E
local SMSG_BATTLEFIELD_PORT_DENIED = 0x14B
local SMSG_AREA_SPIRIT_HEALER_TIME = 0x2E4

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
{191810, 3773},
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
 -- Workshop data
local workshop_data = {
{192028, 3698, -1, -1, -1,2,4},
{192029, 3699, -1, -1, -1,2,4},
{192030, 3700, brokentemple_progres, 4539, 190487,2},
{192031, 3701, sunkenring_progress, 4538, 190475,2},
{192032, 3702, westspark_progress, 4611, 194962,2},
{192033, 3703, eastspark_progress, 4612, 194959,2};
};
 -- Zone ID's for wg buff
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

local pvp_detection_data = {
{3723, 5051.19, 2849.41},
{3724, 4488.25, 2823.86},
{3725, 4748.14, 2877.06},
{3726, 5015.43, 2588.31},
{3727, 4736.71, 2418.49},
{3728, 4491.45, 2326.30},
{3729, 5049.93, 3183.56},
{3730, 4814.13, 3304.06},
{3731, 4492.49, 3336.17},
{3737, 4774.71, 2045.71},
{3738, 4516.30, 2087.43},
{3739, 5016.75, 2733.45},
{3740, 4820.90, 2618.30},
{3741, 4450.00, 2528.82},
{3742, 4403.17, 3091.06},
{3743, 4788.79, 3066.96},
{3744, 5045.93, 3016.11},
{3745, 4393.02, 3468.74},
{3746, 4555.75, 3479.11},
{3747, 4832.32, 3457.11},
{3748, 5075.76, 3445.33},
{3774, 5217.59, 2842.80},
{3775, 5214.62, 2995.52},
{3776, 5206.28, 2683.36},
{3777, 5335.53, 2706.81},
{3778, 5333.18, 2840.28},
{3779, 5338.16, 2981.39},
{3788, 4948.71, 3332.18},
{3790, 4932.04, 2440.23},
{3791, 4403.33, 2349.30},
{3792, 4394.57, 3294.98},
{3793, 4531.44, 3584.90},
{3794, 4481.27, 1994.00},
{3795, 4446.45, 2820.81},
{3796, 4683.09, 3824.08},
{3797, 4860.65, 2023.60},
{3798, 4310.05, 1811.11},
{3799, 4506.89, 4030.26};
};

local self = getfenv(1)

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
		v:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES, vehicle_vallue_a)
		v:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES, vehicle_vallue_h)
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
		v:SetWorldStateForZone(3698, 7)
		v:SetWorldStateForZone(3699, 7)
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
		v:SetWorldStateForZone(3702, 4)
		v:SetWorldStateForZone(3703, 4)
		v:SetWorldStateForZone(3700, 4)
		v:SetWorldStateForZone(3701, 4)
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
		v:SetWorldStateForZone(3698, 4)
		v:SetWorldStateForZone(3699, 4)
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
		v:SetWorldStateForZone(3702, 7)
		v:SetWorldStateForZone(3703, 7)
		v:SetWorldStateForZone(3700, 7)
		v:SetWorldStateForZone(3701, 7)
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

for k,v in pairs(pUnit:GetInRangeObjects())do
if(v:GetHP() ~= nil)then -- filter all non destructable objects.
	if(battle == 0 and v:GetHP() < v:GetMaxHP())then -- rebuild all if there is no battle and anything is damaged.
		v:Rebuild()
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
self[tostring(pGO)] = {
data = 0,
health = 0,
state = 0,
plrvall = 0
}
pGO:RegisterAIUpdateEvent(300)
end

function AIUpdate_Cpoint(pGO)
if(pGO == nil)then
	pGO:RemoveAIUpdateEvent()
end
local vars = self[tostring(pGO)]
for k,m in pairs (pGO:GetInRangePlayers())do
if(m:IsPvPFlagged() and m:IsStealthed() == false and m:IsAlive() and battle == 1)then
	if(pGO:GetDistance(m) <= 5500)then
		if(m:GetTeam() == 0)then
			vars.plrvall = vars.plrvall + 1
		elseif(m:GetTeam() == 1)then
			vars.plrvall = vars.plrvall - 1
		end
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_SHOW,1)
		for i = 1, #workshop_data do
			if(pGO:GetEntry() == workshop_data[i][5])then
				m:SetWorldStateForPlayer(WG_STATE_SOUTH_PROGRESS,workshop_data[i][3])
			end
		end
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_NEUTRAL,80)
	else
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_SHOW,0)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_PROGRESS,0)
		m:SetWorldStateForPlayer(WG_STATE_SOUTH_NEUTRAL,0)
	end
end
end
for i = 1, #workshop_data do
	if(pGO:GetEntry() == workshop_data[i][5] and pGO:GetWorldStateForZone(workshop_data[i][2])~=3 and pGO:GetWorldStateForZone(workshop_data[i][2])~=6 and pGO:GetWorldStateForZone(workshop_data[i][2])~=9)then
		if(workshop_data[i][3] <= 100.9 and workshop_data[i][3] >= -0.9)then
			workshop_data[i][3] = workshop_data[i][3] + (vars.plrvall/10)
		elseif(workshop_data[i][3] > 100)then
			workshop_data[i][3] = 100
		elseif(workshop_data[i][3] < 0)then
			workshop_data[i][3] = 0
		end
		if(workshop_data[i][5] == pGO:GetEntry())then
			if(workshop_data[i][3] >= 90 and workshop_data[i][6] == 2 and pGO:GetWorldStateForZone(workshop_data[i][2])==1)then
				pGO:SetWorldStateForZone(workshop_data[i][2],7)
				vehicle_vallue_a = vehicle_vallue_a + 4
				pGO:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES,vehicle_vallue_a)
			elseif(workshop_data[i][3] < 90 and workshop_data[i][3] > 10 and workshop_data[i][6] == 2 and pGO:GetWorldStateForZone(workshop_data[i][2])==7)then
				pGO:SetWorldStateForZone(workshop_data[i][2],1)
				vehicle_vallue_a = vehicle_vallue_a - 4
				pGO:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES,vehicle_vallue_a)
			elseif(workshop_data[i][3] < 90 and workshop_data[i][3] > 10 and workshop_data[i][6] == 2 and pGO:GetWorldStateForZone(workshop_data[i][2])==4)then
				pGO:SetWorldStateForZone(workshop_data[i][2],1)
				vehicle_vallue_h = vehicle_vallue_h - 4
				pGO:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES,vehicle_vallue_h)
			elseif(workshop_data[i][3] <= 10 and workshop_data[i][6] == 2 and pGO:GetWorldStateForZone(workshop_data[i][2])==1)then
				pGO:SetWorldStateForZone(workshop_data[i][2],4)
				vehicle_vallue_h = vehicle_vallue_h + 4
				pGO:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES,vehicle_vallue_h)
			elseif(workshop_data[i][3] >= 90 and workshop_data[i][6] == 1 and pGO:GetWorldStateForZone(workshop_data[i][2])==2)then
				pGO:SetWorldStateForZone(workshop_data[i][2],8)
				vehicle_vallue_a = vehicle_vallue_a + 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES,vehicle_vallue_a)
			elseif(workshop_data[i][3] < 90 and workshop_data[i][3] > 10 and workshop_data[i][6] == 1 and pGO:GetWorldStateForZone(workshop_data[i][2])==8)then
				pGO:SetWorldStateForZone(workshop_data[i][2],2)
				vehicle_vallue_a = vehicle_vallue_a - 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES,vehicle_vallue_a)
			elseif(workshop_data[i][3] < 90 and workshop_data[i][3] > 10 and workshop_data[i][6] == 1 and pGO:GetWorldStateForZone(workshop_data[i][2])==5)then
				pGO:SetWorldStateForZone(workshop_data[i][2],2)
				vehicle_vallue_h = vehicle_vallue_h - 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES,vehicle_vallue_h)
			elseif(workshop_data[i][3] <= 10 and workshop_data[i][6] == 1 and pGO:GetWorldStateForZone(workshop_data[i][2])==2)then
				pGO:SetWorldStateForZone(workshop_data[i][2],5)
				vehicle_vallue_h = vehicle_vallue_h + 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES,vehicle_vallue_h)
			end
		end
	end
end
vars.plrvall = 0
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
			arms:SpawnCreature(NPC_VEHICLE_CATAPULT, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_ALLIANCE, 3300000, 35, 0, 0, 241, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_CATAPULT)
		pPlayer:GossipComplete()
	elseif(intid == 2)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_DEMOLISHER, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_ALLIANCE, 3300000, 35, 0, 0, 241, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_DEMOLISHER)
		pPlayer:GossipComplete()
	elseif(intid == 3)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_SIEGE_ENGINE_A, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_ALLIANCE, 3300000, 35, 0, 0, 241, 0)
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
			arms:SpawnCreature(NPC_VEHICLE_CATAPULT, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_HORDE, 3300000, 35, 0, 0, 241, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_CATAPULT)
		pPlayer:GossipComplete()
	elseif(intid == 2)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_DEMOLISHER, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_HORDE, 3300000, 35, 0, 0, 241, 0)
		end
		-- pPlayer:FullCastSpell(SPELL_BUILD_DEMOLISHER)
		pPlayer:GossipComplete()
	elseif(intid == 3)then
		if(arms ~= nil)then
			arms:SpawnCreature(NPC_VEHICLE_SIEGE_ENGINE_H, arms:GetX(), arms:GetY(),arms:GetZ(), arms:GetO(), FACTION_HORDE, 3300000, 35, 0, 0, 241, 0)
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
				if not(pPlayer:HasAura(SPELL_ESSENCE_OF_WINTERGRASP))then
					if(controll == pPlayer:GetTeam()+1)then
						pPlayer:AddAura(SPELL_ESSENCE_OF_WINTERGRASP,0)
					end
				end
		 return true end
	end
	if(pPlayer:HasAura(SPELL_ESSENCE_OF_WINTERGRASP))then
		pPlayer:RemoveAura(SPELL_ESSENCE_OF_WINTERGRASP)
	end
	return false
end
print(zonecheck(buff_areas, ZoneId))
end

function OnEnterBuff(event, pPlayer)
local ZoneId = pPlayer:GetZoneId()
function zonecheck(buff_areas, ZoneId)
	for key, value in pairs(buff_areas) do
		if(value == ZoneId)then
				if not(pPlayer:HasAura(SPELL_ESSENCE_OF_WINTERGRASP))then
					if(controll == pPlayer:GetTeam()+1)then
						pPlayer:AddAura(SPELL_ESSENCE_OF_WINTERGRASP,0)
					end
				end
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
		if(pGO:GetEntry() == 191810)then
			local wall = pGO:GetGameObjectNearestCoords(pGO:GetX(),pGO:GetY(),pGO:GetZ(),GO_WINTERGRASP_KEEP_COLLISION_WALL)
			if(wall)then
				wall:Despawn(1,0)
			end
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

function ShopOnDamage(pGO, damage)
for i = 1, #workshop_data do
if(pGO:GetEntry() == workshop_data[i][1])then
		if(pGO:GetHP() < pGO:GetMaxHP()/2 and (pGO:GetWorldStateForZone(workshop_data[i][2])== 1 or pGO:GetWorldStateForZone(workshop_data[i][2])== 4 or pGO:GetWorldStateForZone(workshop_data[i][2])== 7))then
			if(pGO:GetWorldStateForZone(workshop_data[i][2]) == 4)then
				vehicle_vallue_h = vehicle_vallue_h - 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES,vehicle_vallue_h)
			elseif(pGO:GetWorldStateForZone(workshop_data[i][2]) == 7)then
				vehicle_vallue_a = vehicle_vallue_a - 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES,vehicle_vallue_a)
			end
			workshop_data[i][6] = 1
			pGO:SetWorldStateForZone(workshop_data[i][2],pGO:GetWorldStateForZone(workshop_data[i][2])+1)
		end
	end
end
end

function ShopOnDestroy(pGO)
for i = 1, #workshop_data do
	if(pGO:GetEntry() == workshop_data[i][1])then
		if(pGO:GetWorldStateForZone(workshop_data[i][2])== 2 or pGO:GetWorldStateForZone(workshop_data[i][2])== 5 or pGO:GetWorldStateForZone(workshop_data[i][2])== 8)then
			if(pGO:GetWorldStateForZone(workshop_data[i][2]) == 5)then
				vehicle_vallue_h = vehicle_vallue_h - 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_H_VEHICLES,vehicle_vallue_h)
			elseif(pGO:GetWorldStateForZone(workshop_data[i][2]) == 8)then
				vehicle_vallue_a = vehicle_vallue_a - 2
				pGO:SetWorldStateForZone(WG_STATE_MAX_A_VEHICLES,vehicle_vallue_a)
			end
			workshop_data[i][6] = 0
			pGO:SetWorldStateForZone(workshop_data[i][2],pGO:GetWorldStateForZone(workshop_data[i][2])+1)
		end
	end
end
end

RegisterUnitGossipEvent(NPC_GOBLIN_ENGINEER,2,HOnSelect)
RegisterUnitGossipEvent(NPC_GOBLIN_ENGINEER,1,HGengineerOnGossip)
RegisterUnitGossipEvent(NPC_GNOME_ENGINEER,2,AOnSelect)
RegisterUnitGossipEvent(NPC_GNOME_ENGINEER,1,AGengineerOnGossip)
for i = 1, #workshop_data do
if(workshop_data[i][5] > 0)then
	RegisterGameObjectEvent(workshop_data[i][5],5,AIUpdate_Cpoint)
	RegisterGameObjectEvent(workshop_data[i][5],2,OnSP_Cpoint)
end
end
RegisterGameObjectEvent(GO_WINTERGRASP_VEHICLE_TELEPORTER,5,OnAIUpdateVehicleTeleporter)
RegisterGameObjectEvent(GO_WINTERGRASP_VEHICLE_TELEPORTER,2,OnLoadVehicleTeleporter)
RegisterGameObjectEvent(GO_WINTERGRASP_DEFENDER_A,4,PortalOnUse)
RegisterGameObjectEvent(GO_WINTERGRASP_DEFENDER_H,4,PortalOnUse)
RegisterGameObjectEvent(GO_WINTERGRASP_DEFENDER_N,4,PortalOnUse)
RegisterGameObjectEvent(GO_WINTERGRASP_TITAN_RELIC,4,TitanRelickOnUse)
RegisterUnitEvent(NPC_DETECTION_UNIT,18,DetectionUnitOnSpawn)
RegisterUnitEvent(NPC_DETECTION_UNIT,21,DetectionUnitAIUpdate)
RegisterTimedEvent("WGUpdate", 1000, 0)
RegisterTimedEvent("Aura", 1000, 0)
RegisterServerHook(16, "DebugWG")
RegisterServerHook(2,KillPlayer)
RegisterServerHook(15,OnZoneEnter)
RegisterServerHook(4,OnEnterBuff)
RegisterUnitEvent(30739,4,KillCreature)
RegisterUnitEvent(30740,4,KillCreature)
for i = 1, #go_wall do
RegisterGameObjectEvent(go_wall[i][1],7,WallOnDamage)
RegisterGameObjectEvent(go_wall[i][1],8,WallOnDestroy)
end
for i = 1, #go_f_tower do
RegisterGameObjectEvent(go_f_tower[i][1],7,FTOnDamage)
RegisterGameObjectEvent(go_f_tower[i][1],8,FTOnDestroy)
end
for i = 1, #go_s_tower do
RegisterGameObjectEvent(go_s_tower[i][1],7,STOnDamage)
RegisterGameObjectEvent(go_s_tower[i][1],8,STOnDestroy)
end
for i = 1, #workshop_data do
RegisterGameObjectEvent(workshop_data[i][1],7,ShopOnDamage)
RegisterGameObjectEvent(workshop_data[i][1],8,ShopOnDestroy)
end
	print("-- Wintergrasp loaded --")