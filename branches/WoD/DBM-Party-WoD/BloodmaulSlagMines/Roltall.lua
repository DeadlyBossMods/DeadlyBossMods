local mod	= DBM:NewMod(887, "DBM-Party-WoD", 2, 385)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75786)
mod:SetEncounterID(1652)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153247 152940 152939",
	"SPELL_AURA_APPLIED 153227",
	"SPELL_PERIODIC_DAMAGE 153227",
	"SPELL_PERIODIC_MISSED 153227"
)


local warnFieryBoulder			= mod:NewCountAnnounce(153247, 3)
local warnHeatWave				= mod:NewSpellAnnounce(152940, 3)
local warnBurningSlag			= mod:NewSpellAnnounce(152939, 3)

local specWarnFieryBoulder		= mod:NewSpecialWarningSpell(153247, false)
local specWarnHeatWave			= mod:NewSpecialWarningSpell(152940, false, nil, nil, 2)
local specWarnBurningSlag		= mod:NewSpecialWarningSpell(152939, false, nil, nil, 2)
local specWarnBurningSlagFire	= mod:NewSpecialWarningMove(152939)

local timerFieryBoulderCD		= mod:NewNextTimer(13.3, 153247)--13.3-13.4 Observed
local timerHeatWaveCD			= mod:NewCDTimer(9.5, 152940)--9.5-9.8 Observed
local timerBurningSlagCD		= mod:NewCDTimer(10.7, 152939)--10.7-11 Observed

mod.vb.boulderCount = 0
mod.vb.burningSlagCast = false--More robust than using a really huge anti spam, because this will work with recovery, antispam won't

function mod:OnCombatStart(delay)
	self.vb.boulderCount = 0
	self.vb.burningSlagCast = false
	timerFieryBoulderCD:Start(8-delay)
end

--[[
"<2.7 01:12:08> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#true#true#Roltall#
"<10.9 01:12:16> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [137]
"<14.3 01:12:20> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [200]
"<18.1 01:12:23> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [248]+33.8 (+9.5)

"<27.6 01:12:33> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#152940#Heat Wave#4", -- [449]  +41.1 (+11)

"<38.6 01:12:44> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#152939#Burning Slag#4", -- [665] +40.8 (13.3)

"<51.9 01:12:57> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [931]
"<55.3 01:13:01> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [1027]
"<59.0 01:13:04> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [1094] +33.7 (+9.7)

"<68.7 01:13:14> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#152940#Heat Wave#4", -- [1244] +41 (+10.7)

"<79.4 01:13:25> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#152939#Burning Slag#4", -- [1455] +41 (+13.3)

"<92.7 01:13:38> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [1627]
"<96.3 01:13:42> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [1681]
"<99.9 01:13:45> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [1723] +33.9 (+9.8)

"<109.7 01:13:55> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#152940#Heat Wave#4", -- [1832] (+10.7)

"<120.4 01:14:06> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#152939#Burning Slag#4", -- [2022] (+13.4)

"<133.8 01:14:19> [CLEU] SPELL_CAST_START#false#Creature:0:3314:1175:11531:75786:00003A26C0#Roltall#68168#0##nil#-2147483648#-2147483648#153247#Fiery Boulder#4", -- [2229]
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153247 then--Boulder
		if self.vb.burningSlagCast then self.vb.burningSlagCast = false end
		self.vb.boulderCount = self.vb.boulderCount + 1
		warnFieryBoulder:Show(self.vb.boulderCount)
		specWarnFieryBoulder:Show()
		if self.vb.boulderCount == 3 then
			timerHeatWaveCD:Start()
			self.vb.boulderCount = 0
		else
			timerFieryBoulderCD:Start(3.5)--Not to be confused with cast timer, that's 3 seconds. The previous meteor WILL hit ground before next cast.
		end
	elseif spellId == 152940 then--Heat Wave
		warnHeatWave:Show()
		specWarnHeatWave:Show()
		timerBurningSlagCD:Start()
	elseif spellId == 152939 and not self.vb.burningSlagCast then--Burning Slag
		self.vb.burningSlagCast = true
		warnBurningSlag:Show()
		specWarnBurningSlag:Show()
		timerFieryBoulderCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 153227 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnBurningSlagFire:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 153227 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBurningSlagFire:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
