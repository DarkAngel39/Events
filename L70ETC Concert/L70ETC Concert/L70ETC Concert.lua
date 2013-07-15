 -- L70etc band members ---
local SAMURO =						23625
local BERGRISST =					23619
local MAIKYL =						23624
local SIGNICIOUS =					23626
local THUNDERSKINS =				23623
local TARGETGROUND =				23830
local TARGETAIR =					48001
local UNDEAD =						48002
local UNDEAD2 =						48003
local UNDEAD3 =						48004
local TRIGGER =						48005

  -- Emotes
local EMOTE_ONESHOT_CUSTOMSPELL01 = 402
local EMOTE_ONESHOT_CUSTOMSPELL02 = 403
local EMOTE_ONESHOT_CUSTOMSPELL03 = 404
local EMOTE_ONESHOT_CUSTOMSPELL04 = 405
local EMOTE_ONESHOT_CUSTOMSPELL05 = 406
local EMOTE_ONESHOT_CUSTOMSPELL06 = 407

 -- Spells
local SPELLFLARE =					42505
local SPELLFIRE =					42501
local SPOTLIGHT =					39312
local SPELLEARTH =					42499
local SPELLLLIGHTNING =				42510
local SPELLLLIGHTNING2 =			42507
local SPELLSTORM =					42500
local CONSECRATION =				26573
 -- Consecration
local SINGERSLIGHT =				42510

local FLAG_NOT_SELECTABLE = 33554432
local self = getfenv(1)

function Sam_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
pUnit:FullCastSpell(SPELLFLARE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function SamAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
vars.timer = vars.timer + 1
if(vars.timer == 1)then
	pUnit:PlaySoundToSet(11803)
elseif(vars.timer == 2)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 19)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL05,11000)
elseif(vars.timer == 30)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,35000)
elseif(vars.timer == 65)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,5000)
elseif(vars.timer == 70)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,14000)
elseif(vars.timer == 84)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL06,35000)
elseif(vars.timer == 112)then
	pUnit:FullCastSpell(SINGERSLIGHT)
elseif(vars.timer == 123)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,14000)
elseif(vars.timer == 137)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL06,5000)
elseif(vars.timer == 142)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,38000)
elseif(vars.timer == 180)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,49000)
elseif(vars.timer == 239)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL06,20000)
elseif(vars.timer == 259)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL06,20000)
elseif(vars.timer == 279)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300000)
end
end

function Ber_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
pUnit:FullCastSpell(SPELLFLARE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function BerAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
if(vars.timer == 0)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 10)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,20000)
elseif(vars.timer == 30)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,4000)
elseif(vars.timer == 34)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,4000)
elseif(vars.timer == 38)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,66000)
elseif(vars.timer == 104)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,19000)
elseif(vars.timer == 123)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,17000)
elseif(vars.timer == 140)then
	pUnit:FullCastSpell(SPOTLIGHT)
elseif(vars.timer == 145)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,23000)
elseif(vars.timer == 168)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,61000)
elseif(vars.timer == 229)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL02,1000)
elseif(vars.timer == 230)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL06,49000)
elseif(vars.timer == 279)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300000)
end
vars.timer = vars.timer + 1
end

function Mai_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
pUnit:FullCastSpell(SPELLFLARE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function MaiAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
if(vars.timer == 0)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 10)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,20000)
elseif(vars.timer == 30)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,15000)
elseif(vars.timer == 45)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,25000)
elseif(vars.timer == 70)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,15000)
elseif(vars.timer == 85)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,10000)
elseif(vars.timer == 95)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,7000)
elseif(vars.timer == 102)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,13000)
elseif(vars.timer == 115)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,8000)
elseif(vars.timer == 123)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL02,42000)
elseif(vars.timer == 165)then
	pUnit:FullCastSpell(SPOTLIGHT)
elseif(vars.timer == 192)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,11000)
elseif(vars.timer == 203)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,26000)
elseif(vars.timer == 229)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,50000)
elseif(vars.timer == 279)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300000)
end
vars.timer = vars.timer + 1
end

function Thu_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
pUnit:FullCastSpell(SPELLFLARE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function ThuAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
if(vars.timer == 2)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 3)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,15000)
elseif(vars.timer == 14)then
	pUnit:SendChatMessage(12, 0,"ARE YOU READY TO ROCK?!?!")
elseif(vars.timer == 17)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,25000)
elseif(vars.timer == 42)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,13000)
elseif(vars.timer == 55)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,7000)
elseif(vars.timer == 62)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,1000)
elseif(vars.timer == 63)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,1000)
elseif(vars.timer == 64)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,11000)
elseif(vars.timer == 75)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,1000)
elseif(vars.timer == 76)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,1000)
elseif(vars.timer == 77)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,11000)
elseif(vars.timer == 88)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,11000)
elseif(vars.timer == 99)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,11000)
elseif(vars.timer == 110)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,27000)
elseif(vars.timer == 137)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL02,3000)
elseif(vars.timer == 140)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,2000)
elseif(vars.timer == 142)then
	pUnit:SendChatMessage(12, 0,"WERE GANA ROCK YOU CRAAAAAAZY!!!")
elseif(vars.timer == 194)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,54000)
elseif(vars.timer == 200)then
	pUnit:Emote(401,80000)
elseif(vars.timer == 279)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300050)
end
vars.timer = vars.timer + 1
end

