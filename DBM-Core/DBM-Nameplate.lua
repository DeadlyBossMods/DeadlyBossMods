--NOBODY, except Keseva touches this file.

---@class DBM
local DBM = DBM

-- globals
---@class DBMNameplateFrame
local nameplateFrame = {}
DBM.Nameplate = nameplateFrame
-- locals
local LCG = LibStub and LibStub:GetLibrary("LibCustomGlow-1.0")
local units = {}
local nameplateTimerBars = {}
local num_units = 0
local lastOptionsUpdateTime = GetTime()
local playerName, playerGUID = UnitName("player"), UnitGUID("player")--Cache these, they never change
local GetNamePlateForUnit, GetNamePlates = C_NamePlate.GetNamePlateForUnit, C_NamePlate.GetNamePlates
---@cast GetNamePlates fun(): table[] -- https://github.com/Ketho/vscode-wow-api/issues/122
local twipe, floor, strsub, strbyte= table.wipe, math.floor, _G.strsub, _G.strbyte
local CooldownFrame_Set = CooldownFrame_Set
--function locals
local NameplateIcon_Hide, Nameplate_UnitAdded, CreateAuraFrame

---@class DBMNameplate: Frame, NamePlateBaseMixin
---@field DBMAuraFrame DBMAuraFrame

--Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
local standardFont
if LOCALE_koKR then
	standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

--------------------
--  Create Frame  --
--------------------
local DBMNameplateFrame = CreateFrame("Frame", "DBMNameplate", UIParent)
DBMNameplateFrame:SetFrameStrata('BACKGROUND')
DBMNameplateFrame:Hide()

