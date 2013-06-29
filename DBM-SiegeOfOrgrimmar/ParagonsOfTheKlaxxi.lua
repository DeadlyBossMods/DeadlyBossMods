local mod	= DBM:NewMod(853, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71152, 71153, 71154, 71155, 71156, 71157, 71158, 71160, 71161)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

--All
local warnActivated					= mod:NewTargetAnnounce(118212, 3, 143542)

--All
--NOTE, this is purely off assumption the ones that make you vunerable to eachother don't spawn at same time.
--It's also possible tehse tank only activate warnings are useless if 4 vulnerability mobs always spawns in pairs
--Then it just means it's an anti solo tank mechanic and we don't need special warnings for it.
local specWarnActivated				= mod:NewSpecialWarningTarget(118212)
local specWarnActivatedVulnerable	= mod:NewSpecialWarning("specWarnActivatedVunerable", mod:IsTank())--Alternate activate warning to warn a tank not to pick up a specific boss


local activatedTargets = {}--A table, for the 3 on pull

local function warnActivatedTargets(vulnerable)
	if #activatedTargets > 1 then
		warnActivated:Show(table.concat(activatedTargets, "<, >"))
		specWarnActivated:Show(table.concat(activatedTargets, ", "))
	else
		warnActivated:Show(activatedTargets[1])
		if vulnerable and mod:IsTank() then
			specWarnActivatedVulnerable:Show(activatedTargets[1])
		else
			specWarnActivated:Show(activatedTargets[1])
		end
	end
	table.wipe(activatedTargets)
end

function mod:OnCombatStart(delay)
--	table.wipe(activatedTargets)--iffy on wiping here so doing it on combat end instead
end

function mod:OnCombatEnd()
	table.wipe(activatedTargets)
end

--[[
function mod:SPELL_CAST_START(args)
	if args.spellId == 137399 then
		self:BossTargetScanner(69465, "FocusedLightningTarget", 0.025, 12)
		timerFocusedLightningCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 137162 then
		timerStaticBurstCD:Start()
	end
end--]]

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143542 then
		--A soon warning? Pull filtering needed?
		print("DBM Debug: Activation on "..args.destName.." next")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143542 then--Ready to Fight
		--Do first 3 fire before or after IEEU? mod functionality hinges on this being after :\
		--Otherwise, will just rewriting the activation controller to use IEEU
		activatedTargets[#activatedTargets + 1] = args.destName
		self:Unschedule(warnActivatedTargets)
		--Activation Controller
		local vulnerable = false
		local cid = args:GetDestCreatureID()
		if cid == 71161 then--Kil'ruk the Wind-Reaver
			if UnitDebuff("player", GetSpellInfo(142929)) then vulnerable = true end
		elseif cid == 71157 then--Xaril the Poisoned-Mind
			if UnitDebuff("player", GetSpellInfo(142931)) then vulnerable = true end
		elseif cid == 71156 then--Kaz'tik the Manipulator
		
		elseif cid == 71155 then--Korven the Prime
		
		elseif cid == 71160 then--Iyyokuk the Lucid
		
		elseif cid == 71154 then--Ka'roz the Locust
		
		elseif cid == 71152 then--Skeer the Bloodseeker
			if UnitDebuff("player", GetSpellInfo(143279)) then vulnerable = true end
		elseif cid == 71158 then--Rik'kal the Dissector
			if UnitDebuff("player", GetSpellInfo(143275)) then vulnerable = true end
		elseif cid == 71153 then--Hisek the Swarmkeeper
		
		end
		--Down here so we can send tank vulnerable status
		self:Schedule(0.3, warnActivatedTargets, vulnerable)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71161 then--Kil'ruk the Wind-Reaver
		
	elseif cid == 71157 then--Xaril the Poisoned-Mind
		
	elseif cid == 71156 then--Kaz'tik the Manipulator
		
	elseif cid == 71155 then--Korven the Prime
		
	elseif cid == 71160 then--Iyyokuk the Lucid
		
	elseif cid == 71154 then--Ka'roz the Locust
		
	elseif cid == 71152 then--Skeer the Bloodseeker
		
	elseif cid == 71158 then--Rik'kal the Dissector
		
	elseif cid == 71153 then--Hisek the Swarmkeeper
		
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
