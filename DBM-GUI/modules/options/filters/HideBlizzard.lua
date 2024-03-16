local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

local L = DBM_GUI_L

local hideBlizzPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_HideBlizzard, "option")

if isRetail then
	local hideToastArea = hideBlizzPanel:CreateArea(L.Area_HideToast)
	hideToastArea:CreateCheckButton(L.HideGarrisonUpdates, true, nil, "HideGarrisonToasts")
	hideToastArea:CreateCheckButton(L.HideGuildChallengeUpdates, true, nil, "HideGuildChallengeUpdates")

	local hideMovieArea = hideBlizzPanel:CreateArea(L.Area_Cinematics)
	hideMovieArea:CreateCheckButton(L.DuringFight, true, nil, "HideMovieDuringFight")
	hideMovieArea:CreateCheckButton(L.InstanceAnywhere, true, nil, "HideMovieInstanceAnywhere")
--	hideMovieArea:CreateCheckButton(L.NonInstanceAnywhere, true, nil, "HideMovieNonInstanceAnywhere")
	hideMovieArea:CreateCheckButton(L.OnlyAfterSeen, true, nil, "HideMovieOnlyAfterSeen")
end

local blockSoundArea = hideBlizzPanel:CreateArea(L.Area_Sound)
blockSoundArea:CreateCheckButton(L.DisableSFX, true, nil, "DisableSFX")
blockSoundArea:CreateCheckButton(L.DisableAmbiance, true, nil, "DisableAmbiance")
blockSoundArea:CreateCheckButton(L.DisableMusic, true, nil, "DisableMusic")

local hideBlizzArea = hideBlizzPanel:CreateArea(L.Area_HideBlizzard)
hideBlizzArea:CreateCheckButton(L.HideBossEmoteFrame, true, nil, "HideBossEmoteFrame2")
if not isRetail then--Hiding it on retail causes taint, there are ways to work around it but involves modifying other addons like elvui first
	hideBlizzArea:CreateCheckButton(L.HideWatchFrame, true, nil, "HideObjectivesFrame")
end
--hideBlizzArea:CreateCheckButton(L.HideQuestTooltips, true, nil, "HideQuestTooltips")--Needs reimplimenting the way BW does it, not altering cvar but manually revising tooltips on fly
hideBlizzArea:CreateCheckButton(L.HideTooltips, true, nil, "HideTooltips")
