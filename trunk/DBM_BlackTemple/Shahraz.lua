local Shahraz = DBM:NewBossMod("Shahraz", DBM_SHAHRAZ_NAME, DBM_SHAHRAZ_DESCRIPTION, DBM_BLACK_TEMPLE, DBM_BT_TAB, 7)

Shahraz.Version	= "1.0"
Shahraz.Author	= "Tandanu"

Shahraz:RegisterCombat("YELL", DBM_SHAHRAZ_YELL_PULL)

Shahraz:AddOption("WarnBeam", false, DBM_SHAHRAZ_OPTION_BEAM)
Shahraz:AddOption("WarnBeamSoon", false, DBM_SHAHRAZ_OPTION_BEAM_SOON)

Shahraz:AddBarOption("Enrage")
Shahraz:AddBarOption("Next Beam", false)

local fa = {}
local icon = 8

Shahraz:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE"
)

function Shahraz:OnCombatStart(delay)
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy")
	self:ScheduleSelf(300 - delay, "EnrageWarn", 300)
	self:ScheduleSelf(480 - delay, "EnrageWarn", 120)
	self:ScheduleSelf(540 - delay, "EnrageWarn", 60)
	self:ScheduleSelf(570 - delay, "EnrageWarn", 30)
	self:ScheduleSelf(590 - delay, "EnrageWarn", 10)
	
	fa = {}
	icon = 8
end

function Shahraz:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 41001 then
			self:SendSync("FA"..tostring(arg1.destName))
		elseif arg1.spellId == 40860 then
			self:SendSync("BeamVile")
		end
	elseif event == "SPELL_DAMAGE" then
		if arg1.spellId == 40859 then
			self:SendSync("BeamSinister")
		elseif arg1.spellId == 40827 then
			self:SendSync("BeamSinful")
		elseif arg1.spellId == 40861 then
			self:SendSync("BeamWicked")
		end
	elseif event == "EnrageWarn" and type(arg1) == "number" then
		if arg1 >= 60 then
			self:Announce(string.format(DBM_SHAHRAZ_WARN_ENRAGE, (arg1/60), DBM_MIN), 1)
		else
			self:Announce(string.format(DBM_SHAHRAZ_WARN_ENRAGE, arg1, DBM_SEC), 3)
		end
	elseif event == "WarnFA" then
		local msg = ""
		for i, v in ipairs(fa) do
			msg = msg..">"..v.."<, "
		end
		msg = msg:sub(0, -3)
		fa = {}
		self:Announce(DBM_SHAHRAZ_WARN_FA:format(msg), 4)
		icon = 8
	elseif event == "WarnBeam" then
		if self.Options.WarnBeamSoon then
			self:Announce(DBM_SHAHRAZ_WARN_BEAM_SOON, 1)
		end
	end
end

function Shahraz:OnSync(msg)
	if msg:sub(0, 2) == "FA" then
		msg = msg:sub(3)
		table.insert(fa, msg)
		if self.Options.Announce and DBM.Rank >= 1 then
			self:SendHiddenWhisper(DBM_SHAHRAZ_WHISPER_FA, msg)
			self:SetIcon(msg, 7.5, icon)
			icon = icon - 1
		end
		if msg == UnitName("player") then
			self:AddSpecialWarning(DBM_SHAHRAZ_SPECWARN_FA)
		end
		self:UnScheduleSelf("WarnFA")
		if #fa == 3 then
			self:OnEvent("WarnFA")
		else
			self:ScheduleSelf(1, "WarnFA")
		end
	elseif msg:sub(0, 4) == "Beam" then
		if self.Options.WarnBeam then
			msg = msg:sub(5)
			if msg == "Vile" then
				self:Announce(DBM_SHAHRAZ_WARN_BEAM_VILE, 2)
			elseif msg == "Sinister" then
				self:Announce(DBM_SHAHRAZ_WARN_BEAM_SINISTER, 2)
			elseif msg == "Sinful" then
				self:Announce(DBM_SHAHRAZ_WARN_BEAM_SINFUL, 2)
			elseif msg == "Wicked" then
				self:Announce(DBM_SHAHRAZ_WARN_BEAM_WICKED, 2)
			end
		end
		self:ScheduleSelf(6, "WarnBeam")
		self:StartStatusBarTimer(9, "Next Beam", "Interface\\Icons\\Spell_Shadow_ShadowBolt")
	end
end
