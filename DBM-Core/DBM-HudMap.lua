-- Original code and concept by Antiarc. Used and modified with his permission.
-- First adaptation in dbm credits to VEM team. Continued on their behalf do to no time from original author to make it an external mod or DBM plugin.

local ADDON_NAME = ...

DBM.HudMap = {
	Version = 2 -- That way external usage can querie hud api feature level of of users installed mod version
}
local mainFrame = CreateFrame("Frame", "DBMHudMapFrame")
local mod = DBM.HudMap

local wipe, type, pairs, ipairs, tinsert, tremove, tonumber, setmetatable, select, unpack = table.wipe, type, pairs, ipairs, table.insert, table.remove, tonumber, setmetatable, select, unpack
local abs, pow, sqrt, sin, cos, atan2, floor, ceil, min, max, pi2 = math.abs, math.pow, math.sqrt, math.sin, math.cos, math.atan2, math.floor, math.ceil, math.min, math.max, math.pi * 2
local error = error

local CallbackHandler = _G["LibStub"]:GetLibrary("CallbackHandler-1.0")
local updateFrame = CreateFrame("Frame", "DBMHudMapUpdateFrame")
local fixedOnUpdateRate = 0.03
local onUpdate, Point, Edge
local callbacks = CallbackHandler:New(mod)
local activeMarkers = 0
local hudarActive = false
local playerName = UnitName("player")
local encounterMarkers = {}

local GetNumGroupMembers, IsInRaid = GetNumGroupMembers, IsInRaid
local GetTime, WorldFrame = GetTime, WorldFrame
local UnitExists, UnitIsUnit, UnitPosition, UnitIsConnected, GetPlayerFacing = UnitExists, UnitIsUnit, UnitPosition, UnitIsConnected, GetPlayerFacing
local GetInstanceInfo = GetInstanceInfo

local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS

-- TAXIROUTE_LINEFACTOR_2 global is removed in legion, but TAXIROUTE_LINEFACTOR still exists, so we create our own
local TAXIROUTE_LINEFACTOR_2 = TAXIROUTE_LINEFACTOR_2 or TAXIROUTE_LINEFACTOR / 2

-- Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
local standardFont
if (LOCALE_koKR) then
	standardFont = "Fonts\\2002.TTF"
elseif (LOCALE_zhCN) then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif (LOCALE_zhTW) then
	standardFont = "Fonts\\blei00d.TTF"
elseif (LOCALE_ruRU) then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

local targetCanvasAlpha, supressCanvas

local textureLookup = {
	star		= 137001, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_1.blp]]
	circle		= 137002, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_2.blp]]
	diamond		= 137003, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_3.BLP]]
	triangle	= 137004, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_4.blp]]
	moon		= 137005, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_5.blp]]
	square		= 137006, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_6.blp]]
	cross		= 137007, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_7.blp]]
	skull		= 137008, -- [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_8.blp]]
	cross2		= 136813, -- [[Interface\RAIDFRAME\ReadyCheck-NotReady.blp]]
	check		= 136814, -- [[Interface\RAIDFRAME\ReadyCheck-Ready.blp]]
	question	= 136815, -- [[Interface\RAIDFRAME\ReadyCheck-Waiting.blp]]
	targeting	= 136439, -- [[Interface\Minimap\Ping\ping5.blp]]
	highlight	= [[Interface\AddOns\DBM-Core\textures\alert_circle]],
	timer		= [[Interface\AddOns\DBM-Core\textures\timer]],
	glow		= 132039, -- [[Interface\GLUES\MODELS\UI_Tauren\gradientCircle]]
	party		= 249183, -- [[Interface\MINIMAP\PartyRaidBlips]]
	ring		= 165793, -- [[SPELLS\CIRCLE]]
	rune1		= 165630, -- [[SPELLS\AURARUNE256.BLP]]
	rune2		= 165637, -- [[SPELLS\AURARUNE9.BLP]]
	rune3		= 165638, -- [[SPELLS\AURARUNE_A.BLP]]
	rune4		= 165639, -- [[SPELLS\AURARUNE_B.BLP]]
	odunblue	= 1323035, -- [[Interface\Icons\Boss_OdunRunes_Blue.blp]]--Blue fishies
	odungreen	= 1323036, -- [[Interface\Icons\Boss_OdunRunes_Green.blp]]--Green cube
	odunorange	= 1323039, -- [[Interface\Icons\Boss_OdunRunes_Orange.blp]]--Orange N
	odunpurple	= 1323037, -- [[Interface\Icons\Boss_OdunRunes_Purple.blp]]--Purple K
	odunyellow	= 1323038, -- [[Interface\Icons\Boss_OdunRunes_Yellow.blp]]--Yellow H
	astrored	= 1391537, -- [[Interface\Icons\icon_7fx_nightborn_astromancer_red.blp]]--Wolf
	astroyellow	= 1391538, -- [[Interface\Icons\icon_7fx_nightborn_astromancer_yellow.blp]]--Crab
	astroblue	= 1391535, -- [[Interface\Icons\icon_7fx_nightborn_astromancer_blue.blp]]--Dragon
	astrogreen	= 1391536, -- [[Interface\Icons\icon_7fx_nightborn_astromancer_green.blp]]--Hunter
	paw			= 165558, -- [[SPELLS\Agility_128.blp]]
	cyanstar	= 165860, -- [[SPELLS\CYANSTARFLASH.BLP]]
	summon		= 165881, -- [[SPELLS\DarkSummon.blp]]
	reticle		= 166706, -- [[SPELLS\Reticle_128.blp]]
	fuzzyring	= 167208, -- [[SPELLS\WHITERINGTHIN128.BLP]]
	fatring		= 167207, -- [[SPELLS\WhiteRingFat128.blp]]
	swords		= 166984, -- [[SPELLS\Strength_128.blp]]
	beam1		= 424588 -- [[Textures\SPELLCHAINEFFECTS\Beam_01]]
}

local textureKeys, textureVals = {}, {}
mod.textureKeys, mod.textureVals = textureKeys, textureVals

local texBlending = {
	highlight	= "ADD",
	targeting	= "ADD",
	glow		= "ADD",
	ring		= "ADD",
	rune1		= "ADD",
	rune2		= "ADD",
	rune3		= "ADD",
	rune4		= "ADD",
	odunblue	= "ADD",
	odungreen	= "ADD",
	odunorange	= "ADD",
	odunpurple	= "ADD",
	odunyellow	= "ADD",
	astrored	= "ADD",
	astroyellow	= "ADD",
	astroblue	= "ADD",
	astrogreen	= "ADD",
	paw			= "ADD",
	reticle		= "ADD",
	cyanstar	= "ADD",
	summon		= "ADD",
	fuzzyring	= "ADD",
	fatring		= "ADD",
	swords		= "ADD"
	-- timer	= "ADD",
}

