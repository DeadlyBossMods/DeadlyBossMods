local mod	= DBM:NewMod(1672, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98965, 98970)
mod:SetEncounterID(1835)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198820 199143 199193 202019",
	"SPELL_CAST_SUCCESS 198635 201733",
	"SPELL_AURA_APPLIED 201733",
	"SPELL_AURA_REMOVED 199193",
	"UNIT_DIED"
)

--TODO, figure out swarm warnings, how many need to switch and kill?
local warnCloud						= mod:NewSpellAnnounce(199143, 2)
local warnSwarm						= mod:NewTargetAnnounce(201733, 2)

local specWarnDarkblast				= mod:NewSpecialWarningDodge(198820, nil, nil, nil, 2)
local specWarnGuile					= mod:NewSpecialWarningDodge(199193, nil, nil, nil, 2, 2)
local specWarnGuileEnded			= mod:NewSpecialWarningEnd(199193, nil, nil, nil, 1, 2)
local specWarnSwarm					= mod:NewSpecialWarningYou(201733)
local specWarnShadowBolt			= mod:NewSpecialWarningDefensive(202019, nil, nil, nil, 3, 2)

local timerDarkBlastCD				= mod:NewCDTimer(18, 198820, nil, nil, nil, 3)
local timerUnerringShearCD			= mod:NewCDTimer(12, 198635, nil, "Tank", nil, 5)
local timerGuileCD					= mod:NewCDTimer(39, 199193, nil, nil, nil, 6)
local timerGuile					= mod:NewBuffFadesTimer(24, 199193, nil, nil, nil, 6)
local timerCloudCD					= mod:NewCDTimer(32.8, 199143, nil, nil, nil, 3)
local timerSwarmCD					= mod:NewCDTimer(32.8, 201733, nil, nil, nil, 3)
local timerShadowBoltVolleyCD		= mod:NewCDTimer(8, 202019, nil, nil, nil, 2)

local countdownShear				= mod:NewCountdown(12, 198635, "Tank")

local voiceDarkblast				= mod:NewVoice(198820)--watchstep
local voiceGuile					= mod:NewVoice(199193)--watchstep/keepmove/safenow
local voiceShadowBolt				= mod:NewVoice(202019)--defensive

mod.vb.phase = 1
mod.vb.shadowboltCount = 0

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.shadowboltCount = 0
	timerUnerringShearCD:Start(5.5-delay)
	countdownShear:Start(5.5-delay)
	timerDarkBlastCD:Start(10-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198820 then
		if self.vb.phase == 1 then
			specWarnDarkblast:Show()
			voiceDarkblast:Play("watchstep")
			timerDarkBlastCD:Start()
		end
	elseif spellId == 199143 then
		warnCloud:Show()
		timerCloudCD:Start()
	elseif spellId == 199193 then
		timerCloudCD:Stop()
		timerSwarmCD:Stop()
		timerShadowBoltVolleyCD:Stop()
		specWarnGuile:Show()
		voiceGuile:Play("watchstep")
		voiceGuile:Schedule(1.5, "keepmove")
		timerGuile:Start()
	elseif spellId == 202019 then
		self.vb.shadowboltCount = self.vb.shadowboltCount + 1
		if self.vb.shadowboltCount == 1 then
			specWarnShadowBolt:Show()
			voiceShadowBolt:Play("defensive")
		end
		--timerShadowBoltVolleyCD:Start()--Not known, and probably not important
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 198635 then
		timerUnerringShearCD:Start()
		countdownShear:Start()
	elseif spellId == 201733 then
		timerSwarmCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 201733 then
		if args:IsPlayer() then
			specWarnSwarm:Show()
		else
			warnSwarm:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 199193 then
		specWarnGuileEnded:Show()
		voiceGuile:Play("safenow")
		timerCloudCD:Start(3)
		if not self:IsNormal() then
			timerSwarmCD:Start(10.5)
		end
		timerGuileCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 98965 then--Kur'talos Ravencrest
		self.vb.phase = 2
		timerDarkBlastCD:Stop()
		timerUnerringShearCD:Stop()
		countdownShear:Cancel()
		if not self:IsNormal() then
			timerSwarmCD:Start(9)
		end
		timerCloudCD:Start(11.5)
		timerShadowBoltVolleyCD:Start(17.5)--Not confirmed, submitted by requesting user
		timerGuileCD:Start(24)--24-28
	end
end
