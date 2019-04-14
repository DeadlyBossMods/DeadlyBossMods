local mod	= DBM:NewMod("Brew", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
--mod:SetCreatureID(15467)
--mod:SetModelID(15879)
--mod:SetReCombatTime(10)
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

mod:AddBoolOption("NormalizeVolume", true, "misc")

local setActive = false
local function CheckEventActive()
	local date = C_Calendar.GetDate()
	local month, day, year = date.month, date.monthDay, date.year
	if month == 9 then
		if day >= 20 then
			setActive = true
		end
	elseif month == 10 then
		if day < 7 then
			setActive = true
		end
	end
end
CheckEventActive()

--Volume normalizing or disabling for blizzard stupidly putting the area's music on DIALOG audio channel, making it blaringly loud
local function setDialog(self, set)
	if not self.Options.NormalizeVolume then return end
	if set then
		local musicEnabled = GetCVarBool("Sound_EnableMusic") or true
		local musicVolume = tonumber(GetCVar("Sound_MusicVolume"))
		self.Options.SoundOption = tonumber(GetCVar("Sound_DialogVolume")) or 1
		if musicEnabled and musicVolume then--Normalize volume to music volume level
			DBM:Debug("Setting normalized volume to music volume of: "..musicVolume)
			SetCVar("Sound_DialogVolume", musicVolume)
		else--Just mute it
			DBM:Debug("Setting normalized volume to 0")
			SetCVar("Sound_DialogVolume", 0)
		end
	else
		if self.Options.SoundOption then
			DBM:Debug("Restoring Dialog volume to saved value of: "..self.Options.SoundOption)
			SetCVar("Sound_DialogVolume", self.Options.SoundOption)
			self.Options.SoundOption = nil
		end
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	if setActive then
		local mapID = C_Map.GetBestMapForUnit("player")
		if mapID == 27 or mapID == 1 then--Dun Morogh, Durotar
			setDialog(self, true)
		else
			setDialog(self)
		end
	else
		--Even if event isn't active. If a sound option was stored, restore it
		if self.Options.SoundOption then
			setDialog(self)
		end
	end
end
mod.OnInitialize = mod.ZONE_CHANGED_NEW_AREA