local texCoordLookup = {
	party	= { 0.525, 0.6, 0.04, 0.2 },
	tank	= { 0.5, 0.75, 0, 1 },
	dps		= { 0.75, 1, 0, 1 },
	healer	= { 0.25, 0.5, 0, 1 },
	paw		= { 0.124, 0.876, 0.091, 0.903 },
	rune4	= { 0.032, 0.959, 0.035, 0.959 },
	reticle	= { 0.05, 0.95, 0.05, 0.95 }
}

local frameScalars = {
	rune1	= 0.86,
	rune2	= 0.86,
	rune3	= 0.77,
	summon	= 0.86,
}

local function UnregisterAllCallbacks(obj)
	-- Cancel all registered callbacks. CBH doesn't seem to provide a method to do this.
	if obj.callbacks.insertQueue then
		for _, callbacks in pairs(obj.callbacks.insertQueue) do
			for k, _ in pairs(callbacks) do
				callbacks[k] = nil
			end
		end
	end
	for eventname, callbacks in pairs(obj.callbacks.events) do
		for k, _ in pairs(callbacks) do
			callbacks[k] = nil
		end
		if obj.callbacks.OnUnused then
			obj.callbacks.OnUnused(obj.callbacks, obj, eventname) -- Make sure this doesn't error. :)
		end
	end
end

mod.RegisterTexture = function(_, key, tex, blend, cx1, cx2, cy1, cy2, scalar)
	if key then
		textureLookup[key] = tex
		if blend then
			texBlending[key] = blend
		end
		if cx1 and cx2 and cy1 and cy2 then
			texCoordLookup[key] = {cx1, cx2, cy1, cy2}
		end
		if scalar then
			frameScalars[key] = scalar
		end
	end
	wipe(textureKeys)
	for k, _ in pairs(textureLookup) do
		tinsert(textureKeys, k)
	end
	wipe(textureVals)
	for _, v in pairs(textureLookup) do
		textureVals[v] = v
	end
end
mod:RegisterTexture()

mod.UnitIsMappable = function(unit, allowSelf)
	return (allowSelf and UnitIsUnit("player", unit)) or UnitPosition(unit) or UnitIsConnected(unit)
end

mod.free = function(e, owner, id, noAnimate)
	if e and not e.freed then
		if owner and id then
			if e:Owned(owner, id) then
				e:Free(noAnimate)
			else
				return e
			end
		else
			e:Free()
		end
	end
end

local function groupIter(state, index)
	if index < 0 then
		return
	end
	local unit = (IsInRaid() and "raid" or "party") .. index
	if UnitExists(unit) then
		return index + 1, unit
	elseif GetNumGroupMembers() == 0 then
		return -1, "player"
	end
end

local function group()
	return groupIter, nil, 1
end

mod.group = group

local pointCache, edgeCache = {}, {}
local activePointList, activeEdgeList = {}, {}

local zoomScale, targetZoomScale, fixedZoomScale = 45, 40, nil
local lastPlayerX, lastPlayerY

do
	local fine, coarse = 1 / 60, 3
	local fineTotal, coarseTotal = 0, 0
	local zoomDelay, fadeInDelay, fadeOutDelay = 0.5, 0.25, 0.5

	local function computeNewScale()
		if fixedZoomScale then
			return fixedZoomScale
		end
		local px, py = mod:GetUnitPosition("player")
		lastPlayerX, lastPlayerY = px, py
		local maxDistance = 0
		for point, _ in pairs(activePointList) do
			local d = point:Distance(px, py, true)

			if d > 0 and d < 200 and d > maxDistance then
				maxDistance = d
			end
		end
		if maxDistance < 20 then
			maxDistance = 20
		end
		return maxDistance
	end

	function onUpdate(_, t)
		fineTotal = fineTotal + t
		coarseTotal = coarseTotal + t
		if coarseTotal > coarse then
			coarseTotal = coarseTotal % coarse
		end
		if fineTotal > fine then
			local steps = floor(fineTotal / fine)
			local elapsed = fine * steps
			fineTotal = fineTotal - elapsed
			targetZoomScale = computeNewScale()
			local currentAlpha = mod.canvas:GetAlpha()
			if not supressCanvas and targetCanvasAlpha and currentAlpha ~= targetCanvasAlpha then
				local newAlpha
				if targetCanvasAlpha > currentAlpha then
					newAlpha = min(targetCanvasAlpha, currentAlpha + 1 * elapsed / fadeInDelay)
				else
					newAlpha = max(targetCanvasAlpha, currentAlpha - 1 * elapsed / fadeOutDelay)
				end
				if newAlpha == 0 and targetCanvasAlpha then
					mod.canvas:Hide()
				end
				mod.canvas:SetAlpha(newAlpha)
			elseif targetCanvasAlpha == 0 and currentAlpha == 0 then
				mod.canvas:Hide()
			end
			if zoomScale < targetZoomScale then
				zoomScale = min(targetZoomScale, zoomScale + ceil((targetZoomScale - zoomScale) * elapsed / zoomDelay))
			elseif zoomScale > targetZoomScale then
				zoomScale = max(targetZoomScale, zoomScale - ceil((zoomScale - targetZoomScale) * elapsed / zoomDelay))
			end
			mod:Update()
			callbacks:Fire("Update", mod)
		end
	end
end

function mod:OnInitialize()
	self.canvas = CreateFrame("Frame", "DBMHudMapCanvas", WorldFrame)
	self.canvas:SetSize(WorldFrame:GetWidth(), WorldFrame:GetHeight())
	self.canvas:SetPoint("CENTER")
	self.canvas:Hide()
	self.HUDEnabled = false
end

function mod:Enable()
	if DBM.Options.DontShowHudMap2 or self.HUDEnabled or DBM:HasMapRestrictions() then
		return
	end
	DBM:Debug("HudMap Activating", 2)
	self.currentMap = select(8, GetInstanceInfo())
	mainFrame:Show()
	mainFrame:RegisterEvent("LOADING_SCREEN_DISABLED")
	if not supressCanvas then
		self.canvas:Show()
	end
	self.canvas:SetAlpha(1)
	self:UpdateCanvasPosition()
	targetZoomScale = 6
	self.pixelsPerYard = WorldFrame:GetHeight() / self:GetMinimapSize()
	self:SetZoom()
	self.HUDEnabled = true
	updateFrame:Show()
	if not updateFrame.ticker then
		updateFrame.ticker = C_Timer.NewTicker(fixedOnUpdateRate, function()
			onUpdate(updateFrame, fixedOnUpdateRate)
		end)
	end
end

