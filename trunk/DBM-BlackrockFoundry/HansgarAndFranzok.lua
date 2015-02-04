local mod	= DBM:NewMod(1155, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76974, 76973)
mod:SetEncounterID(1693)
mod:SetZone()
--mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 160838 160845 160847 160848 153470 156938",
	"SPELL_AURA_APPLIED 157139 162124",
	"SPELL_AURA_APPLIED_DOSE 157139",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",
	"UNIT_TARGETABLE_CHANGED"
)

--TODO, find target scanning for skullcracker. Also, find out how it behaves when it's more than 1 target (just recast?)
--TODO, maybe use http://beta.wowhead.com/spell=154785 for aftershock/Shattered Vertebrae instead?'
--TODO, collect more data to figure out how roar starts/resumes on jump down. One pull/kill is not a sufficient sampling.
local warnSkullcracker					= mod:NewSpellAnnounce(153470, 3, nil, false)--This seems pretty worthless.
local warnShatteredVertebrae			= mod:NewStackAnnounce(157139, 2, nil, "Tank")--Possibly useless or changed. Needs further logs.

local specWarnDisruptingRoar			= mod:NewSpecialWarningCast("OptionVersion2", 160838, "SpellCaster")
local specWarnShatteredVertebrae		= mod:NewSpecialWarningStack(157139, nil, 2, nil, nil, nil, nil, 2)--stack guessed
local specWarnShatteredVertebraeOther	= mod:NewSpecialWarningTaunt(157139)
local specWarnCripplingSuplex			= mod:NewSpecialWarningSpell(156938, nil, nil, nil, 3)--pop a cooldown, or die.
local specWarnSearingPlates				= mod:NewSpecialWarningSpell(161570, nil, nil, nil, 2)
local specWarnStampers					= mod:NewSpecialWarningSpell(174825, nil, nil, nil, 2)
local specWarnEnvironmentalThreatsEnd	= mod:NewSpecialWarningEnd("ej10089", nil)

local timerDisruptingRoar				= mod:NewCastTimer(2.5, 160838, nil, "SpellCaster")
local timerDisruptingRoarCD				= mod:NewCDTimer(46, 160838, nil, "SpellCaster")
local timerSkullcrackerCD				= mod:NewCDTimer(22, 153470, nil, "Healer")
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerSmartStamperCD				= mod:NewNextTimer(12, 162124)--Activation
local timerStamperDodge					= mod:NewNextCountTimer(10, 160582)--Time until stamper falls (spell name fits well, time you have to stamper dodge)

local voiceEnvironmentalThreats			= mod:NewVoice("ej10089")
local voiceShatteredVertebrae			= mod:NewVoice(157139)

