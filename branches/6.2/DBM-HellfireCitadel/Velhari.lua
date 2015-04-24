local mod	= DBM:NewMod(1394, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90269)
mod:SetEncounterID(1784)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180260 180004 180533 180025 180608 180300",
	"SPELL_CAST_SUCCESS 181113 179986 179991 180600",
	"SPELL_AURA_APPLIED 182459 185241 180166 180164 185237 185238 180000 180526 180025",
	"SPELL_AURA_APPLIED_DOSE 180000",
	"SPELL_AURA_REMOVED 182459 185241 180166 180164 185237 185238",
	"SPELL_PERIODIC_DAMAGE 180604",
	"SPELL_ABSORBED 180604",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, find out if edict targets more than one player, if so, a move to warning/arrow isn't going to work.
--TODO, add icon option once i figure out above, as well as arrow, maybe hud.
--TODO, find some way to get annihilation strike target, scan, whisper, debuff, anything.
--TODO, figure out infernal tempest and improve radar
--All
local warnEdictofCondemnation				= mod:NewTargetAnnounce(182459, 3)
local warnTouchofHarm						= mod:NewTargetAnnounce(180166, 3, nil, "Healer")
local warnSealofDecay						= mod:NewStackAnnounce(180000, 2, nil, "Tank|Healer")
--Stage One: Oppression
local warnAnnihilationStrike				= mod:NewTargetAnnounce(180260, 4)
--Stage Two: Contempt
local warnAuraofContempt					= mod:NewSpellAnnounce(179986, 3)
local warnTaintedShadows					= mod:NewSpellAnnounce(180533, 2)
local warnFontofCorruption					= mod:NewTargetAnnounce(180526, 3)
--Stage Three: Malice
local warnAuraofMalice						= mod:NewSpellAnnounce(179991, 3)
local warnBulwarkoftheTyrant				= mod:NewSpellAnnounce(180600, 2)

--All
local specWarnEdictofCondemnation			= mod:NewSpecialWarningYou(182459)
local yellEdictofCondemnation				= mod:NewYell(182459)
--local specWarnEdictofCondemnationOther	= mod:NewSpecialWarningMoveTo(182459, false)
local specWarnTouchofHarm					= mod:NewSpecialWarningTarget(180166, false)
--Stage One: Oppression
local specWarnAnnihilatingStrike			= mod:NewSpecialWarningYou(180260)
local specWarnAnnihilatingStrikeNear		= mod:NewSpecialWarningClose(180260)
local yellAnnihilatingStrike				= mod:NewYell(180260)
local specWarnInfernalTempest				= mod:NewSpecialWarningSpell(180300, nil, nil, nil, 2)
----Ancient Enforcer
local specWarnAncientEnforcer				= mod:NewSpecialWarningSwitch("ej11155", "-Healer")
local specWarnEnforcersOnslaught			= mod:NewSpecialWarningRun(180004, "Melee", nil, nil, 4, nil, 2)
--Stage Two: Contempt
----Ancient Harbinger
local specWarnAncientHarbinger				= mod:NewSpecialWarningSwitch("ej11163", "-Healer")
local specWarnHarbingersMending				= mod:NewSpecialWarningInterrupt(180025, "-Healer", nil, nil, 2, nil, 2)
local specWarnHarbingersMendingDispel		= mod:NewSpecialWarningDispel(180025, "MagicDispeller")--if interrupt is missed (likely at some point, cast gets faster each time). Then it MUST be dispelled
--Stage Three: Malice
local specWarnDespoiledGround				= mod:NewSpecialWarningMove(180604)
local specWarnGaveloftheTyrant				= mod:NewSpecialWarningSpell(180608, nil, nil, nil, 2, nil, 2)
----Ancient Sovereign
local specWarnAncientSovereign				= mod:NewSpecialWarningSwitch("ej11170", "-Healer")

--All
--local timerEdictofCondemnationCD			= mod:NewCDTimer(107, 182459)
--local timerTouchofHarmCD					= mod:NewCDTimer(107, 180166)
--Stage One: Oppression
--local timerAnnihilatingStrikeCD			= mod:NewCDTimer(107, 180260)
----Ancient Enforcer
--local timerEnforcersOnslaughtCD			= mod:NewCDTimer(107, 180004, nil, "Melee")
--Stage Two: Contempt
--local timerTaintedShadowsCD				= mod:NewCDTimer(107, 180533)
----Ancient Harbinger
--local timerHarbingersMendingCD			= mod:NewCDTimer(107, 180025)
--Stage Three: Malice
--local timerBulwarkoftheTyrantCD			= mod:NewCDTimer(107, 180600)

--local berserkTimer						= mod:NewBerserkTimer(360)

--local countdownInfernoSlice				= mod:NewCountdown(12, 155080, "Tank")

local voiceHarbingersMending				= mod:NewVoice(180025)--kickcast/dispelboss
local voiceGaveloftheTyrant					= mod:NewVoice(180608)--carefly

