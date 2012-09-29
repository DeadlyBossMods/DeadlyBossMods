local mod	= DBM:NewMod(657, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56541)
mod:SetModelID(39887)
mod:SetZone()

-- pre-bosswave. Novice -> Black Sash (Fragrant Lotus, Flying Snow). this runs automaticially.
-- maybe we need Black Sash wave warns.
-- but boss (Master Snowdrift) not combat starts automaticilly. 
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_WHISPER"
)

--Chi blast warns very spammy. and not useful.
local warnRemainingNovice	= mod:NewAnnounce("warnRemainingNovice", 2, 122863, false)
local warnFistsOfFury		= mod:NewSpellAnnounce(106853, 3)
local warnTornadoKick		= mod:NewSpellAnnounce(106434, 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnChaseDown			= mod:NewTargetAnnounce(118961, 3)--Targeting spell for Tornado Slam (106352)
-- phase3 ability not found yet.
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnFists			= mod:NewSpecialWarningMove(106853, mod:IsTank())
local specWarnChaseDown		= mod:NewSpecialWarningYou(118961)

local timerFistsOfFuryCD	= mod:NewCDTimer(23, 106853)--Not enough data to really verify this
local timerTornadoKickCD	= mod:NewCDTimer(32, 106434)--Or this
--local timerChaseDownCD		= mod:NewCDTimer(22, 118961)--Unknown
local timerChaseDown		= mod:NewTargetTimer(11, 118961)

local phase = 1
local remainingNovice = 20

function mod:OnCombatStart(delay)
	phase = 1
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(118961) then
		warnChaseDown:Show(args.destName)
		timerChaseDown:Start(args.destName)
--		timerChaseDownCD:Start()
		if args:IsPlayer() then
			specWarnChaseDown:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(118961) then
		timerChaseDown:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106853) then
		warnFistsOfFury:Show()
		specWarnFists:Show()
		timerFistsOfFuryCD:Start()
	elseif args:IsSpellID(106434) then
		warnTornadoKick:Show()
		timerTornadoKickCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.NovicesDefeated or msg:find(L.NovicesDefeated) then
		self:SendSync("NovicesEnd")
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:106774") then
		self:SendSync("NovicesStart")
	end
end

function mod:OnSync(msg)
	if msg == "NovicesStart" then--Does this function fail to alert second healer if 2 different paladins are grabbed within < 2.5 seconds?
		remainingNovice = 20
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE",
			"SWING_DAMAGE",
			"SPELL_PERIODIC_DAMAGE",
			"RANGE_DAMAGE"
		)
	elseif msg == "NovicesEnd" then
		self:UnregisterShortTermEvents()
	end
end

function mod:SWING_DAMAGE(_, _, _, _, destGUID, _, _, _, _, overkill)
	if (overkill or 0) > 0 then -- prevent to waste cpu. only pharse cid when event have overkill parameter.
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 56395 then--Hack for mobs that don't fire UNIT_DIED event.
			remainingNovice = remainingNovice - 1
			warnRemainingNovice:Show(remainingNovice)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if (overkill or 0) > 0 then -- prevent to waste cpu. only pharse cid when event have overkill parameter.
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 56395 then--Hack for mobs that don't fire UNIT_DIED event.
			remainingNovice = remainingNovice - 1
			warnRemainingNovice:Show(remainingNovice)
		end
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 110324 and self:AntiSpam(2) then
		phase = phase + 1
		if phase == 2 then
			warnPhase2:Show()
		elseif phase == 3 then
			warnPhase3:Show()
		end
		timerFistsOfFuryCD:Cancel()
		timerTornadoKickCD:Cancel()
	elseif spellId == 123096 and self:AntiSpam(2) then -- only first kill?
		DBM:EndCombat(self)
	end
end