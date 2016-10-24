local mod	= DBM:NewMod("CoSTrash", "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 209027 212031 209485 209410 209413 211470 211464 209404 209495 225100 211299",
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
local voiceChargingStation			= mod:NewVoice(225100, "HasInterrupt")--kickcast
local voiceSearingGlare				= mod:NewVoice(211299, "HasInterrupt")--kickcast
local voiceFelDetonation			= mod:NewVoice(211464, false, nil, 2)--aesoon
local voiceSealMagic				= mod:NewVoice(209404, "Melee")--runout
local voiceDisruptingEnergy			= mod:NewVoice(209512)--runaway

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("SpyHelper", true)

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
	local hints = {}
	local clues = {
		["There's a rumor that the spy always wears gloves."] = "gloves",
		["I heard the spy carefully hides their hands."] = "gloves",
		["I heard the spy always dons gloves."] = "gloves",
		["Someone said the spy wears gloves to cover obvious scars."] = "gloves",
		["There's a rumor that the spy never has gloves on."] = "no gloves",
		["You know... I found an extra pair of gloves in the back room. The spy is likely to be bare handed somewhere around here."] = "no gloves",
		["I heard the spy dislikes wearing gloves."] = "no gloves",
		["I heard the spy avoids having gloves on, in case some quick actions are needed"] = "no gloves",
		["Someone mentioned the spy came in earlier wearing a cape."] = "cape",
		["I heard the spy enjoys wearing capes."] = "cape",
		["I heard the spy dislikes capes and refuses to wear one."] = "no cape",
		["I heard that the spy left their cape in the palace before coming here."] = "no cape",
		["I heard the spy carries a magical pouch around at all times."] = "pouch",
		["A friend said the spy loves gold and a belt pouch filled with it."] = "pouch",
		["The spy definitely prefers the style of light colored vests."] = "light vest",
		["I heard that the spy is wearing a lighter vest to tonight's party."] = "light vest",
		["People are saying the spy is not wearing a darker vest tonight."] = "light vest",
		["The spy definitely prefers darker clothing."] = "dark vest",
		["I heard the spy's vest is a dark, rich shade this very night."] = "dark vest",
		["The spy enjoys darker colored vests... like the night."] = "dark vest",
		["Rumor has it the spy is avoiding light colored clothing to try and blend in more."] = "dark vest",
		["They say that the spy is here and she's quite the sight to behold."] = "female",
		["I hear some woman has been constantly asking about the district..."] = "female",
		["Someone's been saying that our new guest isn't male."] = "female",
		["They say that the spy is here and she's quite the sight to behold."] = "female",
		["I heard somewhere that the spy isn't female."] = "male",
		["I heard the spy is here and he's very good looking."] = "male",
		["A guest said she saw him entering the manor alongside the Grand Magistrix."] = "male",
		["One of the musicians said he would not stop asking questions about the district."] = "male",
		["I heard the spy wears short sleeves to keep their arms unencumbered."] = "short sleeves",
		["Someone told me the spy hates wearing long sleeves."] = "short sleeves",
		["A friend of mine said she saw the outfit the spy was wearing. It did not have long sleeves."] = "short sleeves",
		["I heard the spy's outfit has long sleeves tonight."] = "long sleeves",
		["Someone said the spy is covering up their arms with long sleeves tonight."] = "long sleeves",
		["I just barely caught a glimpse of the spy's long sleeves earlier in the evening."] = "long sleeves",
		["A friend of mine mentioned the spy has long sleeves on."] = "long sleeves",
		["I heard the spy enjoys the cool air and is not wearing long sleeves tonight."] = "short sleeves",
		["I heard the spy brought along potions, I wonder why?"] = "potions",
		["I didn't tell you this... but the spy is masquerading as an alchemist and carrying potions at the belt."] = "potions",
		["I'm pretty sure the spy has potions at the belt."] = "potions",
		["I heard the spy always has a book of written secrets at the belt."] = "book",
		["Rumor has is the spy loves to read and always carries around at least one book."] = "book",
		["I heard the spy's belt pouch is filled with gold to show off extravagance."] = "pouch",
		["I heard the spy carries a magical pouch around at all times."] = "pouch",
		["I heard the spy's belt pouch is lined with fancy threading."] = "pouch",
		["A friend said the spy loves gold and a belt pouch filled with it."] = "pouch",
		["I heared the spy is not carrying any potions around."] = "no potion",
		["A musician told me she saw the spy throw away their last potion and no longer has any left."] = "no potion"
	}

	local function updateInfoFrame()
		local lines = {}

		for hint, j in pairs(hints) do
			lines[hint] = ""
		end
		
		return lines
	end
	
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
					SendChatMessage(clue, "PARTY")
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
