local L = DBM_GUI_L
local DBM, DBM_GUI = DBM, DBM_GUI
local SetCVar, GetCVar, StopMusic, PlayMusic, tonumber = SetCVar, GetCVar, StopMusic, PlayMusic, tonumber

local engageSounds = DBM_GUI:MixinSharedMedia3("sound", {
	{
		text	= L.NoSound,
		value	= "None"
	},
	{
		text	= "Muradin: Charge",
		value	= 16971 -- "Sound\\Creature\\MuradinBronzebeard\\IC_Muradin_Saurfang02.ogg"
	}
})
local victorySounds = DBM_GUI:MixinSharedMedia3("music", DBM.Victory)
local defeatSounds = DBM_GUI:MixinSharedMedia3("music", DBM.Defeat)
local musicSounds = DBM_GUI:MixinSharedMedia3("music", DBM.Music)
local dungeonMusicSounds = DBM_GUI:MixinSharedMedia3("music", DBM.DungeonMusic)
local battleMusicSounds = DBM_GUI:MixinSharedMedia3("music", DBM.BattleMusic)

local eventSoundsPanel			= DBM_GUI.Cat_Alerts:CreateNewPanel(L.Panel_EventSounds, "option")
local eventSoundsGeneralArea	= eventSoundsPanel:CreateArea(L.Area_SoundSelection)

local VictorySoundDropdown = eventSoundsGeneralArea:CreateDropdown(L.EventVictorySound, victorySounds, "DBM", "EventSoundVictory2", function(value)
	DBM.Options.EventSoundVictory2 = value
	if value ~= "Random" then
		DBM:PlaySoundFile(value)
	end
end, 180)
VictorySoundDropdown:SetPoint("TOPLEFT", eventSoundsGeneralArea.frame, "TOPLEFT", 0, -20)
VictorySoundDropdown.myheight = 40

local WipeSoundDropdown = eventSoundsGeneralArea:CreateDropdown(L.EventWipeSound, defeatSounds, "DBM", "EventSoundWipe", function(value)
	DBM.Options.EventSoundWipe = value
	if value ~= "Random" then
		DBM:PlaySoundFile(value)
	end
end, 180)
WipeSoundDropdown:SetPoint("LEFT", VictorySoundDropdown, "RIGHT", 45, 0)
WipeSoundDropdown.myheight = 0

local useCombined = DBM.Options.EventSoundMusicCombined
local DungeonMusicDropDown = eventSoundsGeneralArea:CreateDropdown(L.EventDungeonMusic, useCombined and musicSounds or dungeonMusicSounds, "DBM", "EventSoundDungeonBGM", function(value)
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
DungeonMusicDropDown.myheight = 40

local MusicDropDown = eventSoundsGeneralArea:CreateDropdown(L.EventEngageMusic, useCombined and musicSounds or battleMusicSounds, "DBM", "EventSoundMusic", function(value)
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
MusicDropDown:SetPoint("TOPLEFT", WipeSoundDropdown, "TOPLEFT", 0, -45)
MusicDropDown.myheight = 0

local EngageSoundDropdown = eventSoundsGeneralArea:CreateDropdown(L.EventEngageSound, engageSounds, "DBM", "EventSoundEngage2", function(value)
	DBM.Options.EventSoundEngage2 = value
	DBM:PlaySoundFile(DBM.Options.EventSoundEngage2)
end, 180)
EngageSoundDropdown:SetPoint("TOPLEFT", DungeonMusicDropDown, "TOPLEFT", 0, -45)
EngageSoundDropdown.myheight = 50

local eventSoundsExtrasArea	= eventSoundsPanel:CreateArea(L.Area_EventSoundsExtras)
eventSoundsExtrasArea:CreateCheckButton(L.EventMusicCombined, true, nil, "EventSoundMusicCombined")

local eventSoundsFiltersArea= eventSoundsPanel:CreateArea(L.Area_EventSoundsFilters)
eventSoundsFiltersArea:CreateCheckButton(L.EventFilterDungMythicMusic, true, nil, "EventDungMusicMythicFilter")
eventSoundsFiltersArea:CreateCheckButton(L.EventFilterMythicMusic, true, nil, "EventMusicMythicFilter")
