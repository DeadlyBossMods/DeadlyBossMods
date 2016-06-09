local mod	= DBM:NewMod("AVHTrash", "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 204966",
	"SPELL_AURA_APPLIED 204962 205088",
	"UNIT_DIED"
)

--TODO, portal announces and boss incoming announces and maybe timer for next portal after a boss dies. If blizz adds apis to do all this
--TODO, GTFO for the weapon felguard mobs throw that leave a circle on ground that does damage with no debuff.
local warnSummonBeasts				= mod:NewSpellAnnounce(204966, 2)
local warnShadowBomb				= mod:NewTargetAnnounce(204962, 3)
--local warningPortalNow				= mod:NewAnnounce("WarningPortalNow", 2, 57687)
local warningPortalSoon				= mod:NewAnnounce("WarningPortalSoon", 1, 57687)

local specWarnShadowBomb			= mod:NewSpecialWarningMoveAway(204962, nil, nil, nil, 1, 2)
local specWarnHellfire				= mod:NewSpecialWarningInterrupt(205088, "HasInterrupt", nil, nil, 1, 2)

local timerPortal					= mod:NewTimer(122, "TimerPortal", 57687, nil, nil, 6)

local voiceShadowBomb				= mod:NewVoice(204962)--runout
local voiceHellfire					= mod:NewVoice(205088, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 204966 and self:AntiSpam(2, 1) then
		warnSummonBeasts:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 204962 then
		if args:IsPlayer() then
			specWarnShadowBomb:Show()
			voiceShadowBomb:Play("runout")
		else
			warnShadowBomb:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 205088 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnHellfire:Show(args.sourceName)
		voiceHellfire:Play("kickcast")
	end
end

function mod:UNIT_DIED(args)
	local z = mod:GetCIDFromGUID(args.destGUID)
	if z == 102246 or z == 101995 or z == 101976 or z == 101950 or z == 102431 or z == 101951 then  -- bosses (at least one is missing, Saelorn)
		timerPortal:Start(30)--Guessed
		warningPortalSoon:Schedule(25)
	end
end
