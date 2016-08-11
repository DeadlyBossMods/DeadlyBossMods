local mod	= DBM:NewMod(1500, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98207)
mod:SetEncounterID(1826)
mod:SetZone()
mod:SetUsedIcons(2, 1)

mod.onlyMythic = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 200284",
	"SPELL_AURA_REMOVED 200284",
	"SPELL_CAST_START 200227 200024",
	"SPELL_PERIODIC_DAMAGE 200040",
	"SPELL_PERIODIC_MISSED 200040",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1"
)

--TODO timers are iffy.
--TODO, blink scanning should work but may not if logic errors. May be spammy in certain situations such as pets/etc taunting boss
local warnBlink					= mod:NewTargetAnnounce(199811, 4)
local warnWeb					= mod:NewTargetAnnounce(200284, 3)

local specWarnBlink				= mod:NewSpecialWarningRun(199811, nil, nil, nil, 4, 2)
local yellBlink					= mod:NewYell(199811, nil, false)
local specWarnBlinkNear			= mod:NewSpecialWarningClose(199811, nil, nil, nil, 1, 2)
local specWarnVenomGTFO			= mod:NewSpecialWarningMove(199811, nil, nil, nil, 1, 2)

local timerBlinkCD				= mod:NewNextTimer(30, 199811, nil, nil, nil, 3)
local timerWebCD				= mod:NewCDTimer(21.8, 200227, nil, nil, nil, 3)--21-26
local timerVenomCD				= mod:NewCDTimer(30, 200024, nil, nil, nil, 3)--30-33

local voiceBlink				= mod:NewVoice(199811)--runaway
local voiceVenomGTFO			= mod:NewVoice(199811)--runaway

--mod:AddHudMapOption("HudMapOnBlink", 199811)
mod:AddSetIconOption("SetIconOnWeb", 200284)

mod.vb.blinkCount = 0

function mod:BlinkTarget(targetname, uId)
--	self:BossUnitTargetScannerAbort()
	if not targetname then 
		self:BossUnitTargetScanner("boss1", "BlinkTarget")
		return
	end
	if targetname == UnitName("player") then
		specWarnBlink:Show()
		voiceBlink:Play("runaway")
		yellBlink:Yell()
	elseif self:CheckNearby(5, targetname) and self:AntiSpam(2.5, 2) then--Near warning disabled on mythic, mythic mechanic requires being near it on purpose. Plus raid always stacked
		specWarnBlinkNear:Show(targetname)
		voiceBlink:Play("runaway")
	else
		warnBlink:Show(targetname)--No reason to show this if you got a special warning. so reduce spam and display this only to let you know jump is far away and you're safe
	end
	--self:BossTargetScanner(98207, "BlinkTarget", 0.1, 20, true, nil, nil, targetname)
--	if self.Options.HudMapOnBlink then
--		--Static marker, boss doesn't move once a target is picked. it's aimed at static location player WAS
--		DBMHudMap:RegisterStaticMarkerOnPartyMember(154989, "highlight", targetname, 5, 2.5, 1, 0, 0, 0.5, nil, 1):Pulse(0.5, 0.5)
--	end
end

function mod:OnCombatStart(delay)
	self.vb.blinkCount = 0
	timerBlinkCD:Start(15-delay)
	timerVenomCD:Start(21-delay)
	timerWebCD:Start(30-delay)
end

function mod:OnCombatEnd()
--	if self.Options.HudMapOnBlink then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 200284 then
		warnWeb:CombinedShow(0.5, args.destName)
		if self.Options.SetIconOnWeb and args:IsDestTypePlayer() then
			self:SetAlphaIcon(0.5, args.destName, 2)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 200284 and self.Options.SetIconOnWeb then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 200227 then
		timerWebCD:Start()
	elseif spellId == 200024 and self:AntiSpam(5, 3) then
		timerVenomCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 200040 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnVenomGTFO:Show()
		voiceVenomGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--"<53.44 00:02:07> [UNIT_SPELLCAST_SUCCEEDED] Nal'tira(Omegal) [[boss1:Blink Strikes::3-2084-1516-4913-199809-00064E8ACE:199809]]", -- [197]
--"<54.03 00:02:07> [UNIT_SPELLCAST_CHANNEL_START] Nal'tira(Dayani) - spell_mage_arcaneorb - 2.5sec [[boss1:Blink Strikes::0-0-0-0-0-0000000000:199811]]", -- [201]
--It's not that much slower to just use UNIT_SPELLCAST_CHANNEL_START target and ditch scanning Will leave it this way for now for the .6 second gain though
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 199809 then--Blink Strikes begin
		timerBlinkCD:Start()
		self.vb.blinkCount = 0
		self:BossUnitTargetScanner(uId, "BlinkTarget")
--		self:BossTargetScanner(98207, "BlinkTarget", 0.1, 20, true)--Filter tank on first jump
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 199811 then--Blink Strikes Channel ending
		self.vb.blinkCount = self.vb.blinkCount + 1
		if self.vb.blinkCount == 2 then
			self:BossUnitTargetScannerAbort()
		elseif self.vb.blinkCount == 1 then
			self:BossUnitTargetScanner(uId, "BlinkTarget")
		end
	end
end
