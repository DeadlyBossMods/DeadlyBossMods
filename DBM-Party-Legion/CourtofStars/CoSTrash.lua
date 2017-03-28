local mod	= DBM:NewMod("CoSTrash", "DBM-Party-Legion", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 209027 212031 209485 209410 209413 211470 211464 209404 209495 225100 211299 209378",
	"SPELL_AURA_APPLIED 209033 209512",
	"GOSSIP_SHOW"
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
local specWarnChargingStation		= mod:NewSpecialWarningInterrupt(225100, "HasInterrupt", nil, nil, 1, 2)
local specWarnSearingGlare			= mod:NewSpecialWarningInterrupt(211299, "HasInterrupt", nil, nil, 1, 2)
local specWarnFelDetonation			= mod:NewSpecialWarningSpell(211464, false, nil, 2, 2, 2)
local specWarnSealMagic				= mod:NewSpecialWarningRun(209404, false, nil, 2, 4, 2)
local specWarnDisruptingEnergy		= mod:NewSpecialWarningMove(209512, nil, nil, nil, 1, 2)
local specWarnWhirlingBlades		= mod:NewSpecialWarningRun(209378, "Melee", nil, nil, 4, 2)

local voiceFortification			= mod:NewVoice(209033, "MagicDispeller")--dispelnow
local voiceQuellingStrike			= mod:NewVoice(209027, "Tank")--shockwave
local voiceChargedBlast				= mod:NewVoice(212031, "Tank")--shockwave
local voiceChargedSmash				= mod:NewVoice(209495, "Tank")--chargemove
local voiceDrainMagic				= mod:NewVoice(209485, "HasInterrupt")--kickcast
local voiceNightfallOrb				= mod:NewVoice(209410, "HasInterrupt")--kickcast
local voiceSuppress					= mod:NewVoice(209413, "HasInterrupt")--kickcast
local voiceBewitch					= mod:NewVoice(211470, "HasInterrupt")--kickcast
local voiceChargingStation			= mod:NewVoice(225100, "HasInterrupt")--kickcast
local voiceSearingGlare				= mod:NewVoice(211299, "HasInterrupt")--kickcast
local voiceFelDetonation			= mod:NewVoice(211464, false, nil, 2)--aesoon
local voiceSealMagic				= mod:NewVoice(209404, false, nil, 2)--runout
local voiceDisruptingEnergy			= mod:NewVoice(209512)--runaway
local voiceWhirlingBlades			= mod:NewVoice(209378, "Melee")--runout

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("SpyHelper", true)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 209027 and self:AntiSpam(2, 1) then
		specWarnQuellingStrike:Show()
		voiceQuellingStrike:Play("shockwave")
	elseif spellId == 212031 and self:AntiSpam(2, 2) then
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
	elseif spellId == 225100 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnChargingStation:Show(args.sourceName)
		voiceChargingStation:Play("kickcast")
	elseif spellId == 211299 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnSearingGlare:Show(args.sourceName)
		voiceSearingGlare:Play("kickcast")
	elseif spellId == 211464 then
		specWarnFelDetonation:Show()
		voiceFelDetonation:Play("aesoon")
	elseif spellId == 209404 then
		specWarnSealMagic:Show()
		voiceSealMagic:Play("runout")
	elseif spellId == 209495 then
		--Don't want to move too early, just be moving already as cast is finishing
		specWarnChargedSmash:Schedule(1.2)
		voiceChargedSmash:Schedule(1.2, "chargemove")
	elseif spellId == 209378 then
		specWarnWhirlingBlades:Show()
		voiceWhirlingBlades:Play("runout")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 209033 and not args:IsDestTypePlayer() then
		specWarnFortification:Show(args.destName)
		voiceFortification:Play("dispelnow")
	elseif spellId == 209512 and args:IsPlayer() then
		specWarnDisruptingEnergy:Show()
		voiceDisruptingEnergy:Play("runaway")
	end
end

do
	local hintTranslations = {
		["gloves"] = L.Gloves,
		["no gloves"] = L.NoGloves,
		["cape"] = L.Cape,
		["no cape"] = L.Nocape,
		["light vest"] = L.LightVest,
		["dark vest"] = L.DarkVest,
		["female"] = L.Female,
		["male"] = L.Male,
		["short sleeves"] = L.ShortSleeve,
		["long sleeves"] = L.LongSleeve,
		["potions"] = L.Potions,
		["no potion"] = L.NoPotions,
		["book"] = L.Book,
		["pouch"] = L.Pouch
	}
	local hints = {}
	local clues = {
		[L.Gloves1] = "gloves",
		[L.Gloves2] = "gloves",
		[L.Gloves3] = "gloves",
		[L.Gloves4] = "gloves",
		
		[L.NoGloves1] = "no gloves",
		[L.NoGloves2] = "no gloves",
		[L.NoGloves3] = "no gloves",
		[L.NoGloves4] = "no gloves",
		
		[L.Cape1] = "cape",
		[L.Cape2] = "cape",
		
		[L.NoCape1] = "no cape",
		[L.NoCape2] = "no cape",
		
		[L.LightVest1] = "light vest",
		[L.LightVest2] = "light vest",
		[L.LightVest3] = "light vest",
		
		[L.DarkVest1] = "dark vest",
		[L.DarkVest2] = "dark vest",
		[L.DarkVest3] = "dark vest",
		[L.DarkVest4] = "dark vest",
		
		[L.Female1] = "female",
		[L.Female2] = "female",
		[L.Female3] = "female",
		[L.Female4] = "female",
		
		[L.Male1] = "male",
		[L.Male2] = "male",
		[L.Male3] = "male",
		[L.Male4] = "male",
		
		[L.ShortSleeve1] = "short sleeves",
		[L.ShortSleeve2] = "short sleeves",
		[L.ShortSleeve3] = "short sleeves",
		[L.ShortSleeve4] = "short sleeves",
		
		[L.LongSleeve1] = "long sleeves",
		[L.LongSleeve2] = "long sleeves",
		[L.LongSleeve3] = "long sleeves",
		[L.LongSleeve4] = "long sleeves",
		
		[L.Potions1] = "potions",
		[L.Potions2] = "potions",
		[L.Potions3] = "potions",
		[L.Potions4] = "potions",
		
		[L.NoPotions1] = "no potion",
		[L.NoPotions2] = "no potion",
		
		[L.Book1] = "book",
		[L.Book2] = "book",
		
		[L.Pouch1] = "pouch",
		[L.Pouch2] = "pouch",
		[L.Pouch3] = "pouch",
		[L.Pouch4] = "pouch"
	}

	local function updateInfoFrame()
		local lines = {}
		for hint, j in pairs(hints) do
			local text = hintTranslations[hint] or hint
			lines[text] = ""
		end
		
		return lines
	end
	
	--/run DBM:GetModByName("CoSTrash"):ResetGossipState()
	function mod:ResetGossipState()
		table.wipe(hints)
		DBM.InfoFrame:Hide()
	end

	function mod:GOSSIP_SHOW()
		if not self.Options.SpyHelper then return end
		local guid = UnitGUID("target")
		if not guid then return end
		local cid = self:GetCIDFromGUID(guid)
	
		-- Disguise NPC
		if cid == 106468 then
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1)
				CloseGossip()
			end
		end
	
		-- Suspicious noble
		if cid == 107486 then 
			if select('#', GetGossipOptions()) > 0 then
				SelectGossipOption(1)
			else
				local clue = clues[GetGossipText()]
				if clue and not hints[clue] then
					CloseGossip()
					SendChatMessage(hintTranslations[clue], "PARTY")
					hints[clue] = true
					self:SendSync("CoS", clue)
					DBM.InfoFrame:Show(5, "function", updateInfoFrame)
				end
			end
		end
	end
	
	function mod:OnSync(msg, clue)
		if msg == "CoS" and clue and self.Options.SpyHelper then
			hints[clue] = true
			DBM.InfoFrame:Show(5, "function", updateInfoFrame)
		end
	end
end
