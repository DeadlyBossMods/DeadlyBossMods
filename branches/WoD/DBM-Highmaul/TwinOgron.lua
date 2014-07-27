local mod	= DBM:NewMod(1148, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78238, 78237)--Pol 78238, Phemos 78237
mod:SetEncounterID(1719)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 158057 157943 158134 158093 158200"
)

local warnEnfeeblingroar			= mod:NewCountAnnounce(158057, 3)
local warnWhirlwind					= mod:NewSpellAnnounce(157943, 3, nil, mod:IsMelee())
local warnShieldCharge				= mod:NewTargetAnnounce(158134, 4)--Target scanning assumed
local warnInterruptingShout			= mod:NewCastAnnounce(158093, 3)
local warnQuake						= mod:NewCountAnnounce(158200, 3)
--local warnPulverize					= mod:NewSpellAnnounce(158385, 3)--Too many spellids to guess. Investigate this after logs

local specWarnEnfeeblingRoar		= mod:NewSpecialWarningCount(158057)
local specWarnWhirlWind				= mod:NewSpecialWarningRun(157943, mod:IsMelee())
local specWarnShieldCharge			= mod:NewSpecialWarningYou(158134)
local specWarnShieldChargeNear		= mod:NewSpecialWarningClose(158134)
local yellShieldCharge				= mod:NewYell(158134)
local specWarnInterruptingShout		= mod:NewSpecialWarningCast(158093)
local specWarnQuake					= mod:NewSpecialWarningCount(158200, nil, nil, nil, 2)

--local timerEnfeeblingRoarCD		= mod:NewCDTimer(20, 158057)--Assumed less than 30sec because it lasts 30 seconds and stacks. 2 group rotation likely so probably 15-20sec CD
--local timerWhirlwindCD			= mod:NewCDTimer(20, 157943)
--local timerShieldChargeCD			= mod:NewCDTimer(20, 158134)
--local timerInterruptingShoutCD	= mod:NewCDTimer(20, 158093)
--local timerQuakeCD				= mod:NewCDTimer(20, 158200)

mod.vb.EnfeebleCount = 0
mod.vb.QuakeCount = 0

function mod:ShieldTarget(targetname, uId)
	if not targetname then return end
	warnShieldCharge:Show(targetname)
	if targetname == UnitName("player") then
		specWarnShieldCharge:Show()
		yellShieldCharge:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnShieldChargeNear:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.EnfeebleCount = 0
	self.vb.QuakeCount = 0
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 147688 then
		self.vb.EnfeebleCount = self.vb.EnfeebleCount + 1
		warnEnfeeblingroar:Show(self.vb.EnfeebleCount)
		specWarnEnfeeblingRoar:Show(self.vb.EnfeebleCount)
		if self.vb.EnfeebleCount == 2 then--Atlernate 1 2 1 2 until have better understanding of mechanic, timing and strategy
			self.vb.EnfeebleCount = 0
		end
	elseif spellId == 157943 then
		warnWhirlwind:Show()
		specWarnWhirlWind:Show()
	elseif spellId == 158134 then
		self:BossTargetScanner(78238, "ShieldTarget", 0.15, 16)--Long cast, scan for a while in case it's a slow look, like sawblades were in SoO
	elseif spellId == 158093 then
		warnInterruptingShout:Show()
		specWarnInterruptingShout:Show()
	elseif spellId == 158200 then
		self.vb.QuakeCount = self.vb.QuakeCount + 1
		warnQuake:Show(self.vb.QuakeCount)
		specWarnQuake:Show(self.vb.QuakeCount)
		if self.vb.QuakeCount == 3 then--Assume standard 3 healer Cd rotation, where group 1 is back up for 4th.
			self.vb.QuakeCount = 0
		end
	end
end
--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 147824 then--Tower Spell
		warnMuzzleSpray:Show()
		specWarnMuzzleSpray:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 147068 then

	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 147029 then
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 147068 then
	end
end


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