function mod:Disable()
	if not self.HUDEnabled then
		return
	end
	DBM:Debug("HudMap Deactivating", 2)
	self:FreeEncounterMarkers()
	Edge:ClearAll()
	if hudarActive then -- Don't disable if hudar is open
		return
	end
	mainFrame:UnregisterEvent("LOADING_SCREEN_DISABLED")
	self.canvas:Hide()
	mainFrame:Hide()
	updateFrame:Hide()
	self.HUDEnabled = false
	if updateFrame.ticker then
		updateFrame.ticker:Cancel()
		updateFrame.ticker = nil
	end
end

function mod:ToggleHudar(r, hide)
	if hudarActive or hide then
		hudarActive = false
		self:FreeEncounterMarkerByTarget(143430, playerName)
	else
		hudarActive = true
		self:RegisterRangeMarkerOnPartyMember(143430, "timer", playerName, 1.5, nil, 0, 1, 0, 0.3):Appear():RegisterForAlerts("all"):Rotate(360, 9.5)
	end
end

do
	mainFrame:SetScript("OnEvent", function(_, event, addon)
		if event == "ADDON_LOADED" and addon == ADDON_NAME then
			mod:OnInitialize()
			mainFrame:UnregisterEvent("ADDON_LOADED")
		elseif event == "LOADING_SCREEN_DISABLED" then
			mod.currentMap = select(8, GetInstanceInfo())
		end
	end)
	mainFrame:RegisterEvent("ADDON_LOADED")
end

function mod:PointExists(id)
	for k, _ in pairs(activePointList) do
		if(k.id == id) then
			return true
		end
	end
	return false
end

function mod:UpdateCanvasPosition()
	self.canvas:ClearAllPoints()
	self.canvas:SetPoint("CENTER", WorldFrame, "CENTER")
	self.canvas:SetSize((WorldFrame:GetHeight() * 0.48) * 2, (WorldFrame:GetHeight() * 0.48) * 2)
end

-----------------------------------
--- Points
-----------------------------------
mod.textures = textureLookup

local animations = {
	onLoad = function(self)
		self.regionParent = self:GetRegionParent()
	end,
	scale = function(self)
		local p = self:GetProgress()
		local progress = self:GetParent():GetLoopState() == "REVERSE" and (1 - p) or p
		if progress < 0 then
			progress = 0
		elseif progress > 1
			then progress = 1
		end
		self.regionParent:SetScale(1 + ((self.pulseTarget - 1) * progress))
	end,
	alpha = function(self)
		self.regionParent:SetAlpha(self:GetProgress())
	end,
	fullOpacity = function(self)
		self.regionParent:SetAlpha(1)
	end,
	scaleIn = function(self)
		self.regionParent:SetScale(1 + ((1 - self:GetProgress()) * 0.5))
	end,
	hideParent = function(self)
		self:GetRegionParent():Hide()
	end,
	replay = function(self)
		self:Play()
	end
}

local function DrawRouteLineCustom(T, C, sx, sy, ex, ey, w, extend, relPoint)
	if not relPoint then
		relPoint = "BOTTOMLEFT"
	end
	-- Determine dimensions and center point of line
	local dx, dy = ex - sx, ey - sy
	local cx, cy = (sx + ex) / 2, (sy + ey) / 2
	-- Normalize direction if necessary
	local reverse = dx < 0 and -1 or 1
	if dx < 0 then
		dx, dy = -dx, -dy
	end
	-- Calculate actual length of line
	local l = sqrt((dx * dx) + (dy * dy))
	-- Quick escape if it's zero length
	if l == 0 then
		T:SetTexCoord(0, 0, 0, 0, 0, 0, 0, 0)
		T:SetPoint("BOTTOMLEFT", C, relPoint, cx, cy)
		T:SetPoint("TOPRIGHT", C, relPoint, cx, cy)
		return
	end
	-- Sin and Cosine of rotation, and combination (for later)
	local s, c = -dy / l, dx / l
	local sc = s * c
	-- Calculate bounding box size and texture coordinates
	local Bwid, Bhgt, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy
	if dy >= 0 then
		Bwid = ((l * c) - (w * s)) * TAXIROUTE_LINEFACTOR_2
		Bhgt = ((w * c) - (l * s)) * TAXIROUTE_LINEFACTOR_2
		BLx, BLy, BRy = (w / l) * sc, s * s, (l / w) * sc
		BRx, TLx, TLy, TRx = 1 - BLy, BLy, 1 - BRy, 1 - BLx
		TRy = BRx
	else
		Bwid = ((l * c) + (w * s)) * TAXIROUTE_LINEFACTOR_2
		Bhgt = ((w * c) + (l * s)) * TAXIROUTE_LINEFACTOR_2
		BLx, BLy, BRx = s * s, -(l / w) * sc, 1 + (w / l) * sc
		BRy, TLx, TLy, TRy = BLx, 1 - BRx, 1 - BLx, 1 - BLy
		TRx = TLy
	end
	Bwid = Bwid * reverse
	Bhgt = Bhgt * reverse
	T:ClearAllPoints()
	-- Hack to fix backwards arrow since it's easier to fix here than figure out wtf is going on up above
	if reverse == 1 then
		T:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy)
	else
		T:SetTexCoord(BRx, BRy, TRx, TRy, BLx, BLy, TLx, TLy)
	end
	T:SetPoint("BOTTOMLEFT", C, relPoint, cx - Bwid, cy - Bhgt)
	T:SetPoint("TOPRIGHT", C, relPoint, cx + Bwid, cy + Bhgt)
end

local animationNames = { "fadeOutGroup", "fadeOut", "repeatAnimations", "pulseAnimations", "pulse", "rotate", "fadeInGroup" }
local Object = {
	Serial = function(self, prefix)
		self.serials = self.serials or {}
		self.serials[prefix] = (self.serials[prefix] or 0) + 1
		return prefix .. self.serials[prefix]
	end,
	OnAcquire = function(self)
		if self.freed == false then
			error("ERROR: Attempted to reallocate a freed object.")
		end
		self.radiusClipOffset = nil
		self.fixedClipOffset = nil
		self.ownerModule = nil
		self.id = nil
		self.freed = false
		self.frame:Show()
		self.frame:SetAlpha(1)
		self.frame:StopAnimating()
		for _, anim in ipairs(animationNames) do
			if self[anim] then self[anim]:Stop() end
		end
	end,
	OnFree = function(self, noAnimate)
		if self.freed then
			return false
		end
		self.freed = true
		self.callbacks:Fire("Free", self)
		UnregisterAllCallbacks(self)
		self:Hide(noAnimate)
	end,
	ParseSize = function(self, size)
		local yards, fixed
		if type(size) == "string" then
			local t = size:match("(%d+)px")
			if t then
				fixed = tonumber(t)
			else
				t = size:match("(%d+)yd")
				if t then
					yards = tonumber(t)
				end
			end
		else
			yards = size
		end
		return yards, fixed
	end,
	SetClipOffset = function(self, offset)
		self.radiusClipOffset, self.fixedClipOffset = self:ParseSize(offset)
		return self
	end,
	Identify = function(self, ownerModule, id)
		self.ownerModule = ownerModule
		self.id = id
		return self
	end,
	Owned = function(self, ownerModule, id)
		return not self.freed and ownerModule == self.ownerModule and id == self.id
	end,
	Show = function(self, noAnimate)
	end,
	Hide = function(self, noAnimate)
		if noAnimate then
			self.frame:Hide()
			self.frame:StopAnimating()
		else
			self.fadeOutGroup:Play()
		end
	end
}

