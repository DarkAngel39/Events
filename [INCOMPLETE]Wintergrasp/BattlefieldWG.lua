local timer_nextbattle = os.time() + 36
local timer_battle = 0
local controll = math.random(1,2)
battle = 0
stateset = nil
battlestates_set = nil

 -- Factions
FACTION_HORDE = 1735
FACTION_ALLIANCE = 1732
FACTION_NEUTRAL = 35

 -- vehicle workshops capture bar controllers
eastspark_progress = 50
westspark_progress = 50
sunkenring_progress = 50
brokentemple_progres = 50
 -- Max vehicle worldstate controllers (neutra, destroyed - 0, half destroyed (A/H) - 2, intact (A/H) - 4)
A_V_EASTSPARK = 0
H_V_EASTSPARK = 0
A_V_WESTSPARK = 0
H_V_WESTSPARK = 0
A_V_SUNKENRING = 0
H_V_SUNKENRING = 0
A_V_BROKENTEMPLE = 0
H_V_BROKENTEMPLE = 0
A_V_FORTRESS_EAST = 0
H_V_FORTRESS_EAST = 0
A_V_FORTRESS_WEST = 0
H_V_FORTRESS_WEST = 0
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
WG_STATE_W_FORTRESS_WORKSHOP = 3698
WG_STATE_E_FORTRESS_WORKSHOP = 3699
WG_STATE_BT_WORKSHOP = 3700
WG_STATE_SR_WORKSHOP = 3701
WG_STATE_WS_WORKSHOP = 3702
WG_STATE_ES_WORKSHOP = 3703
WG_STATE_MAIN_GATE = 3763
WG_STATE_KEEP_GATE_ANDGY = 3773

WG_STATE_KEEP_SE_TOWER = 3714
WG_STATE_KEEP_SW_TOWER = 3713
WG_STATE_KEEP_NW_TOWER = 3711
WG_STATE_KEEP_NE_TOWER = 3712

NPC_DETECTION_UNIT = 27869
NPC_GOBLIN_ENGINEER = 30400
NPC_GNOME_ENGINEER = 30499

GO_WINTERGRASP_TITAN_RELIC = 192829 -- 5439.66, 2840.83, 420.427, 6.20393, 0, 0, 0.0396173, -0.999215 should be spawned by the sript.
GO_WINTERGRASP_SE_TOWER = 190377
GO_WINTERGRASP_NE_TOWER = 190378
GO_WINTERGRASP_SW_TOWER = 190373
GO_WINTERGRASP_NW_TOWER = 190221
GO_WINTERGRASP_SHADOWSIGHT_TOWER = 190356
GO_WINTERGRASP_WINTER_S_EDGE_TOWER = 190357
GO_WINTERGRASP_FLAMEWATCH_TOWER = 190358
GO_WINTERGRASP_FORTRESS_GATE = 190375
GO_WINTERGRASP_VAULT_GATE = 191810
GO_WINTERGRASP_KEEP_COLLISION_WALL = 194323

MAP_NORTHREND = 571
ZONE_WG = 4197
AREA_FORTRESS = 4575
AREA_EASTSPARK = 4612
AREA_WESTSPARK = 4611
AREA_BROKENTEMPLE = 4539
AREA_SUNKENRING = 4538
AREA_FLAMEWATCH_T = 4581
AREA_WINTERSEDGE_T = 4582
AREA_SHADOWSIGHT_T = 4583
AREA_C_BRIDGE = 4576
AREA_E_BRIDGE = 4557
AREA_W_BRIDGE = 4577
 -- Spells
SPELL_RECRUIT = 37795
SPELL_CORPORAL = 33280
SPELL_LIEUTENANT = 55629
SPELL_TENACITY = 58549
SPELL_TENACITY_VEHICLE = 59911
SPELL_TOWER_CONTROL = 62064
SPELL_SPIRITUAL_IMMUNITY = 58729
SPELL_GREAT_HONOR = 58555
SPELL_GREATER_HONOR = 58556
SPELL_GREATEST_HONOR = 58557
SPELL_ALLIANCE_FLAG = 14268
SPELL_HORDE_FLAG = 14267
SPELL_GRAB_PASSENGER = 61178
 -- Reward spells
