local mod	= DBM:NewMod(1227, "DBM-Party-WoD", 8, 559)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76021)
mod:SetEncounterID(1758)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 161203 162600",
	"SPELL_CAST_START 161199 161203",
	"SPELL_PERIODIC_DAMAGE 161288",
	"SPELL_PERIODIC_MISSED 161288",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnDeblitatingFixation		= mod:NewSpellAnnounce(161199, 2, nil, mod:IsTank())
local warnRejuvSerumCast			= mod:NewCastAnnounce(161203, 3)
local warnRejuvSerum				= mod:NewTargetAnnounce(161203, 4, nil, mod:IsMagicDispeller())
local warnToxicFumes				= mod:NewTargetAnnounce(162600, 3, nil, mod:IsHealer())
local warnVilebloodSerum			= mod:NewSpellAnnounce(161209, 3)--Some may think this is spammy but the puddles tick literally instantly giving not much time to move before 2nd tick which may kill you.

local specWarnDeblitatingFixation	= mod:NewSpecialWarningInterrupt(161199, mod:IsTank())--12 second cd, but tank can only interrupt every 15, hmm
local specWarnRejuvSerum			= mod:NewSpecialWarningDispel(161203, mod:IsMagicDispeller())
local specWarnToxicFumes			= mod:NewSpecialWarningDispel(162600, mod:IsHealer())
local specWarnVilebloodSerum		= mod:NewSpecialWarningMove(161288)

--local timerRejuvSerumCD			= mod:NewCDTimer(33, 161203, nil, mod:IsMagicDispeller())--33-40sec variation. Could also be health based so disabled for now.
local timerVilebloodSerumCD			= mod:NewCDTimer(9.5, 161209)--every 9-10 seconds

function mod:OnCombatStart(delay)
--	timerRejuvSerumCD:Start(29-delay)--Insufficent sample size
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 161203 and not args:IsDestTypePlayer() then
		warnRejuvSerum:Show(args.destName)
		specWarnRejuvSerum:Show(args.destName)
--		timerRejuvSerumCD:Start()
	elseif spellId == 162600 then
		warnToxicFumes:Show(args.destName)
		specWarnToxicFumes:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 161199 then
		warnDeblitatingFixation:Show()
		specWarnDeblitatingFixation:Show(args.sourceName)
	elseif args.spellId == 161203 then
		warnRejuvSerumCast:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 161288 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then--Goriona's Void zones
		specWarnVilebloodSerum:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--TODO, watch for blizzard to fix IEEU on this fight so we can use "boss1" instead
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
--	"<58.9 23:54:07> [UNIT_SPELLCAST_SUCCEEDED] Drakonid Monstrosity [[target:Vileblood Serum::0:161209]]", -- [1996]
	if spellId == 161209 and self:AntiSpam(3, 2) then
		self:SendSync("VileSerum")--Syncing because IEEU is broken on fight and so there is no "boss1"
	end
end

function mod:OnSync(event, arg)
	if event == "VileSerum" then
		warnVilebloodSerum:Show()
		timerVilebloodSerumCD:Start()
	end
end
