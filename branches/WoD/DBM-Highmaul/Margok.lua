local mod	= DBM:NewMod(1197, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(71859)
mod:SetEncounterID(1705)
mod:SetZone()
--mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156238 156467 157349 163988 164075 156471 164299 164232 164301 163989 164076 164235 163990 164077 164240 164303",
	"SPELL_CAST_SUCCESS 158563",
	"SPELL_AURA_APPLIED 158605 164176 164178 164191 157763 158553",
	"SPELL_AURA_APPLIED_DOSE 158553",
	"SPELL_AURA_REMOVED 158605 164176 164178 164191",
	"SPELL_PERIODIC_DAMAGE 157353",
	"SPELL_PERIODIC_MISSED 157353"
)

--TODO, probably add range 5 for http://beta.wowhead.com/spell=157769 during first intermission.
--TODO, probably add http://beta.wowhead.com/spell=158547 for second intermission
--TODO, probably add timer for Volatile Anomalies in both intermissions (12 second timer)
--Phase 1: Might of the Crown
local warnArcaneWrath							= mod:NewSpellAnnounce(156238, 3)
local warnDestructiveResonance					= mod:NewSpellAnnounce(156467, 4)--Find out if target scanning works
local warnMarkOfChaos							= mod:NewTargetAnnounce(158605, 4)
local warnForceNova								= mod:NewSpellAnnounce(157349, 3)
local warnSummonArcaneAberration				= mod:NewSpellAnnounce(156471, 3)
--Phase 2: Rune of Displacement
local warnArcaneWrathDisplacement				= mod:NewSpellAnnounce(163988, 3)
local warnDestructiveResonanceDisplacement		= mod:NewSpellAnnounce(164075, 4)--Find out if target scanning works
local warnMarkOfChaosDisplacement				= mod:NewTargetAnnounce(164176, 4)
local warnForceNovaDisplacement					= mod:NewSpellAnnounce(164232, 3)
local warnSummonDisplacingArcaneAberration		= mod:NewSpellAnnounce(164299, 3)
--Intermission: Dormant Runestones
local warnFixate								= mod:NewTargetAnnounce(157763, 3)
--Phase 3: Rune of Fortification
local warnArcaneWrathFortification				= mod:NewSpellAnnounce(163989, 3)
local warnDestructiveResonanceFortification		= mod:NewSpellAnnounce(164076, 4)--Find out if target scanning works
local warnMarkOfChaosFortification				= mod:NewTargetAnnounce(164178, 4)
local warnForceNovaFortification				= mod:NewSpellAnnounce(164235, 3)
local warnSummonFortifiedArcaneAberration		= mod:NewSpellAnnounce(164301, 3)
--Intermission: Lineage of Power
local warnKickToTheFace							= mod:NewSpellAnnounce(158563, 3)
local warnCrushArmor							= mod:NewStackAnnounce(158553, 2, nil, mod:IsTank())
--Phase 4: Rune of Replication
local warnArcaneWrathReplication				= mod:NewSpellAnnounce(163990, 3)
local warnDestructiveResonanceReplication		= mod:NewSpellAnnounce(164077, 4)--Find out if target scanning works
local warnMarkOfChaosReplication				= mod:NewTargetAnnounce(164191, 4)
local warnForceNovaReplication					= mod:NewSpellAnnounce(164240, 3)
local warnSummonReplicatingArcaneAberration		= mod:NewSpellAnnounce(164303, 3)

--Phase 1: Might of the Crown
local specWarnDestructiveResonance				= mod:NewSpecialWarningSpell(156467, nil, nil, nil, 3)--If target scanning works make this personal.
local specWarnMarkOfChaos						= mod:NewSpecialWarningMoveAway(158605, nil, nil, nil, 3)
local specWarnForceNova							= mod:NewSpecialWarningMove(157353)--All use this version? I can't find other damage IDs
--Phase 2: Rune of Displacement
local specWarnDestructiveResonanceDisplacement	= mod:NewSpecialWarningSpell(164075, nil, nil, nil, 3)--If target scanning works make this personal.
local specWarnMarkOfChaosDisplacement			= mod:NewSpecialWarningMoveAway(164176, nil, nil, nil, 3)
--Intermission: Dormant Runestones
local specWarnFixate							= mod:NewSpecialWarningYou(157763)--Change to run warning?
--Phase 3: Rune of Fortification
local specWarnDestructiveResonanceFortification	= mod:NewSpecialWarningSpell(164076, nil, nil, nil, 3)--If target scanning works make this personal.
local specWarnMarkOfChaosFortification			= mod:NewSpecialWarningYou(164178)--Debuffed player can not move for this one
local yellMarkOfChaosFortification				= mod:NewYell(164178)--So give yell
local specWarnMarkOfChaosFortificationNear		= mod:NewSpecialWarningClose(164178, nil, nil, nil, 3)--And super important "near" warning.
--Intermission: Lineage of Power
local specWarnKickToTheFace						= mod:NewSpecialWarningSpell(158563, mod:IsTank())
--local specWarnCrushArmor						= mod:NewSpecialWarningStack(158553, nil, 3)--Stack count assumed, may be less
--local specWarnCrushArmorOther					= mod:NewSpecialWarningTaunt(158553)
--Phase 4: Rune of Replication
local specWarnDestructiveResonanceReplication	= mod:NewSpecialWarningSpell(164077, nil, nil, nil, 3)--If target scanning works make this personal.
local specWarnMarkOfChaosReplication			= mod:NewSpecialWarningYou(164191)--Debuffed player can not move for this one
local yellMarkOfChaosReplication				= mod:NewYell(164191)--Give a yell to this one too since balls form at that location of player

