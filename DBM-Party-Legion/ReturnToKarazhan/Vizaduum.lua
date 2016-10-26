local mod	= DBM:NewMod(1838, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114790)
mod:SetEncounterID(2017)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 229151 229083",
	"SPELL_CAST_SUCCESS 229610 229242 229284",
	"SPELL_AURA_APPLIED 229159 229241",
	"SPELL_AURA_REMOVED 229159"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
)

--TODO: Burning Blast INterrupt helper. Figure out CD, then what to do with it
--TODO: Phases
--TODO: Figure out what to do with soul harvest
--TODO: figure out what to do with Felguard Sentry (115730)
--ALL
local warnChaoticShadows			= mod:NewTargetAnnounce(229159, 3)
local warnFelBeam					= mod:NewTargetAnnounce(229242, 4)
local warnDisintegrate				= mod:NewSpellAnnounce(229151, 4)--Switch to special warning if target scanning works

--ALL
local specWarnChaoticShadows		= mod:NewSpecialWarningYou(229159, nil, nil, nil, 1, 2)
local yellChaoticShadows			= mod:NewPosYell(229159)
--Phase 1
local specWarnFelBeam				= mod:NewSpecialWarningRun(229242, nil, nil, nil, 1, 2)
local yellFelBeam					= mod:NewYell(229242)

--ALL
local timerChaoticShadowsCD			= mod:NewAITimer(40, 229159, nil, nil, nil, 3)
local timerDisintegrateCD			= mod:NewAITimer(40, 229151, nil, nil, nil, 3)
--local timerBurningBlastCD			= mod:NewAITimer(40, 229151, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Phase 1
local timerFelBeamCD				= mod:NewAITimer(40, 229242, 219084, nil, nil, 3)
local timerBombardmentCD			= mod:NewAITimer(40, 229284, 229287, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

--ALL
local voiceChaoticShadows			= mod:NewVoice(229159)--runout
--Phase 1
local voiceFelBeam					= mod:NewVoice(229242)--justrun/keepmove

mod:AddSetIconOption("SetIconOnShadows", 229159, true)
mod:AddRangeFrameOption(6, 230066)
--mod:AddInfoFrameOption(198108, false)

mod.vb.phase = 1
local chaoticShadowsTargets = {}
local laserWarned = false

local function breakShadows(self)
	warnChaoticShadows:Show(table.concat(chaoticShadowsTargets, "<, >"))
	table.wipe(chaoticShadowsTargets)
end

function mod:OnCombatStart(delay)
	laserWarned = false
	table.wipe(chaoticShadowsTargets)
	self.vb.phase = 1
	timerFelBeamCD:Start(1-delay)
	timerDisintegrateCD:Start(1-delay)
	timerChaoticShadowsCD:Start(1-delay)
	timerBombardmentCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 229151 then
		warnDisintegrate:Show()
		timerDisintegrateCD:Show()
	elseif spellId == 229083 then
--		timerBurningBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 229610 then--Demonic Portal (both times or just once?)
		self.vb.phase = self.vb.phase + 1
		--Cancel stuff
		timerDisintegrateCD:Stop()
		timerChaoticShadowsCD:Stop()
		--timerBurningBlastCD:Stop()
		timerBombardmentCD:Stop()
		if self.vb.phase == 2 then
			timerFelBeamCD:Stop()
			timerDisintegrateCD:Start(2)
			timerChaoticShadowsCD:Start(2)
--			timerBurningBlastCD:Start(2)
			timerBombardmentCD:Start(2)
		elseif self.vb.phase == 3 then
			timerDisintegrateCD:Start(3)
			timerChaoticShadowsCD:Start(3)
--			timerBurningBlastCD:Start(3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(6)
			end
		end
	elseif spellId == 229242 then
		timerFelBeamCD:Start()
	elseif spellId == 229284 then
		timerBombardmentCD:Start()
	elseif spellId == 230084 then--Stabilize Rift
		DBM:Debug("THE RIFT")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 229159 then
		local name = args.destName
		if not tContains(chaoticShadowsTargets, name) then
			chaoticShadowsTargets[#chaoticShadowsTargets+1] = name
		end
		local count = #chaoticShadowsTargets
		self:Unschedule(breakShadows)
		--TODO, when phase detection is working, Improve this
		if count == 3 then
			breakShadows(self)
		else
			self:Schedule(1, breakShadows, self)
		end
		if args:IsPlayer() then
			specWarnChaoticShadows:Show()
			voiceChaoticShadows:Play("runout")
			yellChaoticShadows:Yell(count, count, count)
		end
		if self.Options.SetIconOnShadows then
			self:SetIcon(name, count)
		end
	elseif spellId == 229241 then
		if args:IsPlayer() then
			specWarnFelBeam:Show()
			voiceFelBeam:Play("justrun")
			voiceFelBeam:Schedule(1, "keepmove")
		else
			warnFelBeam:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 229159 then
		if self.Options.SetIconOnShadows then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 103695 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 206341 then
	
	end
end
--]]