SPELL_VICTORY_REWARD = 56902
SPELL_DEFEAT_REWARD = 58494
SPELL_DAMAGED_TOWER = 59135
SPELL_DESTROYED_TOWER = 59136
SPELL_DAMAGED_BUILDING = 59201
SPELL_INTACT_BUILDING = 59203
SPELL_TELEPORT_BRIDGE = 59096
SPELL_TELEPORT_FORTRESS = 60035
SPELL_TELEPORT_DALARAN = 53360
SPELL_VICTORY_AURA = 60044
SPELL_WINTERGRASP_WATER = 36444
SPELL_ESSENCE_OF_WINTERGRASP = 58045
SPELL_WINTERGRASP_RESTRICTED_FLIGHT_AREA = 58730
 -- Phasing spells
SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT = 56618 -- phase 16
SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT = 56617 -- phase 32
SPELL_HORDE_CONTROL_PHASE_SHIFT = 55773 -- phase 64
SPELL_ALLIANCE_CONTROL_PHASE_SHIFT = 55774  -- phase 128

function BattlefieldTick()
if(timer_nextbattle <= os.time() and timer_battle == 0)then
	SendWorldMsg("Battlefield is starting!", 2)
	timer_battle = os.time() + 180
	timer_nextbattle = 0
	battle = 1
	battlestates_set = 0
elseif(timer_nextbattle == 0 and timer_battle <= os.time())then
	timer_battle = 0
	timer_nextbattle = os.time() + 36
	SendWorldMsg("The battlefield is over!", 2)
	battle = 0
	if(controll == 1)then
		controll = 2
	elseif(controll == 2)then -- This section is used to change the controll when the "battle" ends. This is not how the battlefield works but it will be put in the right place later.
		controll = 1
	end
end
end

