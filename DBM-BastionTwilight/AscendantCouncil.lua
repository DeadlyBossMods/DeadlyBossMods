local mod	= DBM:NewMod("AscendantCouncil", "DBM-BastionTwilight", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43686, 43687, 43688, 43689, 43735)
mod:SetZone()
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnGlaciate		= mod:NewSpellAnnounce(82746, 3)
local warnHeartIce		= mod:NewTargetAnnounce(82665, 3)
local warnWaterBomb		= mod:NewSpellAnnounce(82699, 3)
local warnFrozen		= mod:NewTargetAnnounce(82772, 3)
local warnFlameTorrent		= mod:NewSpellAnnounce(82777, 2)
local warnBurningBlood		= mod:NewTargetAnnounce(82660, 3)
local warnAegisFlame		= mod:NewSpellAnnounce(82631, 4)
local warnRisingFlames		= mod:NewSpellAnnounce(82636, 4)
local warnGravityWell		= mod:NewSpellAnnounce(83572, 3)
local warnEruption		= mod:NewSpellAnnounce(83675, 2)
local warnHardenSkin		= mod:NewSpellAnnounce(83718, 3)
local warnQuake			= mod:NewSpellAnnounce(83565, 4)
local warnCallWinds		= mod:NewSpellAnnounce(83491, 3)
local warnLightningRod		= mod:NewTargetAnnounce(83099, 3)
local warnDisperse		= mod:NewSpellAnnounce(83087, 3)
local warnChainLightning	= mod:NewSpellAnnounce(83300, 2)
local warnLightningBlast	= mod:NewCastAnnounce(83070, 3)
local warnThundershock		= mod:NewSpellAnnounce(83067, 4)

local timerGlaciate		= mod:NewCDTimer(32, 82746)
local timerHeartIce		= mod:NewTargetTimer(60, 82665)
local timerHeartIceCD		= mod:NewCDTimer(20, 82665)
local timerWaterBomb		= mod:NewCDTimer(32, 82699)
local timerFrozen		= mod:NewTargetTimer(10, 82772)
local timerBurningBlood		= mod:NewTargetTimer(60, 82660)
local timerBurningBloodCD	= mod:NewTargetTimer(30, 82660)
local timerRisingFlames		= mod:NewCDTimer(60, 82636)
local timerGravityWell		= mod:NewCDTimer(17, 83572)
local timerQuake		= mod:NewNextTimer(10, 83565)		-- triggered by emote
local timerQuakeCast		= mod:NewCastTimer(3, 83565)
local timerCallWinds		= mod:NewCDTimer(27, 83491)
local timerLightningRod		= mod:NewTargetTimer(15, 83099)
local timerDisperse		= mod:NewCDTimer(30, 83087)
local timerLightningBlast	= mod:NewCastTimer(4, 83070)
local timerThundershock		= mod:NewNextTimer(10, 83067)		-- triggered by emote
local timerThundershockCast	= mod:NewCastTimer(3, 83067)

local specWarnWaterLogged	= mod:NewSpecialWarningYou(82762)
local specWarnGrounded		= mod:NewSpecialWarning("SpecWarnGrounded")
local specWarnSearingWinds	= mod:NewSpecialWarning("SpecWarnSearingWinds")

mod:AddBoolOption("HeartIceIcon")
mod:AddBoolOption("BurningBloodIcon")

local frozenTargets = {}

local showFrozenWarning = function()
	warnFrozen:Show(table.concat(frozenTargets, "<, >"))
	table.wipe(frozenTargets)
end

local checkGrounded = function()
	if not UnitDebuff("player", GetSpellInfo(83581)) and not UnitIsDeadOrGhost("player") then
		specWarnGrounded:Show()
	end
end

local updateBossFrame = function(phase)
	DBM.BossHealth:Clear()
	if phase == 1 then
		DBM.BossHealth:AddBoss(43687, L.Feludius)
		DBM.BossHealth:AddBoss(43686, L.Ignacious)
	elseif phase == 2 then
		DBM.BossHealth:AddBosS(43688, L.Arion)
		DBM.BossHealth:AddBosS(43689, L.Terrastra)
	elseif phase == 3 then
		DBM.BossHealth:AddBoss(43735, L.Monstrosity)
	end
end

local checkSearingWinds = function()
	if not UnitDebuff("player", GetSpellInfo(83500)) and not UnitIsDeadOrGhost("player") then
		specWarnGrounded:Show()
	end
end

function mod:OnCombatStart(delay)
	updateBossFrame(1)
	table.wipe(frozenTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82772) then
		timerFrozen:Start(args.destName)
		frozenTargets[#frozenTargets] = args.destName
		self:Unschedule(showFrozenWarning)
		self:Schedule(0.3, showFrozenWarning())
	elseif args:IsSpellID(82665) then
		warnHeartIce:Show(args.destName)
		timerHeartIce:Start(args.destName)
		timerHeartIceCD:Start()
		if self.Options.HeartIceIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(82660) then
		warnBurningBlood:Show(args.destName)
		timerBurningBlood:Start(args.destName)
		timerBurningBloodCD:Start()
		if self.Options.BurningBloodIcon then
			self:SetIcon(args.destName, 7)
		end
	elseif args:IsSpellID(83099) then
		warnLightningRod:Show(args.destName)
		timerLightningRod:Start(args.destName)
	elseif args:IsSpellID(82777) then
		warnFlameTorrent:Show()
	elseif args:IsSpellID(82660) then
		warnAegisFlame:Show()
	elseif args:IsSpellID(82762) then
		specWarnWaterlogged:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(82772) then
		timerFrozen:Cancel(args.destName)
	elseif args:IsSpellID(82665) then
		timerHeartIce:Cancel(args.destName)
		self:SetIcon(args.destName, 0)
	elseif args:IsSpellID(82660) then
		timerBurningBlood:Cancel(args.destName)
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(82746) then
		warnGlaciate:Show()
		timerGlaciate:Start()
	elseif args:IsSpellID(82699) then
		warnWaterBomb:Show()
		timerWaterBomb:Start()
	elseif args:IsSpellID(83675) then
		warnEruption:Show()
	elseif args:IsSpellID(83718) then
		warnHardenSkin:Show()
	elseif args:IsSpellID(83565) then
		warnQuake:Show()
		timerQuakeCast:Show()
	elseif args:IsSpellID(83491) then
		warnCallWinds:Show()
		timerCallWinds:Start()
	elseif args:IsSpellID(83087) then
		warnDisperse:Show()
		timerDisperse:Start()
	elseif args:IsSpellID(83070) then
		warnLightningBlast:Show()
		timerLightningBlast:Start()
	elseif args:IsSpellID(83067) then
		warnThundershock:Show()
		timerThundershockCast:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82636) then
		warnRisingFlames:Show()
		timerRisingFlames:Start()
	elseif args:IsSpellID(83572) then
		warnGravityWell:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Switch then
		updateBossFrame(2)
	elseif msg == L.Phase3 then
		updateBossFrame(3)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Quake then
		checkSearingWinds()
		timerQuake:Start()
	elseif msg == L.Thundershock then
		checkGrounded()
		timerThundershock:Start()
	end
end

