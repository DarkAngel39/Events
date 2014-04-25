local spellid = {
{18927,43632,43633},
{19148,43626,43627},
{19169,43405,43406},
{19171,43623,43625},
{19172,43628,43629},
{19173,43634,43635},
{19175,43636,43637},
{19176,43638,43639},
{19177,43640,43641},
{19178,43642,43643},
{20102,43630,43631}
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