local object_mt = {
	__index = Object
}
local edge_mt, point_mt = {}, {}

Edge = setmetatable({
	Free = function(self, noAnimate)
		if self:OnFree(noAnimate) == false then
			return
		end
		for point, _ in pairs(self.points) do
			point:DetachEdge(self)
		end
		wipe(self.points)
		self.srcPlayer, self.dstPlayer, self.sx, self.sy, self.dx, self.dy = nil, nil, nil, nil, nil, nil
		activeEdgeList[self] = nil
		tinsert(edgeCache, self)
		activeMarkers = activeMarkers - 1
		if activeMarkers == 0 then
			mod:Disable()
		end
		return nil
	end,
	New = function(self, r, g, b, a, srcPlayer, dstPlayer, sx, sy, dx, dy, lifetime, texfile, w, extend)
		local t = tremove(edgeCache)
		if not t then
			t = setmetatable({}, edge_mt)
			t.points = {}
			t.serial = self:Serial("Edge")
			t.callbacks = CallbackHandler:New(t)
			t.frame = CreateFrame("Frame", nil, mod.canvas)
			t.frame:SetFrameStrata("LOW")
			t.texture = t.frame:CreateTexture()
			t.texture:SetAllPoints()
			t.texture:SetTexture(textureLookup[texfile] or texfile or [[Interface\AddOns\DBM-Core\textures\line]])
			t.fadeOutGroup = t.frame:CreateAnimationGroup()

			t.fadeOut = t.fadeOutGroup:CreateAnimation("alpha")
			t.fadeOut:SetFromAlpha(1)
			t.fadeOut:SetToAlpha(0)
			t.fadeOut:SetDuration(0.25)
			t.fadeOut:SetScript("OnFinished", animations.hideParent)
		end
		t:OnAcquire()
		t.srcPoint = nil
		t.dstPoint = nil

		t.lifetime = type(lifetime) == "number" and GetTime() + lifetime or nil
		t:SetColor(r, g, b, a)
		t.srcPlayer, t.dstPlayer = srcPlayer, dstPlayer
		t.sx, t.sy, t.dx, t.dy, t.w, t.extend = sx, sy, dx, dy, w, extend
		activeEdgeList[t] = true
		activeMarkers = activeMarkers + 1
		return t
	end,
	SetColor = function(self, r, g, b, a)
		self.r = r or 1
		self.g = g or 1
		self.b = b or 1
		self.a = a or 1
		self.texture:SetVertexColor(r, g, b, a)
	end,
	AttachPoint = function(self, point)
		self.points[point] = true
	end,
	DetachPoint = function(self, point)
		self.points[point] = nil
	end,
	TrackFrom = function(self, src_or_x, y)
		if type(src_or_x) == "string" then
			self.srcPlayer = src_or_x
		elseif type(src_or_x) == "table" then
			self.srcPoint = src_or_x
		elseif src_or_x and y then
			self.srcPlayer = nil
			self.sx = src_or_x
			self.sy = y
		end
		return self
	end,
	TrackTo = function(self, dst_or_x, y)
		if type(dst_or_x) == "string" then
			self.dstPlayer = dst_or_x
		elseif type(dst_or_x) == "table" then
			self.dstPoint = dst_or_x
		elseif dst_or_x and y then
			self.dstPlayer = nil
			self.dx = dst_or_x
			self.dy = y
		end
		return self
	end,
	ClearAll = function(self)
		for t, _ in pairs(activeEdgeList) do
			t:Free()
		end
	end,
	UpdateAll = function(self)
		if(self ~= Edge) then
			return
		end
		for t, _ in pairs(activeEdgeList) do
			t:Update()
		end
	end,
	Update = function(self)
		if self.lifetime and GetTime() > self.lifetime then
			self:Free()
			return
		end
		local sx, sy, dx, dy
		if self.srcPlayer then
			sx, sy = mod:GetUnitPosition(self.srcPlayer)
		elseif self.srcPoint then
			sx, sy = self.srcPoint:Location()
		elseif self.sx and self.sy then
			sx, sy = self.sx, self.sy
		end
		if self.dstPlayer then
			if self.extend then
				local destx, desty = mod:GetUnitPosition(self.dstPlayer)
				local extendValue = zoomScale - mod:DistanceBetweenPoints(destx, desty, lastPlayerX, lastPlayerY)
				if extendValue > 0 then
					dx, dy = self:Extend(sx, sy, destx, desty, extendValue)
				else
					dx, dy = destx, desty
				end
			else
				dx, dy = mod:GetUnitPosition(self.dstPlayer)
			end
		elseif self.dstPoint then
			dx, dy = self.dstPoint:Location()
		elseif self.dx and self.dy then
			dx, dy = self.dx, self.dy
		end
		local w = self.w or 100
		local visible
		if sx and sy and dx and dy then
			local px, py = mod:GetUnitPosition("player")
			local radius = zoomScale * zoomScale
			visible = pow(px - sx, 2) + pow(py - sy, 2) < radius or pow(px - dx, 2) + pow(py - dy, 2) < radius
			sx, sy = mod:LocationToMinimapOffset(sx, sy, true, self.radiusClipOffset, self.fixedClipOffset)
			dx, dy = mod:LocationToMinimapOffset(dx, dy, true, self.radiusClipOffset, self.fixedClipOffset)
		end
		if visible then
			local ox = mod.canvas:GetWidth() / 2
			local oy = mod.canvas:GetHeight() / 2
			sx = sx + ox
			dx = dx + ox
			sy = sy + oy
			dy = dy + oy
			local ax = dx - sx
			local ay = dy - sy
			if pow((ax * ax) + (ay * ay), 0.5) > 15 then
				self.texture:Show()
				DrawRouteLineCustom(self.texture, mod.canvas, sx, sy, dx, dy, w, self.extend)
			else
				self.texture:Hide()
			end
		end
	end,
	Extend = function(self, sx, sy, dx, dy, dist)
		local cx = dx - sx
		local cy = dy - sy
		local len = sqrt(cx * cx + cy * cy)
		return ((cx / len) * dist) + dx, ((cy / len) * dist) + dy
	end,
}, object_mt)