mod:AddRangeFrameOption(5)--Seems like range 5 for all spells. I think for this fight it's basically a constant spread out fight for ranged. But melee?

--[[
local debuffFilter
do
	local debuffName = GetSpellInfo(155323)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end--]]

function mod:AnnTarget(targetname, uId)
	if not targetname then
		warnAnnihilationStrike:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnAnnihilatingStrike:Yell()
		specWarnProtoGrenade:Show()
	elseif self:CheckNearby(5, targetname) then
		specWarnAnnihilatingStrikeNear:Show(targetname)
	else
		warnAnnihilationStrike:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180260 then
		--specWarnAnnihilatingStrike:Show()
		--timerAnnihilatingStrikeCD:Start()
		self:BossTargetScanner(90269, "AnnTarget", 0.05, 20, true)
	elseif spellId == 180004 then
		specWarnEnforcersOnslaught:Show()
		--timerEnforcersOnslaughtCD:Start()
	elseif spellId == 180025 then--No target filter, it's only interrupt onfight and it's VERY important
		specWarnHarbingersMending:Show(args.sourceName)
		voiceHarbingersMending:Play("kickcast")
	elseif spellId == 180608 then--No target filter, it's only interrupt onfight and it's VERY important
		specWarnGaveloftheTyrant:Show(args.sourceName)
		voiceGaveloftheTyrant:Play("carefly")
	elseif spellId == 180300 then
		specWarnInfernalTempest:Show()
	end
end

--Not holding breath, but it'll be nice...
--If not, these guy will probably ise IEEU or an emote/yell
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181113 then--Encounter Spawn
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 91304 or cid == 90270 then--Ancient Enforcer
			specWarnAncientEnforcer:Show()
			--timerEnforcersOnslaughtCD:Start()
		elseif cid == 91302 or cid == 90271 then--Ancient Harbinger
			specWarnAncientHarbinger:Show()
			--timerHarbingersMendingCD:Start()
		elseif cid == 91303 or cid == 90272 then--Ancient Sovereign
			specWarnAncientSovereign:Show()
		end
	elseif spellId == 179986 then--Aura of Contempt (phase 2)
		warnAuraofContempt:Show()
		--Cancel phase 1 abilities timers on non mythic? journal is just not remotely useful. It does kind of hint that she retains previous phase aura on mythic though
		--if not self:IsMythic() then
			--timerAnnihilatingStrikeCD:Cancel()
		--end
		--timerTaintedShadowsCD:Start()
	elseif spellId == 180533 then
		warnTaintedShadows:Show()
		--timerTaintedShadowsCD:Start()
	elseif spellId == 179991 then--Aura of Malice (phase 3)
		warnAuraofMalice:Show()
		--if not self:IsMythic() then
			--timerTaintedShadowsCD:Cancel()
		--end
		--timerBulwarkoftheTyrantCD:Start()
	elseif spellId == 180600 then
		warnBulwarkoftheTyrant:Show()
		--timerBulwarkoftheTyrantCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182459 or spellId == 185241 then--185241 mythic root version
		warnEdictofCondemnation:CombinedShow(0.3, args.destName)--Multiple?
		if args:IsPlayer() then
			specWarnEdictofCondemnation:Show()
			yellEdictofCondemnation:Yell()
		end
	elseif args:IsSpellID(180166, 180164, 185237, 185238) then--4 versions seem to exist, From what I can see it's 2 versions mythic, 2 versions non mythic. One version is apply from boss, one is jumped from player to player (dispel)
		if self.Options.SpecWarn180166target then
			specWarnTouchofHarm:CombinedShow(0.3, args.destName)
		else
			warnTouchofHarm:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 180000 and self:AntiSpam(3, 1) then--Antispam temp, analyze stack counts and do it properly after combat data.
		local amount = args.amount or 1
		warnSealofDecay:Show(args.destName, amount)
	elseif spellId == 180526 then
		warnFontofCorruption:CombinedShow(0.3, args.destName)--One target?
	elseif spellId == 180025 then
		specWarnHarbingersMendingDispel:Show(args.destName)
		voiceHarbingersMending:Play("dispelboss")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 182459 or spellId == 185241 then
		--For icon option, or something.
	elseif args:IsSpellID(180166, 180164, 185237, 185238) then
		--For icon option, but may need some work if more than 1 target affected at once at staggered times. maybe alternating 2 icons?
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 180604 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnDespoiledGround:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 91304 or cid == 90270 then--Ancient Enforcer
		--timerEnforcersOnslaughtCD:Cancel()
	elseif cid == 91302 or cid == 90271 then--Ancient Harbinger
		--timerHarbingersMendingCD:Cancel()
	elseif cid == 91303 or cid == 90272 then--Ancient Sovereign
		--Doesn't use anything interesting? Shield cd probably won't seem useful, but who knows
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end--]]

