local mod	= DBM:NewMod(1817, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114350)
mod:SetEncounterID(1965)
mod:SetZone()
mod:SetUsedIcons(1, 2)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227628 227592 227779 228269 228334",
	"SPELL_AURA_APPLIED 227592 228261",
	"SPELL_AURA_REMOVED 227592 228261"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

local warnInfernoBolt				= mod:NewTargetAnnounce(227615, 3)
local warnFlameWreath				= mod:NewCastAnnounce(228269, 4)
local warnFlameWreathTargets		= mod:NewTargetAnnounce(228269, 4)

local specWarnFrostbite				= mod:NewSpecialWarningInterrupt(227592, "HasInterrupt", nil, nil, 1, 2)
local specWarnInfernoBoltMoveTo		= mod:NewSpecialWarningMoveTo(227615, nil, nil, nil, 1, 2)
local specWarnInfernoBoltMoveAway	= mod:NewSpecialWarningMoveAway(227615, nil, nil, nil, 1, 2)
local specWarnInfernoBoltNear		= mod:NewSpecialWarningClose(227615, nil, nil, nil, 1, 2)
local specWarnCeaselessWinter		= mod:NewSpecialWarningSpell(227779, nil, nil, nil, 2, 2)
local specWarnFlameWreath			= mod:NewSpecialWarningYou(228261, nil, nil, nil, 3, 2)
local yellFlameWreath				= mod:NewYell(228261)
local specWarnGuardiansImage		= mod:NewSpecialWarningSwitch(228334, nil, nil, nil, 1, 2)

local timerPiercingMissilesCD		= mod:NewAITimer(40, 227628, nil, "Tank", nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_TANK_ICON)
local timerFrostbiteCD				= mod:NewAITimer(40, 227592, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerInfernoBoltCD			= mod:NewAITimer(40, 227615, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerSpecialCD				= mod:NewCDSpecialTimer(30)

--local berserkTimer				= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

local voiceFrostbite				= mod:NewVoice(227592, "HasInterrupt")--kickcast
local voiceInfernoBolt				= mod:NewVoice(227615)--scatter/gather
local voiceCeaselessWinter			= mod:NewVoice(227779)--keepmove
local voiceFlameWreath				= mod:NewVoice(228261)--stopmove
local voiceGuardiansImage			= mod:NewVoice(228334)--killmob

mod:AddSetIconOption("SetIconOnWreath", 228261, true)
--mod:AddInfoFrameOption(198108, false)

mod.vb.playersFrozen = 0
local frostBiteName = GetSpellInfo(227592)

function mod:InfernoTarget(targetname, uId)
	if not targetname then
		warnInfernoBolt:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		if self.vb.playersFrozen == 0 then
			specWarnInfernoBoltMoveAway:Show()
			voiceInfernoBolt:Play("scatter")
		else
			specWarnInfernoBoltMoveTo:Show(frostBiteName)
			voiceInfernoBolt:Play("gather")
		end
	elseif self:CheckNearby(8, targetname) and not UnitDebuff("player", frostBiteName) then
		specWarnInfernoBoltNear:Show(targetname)
		voiceInfernoBolt:Play("scatter")
	else
		warnInfernoBolt:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.playersFrozen = 0
	timerPiercingMissilesCD:Start(1-delay)
	timerFrostbiteCD:Start(1-delay)
	timerInfernoBoltCD:Start(1-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227628 then
		timerPiercingMissilesCD:Start()
	elseif spellId == 227592 then
		specWarnFrostbite:Show()
		voiceFrostbite:Play("kickcast")
		timerFrostbiteCD:Start()
	elseif spellId == 227615 then
		timerInfernoBoltCD:Start()
		self:BossTargetScanner(args.sourceGUID, "InfernoTarget", 0.1, 16)
	elseif spellId == 227779 then
		specWarnCeaselessWinter:Show()
		voiceCeaselessWinter:Play("keepmove")
		--timerSpecialCD:Start()
	elseif spellId == 228269 then
		warnFlameWreath:Show()
		--timerSpecialCD:Start()
	elseif spellId == 228334 then
		specWarnGuardiansImage:Show()
		voiceGuardiansImage:Play("killmob")
		--timerSpecialCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227592 then
		self.vb.playersFrozen = self.vb.playersFrozen + 1
	elseif spellId == 228261 then
		warnFlameWreathTargets:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFlameWreath:Show()
			voiceFlameWreath:Play("stopmove")
			yellFlameWreath:Yell()
		end
		if self.Options.SetIconOnWreath then
			self:SetAlphaIcon(0.5, args.destName, 2)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227592 then
		self.vb.playersFrozen = self.vb.playersFrozen - 1
	elseif spellId == 228261 then
		if self.Options.SetIconOnWreath then
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
