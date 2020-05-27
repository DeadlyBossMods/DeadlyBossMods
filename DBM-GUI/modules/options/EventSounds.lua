local L = DBM_GUI_L

local Sounds = DBM_GUI:MixinSharedMedia3("sound", {
	{
		text	= L.NoSound,
		value	= "None"
	},
	{
		text	= "Muradin: Charge",
		value	= 16971 -- "Sound\\Creature\\MuradinBronzebeard\\IC_Muradin_Saurfang02.ogg"
	}
})

local eventSoundsPanel			= DBM_GUI_Frame:CreateNewPanel(L.Panel_EventSounds, "option")
local eventSoundsGeneralArea	= eventSoundsPanel:CreateArea(L.Area_SoundSelection, 145)

local VictorySoundDropdown = eventSoundsGeneralArea:CreateDropdown(L.EventVictorySound, DBM.Victory, "DBM", "EventSoundVictory2", function(value)
	DBM.Options.EventSoundVictory2 = value
	if value ~= "Random" then
		DBM:PlaySoundFile(value)
	end
end, 180)
VictorySoundDropdown:SetPoint("TOPLEFT", eventSoundsGeneralArea.frame, "TOPLEFT", 0, -20)

local VictorySoundDropdown2 = eventSoundsGeneralArea:CreateDropdown(L.EventWipeSound, DBM.Defeat, "DBM", "EventSoundWipe", function(value)
	DBM.Options.EventSoundWipe = value
	if value ~= "Random" then
		DBM:PlaySoundFile(value)
	end
end, 180)
VictorySoundDropdown2:SetPoint("LEFT", VictorySoundDropdown, "RIGHT", 45, 0)

local useCombined = DBM.Options.EventSoundMusicCombined
local DungeonMusicDropDown = eventSoundsGeneralArea:CreateDropdown(L.EventDungeonMusic, useCombined and DBM.Music or DBM.DungeonMusic, "DBM", "EventSoundDungeonBGM", function(value)
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

local MusicDropDown = eventSoundsGeneralArea:CreateDropdown(L.EventEngageMusic, useCombined and DBM.Music or DBM.BattleMusic, "DBM", "EventSoundMusic", function(value)
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

local VictorySoundDropdown3 = eventSoundsGeneralArea:CreateDropdown(L.EventEngageSound, Sounds, "DBM", "EventSoundEngage2", function(value)
	DBM.Options.EventSoundEngage2 = value
	DBM:PlaySoundFile(DBM.Options.EventSoundEngage2)
end, 180)
VictorySoundDropdown3:SetPoint("TOPLEFT", DungeonMusicDropDown, "TOPLEFT", 0, -45)

local eventSoundsExtrasArea	= eventSoundsPanel:CreateArea(L.Area_EventSoundsExtras, 52)
eventSoundsExtrasArea:CreateCheckButton(L.EventMusicCombined, true, nil, "EventSoundMusicCombined")

local eventSoundsFiltersArea= eventSoundsPanel:CreateArea(L.Area_EventSoundsFilters, 72)
eventSoundsFiltersArea:CreateCheckButton(L.EventFilterDungMythicMusic, true, nil, "EventDungMusicMythicFilter")
eventSoundsFiltersArea:CreateCheckButton(L.EventFilterMythicMusic, true, nil, "EventMusicMythicFilter")