mod.vb.phase = 1
mod.vb.stamperDodgeCount = 0
mod.vb.bossUp = "NoBody"

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.stamperDodgeCount = 0
	self.vb.bossUp = "NoBody"
	timerSkullcrackerCD:Start(20-delay)
	timerDisruptingRoarCD:Start(-delay)
	if self:IsMythic() then
		timerSmartStamperCD:Start(13-delay)
	end
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(160838, 160845, 160847, 160848) then
		specWarnDisruptingRoar:Show()
		timerDisruptingRoarCD:Start()
		DBM:GetBossUnitId(args.sourceName)
		local _, _, _, _, startTime, endTime = UnitCastingInfo(DBM:GetBossUnitId(args.sourceName))
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		if time then
			timerDisruptingRoar:Start(time)
		end
	elseif spellId == 153470 then
		warnSkullcracker:Show()
		timerSkullcrackerCD:Start()
	elseif spellId == 156938 then
		specWarnCripplingSuplex:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 157139 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") or self:IsTanking(uId, "boss2") then--Assume this can hit non tanks at landing site too, filter them
			local amount = args.amount or 1
			warnShatteredVertebrae:Show(args.destName, amount)
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnShatteredVertebrae:Show(args.amount)
				else
					if not UnitDebuff("player", GetSpellInfo(157139)) and not UnitIsDeadOrGhost("player") then
						specWarnShatteredVertebraeOther:Show(args.destName)
					end
				end
				voiceShatteredVertebrae:Play("changemt")
			end
		end
	elseif spellId == 162124 and self:AntiSpam(2, args.sourceGUID) then
		self.vb.stamperDodgeCount = self.vb.stamperDodgeCount + 1
		timerStamperDodge:Start(nil, self.vb.stamperDodgeCount)--Multiple timers at once is intended. But capped at 3
		--Run antispam code. If raid moves too fast MANY stampers spawn at once. This code will auto cancel timers as new timers are added once we reach 3
		--So only max of 3 bars at once. Cancel current -2 all new timer start
		if self.vb.stamperDodgeCount >= 3 then
			timerStamperDodge:Cancel(self.vb.stamperDodgeCount-2)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 156220 or spellId == 156883) and self.vb.bossUp == "Nobody" then--Tactical Retreat (156883 has lots of invalid casts, so self.vb.bossUp to filter)
		DBM:Debug("Tactical Retreat "..UnitName(uId))
		self.vb.phase = self.vb.phase + 1
		self.vb.stamperDodgeCount = 0
		timerStamperDodge:Cancel()--Cancel all of them
		self.vb.bossUp = UnitName(uId)
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		if cid == 76974 then--Fran
			timerDisruptingRoarCD:Cancel()
			timerSkullcrackerCD:Cancel()
		end
		--The triggers are these percentages for sure but there is a delay before they do it so it always appears later, but the trigger has been triggered
		if self.vb.phase == 2 then--First belt 85% (15 Energy) (fire plates)
			specWarnSearingPlates:Show()
			voiceEnvironmentalThreats:Play("watchstep")
		elseif self.vb.phase == 3 then--Second belt 55% (45 Energy) (Stampers)
			specWarnStampers:Show()
			voiceEnvironmentalThreats:Play("watchstep")
		elseif self.vb.phase == 4 then--Second belt 25% (75 Energy) (Fire plates, then stampers)
			specWarnSearingPlates:Show()
			voiceEnvironmentalThreats:Play("watchstep")	
		end
	end
end

--Currently functional on 6.0.3. But yell method may still be needed in 6.1
function mod:UNIT_TARGETABLE_CHANGED(uId)
	DBM:Debug("UNIT_TARGETABLE_CHANGED event fired")
	if UnitExists(uId) then--Return, not retreat
		self.vb.bossUp = "NoBody"
		if self.vb.phase == 4 then--Stampers activate on their own after 3rd jump away, when they return.
			specWarnStampers:Show()
			voiceEnvironmentalThreats:Play("watchstep")
		else
			if self:IsMythic() then
				timerSmartStamperCD:Start()
				voiceEnvironmentalThreats:Play("gather")--Must restack for smart stampers
			else
				specWarnEnvironmentalThreatsEnd:Show()
				voiceEnvironmentalThreats:Play("safenow")
			end
		end
	end
end
--[[
--Don't remove yet. It's possible the UNIT_TARGETABLE_CHANGED change from PTR may still happen when 6.1 goes live
function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if not target and self.vb.bossUp == npc then--Bosses don't yell with a target for phase change yells. other yells do have targets. For good measure we also make sure sender is boss that's up
		self.vb.bossUp = "NoBody"
		if self.vb.phase == 4 then--Stampers activate on their own after 3rd jump away, when they return.
			specWarnStampers:Show()
			voiceEnvironmentalThreats:Play("watchstep")
		else
			if self:IsMythic() then
				timerSmartStamperCD:Start()
				voiceEnvironmentalThreats:Play("gather")--Must restack for smart stampers
			else
				specWarnEnvironmentalThreatsEnd:Show()
				voiceEnvironmentalThreats:Play("safenow")
			end
		end
	end
end--]]
