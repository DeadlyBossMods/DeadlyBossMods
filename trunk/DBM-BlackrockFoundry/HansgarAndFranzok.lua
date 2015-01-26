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
	"SPELL_AURA_APPLIED 157139",
	"SPELL_AURA_APPLIED_DOSE 157139",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",
	"UNIT_TARGETABLE_CHANGED"
)

--TODO, find target scanning for skullcracker. Also, find out how it behaves when it's more than 1 target (just recast?)
--TODO, maybe use http://beta.wowhead.com/spell=154785 for aftershock/Shattered Vertebrae instead?'
--TODO, collect more data to figure out how roar stops/resumes on jump down. One pull/kill is not a sufficient sampling.
local warnSkullcracker					= mod:NewSpellAnnounce(153470, 3, nil, false)--This seems pretty worthless.
local warnShatteredVertebrae			= mod:NewStackAnnounce(157139, 2, nil, "Tank")--Possibly useless or changed. Needs further logs.

local specWarnDisruptingRoar			= mod:NewSpecialWarningCast("OptionVersion2", 160838, "SpellCaster")
local specWarnShatteredVertebrae		= mod:NewSpecialWarningStack(157139, nil, 2, nil, nil, nil, nil, true)--stack guessed
local specWarnShatteredVertebraeOther	= mod:NewSpecialWarningTaunt(157139)
local specWarnCripplingSuplex			= mod:NewSpecialWarningSpell(156938, nil, nil, nil, 3)--pop a cooldown, or die.
local specWarnSearingPlates				= mod:NewSpecialWarningSpell(161570, nil, nil, nil, 2)
local specWarnStampers					= mod:NewSpecialWarningSpell(174825, nil, nil, nil, 2)
local specWarnEnvironmentalThreatsEnd	= mod:NewSpecialWarningEnd("ej10089", nil)

local timerDisruptingRoar				= mod:NewCastTimer(2.5, 160838)
local timerDisruptingRoarCD				= mod:NewCDTimer(46, 160838)

local voiceEnvironmentalThreats			= mod:NewVoice("ej10089")
local voiceShatteredVertebrae			= mod:NewVoice(157139)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerDisruptingRoarCD:Start(-delay)
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156220 or spellId == 156883 then--Tactical Retreat
		self.vb.phase = self.vb.phase + 1
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		if cid == 76974 then--Fran
			timerDisruptingRoarCD:Cancel()
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

function mod:UNIT_TARGETABLE_CHANGED(uId)
	if UnitExists(uId) then--Return, not retreat
		if self.vb.phase == 4 then--Stampers activate on their own after 3rd jump away, when they return.
			specWarnStampers:Show()
			voiceEnvironmentalThreats:Play("watchstep")	
		else
			specWarnEnvironmentalThreatsEnd:Show()
			voiceEnvironmentalThreats:Play("safenow")
		end
	end
end
