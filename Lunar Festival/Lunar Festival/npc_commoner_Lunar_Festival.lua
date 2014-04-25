local spellid = {
{18927,33398,33397},
{19148,33437,33434},
{19169,33416,33413},
{19171,33431,33428},
{19172,33449,33446},
{19173,33443,33440},
{19175,33456,33453},
{19176,33466,33459},
{19177,33472,33469},
{19178,33478,33475},
{20102,34851,34848}
}

function OnSpawn(pUnit, event)
local entry = pUnit:GetEntry()
for i = 1,#spellid do
	if(entry == spellid[i][1])then
		local aura = math.random(0,1)
		pUnit:CastSpell(spellid[i][2+aura])
	end
end
end

for i = 1,#spellid do
RegisterUnitEvent(spellid[i][1],18,OnSpawn)
end
