NPC_OMEN = 15467
NPC_MINION_OF_OMEN = 15466
NPC_FIREWORK_BLUE = 15879
NPC_FIREWORK_GREEN = 15880
NPC_FIREWORK_PURPLE = 15881
NPC_FIREWORK_RED = 15882
NPC_FIREWORK_YELLOW = 15883
NPC_FIREWORK_WHITE = 15884
NPC_FIREWORK_BIG_BLUE = 15885
NPC_FIREWORK_BIG_GREEN = 15886
NPC_FIREWORK_BIG_PURPLE = 15887
NPC_FIREWORK_BIG_RED = 15888
NPC_FIREWORK_BIG_YELLOW = 15889
NPC_FIREWORK_BIG_WHITE = 15890

NPC_CLUSTER_BLUE = 15872
NPC_CLUSTER_RED = 15873
NPC_CLUSTER_GREEN = 15874
NPC_CLUSTER_PURPLE = 15875
NPC_CLUSTER_WHITE = 15876
NPC_CLUSTER_YELLOW = 15877
NPC_CLUSTER_BIG_BLUE = 15911
NPC_CLUSTER_BIG_GREEN = 15912
NPC_CLUSTER_BIG_PURPLE = 15913
NPC_CLUSTER_BIG_RED = 15914
NPC_CLUSTER_BIG_WHITE = 15915
NPC_CLUSTER_BIG_YELLOW = 15916
NPC_CLUSTER_ELUNE = 15918

GO_FIREWORK_LAUNCHER_1 = 180771
GO_FIREWORK_LAUNCHER_2 = 180868
GO_FIREWORK_LAUNCHER_3 = 180850
GO_CLUSTER_LAUNCHER_1  = 180772
GO_CLUSTER_LAUNCHER_2 = 180859
GO_CLUSTER_LAUNCHER_3 = 180869
GO_CLUSTER_LAUNCHER_4 = 180874

SPELL_ROCKET_BLUE = 26344
SPELL_ROCKET_GREEN = 26345
SPELL_ROCKET_PURPLE = 26346
SPELL_ROCKET_RED = 26347
SPELL_ROCKET_WHITE = 26348
SPELL_ROCKET_YELLOW = 26349
SPELL_ROCKET_BIG_BLUE = 26351
SPELL_ROCKET_BIG_GREEN = 26352
SPELL_ROCKET_BIG_PURPLE = 26353
SPELL_ROCKET_BIG_RED = 26354
SPELL_ROCKET_BIG_WHITE = 26355
SPELL_ROCKET_BIG_YELLOW = 26356
SPELL_LUNAR_FORTUNE = 26522

ZONE_MOONGLADE = 493

function OnSummon(pUnit, event)
local entry = pUnit:GetEntry()
if(entry == NPC_FIREWORK_BLUE or entry == NPC_FIREWORK_GREEN or entry == NPC_FIREWORK_PURPLE or entry == NPC_FIREWORK_RED or entry == NPC_FIREWORK_YELLOW or entry == NPC_FIREWORK_WHITE or entry == NPC_FIREWORK_BIG_BLUE or entry == NPC_FIREWORK_BIG_GREEN or entry == NPC_FIREWORK_BIG_PURPLE or entry == NPC_FIREWORK_BIG_RED or entry == NPC_FIREWORK_BIG_YELLOW or entry == NPC_FIREWORK_BIG_WHITE)then
	local Obj1 = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), GO_FIREWORK_LAUNCHER_1)
	local Obj2 = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), GO_FIREWORK_LAUNCHER_2)
	local Obj3 = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), GO_FIREWORK_LAUNCHER_3)
	if(Obj1 ~= nil or Obj2 ~= nil or Obj3 ~= nil)then
		if(Obj1 ~= nil and pUnit:GetDistanceYards(Obj1) < 20)then
			local O1X, O1Y, O1Z, _ = Obj1:GetSpawnLocation()
			pUnit:TeleportCreature(O1X, O1Y, O1Z)
		elseif(Obj2 ~= nil and pUnit:GetDistanceYards(Obj2) < 20)then
			local O2X, O2Y, O2Z, _ = Obj2:GetSpawnLocation()
			pUnit:TeleportCreature(O2X, O2Y, O2Z)
		elseif(Obj3 ~= nil and pUnit:GetDistanceYards(Obj3) < 20)then
			local O3X, O3Y, O3Z, _ = Obj3:GetSpawnLocation()
			pUnit:TeleportCreature(O3X, O3Y, O3Z)
		end
		if(entry == NPC_FIREWORK_BLUE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BLUE)
		elseif(entry == NPC_FIREWORK_GREEN)then
			pUnit:FullCastSpell(SPELL_ROCKET_GREEN)
		elseif(entry == NPC_FIREWORK_PURPLE)then
			pUnit:FullCastSpell(SPELL_ROCKET_PURPLE)
		elseif(entry == NPC_FIREWORK_RED)then
			pUnit:FullCastSpell(SPELL_ROCKET_RED)
		elseif(entry == NPC_FIREWORK_WHITE)then
			pUnit:FullCastSpell(SPELL_ROCKET_WHITE)
		elseif(entry == NPC_FIREWORK_YELLOW)then
			pUnit:FullCastSpell(SPELL_ROCKET_YELLOW)
		elseif(entry == NPC_FIREWORK_BIG_BLUE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_BLUE)
		elseif(entry == NPC_FIREWORK_BIG_GREEN)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_GREEN)
		elseif(entry == NPC_FIREWORK_BIG_PURPLE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_PURPLE)
		elseif(entry == NPC_FIREWORK_BIG_RED)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_RED)
		elseif(entry == NPC_FIREWORK_BIG_WHITE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_WHITE)
		elseif(entry == NPC_FIREWORK_BIG_YELLOW)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_YELLOW)
		end
	end