function WGUpdate()
for k,v in pairs(GetPlayersInWorld())do
if(v:GetAreaId() == ZONE_WG or v:GetAreaId() == AREA_FORTRESS or v:GetAreaId() == AREA_FLAMEWATCH_T or v:GetAreaId() == AREA_WINTERSEDGE_T or v:GetAreaId() == AREA_SHADOWSIGHT_T or v:GetAreaId() == AREA_C_BRIDGE or v:GetAreaId() == AREA_W_BRIDGE or v:GetAreaId() == AREA_E_BRIDGE)then
	v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIMER, timer_nextbattle)
	v:SetWorldStateForZone(WG_STATE_BATTLE_UI, timer_battle)
	v:SetWorldStateForZone(WG_STATE_BATTLE_TIME, timer_battle)
	if(controll == 1)then
		if(v:HasAura(SPELL_HORDE_CONTROL_PHASE_SHIFT))then
			v:RemoveAura(SPELL_HORDE_CONTROL_PHASE_SHIFT)
		end
		v:CastSpell(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT)
		if(states == 2 or states == nil)then
			states = 1
			v:SetWorldStateForZone(WG_ALLIANCE_CONTROLLED, 1)
			v:SetWorldStateForZone(WG_HORDE_CONTROLLED, 0)
			v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIME, timer_nextbattle)
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
			v:SetWorldStateForZone(3758, 7)  -- NEED TO DEFINE ALL OF THESE STATES AT THE TOP OF THE FILE.
			v:SetWorldStateForZone(3759, 7)
			v:SetWorldStateForZone(3760, 7)
			v:SetWorldStateForZone(3761, 7)
			v:SetWorldStateForZone(3762, 7)
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 7)
			v:SetWorldStateForZone(3764, 7)
			v:SetWorldStateForZone(3765, 7)
			v:SetWorldStateForZone(3766, 7)
			v:SetWorldStateForZone(3767, 7)
			v:SetWorldStateForZone(3768, 7)
			v:SetWorldStateForZone(3769, 7)
			v:SetWorldStateForZone(3770, 7)
			v:SetWorldStateForZone(3771, 7)
			v:SetWorldStateForZone(3772, 7)
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 7)
			v:SetWorldStateForZone(WG_STATE_WS_WORKSHOP, 4)
			v:SetWorldStateForZone(WG_STATE_ES_WORKSHOP, 4)
			v:SetWorldStateForZone(WG_STATE_BT_WORKSHOP, 1)
			v:SetWorldStateForZone(WG_STATE_SR_WORKSHOP, 1)
			eastspark_progress = 0
			westspark_progress = 0
		end
	elseif(controll == 2)then
		if(v:HasAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT))then
			v:RemoveAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT)
		end
		v:CastSpell(SPELL_HORDE_CONTROL_PHASE_SHIFT)
		if(states == 1 or states == nil)then
			states = 2
			v:SetWorldStateForZone(WG_HORDE_CONTROLLED, 1)
			v:SetWorldStateForZone(WG_ALLIANCE_CONTROLLED, 0)
			v:SetWorldStateForZone(WG_STATE_NEXT_BATTLE_TIME, timer_nextbattle)
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
			v:SetWorldStateForZone(3760, 4) -- NEED TO DEFINE ALL OF THESE STATES AT THE TOP OF THE FILE.
			v:SetWorldStateForZone(3761, 4)
			v:SetWorldStateForZone(3762, 4)
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 4)
			v:SetWorldStateForZone(3764, 4)
			v:SetWorldStateForZone(3765, 4)
			v:SetWorldStateForZone(3766, 4)
			v:SetWorldStateForZone(3767, 4)
			v:SetWorldStateForZone(3768, 4)
			v:SetWorldStateForZone(3769, 4)
			v:SetWorldStateForZone(3770, 4)
			v:SetWorldStateForZone(3771, 4)
			v:SetWorldStateForZone(3772, 4)
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 4)
			v:SetWorldStateForZone(WG_STATE_WS_WORKSHOP, 7)
			v:SetWorldStateForZone(WG_STATE_ES_WORKSHOP, 7)
			v:SetWorldStateForZone(WG_STATE_BT_WORKSHOP, 1)
			v:SetWorldStateForZone(WG_STATE_SR_WORKSHOP, 1)
			eastspark_progress = 0
			westspark_progress = 0
		end
	end
elseif(v:GetAreaId() ~= ZONE_WG and v:GetAreaId() ~= AREA_FORTRESS and v:GetAreaId() ~= AREA_FLAMEWATCH_T and v:GetAreaId() ~= AREA_WINTERSEDGE_T and v:GetAreaId() ~= AREA_SHADOWSIGHT_T and v:GetAreaId() ~= AREA_C_BRIDGE and v:GetAreaId() ~= AREA_W_BRIDGE and v:GetAreaId() ~= AREA_E_BRIDGE)then
	if(v:HasAura(SPELL_HORDE_CONTROL_PHASE_SHIFT))then
			v:RemoveAura(SPELL_HORDE_CONTROL_PHASE_SHIFT)
	end
	if(v:HasAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT))then
			v:RemoveAura(SPELL_ALLIANCE_CONTROL_PHASE_SHIFT)
	end
end
end
end

function DetectionUnitOnSpawn(pUnit, event)
pUnit:RegisterAIUpdateEvent(1000)
end

