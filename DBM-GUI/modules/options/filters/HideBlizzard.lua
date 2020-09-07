local L = DBM_GUI_L

local hideBlizzPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_HideBlizzard, "option")
local hideBlizzArea = hideBlizzPanel:CreateArea(L.Area_HideBlizzard)

hideBlizzArea:CreateCheckButton(L.HideBossEmoteFrame, true, nil, "HideBossEmoteFrame2")
hideBlizzArea:CreateCheckButton(L.HideWatchFrame, true, nil, "HideObjectivesFrame")
hideBlizzArea:CreateCheckButton(L.HideGarrisonUpdates, true, nil, "HideGarrisonToasts")
hideBlizzArea:CreateCheckButton(L.HideGuildChallengeUpdates, true, nil, "HideGuildChallengeUpdates")
hideBlizzArea:CreateCheckButton(L.HideQuestTooltips, true, nil, "HideQuestTooltips")
hideBlizzArea:CreateCheckButton(L.HideTooltips, true, nil, "HideTooltips")
local DisableSFX	= hideBlizzArea:CreateCheckButton(L.DisableSFX, true, nil, "DisableSFX")

local movieOptions = {
	{	text	= L.Disable,	value	= "Never"},
	{	text	= L.OnlyFight,	value	= "OnlyFight"},
	{	text	= L.AfterFirst,	value	= "AfterFirst"},
	{	text	= ALWAYS,		value	= "Block"},
}
local blockMovieDropDown = hideBlizzArea:CreateDropdown(L.DisableCinematics, movieOptions, "DBM", "MovieFilter2", function(value)
	DBM.Options.MovieFilter2 = value
end, 350)
blockMovieDropDown:SetPoint("TOPLEFT", _G[DisableSFX:GetName() .. "Text"], "BOTTOMLEFT", -26, -5)
blockMovieDropDown.myheight = 45
