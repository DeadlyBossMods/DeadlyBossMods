local mod	= DBM:NewMod(677, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60399, 60400)--60396 (Rage), 60397 (Strength), 60398 (Courage), 60480 (Titan Spark), 60399 (Qin-xi), 60400 (Jan-xi)
mod:SetModelID(41391)
mod:SetZone()

mod:RegisterCombat("emote", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_POWER"
)

--Rage
local warnRageActivated			= mod:NewSpellAnnounce("ej5678", 3, 116525)
local warnFocusedAssault		= mod:NewTargetAnnounce(116525, 2, nil, false)--Completely and totally spammy, this option is just here for those that want this info despite the spam.
--Strength
local warnStrengthActivated		= mod:NewSpellAnnounce("ej5677", 3, 116550)
local warnEnergizingSmash		= mod:NewSpellAnnounce(116550, 3, nil, false)--Also might be spammy
--Courage
local warnCourageActivated		= mod:NewSpellAnnounce("ej5676", 3, 116778)
local warnFocusedDefense		= mod:NewTargetAnnounce(116778, 4)
--Sparks (Heroic Only)
local warnSpark					= mod:NewCountAnnounce("ej5674", 3)--Probably not very accurate. Not without wasting stupid amounts of cpu same way we do on spine. :\
local warnFocusedEnergy			= mod:NewTargetAnnounce(116829, 4)
--Jan-xi and Qin-xi
local warnBossesActivated		= mod:NewSpellAnnounce("ej5726", 3, 116815)
local warnArcLeft				= mod:NewCountAnnounce(116968, 3, nil, false)--Mostly informative, we cannot detect cast starts, only cast finishes, which is basically too late to pre warn :\
local warnArcRight				= mod:NewCountAnnounce(116971, 3, nil, false)
local warnArcCenter				= mod:NewCountAnnounce(116968, 4, nil, false)
local warnStomp					= mod:NewCountAnnounce(116969, 4, nil, false)

--Rage
local specWarnFocusedAssault	= mod:NewSpecialWarningYou(116525, false)
--Strength
local specWarnStrengthActivated	= mod:NewSpecialWarningSpell("ej5677", mod:IsTank())--These still need to be tanked. so give tanks special warning when these spawn, and dps can enable it too depending on dps strat.
--local specWarnEnergizingSmash	= mod:NewSpecialWarningMove(116550, mod:IsTank())--very hard to dodge, i'm not sure this will help yet. if it proves useless i'll remove it.
--Courage
local specWarnCourageActivated	= mod:NewSpecialWarningSwitch("ej5676", mod:IsDps())--These really need to die asap. If they reach the tank, you will have a dead tank on hands very soon after.
local specWarnFocusedDefense	= mod:NewSpecialWarningYou(116778)
--Jan-xi and Qin-xi
local specWarnBossesActivated	= mod:NewSpecialWarningSwitch("ej5726", mod:IsTank())
local specWarnCombo				= mod:NewSpecialWarningSpell("ej5672", nil, nil, nil, true)--No one in raid can get hit by this. So everyone needs to know about it.
--local specWarnArcCenter			= mod:NewSpecialWarningMove(116972, mod:IsTank())--Primary combo ability tanks need to avoid, currently not effective special warning, comes too late (cast finish, not cast start).
--local specWarnStomp				= mod:NewSpecialWarningMove(116969, mod:IsMelee())--Primary combo ability tanks AND melee need to avoid.

--Rage
local timerRageActivates		= mod:NewNextTimer(13, "ej5678", 116525)
--Strength
local timerStrengthActivates	= mod:NewNextTimer(13, "ej5677", 116550)
--Courage
local timerCourageActivates		= mod:NewNextTimer(13, "ej5676", 116778)
--Jan-xi and Qin-xi
local timerBossesActivates		= mod:NewNextTimer(103.2, "ej5726", 116815)--Might be a little funny sounding "Next Jan-xi and Qin-xi" May just localize it later.
local timerComboCD				= mod:NewNextTimer(19.2, "ej5672")--20 seconds after last one ENDED (or rathor, how long it takes to charge up 20 energy) We start timer at 1 energy though so more like 19 seconds.

local comboWarned = false
local sparkCount = 0
local comboCount = 0