function mod:AddEdge(r, g, b, a, lifetime, srcPlayer, dstPlayer, sx, sy, dx, dy, w, texfile, extend)
	if DBM.Options.DontShowHudMap2 then
		return
	end
	if not self.HUDEnabled then
		self:Enable()
	end
	return Edge:New(r, g, b, a, srcPlayer, dstPlayer, sx, sy, dx, dy, lifetime, texfile, w, extend)
end

function mod:ClearAllEdges()
	Edge:ClearAll()
end

do
	Point = setmetatable({
		Free = function(self, noAnimate)
			if self:OnFree(noAnimate) == false then
				return
			end
			for edge, _ in pairs(self.edges) do
				edge:Free()
			end
			wipe(self.edges)
			self.stickX = nil
			self.stickY = nil
			self.follow = nil
			self.lifetime = nil
			self.lastPPY = nil
			self.lastRadius = nil
			activePointList[self] = nil
			tinsert(pointCache, self)
		end,
		AttachEdge = function(self, edge)
			self.edges[edge] = true
			edge:AttachPoint(self)
		end,
		DetachEdge = function(self, edge)
			self.edges[edge] = nil
			edge:DetachPoint(self)
		end,
		Stick = function(self, map, x, y)
			self.follow = nil
			self.map = map
			self.stickX = x
			self.stickY = y
			return self
		end,
		Follow = function(self, unit)
			self.stickX = nil
			self.stickY = nil
			self.follow = unit
			return self
		end,
		Location = function(self)
			if self.stickX then
				return self.stickX, self.stickY
			elseif self.follow then
				return mod:GetUnitPosition(self.follow)
			end
		end,
		Update = function(self)
			if (self.map and mod.currentMap ~= self.map and not self.persist) or (not self.lifetime or self.lifetime > 0 and self.lifetime < GetTime()) then
				self:Free()
				return
			end
			local x, y
			self.callbacks:Fire("Update", self)
			if not self.alwaysShow then
				local distance
				local px, py = mod:GetUnitPosition("player")
				distance, x, y = self:Distance(px, py, true)
				if distance > 200 then
					self:Hide()
					return
				end
			else
				x, y = self:Location()
			end
			if not x or not y or (x == 0 and y == 0) then
				self:Free()
				return
			elseif not self.frame:IsVisible() then
				self.frame:Show()
				self.fadeIn:Play()
			end
			x, y = mod:LocationToMinimapOffset(x, y, self.alwaysShow, self.radiusClipOffset or self.radius, self.fixedClipOffset or self.fixedSize)
			local needUpdate
			if self.follow == "player" then
				needUpdate = not self.placed
			else
				needUpdate = self.lastX ~= x or self.lastY ~= y
			end
			self:UpdateSize()
			if needUpdate then
				self.frame:ClearAllPoints()
				self.frame:SetPoint("CENTER", self.frame:GetParent(), "CENTER", x, y)
			end
			self.placed = true
			self.lastX = x
			self.lastY = y
			if self.shouldUpdateRange then
				self:UpdateAlerts()
			end
		end,
		UpdateSize = function(self)
			if self.radius then
				if self.lastPPY ~= mod.pixelsPerYard or self.lastRadius ~= self.radius then
					self.lastPPY = mod.pixelsPerYard
					self.lastRadius = self.radius
					local pixels = mod:RangeToPixels((self.radius / (frameScalars[self.texfile] or 1)) * 2)
					self.frame:SetSize(pixels, pixels)
				end
			elseif self.fixedSize then
				self.frame:SetSize(self.fixedSize, self.fixedSize)
			end
		end,
		UpdateAll = function(self)
			if(self ~= Point) then
				return
			end
			for t, _ in pairs(activePointList) do
				t:Update()
			end
		end,
		Pulse = function(self, size, speed)
			self.pulseSize = size
			self.pulseSpeed = speed
			self.pulse:SetDuration(speed)
			self.pulse:SetScale(size, size)
			self.pulseIn:SetDuration(speed)
			self.pulseIn:SetScale(1 / size, 1 / size)
			self.pulseAnimations:Play()
			return self
		end,
		Rotate = function(self, amount, speed)
			self.rotateAmount = amount
			self.rotateSpeed = speed
			speed = speed * (360 / amount)
			amount = -360
			if speed < 0 then
				speed = speed * -1
				amount = 360
			end
			self.rotate:SetDuration(speed)
			self.rotate:SetDegrees(amount)
			self.repeatAnimations:Play()
			return self
		end,
		Appear = function(self)
			self.fadeInGroup:Play()
			return self
		end,
		SetTexCoords = function(self, a, b, c, d)
			self.texture:SetTexCoord(a, b, c, d)
			return self
		end,
		Alert = function(self, bool)
			self.texture:SetVertexColor(
				bool and self.alert.r or self.normal.r or 1,
				bool and self.alert.g or self.normal.g or 1,
				bool and self.alert.b or self.normal.b or 1,
				bool and self.alert.a or self.normal.a or 1
			)
			if bool then
				self:SetLabel(self.alertLabel, nil, nil, nil, nil, nil, 0.8)
			end
			return self
		end,
		RegisterForAlerts = function(self, bool, alertLabel)
			self.alertLabel = alertLabel
			self.shouldUpdateRange = bool == nil and true or bool
			return self
		end,
		Distance = function(self, x2, y2, includeRadius)
			local x, y = self:Location()
			if not x or not y or (x == 0 and y == 0) then
				return -1
			end
			local e = x2 - x
			local f = y2 - y
			return sqrt((e * e)+ (f * f)) + (includeRadius and self.radius or 0), x, y
		end,
		Persist = function(self, bool)
			self.persist = bool == nil and true or bool
			return self
		end,
		AlwaysShow = function(self, bool)
			self.alwaysShow = bool == nil and true or bool
			return self
		end,
		UpdateAlerts = function(self)
			if not self.radius then
				return
			end
			local x, y = self:Location()
			local alert = false
			if type(self.shouldUpdateRange) == "string" and self.shouldUpdateRange ~= "all" then -- Spellname passed, debuff filter
				if not DBM:UnitDebuff("player", self.shouldUpdateRange) then -- Debuff faded from player, auto switch to "all" type
					self.shouldUpdateRange = true
					self:UpdateAlerts(self)
					return
				end
				for _, unit in group() do
					if not DBM:UnitDebuff(unit, self.shouldUpdateRange) and not UnitIsDead(unit) then
						alert = mod:DistanceToPoint(unit, x, y) < self.radius
						if alert then
							break
						end
					end
				end
			elseif self.shouldUpdateRange == "all" or (self.follow and UnitIsUnit(self.follow, "player")) then
				for _, unit in group() do
					if not UnitIsUnit(unit, "player") and not UnitIsDead(unit) then
						alert = mod:DistanceToPoint(unit, x, y) < self.radius
						if alert then
							break
						end
					end
				end
			else
				alert = mod:DistanceToPoint("player", x, y) < self.radius
			end
			self:Alert(alert)
		end,
		SetColor = function(self, r, g, b, a)
			self.normal.r = r or 1
			self.normal.g = g or 1
			self.normal.b = b or 1
			self.normal.a = a or 0.5
			self:Alert(false)
			return self
		end,
		SetAlertColor = function(self, r, g, b, a)
			self.alert.r = r or 1
			self.alert.g = g or 0
			self.alert.b = b or 0
			self.alert.a = a or 0.5
			return self
		end,
		SetTexture = function(self, texfile, blend)
			local tex = self.texture
			texfile = texfile or "glow"
			tex:SetTexture(textureLookup[texfile] or texfile or 132039) -- [[Interface\GLUES\MODELS\UI_Tauren\gradientCircle]]
			if texCoordLookup[texfile] then
				tex:SetTexCoord(unpack(texCoordLookup[texfile]))
			else
				tex:SetTexCoord(0, 1, 0, 1)
			end
			blend = blend or texBlending[texfile] or "BLEND"
			tex:SetBlendMode(blend)
			return self
		end,
		SetLabel = function(self, text, anchorFrom, anchorTo, r, g, b, a, xOff, yOff, fontSize, outline)
			self.text.anchorFrom = anchorFrom or self.text.anchorFrom
			self.text.anchorTo = anchorTo or self.text.anchorTo
			self.text:ClearAllPoints()
			if not r and text then
				local _, cls = UnitClass(text)
				if cls and RAID_CLASS_COLORS[cls] then
					r, g, b = RAID_CLASS_COLORS[cls].r, RAID_CLASS_COLORS[cls].g, RAID_CLASS_COLORS[cls].b
					text = DBM:GetShortServerName(text)
				end
			end
			self.text.r = r or self.text.r
			self.text.g = g or self.text.g
			self.text.b = b or self.text.b
			self.text.a = a or self.text.a
			self.text.xOff = xOff or self.text.xOff or 0
			self.text.yOff = yOff or self.text.yOff or 0
			if not text or text == "" then
				self.text:SetText(nil)
				self.text:Hide()
			else
				self.text:SetPoint(self.text.anchorFrom, self.frame, self.text.anchorTo, self.text.xOff, self.text.yOff)
				self.text:SetTextColor(self.text.r, self.text.g, self.text.b, self.text.a)
				self.text:Show()
				local f, s, m = self.text:GetFont()
				local font = f or standardFont
				local size = fontSize or s or 20
				outline = outline or m or "THICKOUTLINE"
				self.text:SetFont(font, size, outline)
				self.text:SetText(text)
			end
			self.labelData = self.labelData or {}
			wipe(self.labelData)
			self.labelData.text = text
			self.labelData.anchorFrom = anchorFrom
			self.labelData.anchorTo = anchorTo
			self.labelData.r = r
			self.labelData.g = g
			self.labelData.b = b
			self.labelData.a = a
			self.labelData.xOff = xOff
			self.labelData.yOff = yOff
			self.labelData.fontSize = fontSize
			self.labelData.outline = outline
			return self
		end,
		SetSize = function(self, size)
			self.lastRadius = nil
			self.size = size
			self.radius, self.fixedSize = self:ParseSize(size)
			if not self.radius and not self.fixedSize then
				self.fixedSize = 20
			end
			self:UpdateSize()
			return self
		end,
		EdgeFrom = function(self, point_or_unit_or_x, to_y, lifetime, r, g, b, a, w, texfile, extend)
			local fromPlayer = self.follow
			local unit, x, y
			if type(point_or_unit_or_x) == "table" then
				unit = point_or_unit_or_x.follow
				x = point_or_unit_or_x.stickX
				y = point_or_unit_or_x.stickY
			else
				unit = to_y == nil and point_or_unit_or_x
				x = to_y ~= nil and point_or_unit_or_x
				y = to_y
			end
			local edge = Edge:New(r, g, b, a, fromPlayer, unit, self.stickX, self.stickY, x, y, lifetime, texfile, w, extend)
			self:AttachEdge(edge)
			if type(point_or_unit_or_x) == "table" then
				point_or_unit_or_x:AttachEdge(edge)
				edge:SetClipOffset(point_or_unit_or_x.fixedSize and point_or_unit_or_x.fixedSize .. "px" or point_or_unit_or_x.radius)
			else
				edge:SetClipOffset(self.fixedSize and self.fixedSize .. "px" or self.radius)
			end
			return edge
		end,
		EdgeTo = function(self, point_or_unit_or_x, from_y, lifetime, r, g, b, a, w, texfile, extend)
			local toPlayer = self.follow
			local unit, x, y
			if type(point_or_unit_or_x) == "table" then
				unit = point_or_unit_or_x.follow
				x = point_or_unit_or_x.stickX
				y = point_or_unit_or_x.stickY
			else
				unit = from_y == nil and point_or_unit_or_x
				x = from_y ~= nil and point_or_unit_or_x
				y = from_y
			end
			local edge = Edge:New(r, g, b, a, unit, toPlayer, x, y, self.stickX, self.stickY, lifetime, texfile, w, extend)
			self:AttachEdge(edge)
			if type(point_or_unit_or_x) == "table" then
				point_or_unit_or_x:AttachEdge(edge)
			end
			edge:SetClipOffset(self.fixedSize and self.fixedSize .. "px" or self.radius)
			return edge
		end,
		Broadcast = function(self)
			local data = self.sendData or {}
			wipe(data)
			data.map = self.map
			data.x, data.y = self:Location()
			data.lifetime = self.baseLifetime
			data.texfile = self.texfile
			data.size = self.size
			data.blend = self.blend
			data.r = self.normal.r
			data.g = self.normal.g
			data.b = self.normal.b
			data.a = self.normal.a
			data.ar = self.alert.r
			data.ag = self.alert.g
			data.ab = self.alert.b
			data.aa = self.alert.a
			data.id = self.id
			data.pulseSize = self.pulseSize
			data.pulseSpeed = self.pulseSpeed
			data.rotateAmount = self.rotateAmount
			data.rotateSpeed = self.rotateSpeed
			data.alertLabel = self.alertLabel
			data.shouldUpdateRange = self.shouldUpdateRange
		end,
		New = function(self, map, x, y, follow, lifetime, texfile, size, blend, r, g, b, a)
			local t = tremove(pointCache)
			if not t then
				t = setmetatable({}, point_mt)
				t.serial = self:Serial("Circle")
				t.callbacks = CallbackHandler:New(t)
				t.frame = CreateFrame("Frame", nil, mod.canvas)
				t.frame:SetFrameStrata("LOW")
				t.frame.owner = t
				t.text = t.frame:CreateFontString()
				t.text:SetFont(standardFont, 10, "")
				t.text:SetDrawLayer("OVERLAY")
				t.text:SetPoint("BOTTOM", t.frame, "CENTER")
				t.edges = {}
				t.texture = t.frame:CreateTexture()
				t.texture:SetAllPoints()
				t.repeatAnimations = t.frame:CreateAnimationGroup()
				t.repeatAnimations:SetLooping("REPEAT")
				t.pulseAnimations = t.frame:CreateAnimationGroup()
				t.pulseAnimations:SetScript("OnFinished", animations.replay)
				t.pulse = t.pulseAnimations:CreateAnimation("scale")
				t.pulse:SetOrder(1)
				t.pulseIn = t.pulseAnimations:CreateAnimation("scale")
				t.pulseIn:SetOrder(2)
				t.pulse:SetScript("OnPlay", animations.onLoad)
				t.rotate = t.repeatAnimations:CreateAnimation("rotation")
				t.normal, t.alert = {}, {}
				do
					t.fadeInGroup = t.frame:CreateAnimationGroup()
					local scaleOut = t.fadeInGroup:CreateAnimation("scale")
					scaleOut:SetDuration(0)
					scaleOut:SetScale(1.5, 1.5)
					scaleOut:SetOrder(1)
					t.fadeIn = t.fadeInGroup:CreateAnimation()
					t.fadeIn:SetDuration(0.35)
					t.fadeIn:SetScript("OnPlay", function(self)
						animations.onLoad(self)
						t.fadeOutGroup:Stop()
					end)
					t.fadeIn:SetScript("OnUpdate", animations.alpha)
					t.fadeIn:SetScript("OnStop", animations.fullOpacity)
					t.fadeIn:SetOrder(2)
					local scaleIn = t.fadeInGroup:CreateAnimation("scale")
					scaleIn:SetDuration(0.35)
					scaleIn:SetScale(1 / 1.5, 1 / 1.5)
					scaleIn:SetOrder(2)
				end
				t.fadeOutGroup = t.frame:CreateAnimationGroup()
				t.fadeOut = t.fadeOutGroup:CreateAnimation("alpha")
				t.fadeOut:SetFromAlpha(1)
				t.fadeOut:SetToAlpha(0)
				t.fadeOut:SetDuration(0.25)
				t.fadeOut:SetScript("OnFinished", animations.hideParent)
				t.fadeOutGroup:SetScript("OnPlay", function() t.fadeInGroup:Stop() end)
			end
			-- These need to be reset so that reconstitution via broadcasts don't get pooched up.
			t.id = nil
			t.shouldUpdateRange = nil
			t.pulseSize = nil
			t.rotateAmount = nil
			t:OnAcquire()
			t.texture:SetDrawLayer("ARTWORK")
			t.alwaysShow = nil
			t.persist = nil
			t.placed = false
			t:SetLabel(nil, "CENTER", "CENTER", r, g, b, a)
			t.texfile = texfile
			t:SetTexture(texfile, blend)
			t:SetSize(size or 20)
			t:SetColor(r, g, b, a)
			t:SetAlertColor(1, 0, 0, a)
			t:Alert(false)
			t.shouldUpdateRange = false
			if x and y then
				t:Stick(map, x, y)
			elseif follow then
				t:Follow(follow)
			end
			t.baseLifetime = lifetime
			t.lifetime = lifetime and (GetTime() + lifetime) or -1
			t.map = map
			activePointList[t] = true
			t.callbacks:Fire("New", t)
			return t
		end,
	}, object_mt)
