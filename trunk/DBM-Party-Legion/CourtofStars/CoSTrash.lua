local mod	= DBM:NewMod("CoSTrash", "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 209027 212031 209485 209410 209413 211470 211464 209404 209495",
	"SPELL_AURA_APPLIED 209033 209512"
)

--TODO, at least 1-2 more GTFOs I forgot names of
local specWarnFortification			= mod:NewSpecialWarningDispel(209033, "MagicDispeller", nil, nil, 1, 2)
local specWarnQuellingStrike		= mod:NewSpecialWarningDodge(209027, "Tank", nil, nil, 1, 2)
local specWarnChargedBlast			= mod:NewSpecialWarningDodge(212031, "Tank", nil, nil, 1, 2)
local specWarnChargedSmash			= mod:NewSpecialWarningDodge(209495, "Tank", nil, nil, 1, 2)
local specWarnDrainMagic			= mod:NewSpecialWarningInterrupt(209485, "HasInterrupt", nil, nil, 1, 2)
local specWarnNightfallOrb			= mod:NewSpecialWarningInterrupt(209410, "HasInterrupt", nil, nil, 1, 2)
local specWarnSuppress				= mod:NewSpecialWarningInterrupt(209413, "HasInterrupt", nil, nil, 1, 2)
local specWarnBewitch				= mod:NewSpecialWarningInterrupt(211470, "HasInterrupt", nil, nil, 1, 2)
local specWarnFelDetonation			= mod:NewSpecialWarningInterrupt(211464, "HasInterrupt", nil, nil, 1, 2)
local specWarnSealMagic				= mod:NewSpecialWarningRun(209404, "Melee", nil, nil, 4, 2)
local specWarnDisruptingEnergy		= mod:NewSpecialWarningMove(209512, nil, nil, nil, 1, 2)

local voiceFortification			= mod:NewVoice(209033, "MagicDispeller")--dispelnow
local voiceQuellingStrike			= mod:NewVoice(209027, "Tank")--shockwave
local voiceChargedBlast				= mod:NewVoice(212031, "Tank")--shockwave
local voiceChargedSmash				= mod:NewVoice(209495, "Tank")--chargemove
local voiceDrainMagic				= mod:NewVoice(209485, "HasInterrupt")--kickcast
local voiceNightfallOrb				= mod:NewVoice(209410, "HasInterrupt")--kickcast
local voiceSuppress					= mod:NewVoice(209413, "HasInterrupt")--kickcast
local voiceBewitch					= mod:NewVoice(211470, "HasInterrupt")--kickcast
local voiceFelDetonation			= mod:NewVoice(211464, "HasInterrupt")--kickcast
local voiceSealMagic				= mod:NewVoice(209404, "Melee")--runout
local voiceDisruptingEnergy			= mod:NewVoice(209512)--runaway

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 209027 then
		specWarnQuellingStrike:Show()
		voiceQuellingStrike:Play("shockwave")
	elseif spellId == 212031 then
		specWarnChargedBlast:Show()
		voiceChargedBlast:Play("shockwave")
	elseif spellId == 209485 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnDrainMagic:Show(args.sourceName)
		voiceDrainMagic:Play("kickcast")
	elseif spellId == 209410 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnNightfallOrb:Show(args.sourceName)
		voiceNightfallOrb:Play("kickcast")
	elseif spellId == 209413 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnSuppress:Show(args.sourceName)
		voiceSuppress:Play("kickcast")
	elseif spellId == 211470 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBewitch:Show(args.sourceName)
		voiceBewitch:Play("kickcast")
	elseif spellId == 211464 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFelDetonation:Show(args.sourceName)
		voiceFelDetonation:Play("kickcast")
	elseif spellId == 209404 then
		specWarnSealMagic:Show()
		voiceSealMagic:Play("runout")
	elseif spellId == 209495 then
		--Don't want to move too early, just be moving already as cast is finishing
		specWarnChargedSmash:Schedule(1.2)
		voiceChargedSmash:Schedule(1.2, "chargemove")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 209033 then
		specWarnFortification:Show(args.destName)
		voiceFortification:Play("dispelnow")
	elseif spellId == 209512 and args:IsPlayer() then
		specWarnDisruptingEnergy:Show()
		voiceDisruptingEnergy:Play("runaway")
	end
end
