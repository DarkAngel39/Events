local SPELL_FIREWORK1 = 6668
local SPELL_FiREWORK2 = 11542
local NPC_DREAD_CREW = 28052

function OnLoad(pUnit)
pUnit:RegisterAIUpdateEvent(math.random(5000,15000))
end

function AIUpdate(pUnit)
local chance = math.random(1,6)
if(chance == 1)then
	pUnit:FullCastSpell(SPELL_FIREWORK1)
elseif(chance == 2)then
	pUnit:FullCastSpell(SPELL_FIREWORK2)
elseif(chance == 3)then
	pUnit:Emote(10,math.random(5000,10000))
end
pUnit:ModifyAIUpdateEvent(math.random(5000,15000))
end

RegisterUnitEvent(NPC_DREAD_CREW,18,OnLoad)
RegisterUnitEvent(NPC_DREAD_CREW,21,AIUpdate)