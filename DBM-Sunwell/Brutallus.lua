local Brutallus = DBM:NewBossMod("Brutallus", DBM_BRUTALLUS_NAME, DBM_BRUTALLUS_DESCRIPTION, DBM_SUNWELL, DBM_SW_TAB, 2)

Brutallus.Version		= "1.0"
Brutallus.Author		= "Tandanu"
Brutallus.MinRevision	= 954


Brutallus:SetCreatureID(24882)
Brutallus:RegisterCombat("yell", DBM_BRUTALLUS_YELL_PULL)


Brutallus:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

Brutallus:AddOption("WarnBurn", true, DBM_BRUTALLUS_OPTION_BURN)
Brutallus:AddOption("WarnBurn2", false, DBM_BRUTALLUS_OPTION_BURN2)
Brutallus:AddOption("BurnIcon", false, DBM_BRUTALLUS_OPTION_BURN3)
Brutallus:AddOption("BurnSpecWarn", true, DBM_BRUTALLUS_OPTION_BURN4)
Brutallus:AddOption("WarnStomp", true, DBM_BRUTALLUS_OPTION_STOMP)
Brutallus:AddOption("PreWarnStomp", false, DBM_BRUTALLUS_OPTION_PRESTOMP)
Brutallus:AddOption("WarnMeteor", false, DBM_BRUTALLUS_OPTION_METEOR)
Brutallus:AddOption("DelayedBurnTimer", false, DBM_BRUTALLUS_OPTION_DEL_BURN)
Brutallus:AddOption("DelayedBurnWarn", false, DBM_BRUTALLUS_OPTION_DEL_BURN2)

Brutallus:AddBarOption("Enrage")
Brutallus:AddBarOption("Burn: (.*)")
Brutallus:AddBarOption("Jumped Burn: (.*)", false)
Brutallus:AddBarOption("Next Burn")
Brutallus:AddBarOption("Next Meteor")
Brutallus:AddBarOption("Next Stomp")

local icons = {}
local lastBurn = 0

function Brutallus:OnCombatStart(delay)
	for i, v in pairs(icons) do
		icons[i] = nil
	end
	
	self:StartStatusBarTimer(360 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy") 
	self:ScheduleAnnounce(180 - delay, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(300 - delay, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(330 - delay, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(350 - delay, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)
	self:StartStatusBarTimer(31 - delay, "Next Stomp", 45185)
end

function Brutallus:OnEvent(event, args)
	if event == "SPELL_AURA_APPLIED" then
		if args.spellId == 46394 then
			self:SendSync("Burn"..tostring(args.destName))
		elseif args.spellId == 45185 then
			self:SendSync("Stomp"..tostring(args.destName))
		end
	elseif event == "SPELL_CAST_START" then
		if args.spellId == 45150 then
			self:SendSync("Meteor")
		end
	end
end

local function clearIcon(id)
	icons[id] = nil
end
function Brutallus:OnSync(msg)
	if msg:sub(0, 4) == "Burn" then
		msg = msg:sub(5)
		if msg == UnitName("player") and self.Options.BurnSpecWarn then
			self:AddSpecialWarning(DBM_BRUTALLUS_WHISP_BURN)
		end
		
		local firstBurn = false
		if (GetTime() - lastBurn) > 19 then
			lastBurn = GetTime()
			firstBurn = true
		end
		
		if (self.Options.WarnBurn and firstBurn) or self.Options.WarnBurn2 then
			self:Announce(DBM_BRUTALLUS_WARN_BURN:format(msg), 2)
			self:SendHiddenWhisper(DBM_BRUTALLUS_WHISP_BURN, msg)
		end
		
		self:ScheduleMethod(45, "DelayedBurn", msg)
		
		if firstBurn then
			if not self.Options.DelayedBurnTimer then
				self:StartStatusBarTimer(60, "Burn: "..msg, 46394, true)
			end
			self:StartStatusBarTimer(20, "Next Burn", "Interface\\Icons\\Spell_Fire_FelFire")
		else
			if not self.Options.DelayedBurnTimer then
				self:StartStatusBarTimer(60, "Jumped Burn: "..msg, 46394, true)
			end
		end
		
		if self.Options.BurnIcon then
			for i = 8, 1, -1 do
				if icons[i] == nil then
					icons[i] = true
					self:SetIcon(msg, 60, i)
					self:Schedule(60, clearIcon, i)
					break
				end
			end
		end

	elseif msg:sub(0, 5) == "Stomp" then
		msg = msg:sub(6)
		if self.Options.WarnStomp then
			self:Announce(DBM_BRUTALLUS_WARN_STOMP:format(msg), 1)
		end
		if self.Options.PreWarnStomp then
			self:ScheduleAnnounce(26, DBM_BRUTALLUS_WARN_STOMP_SOON, 1)
		end
		self:StartStatusBarTimer(31, "Next Stomp", 45185)
	
	elseif msg == "Meteor" then
		if self.Options.WarnMeteor then
			self:Announce(DBM_BRUTALLUS_WARN_METEOR, 3)
		end
		self:StartStatusBarTimer(12, "Next Meteor", 45150)
	end
end

function Brutallus:DelayedBurn(target)
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i) == target then
			if not DBM.GetDebuff("raid"..i, GetSpellInfo(46394)) then
				return
			end
			break
		end
	end
	if self.Options.DelayedBurnWarn then
		self:Announce(DBM_BRUTALLUS_WARN_DEL_BURN:format(target), 4)
	end
	if self.Options.DelayedBurnTimer then
		self:StartStatusBarTimer(15, "Burn: "..target, 46394, true)
	end
end
