local Akilzon = DBM:NewBossMod("Akilzon", DBM_AKIL_NAME, DBM_AKIL_DESCRIPTION, DBM_ZULAMAN, DBM_ZULAMAN_TAB, 2);

Akilzon.Version		= "1.0";
Akilzon.Author		= "Tandanu";

Akilzon:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

Akilzon:SetCreatureID(23574)
Akilzon:RegisterCombat("yell", DBM_AKIL_YELL_PULL)

Akilzon:AddOption("RangeCheck", true, DBM_AKIL_OPTION_RANGE)
Akilzon:AddBarOption("Enrage")
Akilzon:AddBarOption("Electrical Storm")

function Akilzon:OnCombatStart()
	self:StartStatusBarTimer(600, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy") 
	self:ScheduleAnnounce(300, DBM_GENERIC_ENRAGE_WARN:format(5, DBM_MIN), 1)
	self:ScheduleAnnounce(420, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(540, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(570, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(590, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)
	
	self:StartStatusBarTimer(49, "Electrical Storm", "Interface\\Icons\\Spell_Lightning_LightningBolt01")
	self:ScheduleAnnounce(44, DBM_AKIL_WARN_STORM_SOON, 1)
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show()
	end
end

function Akilzon:OnCombatEnd()
	DBM_Gui_DistanceFrame_Hide()
end

function Akilzon:OnEvent(event, args)
	if event == "SPELL_AURA_APPLIED" then
		if args.spellId == 43648 then
			local target = tostring(args.destName)
			if target then
				self:SendSync("Storm"..target)
			end
		end
	end
end

function Akilzon:OnSync(msg)
	if msg:sub(0, 5) == "Storm" then
		if self.Options.RangeCheck then
			DBM_Gui_DistanceFrame_Hide()
			self:Schedule(10, DBM_Gui_DistanceFrame_Show)
		end
		msg = msg:sub(6)
		self:Announce(DBM_AKIL_WARN_STORM_ON:format(msg), 2)
		self:SetIcon(msg, 10)
		self:StartStatusBarTimer(56, "Electrical Storm", "Interface\\Icons\\Spell_Lightning_LightningBolt01")
		self:ScheduleAnnounce(51, DBM_AKIL_WARN_STORM_SOON, 1)
		if msg == UnitName("player") then
			Minimap:PingLocation(CURSOR_OFFSET_X, CURSOR_OFFSET_Y)
		end
	end
end