function Sig_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
pUnit:FullCastSpell(SPELLFLARE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function SigAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
if(vars.timer == 10)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,20000)
elseif(vars.timer == 30)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,4000)
elseif(vars.timer == 34)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL04,4000)
elseif(vars.timer == 38)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,66000)
elseif(vars.timer == 104)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,19000)
elseif(vars.timer == 123)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,23000)
elseif(vars.timer == 140)then
	pUnit:FullCastSpell(SPOTLIGHT)
elseif(vars.timer == 145)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL03,23000)
elseif(vars.timer == 168)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL01,61000)
elseif(vars.timer == 229)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL02,1000)
elseif(vars.timer == 230)then
	pUnit:Emote(EMOTE_ONESHOT_CUSTOMSPELL06,49000)
elseif(vars.timer == 279)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300050)
end
vars.timer = vars.timer + 1
end

function Trigger_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function TriggerAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
if(vars.timer == 1)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 8)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 15)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 21)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 28)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 35)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 41)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 48)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 55)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 62)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 69)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 76)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 81)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 89)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 96)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 101)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 108)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 115)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 121)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 128)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 135)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 141)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 148)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 155)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 162)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 169)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 176)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 181)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 189)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 196)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 201)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 208)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 215)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 221)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 228)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 235)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 241)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 248)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 255)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 262)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 269)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 276)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300050)
end
vars.timer = vars.timer + 1
end

function Trigger2_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function Trigger2AI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
if(vars.timer == 3)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 10)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 18)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 22)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 24)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 38)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 44)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 52)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 58)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 68)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 69)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 76)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 85)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 90)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 96)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 107)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 109)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 125)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 127)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 129)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 132)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 144)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 149)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 159)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 166)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 169)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 176)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 183)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 186)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 194)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 204)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 209)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 218)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 223)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 228)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 235)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 241)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 248)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 252)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 263)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 266)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 274)then
	pUnit:FullCastSpell(CONSECRATION)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300050)
end
vars.timer = vars.timer + 1
end

function TargetG_OnLoad(pUnit, event)
pUnit:DisableCombat(1)
pUnit:SetUInt32Value(59, FLAG_NOT_SELECTABLE)
self[tostring(pUnit)] = {
timer = 0
}
pUnit:RegisterAIUpdateEvent(1000)
end

function TargetGAI(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local vars = self[tostring(pUnit)]
if(vars.timer == 2)then
	pUnit:FullCastSpell(SPELLLLIGHTNING)
	pUnit:FullCastSpell(SPELLLLIGHTNING2)
elseif(vars.timer == 6)then
	pUnit:FullCastSpell(SPELLEARTH)
elseif(vars.timer == 8)then
	pUnit:FullCastSpell(SPELLFIRE)
elseif(vars.timer == 72)then
	pUnit:FullCastSpell(SPELLLLIGHTNING)
	pUnit:FullCastSpell(SPELLLLIGHTNING2)
elseif(vars.timer == 76)then
	pUnit:FullCastSpell(SPELLEARTH)
elseif(vars.timer == 78)then
	pUnit:FullCastSpell(SPELLFIRE)
elseif(vars.timer == 125)then
	pUnit:FullCastSpell(SPELLLLIGHTNING)
	pUnit:FullCastSpell(SPELLLLIGHTNING2)
elseif(vars.timer == 128)then
	pUnit:FullCastSpell(SPELLEARTH)
elseif(vars.timer == 132)then
	pUnit:FullCastSpell(SPELLFIRE)
elseif(vars.timer == 232)then
	pUnit:FullCastSpell(SPELLLLIGHTNING)
	pUnit:FullCastSpell(SPELLLLIGHTNING2)
elseif(vars.timer == 236)then
	pUnit:FullCastSpell(SPELLEARTH)
elseif(vars.timer == 238)then
	pUnit:FullCastSpell(SPELLFIRE)
elseif(vars.timer == 245)then
	pUnit:FullCastSpell(SPELLLLIGHTNING)
	pUnit:FullCastSpell(SPELLLLIGHTNING2)
elseif(vars.timer == 249)then
	pUnit:FullCastSpell(SPELLEARTH)
elseif(vars.timer == 251)then
	pUnit:FullCastSpell(SPELLFIRE)
elseif(vars.timer == 279)then
	pUnit:FullCastSpell(SPELLFLARE)
elseif(vars.timer == 280)then
	pUnit:Despawn(1000,300050)
end
vars.timer = vars.timer + 1
end

RegisterUnitEvent(SAMURO,18,Sam_OnLoad)
RegisterUnitEvent(SAMURO,21,SamAI)
RegisterUnitEvent(BERGRISST,18,Ber_OnLoad)
RegisterUnitEvent(BERGRISST,21,BerAI)
RegisterUnitEvent(MAIKYL,18,Mai_OnLoad)
RegisterUnitEvent(MAIKYL,21,MaiAI)
RegisterUnitEvent(THUNDERSKINS,18,Thu_OnLoad)
RegisterUnitEvent(THUNDERSKINS,21,ThuAI)
RegisterUnitEvent(SIGNICIOUS,18,Sig_OnLoad)
RegisterUnitEvent(SIGNICIOUS,21,SigAI)
RegisterUnitEvent(TRIGGER,18,Trigger_OnLoad)
RegisterUnitEvent(TRIGGER,21,TriggerAI)
 -- RegisterUnitEvent(TRIGGER2,18,Trigger2_OnLoad)
 -- RegisterUnitEvent(TRIGGER2,21,Trigger2AI)
RegisterUnitEvent(TARGETGROUND,18,TargetG_OnLoad)
RegisterUnitEvent(TARGETGROUND,21,TargetGAI)