----------------------
-- Helper functions --
----------------------
local function CleanSubString(text, i, j)
	if type(text) == "string" and text ~= "" and i and i > 0 and j and j > 0 then
		i = floor(i)
		j = floor(j)
		local b1 = (#text > 0) and strbyte(strsub(text, #text, #text)) or nil
		local b2 = (#text > 1) and strbyte(strsub(text, #text-1, #text)) or nil
		local b3 = (#text > 2) and strbyte(strsub(text, #text-2, #text)) or nil

		if b1 and (b1 < 194 or b1 > 244) then
			text = strsub (text, i, j)
		elseif b1 and b1 >= 194 and b1 <= 244 then
			text = strsub (text, i*2 - 1, j*2)

		elseif b2 and b2 >= 224 and b2 <= 244 then
			text = strsub (text, i*3 - 2, j*3)

		elseif b3 and b3 >= 240 and b3 <= 244 then
			text = strsub (text, i*4 - 3, j*3)
		end
	end

	return text
end

--------------------------
-- Aura frame functions --
--------------------------
do
	local function AuraFrame_ApplyOptions(self, iconFrame)
		if iconFrame.lastOptionsUpdateTime and (lastOptionsUpdateTime < iconFrame.lastOptionsUpdateTime) then return end

		iconFrame:SetSize(DBM.Options.NPIconSize+2, DBM.Options.NPIconSize+2)

		iconFrame.icon:SetSize(DBM.Options.NPIconSize, DBM.Options.NPIconSize)

		iconFrame.__DBM_NPIconGlowFrame:SetSize(DBM.Options.NPIconSize, DBM.Options.NPIconSize)

		local timerFont = DBM.Options.NPIconTimerFont == "standardFont" and standardFont or DBM.Options.NPIconTimerFont
		local timerFontSize = DBM.Options.NPIconTimerFontSize
		local timerStyle = DBM.Options.NPIconTimerFontStyle == "None" and nil or DBM.Options.NPIconTimerFontStyle
		iconFrame.cooldown.timer:SetFont(timerFont, timerFontSize, timerStyle)

		local textFont = DBM.Options.NPIconTextFont == "standardFont" and standardFont or DBM.Options.NPIconTextFont
		local textFontSize = DBM.Options.NPIconTextFontSize
		local textStyle = DBM.Options.NPIconTextFontStyle == "None" and nil or DBM.Options.NPIconTextFontStyle
		iconFrame.text:SetFont(textFont, textFontSize, textStyle)

		iconFrame.lastOptionsUpdateTime = GetTime()
	end
	local function AuraFrame_CreateIcon(frame)
		-- base frame
		---@class DBMNamePlateIconFrame: Button, BackdropTemplate
		local iconFrame = CreateFrame("Button", "DBMNameplateAI" .. #frame.icons, DBMNameplateFrame, "BackdropTemplate")
		iconFrame:EnableMouse(false)
		iconFrame:SetBackdrop({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1})
		iconFrame:Hide()

		-- texture icon
		iconFrame.icon = iconFrame:CreateTexture(nil, 'BORDER')
		iconFrame.icon:SetPoint("CENTER")

		-- glow frame
		iconFrame.__DBM_NPIconGlowFrame = CreateFrame("Frame", nil, iconFrame, BackdropTemplateMixin and "BackdropTemplate");
		iconFrame.__DBM_NPIconGlowFrame:SetAllPoints(iconFrame);
		iconFrame.__DBM_NPIconGlowFrame:Hide()

		-- CD swipe
		---@class DBMNameplateFrameCooldown: Cooldown, BackdropTemplate
		iconFrame.cooldown = CreateFrame("Cooldown", "$parentCooldown", iconFrame, "CooldownFrameTemplate, BackdropTemplate")
		iconFrame.cooldown:SetPoint("CENTER")
		iconFrame.cooldown:SetAllPoints()
		iconFrame.cooldown:EnableMouse(false)
		if iconFrame.cooldown.EnableMouseMotion then
			iconFrame.cooldown:EnableMouseMotion(false)
		end
		iconFrame.cooldown:SetHideCountdownNumbers (true) -- disable blizzard timers as we are using our own.
		--iconFrame.cooldown.noCooldownCount = true --OmniCC override flag

		-- CD text
		iconFrame.cooldown.timer = iconFrame.cooldown:CreateFontString (nil, "OVERLAY", "NumberFontNormal")
		iconFrame.cooldown.timer:SetPoint ("CENTER")
		iconFrame.cooldown.timer:Show()
		iconFrame.timerText = iconFrame.cooldown.timer

		iconFrame.text = iconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		iconFrame.text:SetPoint("BOTTOM", iconFrame, "TOP", 0, 2)
		iconFrame.text:Hide()

		iconFrame:SetScript ("OnUpdate", frame.UpdateTimerText)

		tinsert(frame.icons,iconFrame)
		iconFrame.parent = frame


		frame:ApplyOptions(iconFrame)

		return iconFrame
	end
	local function AuraFrame_FormatTime(time)
		if (time >= 3600) then
			return floor (time / 3600) .. "h"
		elseif (time >= 60) then
			return floor (time / 60) .. "m"
		else
			return floor (time)
		end
	end
	local function AuraFrame_FormatTimeDecimal(time)
		if time < 10 then
			return ("%.1f"):format(time)
		elseif time < 60 then
			return ("%d"):format(time)
		elseif time < 3600 then
			return ("%d:%02d"):format(time/60%60, time%60)
		elseif time < 86400 then
			return ("%dh %02dm"):format(time/(3600), time/60%60)
		else
			return ("%dd %02dh"):format(time/86400, (time/3600) - (floor(time/86400) * 24))
		end
	end
	local function AuraFrame_GetIcon(frame,index)
		-- find unused icon or create new icon
		if not frame.icons or #frame.icons == 0 then
			return frame:CreateIcon()
		else
			if frame.texture_index[index] then
				-- return icon already used for this texture
				return frame.texture_index[index]
			else
				-- find unused icon:
				for _, iconFrame in ipairs(frame.icons) do
					if not iconFrame:IsShown() then
						return iconFrame
					end
				end

				-- create new icon
				return frame:CreateIcon()
			end
		end
	end
	local function AuraFrame_ArrangeIcons(frame)
		if not frame.icons or #frame.icons == 0 then return end

		local curTime = GetTime()
		local sortedIcons = {}
		for _, icon in pairs(frame.icons) do
			tinsert(sortedIcons,icon)
		end

		table.sort(sortedIcons, function(a, b) --sort this by aura type (1 = nameplate aura; 2 = nameplate CD timers) and time remaining
			local a_aura_tbl, b_aura_tbl = a.aura_tbl, b.aura_tbl
			if a_aura_tbl.auraType < b_aura_tbl.auraType then
				return true
			elseif a_aura_tbl.auraType > b_aura_tbl.auraType then
				return false
			elseif a_aura_tbl.paused and not b_aura_tbl.paused then
				return false
			elseif not a_aura_tbl.paused and b_aura_tbl.paused then
				return true
			elseif a_aura_tbl.auraType == 2 and b_aura_tbl.auraType == 2 then
				local at, bt = a_aura_tbl.duration or 0, b_aura_tbl.duration or 0
				local as, bs = a_aura_tbl.startTime or 0, b_aura_tbl.startTime or 0
				local ar = at - (a_aura_tbl.paused and (a_aura_tbl.pauseStartTime - as) or (curTime - as))
				local br = bt - (b_aura_tbl.paused and (b_aura_tbl.pauseStartTime - bs) or (curTime - bs))
				return br > ar
			elseif (a_aura_tbl.startTime + a_aura_tbl.duration) < (b_aura_tbl.startTime + b_aura_tbl.duration) then
				return true
			else
				return false -- unreachable
			end
		end)

		local iconSpacing = DBM.Options.NPIconSpacing
		local typeOffset = DBM.Options.NPIconSize/4 + iconSpacing
		local prev,total_width,first_icon
		local mainAnchor,mainAnchorRel,anchor,anchorRel = 'BOTTOM','TOP','LEFT','RIGHT' --top is default
		local centered = false
		local vertical = false
		local growthDirection = DBM.Options.NPIconGrowthDirection
		local anchorPoint = DBM.Options.NPIconAnchorPoint
		if anchorPoint == "TOP" then
			mainAnchor, mainAnchorRel = 'BOTTOM','TOP'
		elseif anchorPoint == "BOTTOM" then
			mainAnchor, mainAnchorRel = 'TOP','BOTTOM'
		elseif anchorPoint == "LEFT" then
			mainAnchor, mainAnchorRel = 'RIGHT','LEFT'
		elseif anchorPoint == "RIGHT" then
			mainAnchor, mainAnchorRel = 'LEFT','RIGHT'
		elseif anchorPoint == "CENTER" then
			mainAnchor, mainAnchorRel = 'CENTER','CENTER'
		end
		if growthDirection == "UP" then
			anchor, anchorRel = 'BOTTOM','TOP'
			vertical = true
		elseif growthDirection == "DOWN" then
			anchor, anchorRel = 'TOP','BOTTOM'
			vertical = true
		elseif growthDirection == "LEFT" then
			anchor, anchorRel = 'RIGHT','LEFT'
		elseif growthDirection == "RIGHT" then
			anchor, anchorRel = 'LEFT','RIGHT'
		elseif growthDirection == "CENTER_VERTICAL" then
			anchor, anchorRel = 'BOTTOM','TOP'
			centered = true
			vertical = true
		else
			centered = true
		end

		for _, iconFrame in ipairs(sortedIcons) do
			if iconFrame:IsShown() then
				--easiest to hanlde here: paused timer icons
				if iconFrame.aura_tbl.paused then
					iconFrame:SetScript("OnUpdate", nil)
					iconFrame.cooldown:Pause()
					iconFrame.icon:SetDesaturated(true)
				else
					iconFrame:SetScript ("OnUpdate", frame.UpdateTimerText)
					iconFrame.cooldown:Resume()
					iconFrame.icon:SetDesaturated(iconFrame.aura_tbl.desaturate)
				end

				iconFrame:ClearAllPoints()

				if not prev then
					total_width = 0
					first_icon = iconFrame
					iconFrame:SetPoint(mainAnchor,frame.parent,mainAnchorRel, DBM.Options.NPIconOffsetX, DBM.Options.NPIconOffsetY)
				else
					local spacing = (prev.aura_tbl.auraType ~= iconFrame.aura_tbl.auraType) and typeOffset or 0 + iconSpacing
					total_width = total_width + iconFrame:GetWidth() + spacing --width equals height, so we're fine
					iconFrame:SetPoint(anchor,prev,anchorRel, not vertical and spacing or 0, vertical and spacing or 0)
				end

				prev = iconFrame
			end
		end

		if first_icon and total_width and total_width > 0 then
			-- shift first icon to match anchor point
			first_icon:SetPoint(mainAnchor,frame.parent,mainAnchorRel,
				-floor((centered and not vertical and total_width or 0)/2) + DBM.Options.NPIconOffsetX,
				-floor((centered and vertical and total_width or 0)/2) + DBM.Options.NPIconOffsetY) -- icons are squares. tracking one total size is ok.
		end
	end
	local function AuraFrame_AddAura(frame,aura_tbl,batch)
		if not frame.icons then
			frame.icons = {}
		end
		if not frame.texture_index then
			frame.texture_index = {}
		end

		local iconFrame = frame:GetIcon(aura_tbl.index)
		frame:ApplyOptions(iconFrame)
		iconFrame.aura_tbl = aura_tbl
		iconFrame.icon:SetTexture(aura_tbl.texture)
		iconFrame.icon:SetDesaturated(aura_tbl.desaturate)
		if aura_tbl.color then
			iconFrame:SetBackdropBorderColor(aura_tbl.color[1], aura_tbl.color[2], aura_tbl.color[3], 1)
		else
			iconFrame:SetBackdropBorderColor(1, 1, 1, 1)
		end

		if DBM.Options.NPIconTextEnabled and aura_tbl.display and aura_tbl.display ~= "" then
			iconFrame.text:SetText(aura_tbl.display)
			iconFrame.text:SetTextColor(aura_tbl.color[1], aura_tbl.color[2], aura_tbl.color[3], 1)
			iconFrame.text:Show()
		else
			iconFrame.text:Hide()
		end

		frame.UpdateTimerText(iconFrame)
		CooldownFrame_Set (iconFrame.cooldown, aura_tbl.startTime, (aura_tbl.duration or 0), (aura_tbl.duration or 0) > 0, true)
		iconFrame:Show()

		frame.texture_index[aura_tbl.index] = iconFrame
		if not batch then
			frame:ArrangeIcons()
		end
	end
	local function AuraFrame_RemoveAura(frame,index,batch)
		if not index then return end
		if not frame.texture_index then return end

		local iconFrame = frame.texture_index[index]
		if not iconFrame then return end

		iconFrame:SetScript("OnUpdate", nil)
		iconFrame:Hide()
		frame.texture_index[index] = nil

		if not batch then
			frame:ArrangeIcons()
		end
	end
	local function AuraFrame_RemoveAll(frame)
		if not frame.icons or not frame.texture_index then return end

		for texture,_ in pairs(frame.texture_index) do
			frame:RemoveAura(texture,true)
		end
		frame:ArrangeIcons()
		twipe(frame.texture_index)
	end
	local function AuraFrame_StartGlow(self, iconFrame, glowType)
		local aura_tbl = iconFrame.aura_tbl
		iconFrame.__DBM_NPIconGlowFrame:Show()
		if glowType == 1 then--Pixel
			local options = {
				glowType = "pixel",
				color = aura_tbl.color, -- all plater color types accepted, from lib: {r,g,b,a}, color of lines and opacity, from 0 to 1. Defaul value is {0.95, 0.95, 0.32, 1}
				N = 8, -- number of lines. Defaul value is 8;
				frequency = 0.25, -- frequency, set to negative to inverse direction of rotation. Default value is 0.25;
				length = 3, -- length of lines. Default value depends on region size and number of lines;
				th = 3, -- thickness of lines. Default value is 2;
				xOffset = 0,
				yOffset = 0, -- offset of glow relative to region border;
				border = false, -- set to true to create border under lines;
				key = "DBM_ImportantMinDurationGlow", -- key of glow, allows for multiple glows on one frame;
			}
			LCG.PixelGlow_Start(iconFrame.__DBM_NPIconGlowFrame, options.color, options.N, options.frequency, options.length, options.th, options.xOffset, options.yOffset, options.border, options.key or "")
		elseif glowType == 2 then--Proc
			local options = {
				color = aura_tbl.color,
				--frameLevel = 8,
				startAnim = true,
				xOffset = 0,
				yOffset = 0,
				duration = 1,
				key = "DBM_ImportantMinDurationGlow",
			}
			LCG.ProcGlow_Start(iconFrame.__DBM_NPIconGlowFrame, options)
		elseif glowType == 3 then--Auto Cast Glow
			local options = {
				color = aura_tbl.color,
				N = 4, -- number of particle groups. Default value is 4
				frequency = 0.125, -- frequency, set to negative to inverse direction of rotation. Default value is 0.125
				scale = 1,-- scale of particles.
				yOffset = 0,
				xOffset = 0,
				duration = 1,
				key = "DBM_ImportantMinDurationGlow",
			}
			LCG.AutoCastGlow_Start(iconFrame.__DBM_NPIconGlowFrame, options.color, options.N, options.frequency, options.scale, options.xOffset, options.yOffset, "DBM_ImportantMinDurationGlow")
		elseif glowType == 4 then--Button Glow (similar to proc but different enough to give users the option) Proc is basically successor with more options and this is the OG
			local options = {
				color = {aura_tbl.color[1], aura_tbl.color[2], aura_tbl.color[3], 1},--This one also expects alpha
				frequency = 0.125,--Default value is 0.125
			}
			LCG.ButtonGlow_Start(iconFrame.__DBM_NPIconGlowFrame, options.color, options.frequency)--This one doesn't use a key
		end
	end
	local function AuraFrame_StopGlow(self, iconFrame, glowType)
		if glowType == 1 then
			LCG.PixelGlow_Stop(iconFrame.__DBM_NPIconGlowFrame, "DBM_ImportantMinDurationGlow")
		elseif glowType == 2 then
			LCG.ProcGlow_Stop(iconFrame.__DBM_NPIconGlowFrame, "DBM_ImportantMinDurationGlow")
		elseif glowType == 3 then
			LCG.AutoCastGlow_Stop(iconFrame.__DBM_NPIconGlowFrame, "DBM_ImportantMinDurationGlow")
		elseif glowType == 4 then
			LCG.ButtonGlow_Stop(iconFrame.__DBM_NPIconGlowFrame)
		else--In event of failure of glowtype, cleanup all
			LCG.PixelGlow_Stop(iconFrame.__DBM_NPIconGlowFrame, "DBM_ImportantMinDurationGlow")
			LCG.ProcGlow_Stop(iconFrame.__DBM_NPIconGlowFrame, "DBM_ImportantMinDurationGlow")
			LCG.AutoCastGlow_Stop(iconFrame.__DBM_NPIconGlowFrame, "DBM_ImportantMinDurationGlow")
			LCG.ButtonGlow_Stop(iconFrame.__DBM_NPIconGlowFrame)
		end
		iconFrame.__DBM_NPIconGlowFrame:Hide()
	end
	local function AuraFrame_UpdateTimerText (self) --has deltaTime as second parameter, not needed here.
		local now = GetTime()
		if ((self.lastUpdateCooldown or 0) + 0.09) <= now then --throttle a bit
			local aura_tbl = self.aura_tbl
			aura_tbl.remaining = (aura_tbl.startTime + (aura_tbl.duration or 0) - now)
			if DBM.Options.NPIconTimerEnabled and (aura_tbl.remaining > 0) then
				if self.formatWithDecimals then
					self.cooldown.timer:SetText(AuraFrame_FormatTimeDecimal(aura_tbl.remaining))
				else
					self.cooldown.timer:SetText(AuraFrame_FormatTime(aura_tbl.remaining))
				end
			else
				self.cooldown.timer:SetText ("")
			end

			local canGlow = false
			--cooldown nameplate icon. 1 = priority only, 2 = always
			if aura_tbl.barType ~= "castnp" and ((DBM.Options.NPIconGlowBehavior == 1 and aura_tbl.isPriority) or DBM.Options.NPIconGlowBehavior == 2) and aura_tbl.remaining < 4 then
				canGlow = true
			--cast nameplate icon. 1 = priority only. There is no "always" for cast timers at this time
			elseif aura_tbl.barType == "castnp" and DBM.Options.CastNPIconGlowBehavior == 1 and aura_tbl.isPriority and (aura_tbl.remaining or 0) > 0 then
				canGlow = true
			end
			local glowType = aura_tbl.barType == "castnp" and DBM.Options.CastNPIconGlowType2 or DBM.Options.CDNPIconGlowType
			if canGlow and not self.isGlowing then
				self.parent:StartGlow(self, glowType)
				self.isGlowing = glowType
			elseif not canGlow and self.isGlowing ~= false or aura_tbl.remaining < 0 then
				self.parent:StopGlow(self, self.isGlowing)
				self.isGlowing = false
			end

			self.lastUpdateCooldown = now

			if (aura_tbl.duration or 0) > 0 and (aura_tbl.remaining or 0) <= 0 and not aura_tbl.keep then
				if self.isGlowing then
					self.isGlowing = false
					self.parent:StopGlow(self, 0)
				end
				self.parent:RemoveAura(aura_tbl.index)
				if aura_tbl.id then
					nameplateTimerBars[aura_tbl.id] = nil --ensure CDs cleanup
				end
			end
		end
	end

	---@class DBMAuraFrame
	local auraframe_proto = {
		CreateIcon = AuraFrame_CreateIcon,
		GetIcon = AuraFrame_GetIcon,
		ApplyOptions = AuraFrame_ApplyOptions,
		ArrangeIcons = AuraFrame_ArrangeIcons,
		AddAura = AuraFrame_AddAura,
		RemoveAura = AuraFrame_RemoveAura,
		RemoveAll = AuraFrame_RemoveAll,
		UpdateTimerText = AuraFrame_UpdateTimerText,
		StartGlow = AuraFrame_StartGlow,
		StopGlow = AuraFrame_StopGlow,
	}
	auraframe_proto.__index = auraframe_proto

	function CreateAuraFrame(frame)
		if not frame then return end

		local new_frame = {}
		setmetatable(new_frame, auraframe_proto)
		new_frame.parent = frame

		return new_frame
	end
end
-----------------------------------------
--  Internal Nameplate Icon Functions  --
-----------------------------------------
-- handling both: Icon CDs and static nameplate icons
--Add more nameplate mods as they gain support
local function SupportedNPModIcons()
	if not DBM.Options.UseNameplateHandoff then return false end
	if _G["KuiNameplates"] or _G["TidyPlatesThreatDBM"] or _G["Plater"] then return true end
	return false
end
local function SupportedNPModBars()
	if not DBM.Options.UseNameplateHandoff then return false end
	if _G["Plater"] then return true end--Plater support disabled for time being due to bugs in plater that prevent using glow types correctly
	return false
end

local function NameplateIcon_UpdateUnitAuras(isGUID,unit)
	-- find frame for this unit;
	if not isGUID then
		local frame = GetNamePlateForUnit(unit) --[[@as DBMNameplate?]]
		if frame and frame.DBMAuraFrame then
			frame.DBMAuraFrame:ArrangeIcons()
		end
	else
		--TODO: lookup table, fed by NAME_PLATE_UNIT_ADDED and NAME_PLATE_UNIT_REMOVED?
		--GUID, less efficient because it must scan all plates to find
		--but supports npcs/enemies
		for _, frame in pairs(GetNamePlates()) do
			local foundUnit = frame.namePlateUnitToken or (frame.UnitFrame and frame.UnitFrame.unit)
			if foundUnit and UnitGUID(foundUnit) == unit and frame.DBMAuraFrame then
				frame.DBMAuraFrame:ArrangeIcons()
				break
			end
		end
	end
end

local function NameplateIcon_Show(isGUID, unit, aura_tbl)

	-- ensure integrity
	if not unit or not aura_tbl then return end

	--Not running supported NP Mod, internal handling
	if not DBMNameplateFrame:IsShown() then
		DBMNameplateFrame:Show()
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
		DBM:Debug("DBM.Nameplate Enabling", 2)
	end

	if not units[unit] then
		units[unit] = {}
		num_units = num_units + 1
	end

	tinsert(units[unit], aura_tbl)

	-- find frame for this unit;
	if not isGUID then
		local frame = GetNamePlateForUnit(unit)
		if frame then
			Nameplate_UnitAdded(frame, unit)
		end
	else
		--TODO: lookup table, fed by NAME_PLATE_UNIT_ADDED and NAME_PLATE_UNIT_REMOVED?
		--GUID, less efficient because it must scan all plates to find
		--but supports npcs/enemies
		for _, frame in pairs(GetNamePlates()) do
			local foundUnit = frame.namePlateUnitToken or (frame.UnitFrame and frame.UnitFrame.unit)
			if foundUnit and UnitGUID(foundUnit) == unit then
				Nameplate_UnitAdded(frame, foundUnit)
				break
			end
		end
	end
end

---@param isGUID boolean? If true, unit is GUID, if false, unit is unitID
---@param force boolean? If true, force hide all icons, if false, hide only one icon
function NameplateIcon_Hide(isGUID, unit, index, force)

	-- need to remove the entry
	if unit and units[unit] and index then
		local t_index
		for i,aura_tbl in ipairs(units[unit]) do
			if aura_tbl.index == index then
				t_index = i
				break
			end
		end
		if t_index then
			tremove(units[unit],t_index)
		end
	end

	-- cleanup
	if unit and units[unit] and (not index or #units[unit] == 0) then
		units[unit] = nil
		num_units = num_units - 1
	end

	-- find frame for this unit
	-- (or hide all visible textures if force ~= nil)
	if not isGUID and not force then --Only need to find one unit
		local frame = GetNamePlateForUnit(unit) --[[@as DBMNameplate?]]
		if frame and frame.DBMAuraFrame then
			if not index then
				frame.DBMAuraFrame:RemoveAll()
			else
				frame.DBMAuraFrame:RemoveAura(index)
			end
		end
	else
		--We either passed force, or GUID,
		--either way requires scanning all nameplates
		for _, frame in pairs(GetNamePlates()) do
			if frame.DBMAuraFrame then
				if force then
					frame.DBMAuraFrame:RemoveAll()
				elseif isGUID then
					local foundUnit = frame.namePlateUnitToken or (frame.UnitFrame and frame.UnitFrame.unit)
					if foundUnit and UnitGUID(foundUnit) == unit then
						if not index then
							frame.DBMAuraFrame:RemoveAll()
						else
							frame.DBMAuraFrame:RemoveAura(index)
						end
					end
				end
			end
		end
	end

	-- disable nameplate hooking;
	if force or num_units <= 0 then
		twipe(units)
		num_units = 0

		DBMNameplateFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DBMNameplateFrame:Hide()
		DBM:Debug("DBM.Nameplate Disabling", 2)
	end
end
-------------------------
-- Nameplate functions --
-------------------------
local function Nameplate_OnHide(frame)
	if not frame then return end
	frame.DBMAuraFrame:RemoveAll()
end
local function HookNameplate(frame)
	if not frame then return end
	frame.DBMAuraFrame = CreateAuraFrame(frame)
	frame:HookScript('OnHide',Nameplate_OnHide)
end

function Nameplate_UnitAdded(frame,unit)
	if not frame or not unit then return end

	if not frame.DBMAuraFrame then
		-- hook as required;
		HookNameplate(frame)
	end

	local guid = UnitGUID(unit)
	local unit_tbl = guid and units[guid]

	if unit_tbl and #unit_tbl > 0 then
		local curTime = GetTime()
		for _,aura_tbl in ipairs(unit_tbl) do
			local dur = (aura_tbl.duration or 0)
			if dur == 0 or (dur > 0 and (curTime < aura_tbl.startTime + dur)) then
				frame.DBMAuraFrame:AddAura(aura_tbl,true)
			end
		end
		frame.DBMAuraFrame:ArrangeIcons()
	end
end
----------------
--  On Event  --
----------------
DBMNameplateFrame:SetScript("OnEvent", function(_, event, ...)
	if event == 'NAME_PLATE_UNIT_ADDED' then
		local unit = ...
		if not unit then return end
		local f = GetNamePlateForUnit(unit)
		if not f then return end

		Nameplate_UnitAdded(f,unit)
	end
end)

--------------------------------------
--  Nameplate Timer Icons Registry  --
--------------------------------------
local function getAllShownGUIDs() -- for testing
	local guids = {}
	for _, plateFrame in ipairs(GetNamePlates()) do
		if plateFrame and plateFrame.UnitFrame and plateFrame.UnitFrame.unit then
			tinsert(guids,  UnitGUID(plateFrame.UnitFrame.unit))
		end
	end
	return guids
end

--register callbacks for aura icon CDs
local barsTestMode = false --this is to handle the "non-guid" test bars. just turn on for testing.
do
	--test start
	local testStartCallback = function(event, id, msg, timer, icon, barType, spellId, colorType, modId, keep, fade, name, guid, timerCount, isPriority)
		if event ~= "DBM_TimerStart" then return end
		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		--Disable cooldown icons for any timer designated as a nameplate only cooldown timer
		--NOTE, bosses that send GUID send "cd" and not "cdnp" so if DontSendBossGUIDs isn't enabled, they will still be passed even if DontShowNameplateIconsCD is
		--This is intended behavior as I want the option to toggle separately.
		if DBM.Options.DontShowNameplateIconsCD and barType == "cdnp" then return end
		--Disable cast icons for any timer designated as a nameplate only cast timer
		if DBM.Options.DontShowNameplateIconsCast and barType == "castnp" then return end--Globally disabled
		--Disables cooldown icons for hybrid timers (ie timers that are both regular timer and nameplate timer)
		if DBM.Options.DontSendBossGUIDs and barType ~= "cdnp" and barType ~= "castnp" then return end--Basically all other bar types

		if id and not guid and barsTestMode then
			for _, curGuid in pairs(getAllShownGUIDs()) do
				local tmpId = id .. curGuid
				local color = {DBT:GetColorForType(colorType)}
				local display = CleanSubString(string.match(name or msg or "", "^%s*(.-)%s*$" ), 1, DBM.Options.NPIconTextMaxLen)
				--local display = string.match(name or msg or "", "^%s*(.-)%s*$" )
				local curTime =  GetTime()

				if not units[curGuid] then
					units[curGuid] = {}
					num_units = num_units + 1
				end

				local aura_tbl = {
					msg = msg or "",
					display = display or name or msg or "",
					id = id,
					texture = icon or DBM:GetSpellTexture(spellId),
					spellId = spellId,
					duration = timer or 0,
					desaturate = fade or false,
					startTime = curTime,
					barType = barType,
					color = color,
					colorType = colorType,
					modId = modId,
					keep = keep,
					name = name,
					guid = curGuid,
					timerCount = timerCount,
					isPriority = isPriority,
					paused = false,
					auraType = 2, -- 1 = nameplate aura; 2 = nameplate CD timers
					index = tmpId,
				}
				nameplateTimerBars[id] = aura_tbl
				NameplateIcon_Show(true, curGuid, aura_tbl)
			end
		end
	end

	--test stop
	local testEndCallback = function (event, id)
		if event ~= "DBM_TimerStop" then return end

		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		if DBM.Options.DontShowNameplateIconsCD then return end--Globally disabled

		if not id then return end
		local guid = nameplateTimerBars[id] and nameplateTimerBars[id].guid
		if not guid and barsTestMode then
			for _, curGuid in pairs(getAllShownGUIDs()) do
				for _,aura_tbl in ipairs(units[curGuid] or {}) do
					if aura_tbl.id == id then
						NameplateIcon_Hide(true, curGuid, aura_tbl.index, false)
						break
					end
				end
			end
		end
		nameplateTimerBars[id] = nil
	end

	--test mode start
	local testModeStartCallback = function(event, timer)
		if event ~= "DBM_TestModStarted" then return end
		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		if DBM.Options.DontShowNameplateIconsCD then return end--Globally disabled

		barsTestMode = true
		C_Timer.After (tonumber(timer) or 10, function()
			barsTestMode = false
			DBM:UnregisterCallback("DBM_TimerStart", testStartCallback)
			DBM:UnregisterCallback("DBM_TimerStop", testEndCallback)
		end)
		DBM:RegisterCallback("DBM_TimerStart", testStartCallback)
		DBM:RegisterCallback("DBM_TimerStop", testEndCallback)
	end
	DBM:RegisterCallback("DBM_TestModStarted", testModeStartCallback)

	--timer start
	local timerStartCallback = function(event, id, msg, timer, icon, barType, spellId, colorType, modId, keep, fade, name, guid, timerCount, isPriority)
		if event ~= "DBM_NameplateStart" then return end
		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		--Disable cooldown icons for any timer designated as a nameplate only cooldown timer
		--NOTE, bosses that send GUID send "cd" and not "cdnp" so if DontSendBossGUIDs isn't enabled, they will still be passed even if DontShowNameplateIconsCD is
		--This is intended behavior as I want the option to toggle separately.
		if DBM.Options.DontShowNameplateIconsCD and barType == "cdnp" then return end
		--Disable cast icons for any timer designated as a nameplate only cast timer
		if DBM.Options.DontShowNameplateIconsCast and barType == "castnp" then return end--Globally disabled
		--Disables cooldown icons for hybrid timers (ie timers that are both regular timer and nameplate timer)
		if DBM.Options.DontSendBossGUIDs and barType ~= "cdnp" and barType ~= "castnp" then return end--Basically all other bar types

		if (id and guid) then
			local color = {DBT:GetColorForType(colorType)}
			local display = CleanSubString(string.match(name or msg or "", "^%s*(.-)%s*$" ), 1, DBM.Options.NPIconTextMaxLen)
			--local display = string.match(name or msg or "", "^%s*(.-)%s*$" )
			local curTime =  GetTime()

			if not units[guid] then
				units[guid] = {}
				num_units = num_units + 1
			end

			local aura_tbl = {
				msg = msg or "",
				display = display or name or msg or "",
				id = id,
				texture = icon or DBM:GetSpellTexture(spellId),
				spellId = spellId,
				duration = timer or 0,
				desaturate = fade or false,
				startTime = curTime,
				barType = barType,
				color = color,
				colorType = colorType,
				modId = modId,
				keep = keep,
				name = name,
				guid = guid,
				timerCount = timerCount,
				isPriority = isPriority,
				paused = false,
				auraType = 2, -- 1 = nameplate aura; 2 = nameplate CD timers
				index = id,
			}
			nameplateTimerBars[id] = aura_tbl
			NameplateIcon_Show(true, guid, aura_tbl)
		end
	end
	DBM:RegisterCallback("DBM_NameplateStart", timerStartCallback)

	local timerUpdateCallback = function(event, id, elapsed, totalTime)
		if event ~= "DBM_NameplateUpdate" then return end

		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		if DBM.Options.DontShowNameplateIconsCD then return end--Globally disabled

		if not id or not elapsed or not totalTime then return end
		local entry = id and nameplateTimerBars[id] or nil
		local guid = entry and entry.guid
		local curTime = GetTime()
		if entry and guid then
			entry.duration = totalTime
			entry.startTime = curTime - elapsed
			if entry.paused then
				entry.pauseStartTime = curTime
			end

			NameplateIcon_UpdateUnitAuras(true,guid)
		end
	end
	DBM:RegisterCallback("DBM_NameplateUpdate", timerUpdateCallback)

	local timerPauseCallback = function(event, id)
		if event ~= "DBM_NameplatePause" then return end

		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		if DBM.Options.DontShowNameplateIconsCD then return end--Globally disabled

		if not id then return end
		local entry = id and nameplateTimerBars[id] or nil
		local guid = entry and entry.guid
		if entry and guid then
			local curTime = GetTime()
			entry.paused = true
			entry.pauseStartTime = curTime

			NameplateIcon_UpdateUnitAuras(true,guid)
		end
	end
	DBM:RegisterCallback("DBM_NameplatePause", timerPauseCallback)

	local timerResumeCallback = function(event, id)
		if event ~= "DBM_NameplateResume" then return end

		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		if DBM.Options.DontShowNameplateIconsCD then return end--Globally disabled

		if not id then return end
		local entry = id and nameplateTimerBars[id] or nil
		local guid = entry and entry.guid
		if entry and entry.paused and guid then
			entry.paused = false
			entry.startTime = entry.startTime + (GetTime() - entry.pauseStartTime)
			entry.pauseStartTime = entry.startTime

			NameplateIcon_UpdateUnitAuras(true,guid)
		end
	end
	DBM:RegisterCallback("DBM_NameplateResume", timerResumeCallback)

	--timer stop
	local timerEndCallback = function (event, id)
		if event ~= "DBM_NameplateStop" then return end

		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		if DBM.Options.DontShowNameplateIconsCD then return end--Globally disabled

		if not id then return end
		local guid = nameplateTimerBars[id] and nameplateTimerBars[id].guid
		if guid then
			for _,aura_tbl in ipairs(units[guid]) do
				if aura_tbl.id == id then
					NameplateIcon_Hide(true, guid, aura_tbl.index, false)
					break
				end
			end
		end
		nameplateTimerBars[id] = nil
	end
	DBM:RegisterCallback("DBM_NameplateStop", timerEndCallback)

	--timer stop all
	local timerEndAllCallback = function (event, id)
		if event ~= "DBM_NameplateStopAll" then return end

		-- Supported by nameplate mod, passing to their handler
		if SupportedNPModBars() then return end
		if DBM.Options.DontShowNameplateIconsCD then return end--Globally disabled

		NameplateIcon_Hide(false, nil, nil, true)--Nil GUID force true basically triggers RemoveAll
	end
	DBM:RegisterCallback("DBM_NameplateStopAll", timerEndAllCallback)
end

function DBM.PauseTestTimer(text)
	for _, guid in pairs(getAllShownGUIDs()) do
		for _, aura_tbl in ipairs(units[guid]) do
			if aura_tbl.id:find(text) then
				if aura_tbl.paused and guid then
					aura_tbl.paused = false
					aura_tbl.startTime = aura_tbl.startTime + (GetTime() - aura_tbl.pauseStartTime)
					aura_tbl.pauseStartTime = aura_tbl.startTime

					NameplateIcon_UpdateUnitAuras(true,guid)
				elseif not aura_tbl.paused and guid then
					aura_tbl.paused = true
					aura_tbl.pauseStartTime = GetTime()

					NameplateIcon_UpdateUnitAuras(true,guid)
				end
			end
		end
	end
end

--------------------------------
--  Nameplate Icon Functions  --
--------------------------------
--/run DBM:FireEvent("BossMod_EnableHostileNameplates")
--/run DBM.Nameplate:Show(true, UnitGUID("target"), 227723)--Mana tracking, easy to find in Dalaran
--/run DBM.Nameplate:Show(false, "target", 227723)--Mana tracking, easy to find in Dalaran
--/run DBM.Nameplate:Hide(true, nil, nil, nil, true)
--/run DBM.Nameplate:Hide(true, UnitGUID("target"), 227723)
--/run DBM.Nameplate:Hide(false, GetUnitName("target", true), 227723)

--ie, anchored to UIParent Center (ie player is in center) and to bottom of nameplate aura.

---@param isGUID boolean? whether or not it's name based or guid based unit, guid preferred
---@param unit string the actual name or guid
---@param spellId number? if show is called with spellId, hide must also be called with spellid
---@param texture number|string? accepts texture ID or spell ID
---@param duration number? adds countdown duration to icon
---@param desaturate boolean?
---@param isPriority boolean? true for high priority/important cooldowns or casts. false or nil otherwise
---@param forceDBM boolean? makes it use internal handler even when 3rd party nameplate mod exists
function nameplateFrame:Show(isGUID, unit, spellId, texture, duration, desaturate, isPriority, forceDBM)

	-- nameplate icons are disabled;
	if DBM.Options.DontShowNameplateIcons then return end

	-- ignore player nameplate;
	if playerGUID == unit or playerName == unit then return end

	--Texture Id passed as string so as not to get confused with spellID for GetSpellTexture
	local currentTexture = tonumber(texture) or texture or DBM:GetSpellTexture(spellId or 0)

	-- build aura info table
	local curTime = GetTime()
	local aura_tbl = {
		texture = currentTexture,
		spellId = spellId,
		duration = duration or 0,
		desaturate = desaturate or false,
		isPriority = isPriority or false,
		startTime = curTime,
		auraType = 1, -- 1 = nameplate aura; 2 = nameplate CD/Cast timers
		index = currentTexture,
	}

	-- Supported by nameplate mod, passing to their handler
	if SupportedNPModIcons() and not forceDBM then
		DBM:FireEvent("BossMod_EnableHostileNameplates") --TODO: is this needed?
		DBM:FireEvent("BossMod_ShowNameplateAura", isGUID, unit, aura_tbl.texture, aura_tbl.duration, aura_tbl.desaturate, aura_tbl.isPriority)
		DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Show callbacks", 3)
		return
	end

	--call internal show function
	NameplateIcon_Show(isGUID, unit, aura_tbl)
end

---@param isGUID boolean? whether or not it's name based or guid based unit, guid preferred
---@param unit string? the actual name or guid. Can be blank when using force
---@param spellId number? if show is called with spellId, hide must also be called with spellid
---@param texture number|string? accepts texture ID or spell ID
---@param force boolean? set to true to to do a cleanup on all nameplates (basically combat end call)
---@param isHostile boolean? sets true for firing BossMod_DisableFriendlyNameplates callback on force
---@param isFriendly boolean? sets true for firing BossMod_DisableHostileNameplates callback on force
---@param forceDBM boolean? makes it use internal handler even when 3rd party nameplate mod exists
function nameplateFrame:Hide(isGUID, unit, spellId, texture, force, isHostile, isFriendly, forceDBM)
	--Texture Id passed as string so as not to get confused with spellID for GetSpellTexture
	local currentTexture = tonumber(texture) or texture or spellId and DBM:GetSpellTexture(spellId)

	if SupportedNPModIcons() and not forceDBM then --aura icon handling
		--Not running supported NP Mod, internal handling
		DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Hide callbacks", 3)

		if force then
			if isFriendly then
				DBM:FireEvent("BossMod_DisableFriendlyNameplates")
			end
			if isHostile then
				DBM:FireEvent("BossMod_DisableHostileNameplates")
			end
		elseif unit then
			DBM:FireEvent("BossMod_HideNameplateAura", isGUID, unit, currentTexture)
		end

		return
	end

	--call internal hide function
	NameplateIcon_Hide(isGUID or false, unit, currentTexture, force)
end

function nameplateFrame:IsShown()
	return DBMNameplateFrame and DBMNameplateFrame:IsShown()
end

function nameplateFrame:UpdateIconOptions()
	lastOptionsUpdateTime = GetTime()
	for _, frame in pairs(GetNamePlates()) do
		local dbmAuraFrame = frame.DBMAuraFrame
		if dbmAuraFrame then
			for _, iconFrame in pairs(dbmAuraFrame.icons or {}) do
				dbmAuraFrame:ApplyOptions(iconFrame)
			end
		end
	end
end
