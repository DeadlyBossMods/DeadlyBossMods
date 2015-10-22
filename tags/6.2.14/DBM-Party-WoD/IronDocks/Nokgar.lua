local mod	= DBM:NewMod(1235, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81297, 81305)
mod:SetEncounterID(1749)
mod:SetZone()
mod:SetBossHPInfoToHighest(false)

mod:RegisterCombat("combat")

mod:SetBossHealthInfo(81297)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 164426 164835 164632",
	"SPELL_AURA_REMOVED 164426",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_TARGETABLE_CHANGED",
	"UNIT_DIED"
)

local warnNokgar						= mod:NewSpellAnnounce("ej10433", 3, "Interface\\ICONS\\INV_Misc_Head_Orc_01.blp")
local warnBurningArrows					= mod:NewSpellAnnounce(164635, 3)
local warnRecklessProvocation			= mod:NewTargetAnnounce(164426, 3)
local warnEnrage						= mod:NewSpellAnnounce(164835, 3, nil, "RemoveEnrage|Tank")

local specWarnBurningArrows				= mod:NewSpecialWarningSpell(164635, nil, nil, nil, 2)
local specWarnBurningArrowsMove			= mod:NewSpecialWarningMove(164635)
local specWarnRecklessProvocation		= mod:NewSpecialWarningReflect(164426)
local specWarnRecklessProvocationEnd	= mod:NewSpecialWarningEnd(164426)
local specWarnEnrage					= mod:NewSpecialWarningDispel(164835, "RemoveEnrage")

local timerRecklessProvocation			= mod:NewBuffActiveTimer(5, 164426)
--local timerBurningArrowsCD			= mod:NewNextTimer(25, 164635)--25~42 variable (patterned?)

local voiceRecklessProvocation			= mod:NewVoice(164426)
local voiceEnrage						= mod:NewVoice(164835, "RemoveEnrage")
local voiceBurningArrows				= mod:NewVoice(164632)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 164426 then
		warnRecklessProvocation:Show(args.destName)
		specWarnRecklessProvocation:Show(args.destName)
		timerRecklessProvocation:Start()
		voiceRecklessProvocation:Play("stopattack")
	elseif args.spellId == 164835 and self:AntiSpam(2, 1) then
		warnEnrage:Show()
		specWarnEnrage:Show(args.destName)
		voiceEnrage:Play("trannow") --multi sound
	elseif args.spellId == 164632 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnBurningArrowsMove:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 164426 then
		specWarnRecklessProvocationEnd:Show()
		voiceBurningArrows:Play("runaway")
	end
end

--Not detectable in phase 1. Seems only cleanly detectable in phase 2, in phase 1 boss has no "boss" unitid so cast hidden.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164635 then
		warnBurningArrows:Show()
		specWarnBurningArrows:Show()
		--timerBurningArrowsCD:Start()
	end
end

function mod:UNIT_TARGETABLE_CHANGED()
	warnNokgar:Show()
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:AddBoss(81305)
	end
end

function mod:UNIT_DIED(args)
	if not DBM.BossHealth:IsShown() then return end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 81297 then
		DBM.BossHealth:RemoveBoss(81297)
	end
end
