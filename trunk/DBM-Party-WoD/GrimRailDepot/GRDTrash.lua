local mod	= DBM:NewMod("GRDTrash", "DBM-Party-WoD", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 176025",
	"SPELL_CAST_START 166675 176032",
	"SPELL_PERIODIC_DAMAGE 176033 166340",
	"SPELL_PERIODIC_MISSED 176033 166340"
)

local warnLavaWreath					= mod:NewTargetAnnounce(176025, 4)
--local warnFlametongue					= mod:NewTargetAnnounce(176032, 4)--target scanning unverified
local warnShrapnelBlast					= mod:NewCastAnnounce(166675, 4)

local specWarnLavaWreath				= mod:NewSpecialWarningMoveAway(176025)
--local specWarnFlametongue				= mod:NewSpecialWarningYou(176032)
--local yellFlametongue					= mod:NewYell(176032)
local specWarnFlametongueGround			= mod:NewSpecialWarningMove(176033)--Ground aoe, may add an earlier personal warning if target scanning works.
local specWarnShrapnelblast				= mod:NewSpecialWarningMove(166675, mod:IsTank(), nil, nil, 3)--160943 boss version, 166675 trash version.
local specWarnThunderzone				= mod:NewSpecialWarningMove(166340)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:FlametongueTarget(targetname, uId)
	if not targetname then return end
--	warnFlametongue:Show(targetname)
	DBM:Debug("Flametongue possibly on "..targetname)
	if targetname == UnitName("player") then
--		specWarnFlametongue:Show()
--		yellFlametongue:Yell()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 176025 then
		warnLavaWreath:Show(args.destName)
		if args:IsPlayer() then
			specWarnLavaWreath:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 166675 and self:AntiSpam(2, 1) then
		warnShrapnelBlast:Show()
		specWarnShrapnelblast:Show()
	elseif spellId == 176032 then
		self:BossTargetScanner(args.sourceGUID, "FlametongueTarget", 0.05, 16)
		if self:IsTank() then
			specWarnFlametongueGround:Show()--Pre warn here for tanks, because this attack also massively buffs trash damage if they are standing in the fire too. Will improve if target scanning works
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 176033 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnFlametongueGround:Show()
	elseif spellId == 166340 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnThunderzone:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
