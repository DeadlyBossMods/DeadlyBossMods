local mod	= DBM:NewMod(671, "DBM-Party-MoP", 9, 316)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59223)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warnFlyingKick		= mod:NewSpellAnnounce(113764, 4)--This is always followed instantly by Firestorm kick, so no reason to warn both.
local warnBlazingFists		= mod:NewSpellAnnounce(114807, 3)
--local warnScorchedEarth		= mod:NewCountAnnounce(114460, 3)--only aoe warn will be enough.

--local yellFlyingKick		= mod:NewYell(114487)
local specWarnFlyingKick	= mod:NewSpecialWarningSpell(113764, nil, nil, nil, true)
--local specWarnFlyingKickNear= mod:NewSpecialWarningClose(114487)
local specWarnScorchedEarth	= mod:NewSpecialWarningMove(114460)
local specWarnBlazingFists	= mod:NewSpecialWarningMove(114807, mod:IsTank()) -- Everything is dangerous in challenge mode, entry level heriocs will also be dangerous when they aren't overtuning your gear with an ilvl buff.if its avoidable, you should avoid it, in good practice, to create good habit for challenge modes.

local timerFlyingKickCD		= mod:NewCDTimer(25, 113764)--25-30 second variation
local timerFirestormKick	= mod:NewBuffActiveTimer(6, 113764)
local timerBlazingFistsCD	= mod:NewNextTimer(30, 114807)

mod:AddBoolOption("KickArrow", true)

function mod:OnCombatStart(delay)
	timerFlyingKickCD:Start(10-delay)
	timerBlazingFistsCD:Start(20.5-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 113764 then
		--[[if args:IsPlayer() then
			specWarnFlyingKick:Show()
			yellFlyingKick:Yell()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 8 then
					specWarnFlyingKickNear:Show(args.destName)
					if self.Options.KickArrow then
						DBM.Arrow:ShowRunAway(x, y, 8, 5)
					end
				end
			end
		end]]
		warnFlyingKick:Show()
		specWarnFlyingKick:Show()
		timerFirestormKick:Start()
		timerFlyingKickCD:Start()
	elseif args.spellId == 114807 then
		warnBlazingFists:Show()
		specWarnBlazingFists:Show()
		timerBlazingFistsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 114460 then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE",
			"SPELL_MISSED"
		)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if spellId == 114465 and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specWarnScorchedEarth:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
