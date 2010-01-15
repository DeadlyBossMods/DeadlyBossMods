local mod	= DBM:NewMod("Lanathel", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37955)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnPactDarkfallen		= mod:NewTargetAnnounce(71340, 3)
local warnBloodMirror			= mod:NewTargetAnnounce(71510, 3)

local specWarnPactDarkfallen	= mod:NewSpecialWarningYou(71340)
local specWarnBloodthirst		= mod:NewSpecialWarningYou(70877)
local specWarnBloodMirror		= mod:NewSpecialWarningTarget(71510, false)

local timerNextPactDarkfallen	= mod:NewNextTimer(30, 71340)
local timerBloodMirror			= mod:NewTargetTimer(30, 71510)

mod:AddBoolOption("SetIconOnDarkFallen", true)

local pactTargets = {}
local pactIcons = 8

local function warnPactTargets()
	warnPactDarkfallen:Show(table.concat(pactTargets, "<, >"))
	table.wipe(pactTargets)
	timerNextPactDarkfallen:Start(30)
	pactIcons = 8
end

function mod:OnCombatStart(delay)
	table.wipe(pactTargets)
	pactIcons = 8
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71340) then		--Pact of the Darkfallen
		pactTargets[#pactTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnPactDarkfallen:Show()
		end
		if self.Options.SetIconOnDarkFallen then--Debuff doesn't actually last 30 seconds
			self:SetIcon(args.destName, pactIcons, 30)--it lasts forever, but if you still have it after 30 seconds
			pactIcons = pactIcons - 1--then it's probably a wipe anyways
		end
		self:Unschedule(warnPactTargets)
		if #pactTargets >= 5 then
			warnPactTargets()
		else
			self:Schedule(0.3, warnPactTargets)
		end
	elseif args:IsSpellID(71510, 70838, 70451) then--Spellids drycoded from wowhead will verify on release
		warnBloodMirror:Show(args.destName)
		timerBloodMirror:Start(args.destName)
		specWarnBloodMirror:Show(args.destName)
	elseif args:IsSpellID(70877, 71474) then--Spellids drycoded from wowhead will verify on release
		specWarnBloodthirst:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(71340) then		-- Pact of the Darkfallen
		self:SetIcon(args.destName, 0)--Clear icon once you got to where you are supposed to be
	end
end