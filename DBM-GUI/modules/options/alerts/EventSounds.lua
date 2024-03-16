local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

local L = DBM_GUI_L

local Sounds = DBM_GUI:MixinSharedMedia3("sound", {
	{
		text	= L.NoSound,
		value	= "None"
	}
})

if isRetail then
	table.insert(Sounds, {
		text	= "Muradin: Charge",
		value	= 555967 -- "Sound\\Creature\\MuradinBronzebeard\\IC_Muradin_Saurfang02.ogg"
	})
end

local eventSoundsPanel			= DBM_GUI.Cat_Alerts:CreateNewPanel(L.Panel_EventSounds, "option")
local eventSoundsGeneralArea	= eventSoundsPanel:CreateArea(L.Area_SoundSelection)

local VictorySoundDropdown = eventSoundsGeneralArea:CreateDropdown(L.EventVictorySound, DBM:GetVictorySounds(), "DBM", "EventSoundVictory2", function(value)
	DBM.Options.EventSoundVictory2 = value
	if value ~= "Random" then
		DBM:PlaySoundFile(value)
	end
end, 180)
VictorySoundDropdown:SetPoint("TOPLEFT", eventSoundsGeneralArea.frame, "TOPLEFT", 0, -20)
VictorySoundDropdown.myheight = 0

local VictorySoundDropdown2 = eventSoundsGeneralArea:CreateDropdown(L.EventWipeSound, DBM:GetDefeatSounds(), "DBM", "EventSoundWipe", function(value)
	DBM.Options.EventSoundWipe = value
	if value ~= "Random" then
		DBM:PlaySoundFile(value)
	end
end, 180)
VictorySoundDropdown2:SetPoint("LEFT", VictorySoundDropdown, "RIGHT", 45, 0)

local useCombined = DBM.Options.EventSoundMusicCombined
local DungeonMusicDropDown = eventSoundsGeneralArea:CreateDropdown(L.EventDungeonMusic, useCombined and DBM:GetMusic() or DBM:GetDungeonMusic(), "DBM", "EventSoundDungeonBGM", function(value)
	DBM.Options.EventSoundDungeonBGM = value
	if value == "Random" or value == "None" then
		if DBM.Options.tempMusicSetting then
			SetCVar("Sound_EnableMusic", DBM.Options.tempMusicSetting)
			DBM.Options.tempMusicSetting = nil
		end
		if DBM.Options.musicPlaying then
			StopMusic()
			DBM.Options.musicPlaying = nil
		end
	else
		if not DBM.Options.tempMusicSetting then
			DBM.Options.tempMusicSetting = tonumber(GetCVar("Sound_EnableMusic"))
			if DBM.Options.tempMusicSetting == 0 then
				SetCVar("Sound_EnableMusic", 1)
			else
				DBM.Options.tempMusicSetting = nil
			end
		end
		PlayMusic(value)
		DBM.Options.musicPlaying = true
	end
end, 180)
DungeonMusicDropDown:SetPoint("TOPLEFT", VictorySoundDropdown, "TOPLEFT", 0, -45)

local MusicDropDown = eventSoundsGeneralArea:CreateDropdown(L.EventEngageMusic, useCombined and DBM:GetMusic() or DBM:GetBattleMusic(), "DBM", "EventSoundMusic", function(value)
	DBM.Options.EventSoundMusic = value
	if value == "Random" or value == "None" then
		if DBM.Options.tempMusicSetting then
			SetCVar("Sound_EnableMusic", DBM.Options.tempMusicSetting)
			DBM.Options.tempMusicSetting = nil
		end
		if DBM.Options.musicPlaying then
			StopMusic()
			DBM.Options.musicPlaying = nil
		end
	else
		if not DBM.Options.tempMusicSetting then
			DBM.Options.tempMusicSetting = tonumber(GetCVar("Sound_EnableMusic"))
			if DBM.Options.tempMusicSetting == 0 then
				SetCVar("Sound_EnableMusic", 1)
			else
				DBM.Options.tempMusicSetting = nil
			end
		end
		PlayMusic(value)
		DBM.Options.musicPlaying = true
	end
end, 180)
MusicDropDown:SetPoint("TOPLEFT", VictorySoundDropdown2, "TOPLEFT", 0, -45)
MusicDropDown.myheight = 0

local PullTimerSoundDropdown = eventSoundsGeneralArea:CreateDropdown(L.EventEngagePT, Sounds, "DBM", "EventSoundPullTimer", function(value)
	DBM.Options.EventSoundPullTimer = value
	DBM:PlaySoundFile(DBM.Options.EventSoundPullTimer)
end, 180)
PullTimerSoundDropdown:SetPoint("TOPLEFT", DungeonMusicDropDown, "TOPLEFT", 0, -45)

local EngageSoundDropdown = eventSoundsGeneralArea:CreateDropdown(L.EventEngageSound, Sounds, "DBM", "EventSoundEngage2", function(value)
	DBM.Options.EventSoundEngage2 = value
	DBM:PlaySoundFile(DBM.Options.EventSoundEngage2)
end, 180)
EngageSoundDropdown:SetPoint("LEFT", PullTimerSoundDropdown, "RIGHT", 45, 0)

local eventSoundsExtrasArea	= eventSoundsPanel:CreateArea(L.Area_EventSoundsExtras)
eventSoundsExtrasArea:CreateCheckButton(L.EventMusicCombined, true, nil, "EventSoundMusicCombined")

if isRetail then
	local eventSoundsFiltersArea= eventSoundsPanel:CreateArea(L.Area_EventSoundsFilters)
	eventSoundsFiltersArea:CreateCheckButton(L.EventFilterDungMythicMusic, true, nil, "EventDungMusicMythicFilter")
	eventSoundsFiltersArea:CreateCheckButton(L.EventFilterMythicMusic, true, nil, "EventMusicMythicFilter")
end
