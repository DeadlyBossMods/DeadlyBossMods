local mod	= DBM:NewMod(2402, "DBM-Party-Shadowlands", 3, 1184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164501)
mod:SetEncounterID(2392)
mod:SetUsedIcons(1, 2, 3, 4)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 336499 321834 321873 321828 321669",
	"SPELL_AURA_APPLIED 321891 321828",
	"SPELL_AURA_REMOVED 321891 336499"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, timers still a mess, mostly freeze tag. dodge ball and Patty cake seem okish but still a little iffy like there is something more. More data required
--[[
(ability.id = 321834 or ability.id = 321873 or ability.id = 321828) and type = "begincast"
 or ability.id = 336499
 or ability.id = 321669 and type = "begincast"
--]]
local warnGuessingGame				= mod:NewCastAnnounce(336499, 4)
local warnGuessingGameOver			= mod:NewEndAnnounce(321873, 1)
local warnFreezeTag					= mod:NewCastAnnounce(321873, 3)
local warnFixate					= mod:NewTargetNoFilterAnnounce(321891, 2)
local warnPattyCake					= mod:NewTargetNoFilterAnnounce(321828, 3)

local specWarnDodgeBall				= mod:NewSpecialWarningDodge(321834, nil, nil, nil, 2, 2)
local specWarnFixate				= mod:NewSpecialWarningRun(321891, nil, nil, nil, 4, 2)
local specWarnPattyCake				= mod:NewSpecialWarningInterrupt(321828, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDodgeBallCD				= mod:NewCDTimer(13.3, 321834, nil, nil, nil, 3)--13-16
--local timerFreezeTagCD				= mod:NewCDTimer(21.4, 321873, nil, nil, nil, 3)--21-71.7?
local timerPattyCakeCD				= mod:NewCDTimer(20.6, 321828, nil, nil, nil, 3)--20-23

mod:AddNamePlateOption("NPAuraOnFixate", 321891)
mod:AddSetIconOption("SetIconOnAdds", "ej21691", true, true, {1, 2, 3, 4})

local seenAdds = {}
mod.vb.addIcon = 1

function mod:OnCombatStart(delay)
	table.wipe(seenAdds)
	self.vb.addIcon = 1
	timerDodgeBallCD:Start(8.1-delay)
	timerPattyCakeCD:Start(13.4-delay)
--	timerFreezeTagCD:Start(18.4-delay)--Sometimes cast is skipped?
	if self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(seenAdds)
	if self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 336499 then
		self.vb.addIcon = 1
		warnGuessingGame:Show()
	elseif spellId == 321834 and self:AntiSpam(8, 1) then
		specWarnDodgeBall:Show()
		specWarnDodgeBall:Play("farfromline")
		timerDodgeBallCD:Start()
	elseif spellId == 321873 then
		warnFreezeTag:Show()
--		timerFreezeTagCD:Start()
	elseif spellId == 321828 then
		if self:IsTanking("player", "boss1", nil, nil, nil, true) then
			--Only target of spell can interrupt it
			specWarnPattyCake:Show(args.sourceName)
			specWarnPattyCake:Play("kickcast")
		end
		timerPattyCakeCD:Start()
	elseif spellId == 321669 then
		if not seenAdds[args.sourceGUID] then
			seenAdds[args.sourceGUID] = true
			if self.Options.SetIconOnAdds then--Only use up to 5 icons
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12)
			end
			self.vb.addIcon = self.vb.addIcon + 1
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321891 then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("runout")
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 6)
			end
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 321828 then
		warnPattyCake:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 321891 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 336499 then
		warnGuessingGameOver:Show()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
