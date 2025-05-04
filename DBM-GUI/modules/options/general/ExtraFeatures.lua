local L = DBM_GUI_L

local extraFeaturesPanel	= DBM_GUI.Cat_General:CreateNewPanel(L.Panel_ExtraFeatures, "option")

local soundAlertsArea		= extraFeaturesPanel:CreateArea(L.Area_SoundAlerts)
soundAlertsArea:CreateCheckButton(L.LFDEnhance, true, nil, "LFDEnhance")
soundAlertsArea:CreateCheckButton(L.WorldBossNearAlert, true, nil, "WorldBossNearAlert")
soundAlertsArea:CreateCheckButton(L.RLReadyCheckSound, true, nil, "RLReadyCheckSound")
soundAlertsArea:CreateCheckButton(L.AutoReplySound, true, nil, "AutoReplySound")

local combatAlertsArea		= extraFeaturesPanel:CreateArea(L.Area_CombatAlerts)
combatAlertsArea:CreateCheckButton(L.AFKHealthWarning, true, nil, "AFKHealthWarning2")
combatAlertsArea:CreateCheckButton(L.HealthWarningLow, true, nil, "HealthWarningLow")
combatAlertsArea:CreateCheckButton(L.EnteringCombatAlert, true, nil, "EnteringCombatAlert")
combatAlertsArea:CreateCheckButton(L.LeavingCombatAlert, true, nil, "LeavingCombatAlert")

local generaltimeroptions	= extraFeaturesPanel:CreateArea(L.TimerGeneral)
generaltimeroptions:CreateCheckButton(L.SKT_Enabled, true, nil, "AlwaysShowSpeedKillTimer2")
generaltimeroptions:CreateCheckButton(L.ShowRespawn, true, nil, "ShowRespawn")
generaltimeroptions:CreateCheckButton(L.ShowQueuePop, true, nil, "ShowQueuePop")
generaltimeroptions:CreateCheckButton(L.ShowBerserkWarnings, true, nil, "ShowBerserkWarnings")

if _G["oRA3Frame"] then
	local thirdPartyArea = extraFeaturesPanel:CreateArea(L.Area_3rdParty)
	thirdPartyArea:CreateCheckButton(L.oRA3AnnounceConsumables, true, nil, "oRA3AnnounceConsumables")
end

local inviteArea			= extraFeaturesPanel:CreateArea(L.Area_Invite)
inviteArea:CreateCheckButton(L.AutoAcceptFriendInvite, true, nil, "AutoAcceptFriendInvite")
inviteArea:CreateCheckButton(L.AutoAcceptGuildInvite, true, nil, "AutoAcceptGuildInvite")

local tooltipArea = extraFeaturesPanel:CreateArea(L.Area_Tooltip)
local enableTooltip = tooltipArea:CreateCheckButton(L.EnableTooltip, true, nil, "EnableTooltip")
local enableTooltipInCombat = tooltipArea:CreateCheckButton(L.EnableTooltipInCombat, true, nil, "EnableTooltipInCombat")
local enableTooltipHeader = tooltipArea:CreateCheckButton(L.EnableTooltipHeader, true, nil, "EnableTooltipHeader")
local function updateTooltipOpts(self)
	if self:GetChecked() then
		enableTooltipInCombat:Enable()
		enableTooltipHeader:Enable()
		enableTooltipHeader.textObj:SetFontObject("p", GameFontNormal)
		enableTooltipInCombat.textObj:SetFontObject("p", GameFontNormal)
	else
		enableTooltipInCombat:Disable()
		enableTooltipHeader:Disable()
		enableTooltipHeader.textObj:SetFontObject("p", GameFontDisable)
		enableTooltipInCombat.textObj:SetFontObject("p", GameFontDisable)
	end
end
enableTooltip:HookScript("OnShow", updateTooltipOpts)
enableTooltip:HookScript("OnClick", updateTooltipOpts)


local advancedArea	= extraFeaturesPanel:CreateArea(L.Area_Advanced)
advancedArea:CreateCheckButton(L.FakeBW, true, nil, "FakeBWVersion")
