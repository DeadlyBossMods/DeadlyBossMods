local mod = DBM:NewMod("GeneralVezax", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 679 $"):sub(12, -3))
mod:SetCreatureID(33271)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_INTERRUPT",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnShadowCrash		= mod:NewSpecialWarning("WarningShadowCrash")
local timerSearingFlamesCast	= mod:NewTimer(2, "timerSearingFlamesCast", 62661)
local timerSurgeofDarkness	= mod:NewTimer(10, "timerSurgeofDarkness", 62662)
local timerSaroniteVapors	= mod:NewTimer(30, "timerSaroniteVapors", 63322)

mod:AddBoolOption("SetIconOnShadowCrash", true, "announce")
mod:AddBoolOption("SetIconOnLifeLeach", true, "announce")

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62661 then	-- Searing Flames
		timerSearingFlamesCast:Start()
	end
end

function mod:SPELL_INTERRUPT(args)
	if args.spellId == 62661 then
		timerSearingFlamesCast:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62662 then	-- Surge of Darkness
		timerSurgeofDarkness:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62662 then	
		timerSurgeofDarkness:Stop()
	end
end

local function ShadowCrashTarget()
	local targetname = mod:GetBossTarget()

	if self.Options.SetIconOnShadowCrash then
		mod:SetIcon(targetname, 8, 10)
	end

	if targetname == UnitName("player") then
		warnShadowCrash:Show(targetname)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62660 then		-- Shadow Crash
		self:Schedule(0.1, ShadowCrashTarget)
	
	elseif args.spellId == 63276 and self.Options.SetIconOnLifeLeach then	-- Mark of the Faceless  (life leach)
		mod:SetIcon(args.destName, 7, 10)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.SaroniteVapors then
		timerSaroniteVapors:Start()
	end
end