end
edge_mt.__index = Edge
point_mt.__index = Point

function mod:PlaceRangeMarker(texture, x, y, radius, duration, r, g, b, a, blend)
	return Point:New(self.currentMap, x, y, nil, duration, texture, radius, blend, r, g, b, a)
end

function mod:PlaceStaticMarkerOnPartyMember(texture, person, radius, duration, r, g, b, a, blend)
	if not r and person then -- Auto generate class color if colors were left nil
		local _, cls = UnitClass(person)
		if cls and RAID_CLASS_COLORS[cls] then
			r, g, b = RAID_CLASS_COLORS[cls].r, RAID_CLASS_COLORS[cls].g, RAID_CLASS_COLORS[cls].b
		else
			DBM:Debug("HudMap Marker failed, no color defined and no unit class")
			return
		end
	end
	local x, y = self:GetUnitPosition(person)
	return Point:New(self.currentMap, x, y, nil, duration, texture, radius, blend, r, g, b, a)
end

function mod:PlaceRangeMarkerOnPartyMember(texture, person, radius, duration, r, g, b, a, blend)
	if not r and person then -- Auto generate class color if colors were left nil
		local _, cls = UnitClass(person)
		if cls and RAID_CLASS_COLORS[cls] then
			r, g, b = RAID_CLASS_COLORS[cls].r, RAID_CLASS_COLORS[cls].g, RAID_CLASS_COLORS[cls].b
		else
			DBM:Debug("HudMap Marker failed, no color defined and no unit class")
			return
		end
	end
	return Point:New(nil, nil, nil, person, duration, texture, radius, blend, r, g, b, a)
