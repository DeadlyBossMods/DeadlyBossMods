local mod	= DBM:NewMod(1673, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91005)
mod:SetEncounterID(1792)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 209906",
--	"SPELL_AURA_REMOVED 209906",
	"SPELL_CAST_START 199176 210150 205549",
--	"SPELL_PERIODIC_DAMAGE 188494",
--	"SPELL_PERIODIC_MISSED 188494",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnFixate					= mod:NewTargetAnnounce(209906, 2, nil, false)--Could be spammy, optional

local specWarnAdds					= mod:NewSpecialWarningSwitch(199817, "Dps", nil, nil, 1, 2)
local specWarnFixate				= mod:NewSpecialWarningYou(209906)
local specWarnSpikedTongue			= mod:NewSpecialWarningRun(199176, nil, nil, nil, 4, 2)
--local specWarnRancidMaw			= mod:NewSpecialWarningMove(188494)--Needs confirmation this is pool damage and not constant fight aoe damage

local timerSpikedTongueCD			= mod:NewNextTimer(55, 199176, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
local timerAddsCD					= mod:NewCDTimer(65, 199817, nil, nil, nil, 1, 226361)
local timerRancidMawCD				= mod:NewCDTimer(18, 205549, nil, false, nil, 3)--Needed?
local timerToxicRetchCD				= mod:NewCDTimer(14.3, 210150, nil, false, nil, 3)--Needed?

local voiceAdds						= mod:NewVoice(199817, "Dps")--mobsoon
local voiceSpikedTongue				= mod:NewVoice(199176)--runout/keepmove

--mod:AddRangeFrameOption(5, 153396)

function mod:OnCombatStart(delay)
	timerAddsCD:Start(5.5-delay)
	timerRancidMawCD:Start(7.3-delay)
	timerToxicRetchCD:Start(12.4-delay)
	timerSpikedTongueCD:Start(54.7-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209906 then
		warnFixate:Show(args.destName)
		if args:IsPlayer() and self:AntiSpam(4, 1) then
			specWarnFixate:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 199176 then
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		--Do based on threat, because there is a good chance tank might die and backup melee needs warning too.
		if tanking or (status == 3) then
			specWarnSpikedTongue:Show()
			voiceSpikedTongue:Play("runout")
			voiceSpikedTongue:Schedule(1.5, "keepmove")
		end
		timerSpikedTongueCD:Start()
	elseif spellId == 205549 then
		timerRancidMawCD:Start()
	elseif spellId == 210150 then
		timerToxicRetchCD:Start()
	end
end
--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 188494 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnRancidMaw:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 199817 then--Call Minions
		specWarnAdds:Show()
		voiceAdds:Play("mobsoon")
		timerAddsCD:Start()
	end
end
