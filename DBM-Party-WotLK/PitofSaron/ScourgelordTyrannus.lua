local mod	= DBM:NewMod("ScourgelordTyrannus", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36658, 36661)
mod:SetUsedIcons(8)

mod:RegisterCombat("yell", L.CombatStart)
mod:RegisterKill("yell", L.YellCombatEnd)
mod:SetMinCombatTime(20)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_PERIODIC_DAMAGE"
)

local warnUnholyPower			= mod:NewSpellAnnounce(69629)
local warnForcefulSmash			= mod:NewSpellAnnounce(69627)
local warnOverlordsBrand		= mod:NewTargetAnnounce(69172)
local specWarnIcyBlast			= mod:NewSpecialWarning("specWarnIcyBlast")

local warnHoarfrost				= mod:NewSpellAnnounce(69246)
local specWarnHoarfrost			= mod:NewSpecialWarning("specWarnHoarfrost")
local specWarnHoarfrostNear		= mod:NewSpecialWarning("specWarnHoarfrostNear")

local timerCombatStart			= mod:NewTimer(31, "TimerCombatStart")--when I get the exact timing of rollplay, I will uncomment this.
local timerOverlordsBrand		= mod:NewTargetTimer(8, 69172)
local timerUnholyPowerCD		= mod:NewCDTimer(40, 69629) --40-45seconds between casts
local timerUnholyPower			= mod:NewBuffActiveTimer(10, 69629)
local timerForcefulSmash		= mod:NewCDTimer(40, 69627) --40-45seconds between casts

mod:AddBoolOption("SetIconOnHoarfrostTarget", true)

function mod:OnCombatStart(delay)
	timerCombatStart:Start(-delay)
	timerUnholyPowerCD:Start(-delay)
	timerForcefulSmash:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69629, 69167) then					-- Unholy Power
        warnUnholyPower:Show()
		timerUnholyPower:Start()
		timerUnholyPowerCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(69155, 69627) then					-- Forceful Smash
        warnForcefulSmash:Show()
        timerForcefulSmash:Start()
	end
end

do 
	local lasticyblast = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69238, 69628) and args:IsPlayer() and time() - lasticyblast > 2 then		-- Icy Blast, MOVE!
			specWarnIcyBlast:Show()
			lasticyblast = time()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69172) then							-- Overlord's Brand
		warnOverlordsBrand:Show(args.destName)
		timerOverlordsBrand:Show(args.destName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg and msg:match(L.HoarfrostTarget)
	if target then
		self:SendSync("Hoarfrost", target)
	end
end

function mod:OnSync(msg, target)
	if msg == "Hoarfrost" then
		if target == UnitName("player") then
			specWarnHoarfrost:Show()
		elseif target then
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnHoarfrostNear:Show()
				end
			end
		end
		if self.Options.SetIconOnHoarfrostTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end