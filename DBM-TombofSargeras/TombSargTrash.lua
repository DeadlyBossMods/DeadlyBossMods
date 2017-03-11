local mod	= DBM:NewMod("TombSargTrash", "DBM-TombofSargeras")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 243171",
	"SPELL_CAST_SUCCESS 241360",
	"SPELL_AURA_APPLIED 240735 241362",
	"SPELL_AURA_APPLIED_DOSE"
)

--TODO, add jellyfish Static something, forgot to log it and don't remember name
--local warnDissonantMagic			= mod:NewStackAnnounce(240766, 2, nil, "Tank")
local warnPolyMorphBomb				= mod:NewTargetAnnounce(240735, 3)
local warnWateryGrave				= mod:NewTargetAnnounce(241362, 3)

--local specWarnDissonantMagic		= mod:NewSpecialWarningStack(240766, nil, 3, nil, nil, 1, 2)
--local specWarnDissonantMagicOther	= mod:NewSpecialWarningTaunt(240766, nil, nil, nil, 1, 2)
local specWarnPolyMorphBomb			= mod:NewSpecialWarningMoveAway(240735, nil, nil, nil, 1, 2)
local yellPolyMorphBomb				= mod:NewYell(240735)
local specWarnWateryGrave			= mod:NewSpecialWarningSwitch(241360, "-Healer", nil, nil, 1, 2)
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(243171, "HasInterrupt", nil, nil, 1, 2)

--local voiceDissonantMagic			= mod:NewVoice(240766)--tauntboss/stackhigh
local voicePolyMorphBomb			= mod:NewVoice(240735)--runout
local voiceWateryGrave				= mod:NewVoice(241360, "-Healer")--help?
local voiceShadowBoltVolley			= mod:NewVoice(243171, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 243171 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowBoltVolley:Show(args.sourceName)
		voiceShadowBoltVolley:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 241360 then
		specWarnWateryGrave:Show()
		voiceWateryGrave:Play("help")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240735 then
		if args:IsPlayer() then
			specWarnPolyMorphBomb:Show()
			voicePolyMorphBomb:Play("runout")
			yellPolyMorphBomb:Yell()
		else
			warnPolyMorphBomb:Show(args.destName)
		end
	elseif spellId == 241362 then
		warnWateryGrave:CombinedShow(0.3, args.destName)--Multiple targets assumed
--[[elseif spellId == 240766 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then--Lasts 30 seconds, cast every 5 seconds, swapping will be at 6
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnDissonantMagic:Show(amount)
					voiceDissonantMagic:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnDissonantMagicOther:Show(args.destName)
						voiceDissonantMagic:Play("tauntboss")
					else
						warnDissonantMagic:Show(args.destName, amount)
					end
				end
			else
				if amount % 2 == 0 then
					warnDissonantMagic:Show(args.destName, amount)
				end
			end
		end--]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
