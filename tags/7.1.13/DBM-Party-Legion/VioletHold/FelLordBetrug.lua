local mod	= DBM:NewMod(1711, "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(102446)
mod:SetEncounterID(1856)
mod:SetZone()

mod.imaspecialsnowflake = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 210879 205233",
	"SPELL_AURA_REMOVED 210879 205233",
	"SPELL_CAST_SUCCESS 210879",
	"SPELL_CAST_START 203641 202328"
)

local warnFelSlash				= mod:NewTargetAnnounce(203641, 4)
local warnSeedofDestruction		= mod:NewTargetAnnounce(210879, 3)
local warnExecute				= mod:NewTargetAnnounce(205233, 4)

local specWarnFelSlash			= mod:NewSpecialWarningDodge(203641)--warn Everyone since cone is so wide
local yellFelSlash				= mod:NewYell(203641)
local specWarnMightySmash		= mod:NewSpecialWarningSpell(202328, nil, nil, nil, 2, 2)
local specWarnSeedofDestruction	= mod:NewSpecialWarningYou(210879, nil, nil, nil, 1, 2)
local yellSeedsofDestruction	= mod:NewYell(210879)

--local timerFelSlashCD			= mod:NewCDTimer(18, 203641, nil, nil, nil, 3)--Too unreliable do to smash/executions
local timerMightySmashCD		= mod:NewCDTimer(50, 202328, nil, nil, nil, 2)--50-57
local timerSeedsCD				= mod:NewCDTimer(21.8, 210879, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)--22-40
local timerExecute				= mod:NewTargetTimer(20, 205233, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--22-40

local voiceFelSlash				= mod:NewVoice(203641)--shockwave
local voiceMightySmash			= mod:NewVoice(202328)--carefly
local voiceSeedsofDestruction	= mod:NewVoice(210879)--Runout

mod:AddHudMapOption("HudMapOnFelSlash", 203641)
mod:AddSetIconOption("SetIconOnSeeds", 210879, true)

function mod:SlashTarget(targetname, uId)
	if not targetname then return end
	warnFelSlash:Show(targetname)
	if targetname == UnitName("player") then
		yellFelSlash:Yell()
	end
	if self.Options.HudMapOnFelSlash then
		--Static marker, boss doesn't move once a target is picked. it's aimed at static location player WAS
		DBMHudMap:RegisterStaticMarkerOnPartyMember(203641, "highlight", targetname, 5, 2, 1, 0, 0, 0.5, nil, 1):Pulse(0.5, 0.5)
	end
end

function mod:OnCombatStart(delay)
	--timerFelSlashCD:Start(11-delay)
	if not self:IsNormal() then
		timerSeedsCD:Start(17-delay)
	end
	timerMightySmashCD:Start(30-delay)
end

function mod:OnCombatEnd()
	if self.Options.HudMapOnFelSlash then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 210879 then
		warnSeedofDestruction:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSeedofDestruction:Show()
			yellSeedsofDestruction:Yell()
			voiceSeedsofDestruction:Play("runout")
		end
		if self.Options.SetIconOnSeeds then
			self:SetAlphaIcon(0.5, args.destName)
		end
	elseif spellId == 205233 then
		warnExecute:Show(args.destName)
		timerExecute:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 210879 and self.Options.SetIconOnSeeds then
		self:SetIcon(args.destName, 0)
	elseif spellId == 205233 then
		timerExecute:Stop(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 210879 then
		timerSeedsCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203641 then
		specWarnFelSlash:Show()
		voiceFelSlash:Play("shockwave")
		self:BossUnitTargetScanner("boss1", "SlashTarget", 3)
		--timerFelSlashCD:Start()
	elseif spellId == 202328 then
		specWarnMightySmash:Show()
		voiceMightySmash:Play("carefly")
		timerMightySmashCD:Start()
	end
end
