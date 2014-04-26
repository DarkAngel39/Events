local spell = {75214,75228,75229,75219,75230,75220,40356}
local NPC_RITUAL_DANCER = 40356

function OnSpawn(pUnit, event)
pUnit:RemoveAllAuras()
pUnit:CastSpell(spell[math.random(1,7)])
end

RegisterUnitEvent(NPC_RITUAL_DANCER,18,OnSpawn)