--All Phases (No need to use different timers for empowered abilities. Short names better for timers.)
--local timerArcaneWrathCD						= mod:NewNextTimer(30, 156238)
--local timerDestructiveResonanceCD				= mod:NewNextTimer(30, 156467)
--local timerMarkOfChaosCD						= mod:NewNextTimer(30, 158605)
--local timerForceNovaCD						= mod:NewNextTimer(30, 157349)
--local timerSummonArcaneAberrationCD			= mod:NewNextTimer(30, 156471)

mod:AddRangeFrameOption(35, 158605)

local chaosDebuff1 = GetSpellInfo(158605)
local chaosDebuff2 = GetSpellInfo(164176)
local chaosDebuff3 = GetSpellInfo(164178)
local chaosDebuff4 = GetSpellInfo(164191)
local UnitDebuff = UnitDebuff
local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, chaosDebuff1) or UnitDebuff(uId, chaosDebuff2) or UnitDebuff(uId, chaosDebuff3) or UnitDebuff(uId, chaosDebuff4) then
			return true
		end
	end
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156238 then
		warnArcaneWrath:Show()
	elseif spellId == 163988 then
		warnArcaneWrathDisplacement:Show()
	elseif spellId == 163989 then
		warnArcaneWrathFortification:Show()
	elseif spellId == 163990 then
		warnArcaneWrathReplication:Show()
	-----
	elseif spellId == 156467 then
		warnDestructiveResonance:Show()
		specWarnDestructiveResonance:Show()
	elseif spellId == 164075 then
		warnDestructiveResonanceDisplacement:Show()
		specWarnDestructiveResonanceDisplacement:Show()
	elseif spellId == 164076 then
		warnDestructiveResonanceFortification:Show()
		specWarnDestructiveResonanceFortification:Show()
	elseif spellId == 164077 then
		warnDestructiveResonanceReplication:Show()
		specWarnDestructiveResonanceReplication:Show()
	-----
	elseif spellId == 157349 then
		warnForceNova:Show()
	elseif spellId == 164232 then
		warnForceNovaDisplacement:Show()
	elseif spellId == 164235 then
		warnForceNovaFortification:Show()
	elseif spellId == 164240 then
		warnForceNovaReplication:Show()
	-----
	elseif spellId == 156471 and self:AntiSpam(3, 1) then
		warnSummonArcaneAberration:Show()
	elseif spellId == 164299 and self:AntiSpam(3, 1) then
		warnSummonDisplacingArcaneAberration:Show()
	elseif spellId == 164301 and self:AntiSpam(3, 1) then
		warnSummonFortifiedArcaneAberration:Show()
	elseif spellId == 164303 and self:AntiSpam(3, 1) then
		warnSummonReplicatingArcaneAberration:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158563 then
		warnKickToTheFace:Show()
		specWarnKickToTheFace:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(158605, 164176, 164178, 164191) then
		if spellId == 158605 then
			warnMarkOfChaos:Show(args.destName)
			if args:IsPlayer() then
				specWarnMarkOfChaos:Show()
			end
		elseif spellId == 164176 then
			warnMarkOfChaosDisplacement:Show(args.destName)
			if args:IsPlayer() then
				specWarnMarkOfChaosDisplacement:Show()
			end
		elseif spellId == 164178 then
			local targetname = args.destName
			warnMarkOfChaosFortification:Show(targetname)
			if args:IsPlayer() then
				specWarnMarkOfChaosFortification:Show()
				yellMarkOfChaosFortification:Yell()
			else
				if self:CheckNearby(35, targetname) then
					specWarnMarkOfChaosFortificationNear:Show(targetname)
				end
			end
		elseif spellId == 164191 then
			warnMarkOfChaosReplication:Show(args.destName)
			if args:IsPlayer() then
				specWarnMarkOfChaosReplication:Show()
				yellMarkOfChaosReplication:Yell()
			end
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", GetSpellInfo(spellId)) then--You have debuff, show everyone
				DBM.RangeCheck:Show(35, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(35, debuffFilter)
			end
		end
	elseif spellId == 157763 then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
		end
	elseif spellId == 158553 then
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
--[[		if amount >= 3 then
			if args:IsPlayer() then
				specWarnCrushArmor:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(158553)) and not UnitIsDeadOrGhost("player") then
					specWarnCrushArmorOther:Show(args.destName)
				end
			end
		end--]]
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(158605, 164176, 164178, 164191) and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 157353 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnForceNova:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]
