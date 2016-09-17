local mod	= DBM:NewMod("AVHTrash", "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 204966 204963 205090",
	"SPELL_AURA_APPLIED 204962 205088",
	"SPELL_DAMAGE 204762",
	"SPELL_MISSED 204762",
	"UNIT_DIED"
--	"CHAT_MSG_MONSTER_YELL"
)

--TODO, change fel slam to dodge if tank can actually dodge it.
local warnSummonBeasts				= mod:NewSpellAnnounce(204966, 2)
local warnShadowBomb				= mod:NewTargetAnnounce(204962, 3)
--local warningPortalNow				= mod:NewAnnounce("WarningPortalNow", 2, 57687)
local warningPortalSoon				= mod:NewAnnounce("WarningPortalSoon", 1, 57687)
--local warningBossNow				= mod:NewAnnounce("WarningBossNow", 4, 33341)

local specWarnShadowBomb			= mod:NewSpecialWarningMoveAway(204962, nil, nil, nil, 1, 2)--Malgath bomb debuff.
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(204963, "HasInterrupt", nil, nil, 1, 2)--Malgath interruptable aoe
local specWarnHellfire				= mod:NewSpecialWarningInterrupt(205088, "HasInterrupt", nil, nil, 1, 2)--Infernal AOE
local specWarnFelSlam				= mod:NewSpecialWarningSpell(205090, "Tank", nil, nil, 2, 2)--Infernal frontal fel line/shockwave thingy
local specWarnFelEnergy				= mod:NewSpecialWarningMove(204762, nil, nil, nil, 2, 2)--Felguard Axe damage

local timerPortal					= mod:NewTimer(122, "TimerPortal", 57687, nil, nil, 6)
--local timerShieldDestruction		= mod:NewNextTimer(12.5, 202312, nil, nil, nil, 1)--Time between boss yell and shield coming down.

local voiceShadowBomb				= mod:NewVoice(204962)--runout
local voiceShadowBoltVolley			= mod:NewVoice(204963, "HasInterrupt")--kickcast
local voiceHellfire					= mod:NewVoice(205088, "HasInterrupt")--kickcast
local voiceFelSlam					= mod:NewVoice(205090, "Tank")--shockwave
local voiceFelEnergy				= mod:NewVoice(204762)--runaway

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 204966 and self:AntiSpam(2, 1) then
		warnSummonBeasts:Show()
	elseif spellId == 204963 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowBoltVolley:Show(args.sourceName)
		voiceShadowBoltVolley:Play("kickcast")
	elseif spellId == 205090 then
		specWarnFelSlam:Show()
		voiceFelSlam:Play("shockwave")
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

--I don't like using spell damage events in trash mods if I can help it, but this attack particularly bad, has no debuff, and cast doesn't appear in combat log
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if not self.Options.Enabled then return end
	if spellId == 204762 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFelEnergy:Show()
		voiceFelEnergy:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local z = self:GetCIDFromGUID(args.destGUID)
	if z == 102246 or z == 101995 or z == 101976 or z == 101950 or z == 102431 or z == 101951 then  -- bosses (at least one is missing, Saelorn)
		timerPortal:Start(30)--30-35
		warningPortalSoon:Schedule(25)
--	elseif z == 102336 or z == 102302 or z == 102335 then--Portal Keeper/Portal Guardian
--		timerPortal:Start(12)--8-12, nearly always 12
--		warningPortalSoon:Schedule(7)
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	--Boss only yells when he's spawning a boss (including himself), otherwise he's quiet
	if mob == L.Malgath then--Fact this has to be localized because blizzard didn't put him anywhere in journal, is stupid
		warningBossNow:Show()
		timerShieldDestruction:Start()
	end
end
--]]