elseif(entry == NPC_CLUSTER_BLUE or entry == NPC_CLUSTER_GREEN or entry == NPC_CLUSTER_PURPLE or entry == NPC_CLUSTER_RED or entry == NPC_CLUSTER_YELLOW or entry == NPC_CLUSTER_WHITE or entry == NPC_CLUSTER_BIG_BLUE or entry == NPC_CLUSTER_BIG_GREEN or entry == NPC_CLUSTER_BIG_PURPLE or entry == NPC_CLUSTER_BIG_RED or entry == NPC_CLUSTER_BIG_YELLOW or entry == NPC_CLUSTER_BIG_WHITE)then
	local Obj1 = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), GO_CLUSTER_LAUNCHER_1)
	local Obj2 = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), GO_CLUSTER_LAUNCHER_2)
	local Obj3 = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), GO_CLUSTER_LAUNCHER_3)
	local Obj4 = pUnit:GetGameObjectNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), GO_CLUSTER_LAUNCHER_4)
	if(Obj1 ~= nil or Obj2 ~= nil or Obj3 ~= nil or Obj4 ~= nil)then
		if(Obj1 ~= nil and pUnit:GetDistanceYards(Obj1) < 20)then
			local O1X, O1Y, O1Z, _ = Obj1:GetSpawnLocation()
			pUnit:TeleportCreature(O1X, O1Y, O1Z)
		elseif(Obj2 ~= nil and pUnit:GetDistanceYards(Obj2) < 20)then
			local O2X, O2Y, O2Z, _ = Obj2:GetSpawnLocation()
			pUnit:TeleportCreature(O2X, O2Y, O2Z)
		elseif(Obj3 ~= nil and pUnit:GetDistanceYards(Obj3) < 20)then
			local O3X, O3Y, O3Z, _ = Obj3:GetSpawnLocation()
			pUnit:TeleportCreature(O3X, O3Y, O3Z)
		elseif(Obj4 ~= nil and pUnit:GetDistanceYards(Obj4) < 20)then
			local O4X, O4Y, O4Z, _ = Obj4:GetSpawnLocation()
			pUnit:TeleportCreature(O4X, O4Y, O4Z)
		end
		if(pUnit:GetZoneId() == ZONE_MOONGLADE)then
			if(pUnit:CalcToDistance(7558.993, -2839.999, 450.0214) < 100)then
				local chance = math.random(1,20)
				if(chance == 1)then
					PerformIngameSpawn(1, NPC_OMEN, 1, 7558.993, -2839.999, 450.0214, 4.46, 14, 0, 0, 0, 0, 0, 0)
				else
					PerformIngameSpawn(1, NPC_MINION_OF_OMEN, 1, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO() + math.random(-1,1), 14, 0, 0, 0, 0, 0, 0)
				end
			end
		end
		if(entry == NPC_CLUSTER_BLUE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BLUE)
		elseif(entry == NPC_CLUSTER_GREEN)then
			pUnit:FullCastSpell(SPELL_ROCKET_GREEN)
		elseif(entry == NPC_CLUSTER_PURPLE)then
			pUnit:FullCastSpell(SPELL_ROCKET_PURPLE)
		elseif(entry == NPC_CLUSTER_RED)then
			pUnit:FullCastSpell(SPELL_ROCKET_RED)
		elseif(entry == NPC_CLUSTER_WHITE)then
			pUnit:FullCastSpell(SPELL_ROCKET_WHITE)
		elseif(entry == NPC_CLUSTER_YELLOW)then
			pUnit:FullCastSpell(SPELL_ROCKET_YELLOW)
		elseif(entry == NPC_CLUSTER_BIG_BLUE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_BLUE)
		elseif(entry == NPC_CLUSTER_BIG_GREEN)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_GREEN)
		elseif(entry == NPC_CLUSTER_BIG_PURPLE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_PURPLE)
		elseif(entry == NPC_CLUSTER_BIG_RED)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_RED)
		elseif(entry == NPC_CLUSTER_BIG_WHITE)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_WHITE)
		elseif(entry == NPC_CLUSTER_BIG_YELLOW)then
			pUnit:FullCastSpell(SPELL_ROCKET_BIG_YELLOW)
		end
	end
end
end

RegisterUnitEvent(NPC_FIREWORK_BLUE,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_GREEN,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_PURPLE,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_RED,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_YELLOW,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_WHITE,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_BIG_BLUE,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_BIG_GREEN,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_BIG_PURPLE,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_BIG_RED,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_BIG_YELLOW,18,OnSummon)
RegisterUnitEvent(NPC_FIREWORK_BIG_WHITE,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_BLUE,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_GREEN,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_PURPLE,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_RED,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_YELLOW,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_WHITE,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_BIG_BLUE,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_BIG_GREEN,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_BIG_PURPLE,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_BIG_RED,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_BIG_YELLOW,18,OnSummon)
RegisterUnitEvent(NPC_CLUSTER_BIG_WHITE,18,OnSummon)