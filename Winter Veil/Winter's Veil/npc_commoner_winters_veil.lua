local spellid = {
{18927,33402,33403},
{19148,33433,33436},
{19169,33412,33415},
{19171,33427,33430},
{19172,33445,33448},
{19173,33439,33442},
{19175,33451,33455},
{19176,33458,33465},
{19177,33468,33471},
{19178,33474,33477},
{20102,34845,34849}
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