end

function mod:RegisterEncounterMarker(spellid, name, marker)
	if DBM.Options.DontShowHudMap2 then return end
	if not self.HUDEnabled then
		self:Enable()
	end
	encounterMarkers[spellid .. name] = marker
	activeMarkers = activeMarkers + 1
	marker.RegisterCallback(self, "Free", "FreeEncounterMarker", spellid .. name)
end

function mod:RegisterPositionMarker(spellid, name, texture, x, y, radius, duration, r, g, b, a, blend, localMap, AreaID)
	if localMap then
		if x >= 0 and x <= 100 and y >= 0 and y <= 100 then
			local _, temptable = C_Map.GetWorldPosFromMapPos(tonumber(AreaID) or C_Map.GetBestMapForUnit("player"), CreateVector2D(x / 100, y / 100))
			x, y = temptable.x, temptable.y
		end
	end
	local marker = encounterMarkers[spellid..name]
	if marker ~= nil then
		return marker
	end
	marker = Point:New(self.currentMap, x, y, nil, duration, texture, radius, blend, r, g, b, a)
	self:RegisterEncounterMarker(spellid, name, marker)
	return marker
end

function mod:RegisterStaticMarkerOnPartyMember(spellid, texture, person, radius, duration, r, g, b, a, blend, canFilterSelf)
	if not r and person then -- Auto generate class color if colors were left nil
		local _, cls = UnitClass(person)
		if cls and RAID_CLASS_COLORS[cls] then
			r, g, b = RAID_CLASS_COLORS[cls].r, RAID_CLASS_COLORS[cls].g, RAID_CLASS_COLORS[cls].b
		else
			DBM:Debug("HudMap Marker failed, no color defined and no unit class")
			return
		end
	end
	local marker = encounterMarkers[spellid .. person]
	if marker ~= nil then
		return marker
	end
	local x, y = self:GetUnitPosition(person)
	marker = Point:New(self.currentMap, x, y, nil, duration, texture, radius, blend, r, g, b, a)
	self:RegisterEncounterMarker(spellid, person, marker)
	return marker