function DetectionUnitAIUpdate(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
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
	if(v:GetEntry() == GO_WINTERGRASP_FORTRESS_GATE)then
		if(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_MAIN_GATE) ~= 5)then
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 5)
		elseif(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_MAIN_GATE) ~= 8)then
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 8)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 2 and v:GetWorldStateForZone(WG_STATE_MAIN_GATE) ~= 4)then
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 4)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 1 and v:GetWorldStateForZone(WG_STATE_MAIN_GATE) ~= 7)then
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 7)
		elseif(v:GetHP() == 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_MAIN_GATE) ~= 6)then
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 6)
		elseif(v:GetHP() == 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_MAIN_GATE) ~= 9)then
			v:SetWorldStateForZone(WG_STATE_MAIN_GATE, 9)
		end
	elseif(v:GetEntry() == GO_WINTERGRASP_VAULT_GATE)then
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
		elseif(v:GetHP() == 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY) ~= 9)then
			v:SetWorldStateForZone(WG_STATE_KEEP_GATE_ANDGY, 9)
		end
	elseif(v:GetEntry() == GO_WINTERGRASP_SE_TOWER)then
		if(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_SE_TOWER) ~= 5)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SE_TOWER, 5)
		elseif(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_SE_TOWER) ~= 8)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SE_TOWER, 8)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_SE_TOWER) ~= 4)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SE_TOWER, 4)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_SE_TOWER) ~= 7)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SE_TOWER, 7)
		elseif(v:GetHP() == 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_SE_TOWER) ~= 6)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SE_TOWER, 6)
		elseif(v:GetHP() == 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_SE_TOWER) ~= 9)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SE_TOWER, 9)
		end
	elseif(v:GetEntry() == GO_WINTERGRASP_SW_TOWER)then
		if(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_SW_TOWER) ~= 5)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SW_TOWER, 5)
		elseif(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_SW_TOWER) ~= 8)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SW_TOWER, 8)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_SW_TOWER) ~= 4)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SW_TOWER, 4)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_SW_TOWER) ~= 7)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SW_TOWER, 7)
		elseif(v:GetHP() == 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_SW_TOWER) ~= 6)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SW_TOWER, 6)
		elseif(v:GetHP() == 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_SW_TOWER) ~= 9)then
			v:SetWorldStateForZone(WG_STATE_KEEP_SW_TOWER, 9)
		end
	elseif(v:GetEntry() == GO_WINTERGRASP_NW_TOWER)then
		if(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_NW_TOWER) ~= 5)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NW_TOWER, 5)
		elseif(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_NW_TOWER) ~= 8)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NW_TOWER, 8)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_NW_TOWER) ~= 4)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NW_TOWER, 4)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_NW_TOWER) ~= 7)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NW_TOWER, 7)
		elseif(v:GetHP() == 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_NW_TOWER) ~= 6)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NW_TOWER, 6)
		elseif(v:GetHP() == 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_NW_TOWER) ~= 9)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NW_TOWER, 9)
		end
	elseif(v:GetEntry() == GO_WINTERGRASP_NE_TOWER)then
		if(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_NE_TOWER) ~= 5)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NE_TOWER, 5)
		elseif(v:GetHP() <= v:GetMaxHP()/2 and v:GetHP() > 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_NE_TOWER) ~= 8)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NE_TOWER, 8)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_NE_TOWER) ~= 4)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NE_TOWER, 4)
		elseif(v:GetHP() > v:GetMaxHP()/2 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_NE_TOWER) ~= 7)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NE_TOWER, 7)
		elseif(v:GetHP() == 0 and controll == 2 and v:GetWorldStateForZone(WG_STATE_KEEP_NE_TOWER) ~= 6)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NE_TOWER, 6)
		elseif(v:GetHP() == 0 and controll == 1 and v:GetWorldStateForZone(WG_STATE_KEEP_NE_TOWER) ~= 9)then
			v:SetWorldStateForZone(WG_STATE_KEEP_NE_TOWER, 9)
		end
	end
end
end
end

RegisterUnitEvent(NPC_DETECTION_UNIT,18,DetectionUnitOnSpawn)
RegisterUnitEvent(NPC_DETECTION_UNIT,21,DetectionUnitAIUpdate)
RegisterTimedEvent("BattlefieldTick", 1000, 0)
RegisterTimedEvent("WGUpdate", 1000, 0)