local Muru = DBM:NewBossMod("Muru", DBM_MURU_NAME, DBM_MURU_DESCRIPTION, DBM_SUNWELL, DBM_SW_TAB, 5)

Muru.Version	= "0.9"
Muru.Author		= "Tandanu"
Muru.MinRevision = 1011

Muru:SetCreatureID(25741)
Muru:RegisterCombat("combat", 25840)

Muru:AddOption("VoidWarn", true, DBM_MURU_OPTION_VOID)
Muru:AddOption("VoidSoonWarn", true, DBM_MURU_OPTION_VOID_SOON)
Muru:AddOption("HumWarn", true, DBM_MURU_OPTION_HUM)
Muru:AddOption("HumSoonWarn", true, DBM_MURU_OPTION_HUM_SOON)
Muru:AddOption("WarnDarkness", true, DBM_MURU_OPTION_DARKNESS)
Muru:AddOption("WarnDarknessSoon", true, DBM_MURU_OPTION_DARKNESS_SOON)
Muru:AddOption("WarnBlackHole", true, DBM_MURU_OPTION_HOLE_WARN)
Muru:AddOption("PreWarnBlackHole", true, DBM_MURU_OPTION_HOLE_SOON_WARN)
Muru:AddOption("WarnFiend", true, DBM_MURU_OPTION_WARN_FIEND)

Muru:AddBarOption("Enrage")
Muru:AddBarOption("Humanoids")
Muru:AddBarOption("Void Sentinel")
Muru:AddBarOption("Next Darkness")
Muru:AddBarOption("Next Black Hole")

local p2 = false

Muru:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_SUMMON"
)


function Muru:OnCombatStart(delay)
	p2 = false
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy") 
	self:ScheduleAnnounce(300 - delay, DBM_GENERIC_ENRAGE_WARN:format(5, DBM_MIN), 1)
	self:ScheduleAnnounce(420 - delay, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(540 - delay, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(570 - delay, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(590 - delay, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)
	
	self:StartStatusBarTimer(15 - delay, "Humanoids", "Interface\\Icons\\Spell_Holy_PrayerOfHealing")
	self:ScheduleMethod(15 - delay, "HumanoidSpawn")
	if self.Options.HumSoonWarn then
		self:ScheduleAnnounce(10 - delay, DBM_MURU_WARN_HUMANOIDS_SOON, 1)
	end
	
	if self.Options.VoidSoonWarn then
		self:ScheduleAnnounce(31.5 - delay, DBM_MURU_WARN_VOID_SOON, 1)
	end
	self:ScheduleMethod(36.5 - delay, "VoidSpawn")
	self:StartStatusBarTimer(36.5 - delay, "Void Sentinel", "Interface\\Icons\\Spell_Shadow_SummonVoidWalker")
	
	self:StartStatusBarTimer(45 - delay, "Next Darkness", 45996)
	self:ScheduleAnnounce(40 - delay, DBM_MURU_DARKNESS_SOON, 3)
end

function Muru:OnEvent(event, args)
	if event == "SPELL_AURA_APPLIED" then
		if args.spellId == 45996 then
			if args.auraType == "BUFF" then
				self:SendSync("Darkness")
				p2 = false
			end
		end
	elseif event == "SPELL_SUMMON" then
		if args.spellId == 46268 then
			self:SendSync("Fiend")
		elseif args.spellId == 46282 then
			self:SendSync("BlackHole")
		end
	end
end

function Muru:OnSync(msg)
	if msg == "Darkness" then
		if self.Options.WarnDarkness then
			self:Announce(DBM_MURU_DARKNESS_INC, 4)
		end
		self:StartStatusBarTimer(45, "Next Darkness", 45996)
		if self.Options.WarnDarknessSoon then
			self:ScheduleAnnounce(40, DBM_MURU_DARKNESS_SOON, 3)
		end
	elseif msg == "Fiend" then
		if self.Options.WarnFiend then
			self:Announce(DBM_MURU_WARN_FIEND, 3)
		end
	elseif msg == "BlackHole" then
		if self.Options.WarnBlackHole then
			self:Announce(DBM_MURU_WARN_BLACKHOLE, 2)
		end
		self:StartStatusBarTimer(15, "Next Black Hole", "Interface\\Icons\\Ability_Hunter_Resourcefulness")
		if self.Options.PreWarnBlackHole then
			self:ScheduleAnnounce(10, DBM_MURU_WARN_BLACKHOLE_SOON, 1)
		end
	elseif msg == "Phase2" then
		p2 = true
		self:Announce(DBM_MURU_WARN_P2, 1)
		self:UnScheduleMethod("HumanoidSpawn")
		self:UnScheduleMethod("VoidSpawn")
		self:EndStatusBarTimer("Humanoids")
		self:EndStatusBarTimer("Void Sentinel")
		self:UnScheduleAnnounce(DBM_MURU_WARN_HUMANOIDS_SOON, 1)
		self:UnScheduleAnnounce(DBM_MURU_WARN_VOID_SOON, 1)
	end
end

function Muru:HumanoidSpawn()
	if self.Options.HumWarn then
		self:Announce(DBM_MURU_WARN_HUMANOIDS_NOW, 2)
	end
	self:StartStatusBarTimer(60, "Humanoids", "Interface\\Icons\\Spell_Holy_PrayerOfHealing", true)
	self:ScheduleMethod(60, "HumanoidSpawn")
	if self.Options.HumSoonWarn then
		self:ScheduleAnnounce(55, DBM_MURU_WARN_HUMANOIDS_SOON, 1)
	end
end

function Muru:VoidSpawn()
	if self.Options.VoidWarn then
		self:Announce(DBM_MURU_WARN_VOID_NOW, 3)
	end
	if self.Options.VoidSoonWarn then
		self:ScheduleAnnounce(25, DBM_MURU_WARN_VOID_SOON, 1)
	end
	self:ScheduleMethod(30, "VoidSpawn")
	self:StartStatusBarTimer(30, "Void Sentinel", "Interface\\Icons\\Spell_Shadow_SummonVoidWalker")
end

function Muru:OnUpdate(elapsed)
	if p2 or not self.InCombat then return end
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i.."target") == DBM_MURU_ENTROPIUS and not UnitIsPlayer("raid"..i.."target") then
			self:SendSync("Phase2")
		end
	end
end

function Muru:GetBossHP()
	if p2 then
		return DBM_MURU_ENTROPIUS..": "..DBM.GetHPByName(DBM_MURU_ENTROPIUS)
	else
		return DBM.GetHPByName(DBM_MURU_NAME)
	end
end