end

function mod:RegisterRangeMarkerOnPartyMember(spellid, texture, person, radius, duration, r, g, b, a, blend, canFilterSelf)
	if not r and person then -- Auto generate class color if colors were left nil
		local _, cls = UnitClass(person)
		if cls and RAID_CLASS_COLORS[cls] then
			r, g, b = RAID_CLASS_COLORS[cls].r, RAID_CLASS_COLORS[cls].g, RAID_CLASS_COLORS[cls].b
		else
			DBM:Debug("HudMap Marker failed, no color defined and no unit class")
			return
		end
	end
	local marker = encounterMarkers[spellid .. person]
	if marker ~= nil then
		return marker
	end
	marker = Point:New(nil, nil, nil, person, duration, texture, radius, blend, r, g, b, a)
	self:RegisterEncounterMarker(spellid, person, marker)
	return marker
end

function mod:FreeEncounterMarker(key)
	if not self.HUDEnabled or not encounterMarkers[key] then
		return
	end
	encounterMarkers[key] = nil
	activeMarkers = activeMarkers - 1
	if activeMarkers == 0 then
		self:Disable()
	end
end

function mod:FreeEncounterMarkerByTarget(spellid, name)
	if not self.HUDEnabled or not encounterMarkers[spellid .. name] then
		return
	end
	self.free(encounterMarkers[spellid .. name])
end

function mod:FreeEncounterMarkers()
	if not self.HUDEnabled then
		return
	end
	for k, v in pairs(encounterMarkers) do
		if encounterMarkers[k] == 143430 .. playerName then
			break -- Don't deactivate Hudar in this call
		end
		encounterMarkers[k] = v:Free()
	end
end

function mod:DistanceBetweenPoints(x1, y1, x2, y2)
	local dx = x2 - x1
	local dy = y2 - y1
	return abs(pow((dx * dx) + (dy * dy), 0.5))
end

function mod:DistanceToPoint(unit, x, y)
	local x1, y1 = self:GetUnitPosition(unit)
	return self:DistanceBetweenPoints(x1, y1, x, y)
end

function mod:UnitDistance(unitA, unitB)
	local x1, y1 = self:GetUnitPosition(unitA)
	local x2, y2 = self:GetUnitPosition(unitB)
	return self:DistanceBetweenPoints(x1, y1, x2, y2)
end

function mod:GetUnitPosition(unit)
	if not unit then
		return nil, nil
	end
	return UnitPosition(unit)
end

function mod:SetZoom(zoom, zoomChange)
	if zoom then
		targetZoomScale = zoom
	elseif zoomChange then
		targetZoomScale = targetZoomScale + zoomChange
	else
		targetZoomScale = 100
	end
	if targetZoomScale < 20 then
		targetZoomScale = 20
	elseif targetZoomScale > 200 then
		targetZoomScale = 200
	end
end

function mod:SetFixedZoom(zoom)
	if type(zoom) == "number" then
		fixedZoomScale = zoom
	else
		fixedZoomScale = nil
	end
end

function mod:SetFixedUpdateRate(updateRate)
	if type(updateRate) == "number" and updateRate > 0 then
		fixedOnUpdateRate = updateRate
	else
		fixedOnUpdateRate = 0.03
	end
end

function mod:Update()
	Point:UpdateAll()
	Edge:UpdateAll()
end

function mod:GetMinimapSize()
	return zoomScale
end

do
	local function ClipPointToRadius(dx, dy, offset)
		local e = -dx
		local f = -dy
		local distance = sqrt((e * e) + (f * f)) + offset
		local scaleFactor
		if distance ~= 0 then
			scaleFactor = 1 - ((WorldFrame:GetHeight() * 0.48) / distance)
			if distance > (WorldFrame:GetHeight() * 0.48) then
				dx = dx + (scaleFactor * e)
				dy = dy + (scaleFactor * f)
			end
		end
		return dx, dy
	end

	--[[
	local function ClipPointToEdges(dx, dy, offset)
		local nx, ny
		local z2 = (WorldFrame:GetHeight() * 0.48)
		dx, dy = ClipPointToRadius(dx, dy, offset)
		nx = min(max(dx, -z2 + offset), z2 - offset)
		ny = min(max(dy, -z2 + offset), z2 - offset)
		return nx, ny, nx ~= dx or ny ~= dy
	end
	--]]

	function mod:GetFacing()
		return GetPlayerFacing() or 0
	end

	function mod:LocationToMinimapOffset(x, y, alwaysShow, radiusOffset, pixelOffset)
		mod.pixelsPerYard = (WorldFrame:GetHeight() * 0.48) / zoomScale
		local px, py = self:GetUnitPosition("player")
		local dx, dy
		local nx, ny
		dx = (px - x) * mod.pixelsPerYard
		dy = (py - y) * mod.pixelsPerYard
		-- Now adjust for rotation
		local bearing = self:GetFacing()
		local angle = atan2(dy, dx)
		if angle <= 0 then
			angle = -angle
		else
			angle = pi2 - angle
		end
		local hyp = abs(sqrt((dx * dx) + (dy * dy)))
		x, y = sin(angle + bearing), cos(angle + bearing)
		nx, ny = -x * hyp, -y * hyp
		if alwaysShow then
			local offset = (radiusOffset and radiusOffset * mod.pixelsPerYard) or (pixelOffset and pixelOffset / 2) or 0
			nx, ny = ClipPointToRadius(nx, ny, offset)
		end
		return nx, ny
	end

	function mod:RangeToPixels(range)
		mod.pixelsPerYard = (WorldFrame:GetHeight() * 0.48) / zoomScale
		return mod.pixelsPerYard * range
	end
end

----------
-- Data --
----------
function mod:ShowCanvas()
	if not self.canvas:IsVisible() then
		zoomScale = targetZoomScale
		self.canvas:SetAlpha(0)
		self.canvas:Show()
	end
	targetCanvasAlpha = 1
end

function mod:HideCanvas()
	targetCanvasAlpha = 0
end

function mod:SupressCanvas()
	supressCanvas = true
	if self.HUDEnabled then
		self.canvas:Hide()
	end
end

function mod:UnSupressCanvas()
	supressCanvas = nil
	if self.HUDEnabled then
		self.canvas:Show()
	end
end

function mod:Toggle(flag)
	if flag == nil then
		flag = not self.canvas:IsVisible() or targetCanvasAlpha == 0
	end
	if flag then
		self:ShowCanvas()
	elseif not flag then
		self:HideCanvas()
	else
		self:HideCanvas()
	end
end
