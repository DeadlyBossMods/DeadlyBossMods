local mod	= DBM:NewMod("Kel'Thuzad", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15990)
mod:SetMinCombatTime(60)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.Yell)

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnAddsSoon			= mod:NewAnnounce("warnAddsSoon", 1, 45419)
local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnBlastTargets		= mod:NewTargetAnnounce(27808, 2)
local warnFissure			= mod:NewSpellAnnounce(27810, 3)
local warnMana				= mod:NewTargetAnnounce(27819, 2)
local warnChainsTargets		= mod:NewTargetAnnounce(28410, 2)

local specwarnP2Soon		= mod:NewSpecialWarning("specwarnP2Soon")

local blastTimer			= mod:NewBuffActiveTimer(4, 27808)
local timerMC				= mod:NewBuffActiveTimer(20, 28410)
local timerMCCD				= mod:NewCDTimer(90, 28410)--actually 60 second cdish but its easier to do it this way for the first one.
local timerPhase2			= mod:NewTimer(225, "TimerPhase2", "Interface\\Icons\\Spell_Nature_WispSplode")

mod:AddBoolOption("SetIconOnMC", true)
mod:AddBoolOption("SetIconOnManaBomb", true)
mod:AddBoolOption("SetIconOnFrostTomb", true)
mod:AddBoolOption("ShowRange", true)

local warnedAdds = false
local MCIcon = 1
local frostBlastTargets = {}
local chainsTargets = {}

local function AnnounceChainsTargets()
	warnChainsTargets:Show(table.concat(chainsTargets, "< >"))
	table.wipe(chainsTargets)
	MCIcon = 1
end

local function AnnounceBlastTargets()
	warnBlastTargets:Show(table.concat(frostBlastTargets, "< >"))
	if mod.Options.SetIconOnFrostTomb then
		for i = #frostBlastTargets, 1, -1 do
			mod:SetIcon(frostBlastTargets[i], 8 - i, 4.5) 
			frostBlastTargets[i] = nil
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(chainsTargets)
	table.wipe(frostBlastTargets)
	warnedAdds = false
	MCIcon = 1
	specwarnP2Soon:Schedule(215-delay)
	if mod:IsDifficulty("normal25") then
		timerMCCD:Schedule(225-delay)
	end
	timerPhase2:Start()
	warnPhase2:Schedule(225)
	if self.Options.ShowRange then
		self:ScheduleMethod(215-delay, "RangeToggle", true)
	end
end

function mod:OnCombatEnd()
	if self.Options.ShowRange then
		self:RangeToggle(false)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(27808) then -- Frost Blast
		table.insert(frostBlastTargets, args.destName)
		self:Unschedule(AnnounceBlastTargets)
		self:Schedule(0.5, AnnounceBlastTargets)
		blastTimer:Start()
	elseif args:IsSpellID(27819) then -- Mana Bomb
		warnMana:Show(args.destName)
		if self.Options.SetIconOnManaBomb then
			self:SetIcon(args.destName, 8, 5.5)
		end
	elseif args:IsSpellID(28410) then -- Chains of Kel'Thuzad
		chainsTargets[#chainsTargets + 1] = args.destName
		timerMC:Start()
		timerMCCD:Start(60)--60 seconds?
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, MCIcon, 20)
			MCIcon = MCIcon + 1
		end
		self:Unschedule(AnnounceChainsTargets)
		if #chainsTargets >= 3 then
			AnnounceChainsTargets()
		else
			self:Schedule(1.0, AnnounceChainsTargets)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(27810) then
		warnFissure:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedAdds and self:GetUnitCreatureId(uId) == 15990 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.48 then
		warnedAdds = true
		warnAddsSoon:Show()
	end
end

function mod:RangeToggle(show)
	if show then
		DBM.RangeCheck:Show(10)
	else
		DBM.RangeCheck:Hide()
	end
end
