local mod	= DBM:NewMod(1825, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(113971)
mod:SetEncounterID(1954)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227800 227508 227823 227789",
	"SPELL_AURA_APPLIED 227817",
	"SPELL_AURA_REMOVED 227817",
	"SPELL_INTERRUPT",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON"
)

--Fix timers for repent and abilites after repent
local warnSacredGround				= mod:NewTargetAnnounce(227789, 4)
local warnHolyWrath					= mod:NewCastAnnounce(227823, 4)

local specWarnSacredGround			= mod:NewSpecialWarningYou(227789, nil, nil, nil, 1, 2)
local yellSacredGround				= mod:NewYell(227789)
local specWarnHolyShock				= mod:NewSpecialWarningInterrupt(227800, "HasInterrupt", nil, nil, 1, 2)
local specWarnRepentance			= mod:NewSpecialWarningMoveTo(227508, nil, nil, nil, 1, 2)
local specWarnHolyWrath				= mod:NewSpecialWarningInterrupt(227823, "HasInterrupt", nil, nil, 1, 2)

local timerSacredGroundCD			= mod:NewCDTimer(19, 227789, nil, nil, nil, 3)--19-35 (delayed by bulwarks and what nots)
local timerHolyShockCD				= mod:NewCDTimer(13.3, 227800, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerRepentanceCD				= mod:NewCDTimer(51, 227508, nil, nil, nil, 2)
local timerHolyWrath				= mod:NewCastTimer(10, 227823, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

--local berserkTimer				= mod:NewBerserkTimer(300)

local countdownHolyWrath			= mod:NewCountdown(10, 227823)

local voiceHolyShock				= mod:NewVoice(227800, "HasInterrupt")--kickcast
local voiceHolyWrath				= mod:NewVoice(227823, "HasInterrupt")--kickcast

mod:AddRangeFrameOption(8, 227809)--TODO, keep looking for a VALID 6 yard item/spell
mod:AddBoolOption("HealthFrame", true)

function mod:OnCombatStart(delay)
	timerSacredGroundCD:Start(10.9)
	timerHolyShockCD:Start(15.8-delay)
	timerRepentanceCD:Start(48.5-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)--Will open to 6 when supported, else 8
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227800 then
		timerHolyShockCD:Start()
		specWarnHolyShock:Show(args.sourceName)
		voiceHolyShock:Play("kickcast")
	elseif spellId == 227508 then
		specWarnRepentance:Show(GetSpellInfo(227789))
		timerRepentanceCD:Start()
	elseif spellId == 227823 then
		warnHolyWrath:Show()
		timerHolyWrath:Start()
		countdownHolyWrath:Start()
	elseif spellId == 227789 then
		timerSacredGroundCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227817 and DBM.BossHealth:IsShown() then
		self:ShowShieldHealthBar(args.destGUID, args.spellName, 4680000)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227817 then
		self:RemoveShieldHealthBar(args.destGUID)
		if UnitCastingInfo("boss1") then
			specWarnHolyWrath:Show(L.name)
			voiceHolyWrath:Play("kickcast")
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 227823 then
		timerHolyWrath:Stop()
		countdownHolyWrath:Cancel()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:227789") then
		specWarnSacredGround:Show()
		yellSacredGround:Yell()
	end
end

--per usual, use transcriptor message to get messages from both bigwigs and DBM, all without adding comms to this mod at all
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:227789") then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(5, targetName) then--Antispam sync by target name, since this doesn't use dbms built in onsync handler.
			warnSacredGround:Show(targetName)
		end
	end
end
