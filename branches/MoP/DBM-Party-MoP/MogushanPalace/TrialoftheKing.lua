local mod	= DBM:NewMod(708, "DBM-Party-MoP", 5, 321)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(61442, 61444, 61445)--61442 (Kuai the Brute), 61453 (Mu'Shiba, Kuai's Add), 61444 (Ming the Cunning), 61445 (Haiyan the Unstoppable)
mod:SetModelID(42060)	-- 42059=Ming the Cunning | 42058=Kuai the Brute | 42060=Haiyan the Unstoppable
mod:SetZone()

mod:RegisterCombat("yell", L.Pull)--Might have an engage trigger, who knows, but it's a scripted event, so will use yell for now until we know more.
mod:RegisterKill("yell", L.Defeat)
mod:SetWipeTime(20)--Based on data, phase transitions are 10-16 seconds, 20 should be enough, but can raise if needed.

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnRavage			= mod:NewTargetAnnounce(119946, 3)--Mu'Shiba's Fixate attack
local warnShockwave			= mod:NewSpellAnnounce(119922, 4)--Kuai's Attack
local warnWhirlingDervish	= mod:NewSpellAnnounce(119981, 3)--Ming's Attack
local warnTraumaticBlow		= mod:NewTargetAnnounce(123655, 3)--Haiyan's Attack
local warnConflag			= mod:NewTargetAnnounce(120201, 3)--Haiyan's Attack
local warnMeteor			= mod:NewCastAnnounce(120195, 4)--Haiyan's Attack

local specwarnRavage		= mod:NewSpecialWarningTarget(119946, mod:IsHealer())
local specwarnShockwave		= mod:NewSpecialWarningMove(119922, mod:IsTank())--Not sure if he always faced it toward tank, or did it blackhorn style, if it's blackhorn style this needs to be changed to a targetscan if possible
local specwarnConflag		= mod:NewSpecialWarningTarget(120201, mod:IsHealer())

local timerRavage			= mod:NewTargetTimer(12, 119946)
local timerRavageCD			= mod:NewNextTimer(20, 119946)
local timerShockwaveCD		= mod:NewNextTimer(15, 119922)
local timerWhirlingDervishCD= mod:NewCDTimer(23, 119981)
local timerTraumaticBlow	= mod:NewTargetTimer(5, 123655)
local timerTraumaticBlowCD	= mod:NewCDTimer(17, 123655)--17-21sec variation
local timerConflag			= mod:NewTargetTimer(5, 120201)
local timerConflagCD		= mod:NewCDTimer(32, 120201)--Limited data, may not be completely accurate
local timerMeteorCD			= mod:NewNextTimer(55, 120195)--Assumed based on limited data

local shockwaveCD = 15

function mod:OnCombatStart(delay)
	shockwaveCD = 15
	timerShockwaveCD:Start(20-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(119946) then
		warnRavage:Show(args.destName)
		specwarnRavage:Show(args.destName)
		timerRavage:Start(args.destName)
		timerRavageCD:Start()
	elseif args:IsSpellID(123655) then
		timerTraumaticBlow:Show(args.destName)
		timerTraumaticBlow:Start(args.destName)
		timerTraumaticBlowCD:Start()
	elseif args:IsSpellID(120201) then
		warnConflag:Show(args.destName)
		specwarnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
		timerConflagCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(119922) then
		warnShockwave:Show()
		specwarnShockwave:Show()
		timerShockwaveCD:Start(shockwaveCD)
	elseif args:IsSpellID(119981) then
		warnWhirlingDervish:Show()
		timerWhirlingDervishCD:Start()
	elseif args:IsSpellID(120195) then
		warnMeteor:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		timerShockwaveCD:Cancel()
		timerWhirlingDervishCD:Start(38)--Not confirmed through multiple pulls, just one
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		timerWhirlingDervishCD:Cancel()
		timerMeteorCD:Start()--Not confirmed through multiple pulls, just one
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61453 then
		timerRavageCD:Cancel()
		shockwaveCD = 10--Need more data to confirm this but appears to be case.
	end
end

--[[
Notes
1. Not sure this is worth adding, to be honest i don't even remember it happening, maybe it matters more on heroic
5/2 14:14:41.034  Kuai the Brute yells: We will never surrender our right to rule the destiny of our people!
5/2 14:14:56.295  Ming the Cunning yells: Clan Harthak will show all why they are the truest of Mogu!
5/2 14:15:55.997  SPELL_CAST_START,0xF130F004000049E0,"Ming the Cunning",0x10a48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,120100,"Magnetic Field",0x0
5/2 14:15:57.932  SPELL_AURA_APPLIED,0xF130F004000049E0,"Ming the Cunning",0x10a48,0x0,0xF130F004000049E0,"Ming the Cunning",0x10a48,0x0,120100,"Magnetic Field",0x0,BUFF
5/2 14:16:01.987  SPELL_AURA_REMOVED,0xF130F004000049E0,"Ming the Cunning",0x10a48,0x0,0xF130F004000049E0,"Ming the Cunning",0x10a48,0x0,120100,"Magnetic Field",0x0,BUFF
--]]
