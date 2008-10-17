local Felmyst = DBM:NewBossMod("Felmyst", DBM_FELMYST_NAME, DBM_FELMYST_DESCRIPTION, DBM_SUNWELL, DBM_SW_TAB, 3)

Felmyst.Version		= "0.3"
Felmyst.Author		= "Tandanu"


Felmyst:SetCreatureID(25038)
Felmyst:RegisterCombat("combat")

local pull = 0
local airPhase = false
local lastTarget = nil
local breathCounter = 0

Felmyst:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_SUMMON"
)


local isPriest = false
if select(2, UnitClass("player")) == "PRIEST" then
	isPriest = true
end
Felmyst:AddOption("SpecWarnNova", isPriest, DBM_FELMYST_OPTION_SPECGAS)
Felmyst:AddOption("GasSoonWarn", true, DBM_FELMYST_OPTION_GASSOON)
Felmyst:AddOption("BreathSoonWarn", true, DBM_FELMYST_OPTION_BREATH_SOON)
Felmyst:AddOption("VaporWarn", true, DBM_FELMYST_OPTION_VAPOR)

Felmyst:AddBarOption("Next Gas Nova")
Felmyst:AddBarOption("Gas Nova")

function Felmyst:OnCombatStart(delay)
	pull = GetTime()
	airPhase = false
	lastTarget = nil
	breathCounter = 0
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy") 
	self:ScheduleAnnounce(300 - delay, DBM_GENERIC_ENRAGE_WARN:format(5, DBM_MIN), 1)
	self:ScheduleAnnounce(420 - delay, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(540 - delay, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(570 - delay, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(590 - delay, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)

	self:StartStatusBarTimer(60 - delay, "Air Phase", "Interface\\AddOns\\DBM_API\\Textures\\CryptFiendUnBurrow")
	self:StartStatusBarTimer(17 - delay, "Next Gas Nova", 45855)
	if self.Options.GasSoonWarn then
		self:ScheduleAnnounce(14 - delay, DBM_FELMYST_WARN_GAS_SOON, 1)
	end
end

function Felmyst:OnEvent(event, args)
	if event == "SPELL_CAST_START" then
		if args.spellId == 45855 then
			self:SendSync("GasNova")
		end
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		if arg1 == DBM_FELMYST_EMOTE_BREATH then
			self:SendSync("Breath")
		end
	elseif event == "SPELL_SUMMON" then
		if args.spellId == 45392 then
			self:SendSync("Vapor"..tostring(args.sourceName))
		end
	end
end

local lastEncapsulate = 0
function Felmyst:OnSync(msg)
	if msg == "GasNova" then
		self:Announce(DBM_FELMYST_WARN_GAS, 3)
		if self.Options.SpecWarnNova then
			self:AddSpecialWarning(DBM_FELMYST_WARN_GAS)
		end
		self:StartStatusBarTimer(24, "Next Gas Nova", 45855)
		self:StartStatusBarTimer(1, "Gas Nova", 45855)
		if self.Options.GasSoonWarn then
			self:ScheduleAnnounce(21, DBM_FELMYST_WARN_GAS_SOON, 1)
		end
	elseif msg:sub(0, 6) == "Encaps" then
		msg = msg:sub(7)
		if GetTime() - lastEncapsulate > 7.5 then
			lastEncapsulate = GetTime()
			self:Announce(DBM_FELMYST_WARN_ENCAPS:format(msg), 2)
		end
		if msg == UnitName("player") then
			SendChatMessage(DBM_FELMYST_ENCAPS_WARN_SAY, "SAY")
		end
	elseif msg == "Air" and not airPhase then
		airPhase = GetTime()
		self:Announce(DBM_FELMYST_WARN_AIR, 1)		
		self:EndStatusBarTimer("Next Gas Nova")
		self:UnScheduleAnnounce(DBM_FELMYST_WARN_GAS_SOON, 1)
		
		self:ScheduleAnnounce(89, DBM_FELMYST_LAND_SOON, 1)
		self:StartStatusBarTimer(99, "Ground Phase", "Interface\\AddOns\\DBM_API\\Textures\\CryptFiendBurrow")
		self:ScheduleMethod(99, "SendSync", "Ground")
		
		if self.Options.BreathSoonWarn then
			self:ScheduleAnnounce(34, DBM_FELMYST_BREATH_SOON_FMT:format(1), 1)
		end
		self:StartStatusBarTimer(44, "Next Deep Breath", 37986)
	elseif msg == "Ground" then
		airPhase = false
		pull = GetTime()
		lastTarget = nil
		breathCounter = 0
		self:StartStatusBarTimer(60, "Air Phase", "Interface\\AddOns\\DBM_API\\Textures\\CryptFiendUnBurrow")
		self:StartStatusBarTimer(17, "Next Gas Nova", 45855)
		if self.Options.GasSoonWarn then
			self:ScheduleAnnounce(14, DBM_FELMYST_WARN_GAS_SOON, 1)
		end
	elseif msg == "Breath" then
		breathCounter = breathCounter + 1
		self:Announce(DBM_FELMYST_BREATH_NOW_FMT:format(breathCounter), 4)
		if breathCounter < 3 then
			if self.Options.BreathSoonWarn then
				self:ScheduleAnnounce(14, DBM_FELMYST_BREATH_SOON5_FMT:format(breathCounter + 1), 1)
			end
			self:StartStatusBarTimer(19, "Next Deep Breath", 37986)
		end
		self:StartStatusBarTimer(4, "Deep Breath", 37986)
	elseif msg:sub(0, 5) == "Vapor" then
		msg = msg:sub(6)
		if self.Options.VaporWarn then
			self:Announce(DBM_FELMYST_WARN_VAPOR:format(msg), 2)
		end
		self:SetIcon(msg, 25)
	end
end


function Felmyst:OnUpdate(elapsed)
	if not self.InCombat or GetTime() - pull < 10 then return end
	local foundBoss
	local hasTarget
	local target
	for i = 1, GetNumRaidMembers() do
		local j = 1
		while true do
			local name = UnitDebuff("raid"..i, j)
			j = j + 1
			if not name then
				break
			elseif name == GetSpellInfo(45665) then
				self:SendSync("Encaps"..UnitName("raid"..i))
			end
		end
		if not foundBoss and UnitName("raid"..i.."target") == DBM_FELMYST_NAME then
			foundBoss = true
			hasTarget = UnitExists("raid"..i.."targettarget") -- note: UnitName() might still return a valid name ("Demonic Vapor" or "Unknown")
			target = UnitName("raid"..i.."targettarget")
		end
	end
	
	if foundBoss and not hasTarget and not airPhase then
		self:SendSync("Air")
--	elseif foundBoss and airPhase and hasTarget and GetTime() - airPhase < 98 and target ~= lastTarget then --> useless
--		lastTarget = target
--		self:AddMsg(target, "Felmyst's target")
	end
end