function mod:OnCombatStart(delay)
	comboWarned = false
	sparkCount = 0
	comboCount = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(116525) then
		warnFocusedAssault:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedAssault:Show()
		end
	elseif args:IsSpellID(116778) then
		warnFocusedDefense:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedDefense:Show()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Rage or msg:find(L.Rage) then
		warnRageActivated:Schedule(13)
		timerRageActivates:Start()--They actually spawn 13 seconds after emote
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Strength or msg:find(L.Strength) then
		warnStrengthActivated:Schedule(13)
		specWarnStrengthActivated:Schedule(13)
		timerStrengthActivates:Start()--They actually spawn 13 seconds after emote
	elseif msg == L.Courage or msg:find(L.Courage) then
		warnCourageActivated:Schedule(13)
		specWarnCourageActivated:Schedule(13)
		timerCourageActivates:Start()--They actually spawn 13 seconds after emote
	elseif msg == L.Boss or msg:find(L.Boss) then
		warnBossesActivated:Schedule(13)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 116556 and self:AntiSpam(2, 1) then--Energizing Smash, This is only detectable off your CURRENT target or mouseover, which means, if you are detecting it, you're probably tanking it.
		warnEnergizingSmash:Show()
--		specWarnEnergizingSmash:Show()
	elseif spellId == 116968 and self:AntiSpam(2, 2) then--Arc Left
		comboCount = comboCount + 1
		warnArcLeft:Show(comboCount)
	elseif spellId == 116971 and self:AntiSpam(2, 3) then--Arc Right
		comboCount = comboCount + 1
		warnArcRight:Show(comboCount)
	elseif spellId == 116972 and self:AntiSpam(2, 4) then--Arc Center
		comboCount = comboCount + 1
		warnArcCenter:Show(comboCount)
--		specWarnArcCenter:Show()
	elseif spellId == 116969 and self:AntiSpam(2, 5) then--Stomp
		comboCount = comboCount + 1
		warnStomp:Show(comboCount)
--		specWarnStomp:Show()

	--Not most accurate way to detect sparks, as both depend on SOMEONE in raid to be targeting the mob creating spark, or the spark that's dying.
	--However, FAR more cpu efficent then scanning ALL spell/swing damage and miss events entire fight.
	--Should be accurate enough with syncing, we'll see.
	elseif spellId == 117746 then--Spark Spawning
		self:SendSync("SparkSpawned")
	end
end

--Although, again, it might fail in sync handler antispam throttle if multiple spawn within a single second. Might need more work.
function mod:OnSync(msg)
	if msg == "SparkSpawned" then
		sparkCount = sparkCount + 1
		warnSpark:Show(sparkCount)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 60480 and sparkCount > 0 then--Titan Spark
		sparkCount = sparkCount - 1
		warnSpark:Show(sparkCount)
	end
end

--[[
"<121.7> MANA#0#1#20#0#0", -- [1]--Start Power Gain
"<138.5> MANA#0#18#20#0#0", -- [18]--Beware! here to give 2.4ish sec warning of incoming special.
"<139.7> MANA#0#19#20#0#0", -- [19]
"<140.5> MANA#0#20#20#0#0", -- [20]--Full Power
"<140.9> Qin-xi [boss2:Arc Right::0:116971]", -- [22]--Begin Combo
"<144.1> Qin-xi [boss2:Arc Center::0:116972]", -- [24]
"<149.8> Qin-xi [boss2:Stomp::0:116969]", -- [26]
"<150.6> Qin-xi [boss2:Arc Right::0:116971]", -- [28]
"<153.8> Qin-xi [boss2:Arc Left::0:116968]", -- [30]
"<157.0> Qin-xi [boss2:Arc Right::0:116971]", -- [31]
"<162.2> Qin-xi [boss2:Stomp::0:116969]", -- [33]
"<162.6> Qin-xi [boss2:Arc Center::0:116972]", -- [35]
"<166.3> Qin-xi [boss2:Arc Left::0:116968]", -- [37]
--]]
function mod:UNIT_POWER(uId)
	if (self:GetUnitCreatureId(uId) == 60399 or self:GetUnitCreatureId(uId) == 60400) and UnitPower(uId) == 18 and not comboWarned then
		comboWarned = true
	elseif (self:GetUnitCreatureId(uId) == 60399 or self:GetUnitCreatureId(uId) == 60400) and UnitPower(uId) == 1 then
		comboWarned = false
		comboCount = 0
		timerComboCD:Start()
	end
end
