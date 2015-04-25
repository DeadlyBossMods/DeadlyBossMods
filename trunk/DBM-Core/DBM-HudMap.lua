--Original code and concept by Antiarc. Used and modified with his permission.
--First adaptation in dbm credits to VEM team. Continued on their behalf do to no time from origiinal author to make it an external mod or DBM plugin.

local ADDON_NAME = ...

DBMHudMap = {}
DBMHudMap.mainFrame = CreateFrame("Frame", "DBMHudMapFrame")
local mod = DBMHudMap

local wipe, type, pairs, ipairs, tinsert, tremove, tonumber, setmetatable, select, unpack = table.wipe, type, pairs, ipairs, table.insert, table.remove, tonumber, setmetatable, select, unpack
local abs, pow, sqrt, sin, cos, atan2, floor, ceil, min, max, pi, pi2 = math.abs, math.pow, math.sqrt, math.sin, math.cos, math.atan2, math.floor, math.ceil, math.min, math.max, math.pi, math.pi * 2
local error, print = error, print

local CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0")
local updateFrame = CreateFrame("Frame")
local onUpdate, Point, Edge
local followedUnits = {}
local callbacks = CallbackHandler:New(mod)

local GetNumGroupMembers, GetNumSubgroupMembers = GetNumGroupMembers, GetNumSubgroupMembers
local GetTime, UIParent = GetTime, UIParent
local UnitExists, UnitIsUnit, UnitPosition, GetPlayerFacing = UnitExists, UnitIsUnit, UnitPosition, GetPlayerFacing
local GetInstanceInfo = GetInstanceInfo

local targetCanvasAlpha

local textureLookup = {
	star		= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_1.blp]],
	circle		= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_2.blp]],
	diamond		= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_3.BLP]],
	triangle	= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_4.blp]],
	moon		= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_5.blp]],
	square		= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_6.blp]],
	cross		= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_7.blp]],
	skull		= [[Interface\TARGETINGFRAME\UI-RaidTargetingIcon_8.blp]],
	cross2		= [[Interface\RAIDFRAME\ReadyCheck-NotReady.blp]],
	check		= [[Interface\RAIDFRAME\ReadyCheck-Ready.blp]],
	question	= [[Interface\RAIDFRAME\ReadyCheck-Waiting.blp]],
	targeting	= [[Interface\Minimap\Ping\ping5.blp]],
	highlight	= [[Interface\AddOns\DBM-Core\textures\alert_circle]],
	timer		= [[Interface\AddOns\DBM-Core\textures\timer]],
	glow		= [[Interface\GLUES\MODELS\UI_Tauren\gradientCircle]],
	party		= [[Interface\MINIMAP\PartyRaidBlips]],
	ring		= [[SPELLS\CIRCLE]],
	rune1		= [[SPELLS\AURARUNE256.BLP]],
	rune2		= [[SPELLS\AURARUNE9.BLP]],
	rune3		= [[SPELLS\AURARUNE_A.BLP]],
	rune4		= [[SPELLS\AURARUNE_B.BLP]],
	paw			= [[SPELLS\Agility_128.blp]],
	cyanstar	= [[SPELLS\CYANSTARFLASH.BLP]],
	summon		= [[SPELLS\DarkSummon.blp]],
	reticle		= [[SPELLS\Reticle_128.blp]],
	fuzzyring	= [[SPELLS\WHITERINGTHIN128.BLP]],
	fatring		= [[SPELLS\WhiteRingFat128.blp]],
	swords		= [[SPELLS\Strength_128.blp]],
}

local textureKeys, textureVals = {}, {}
mod.textureKeys, mod.textureVals = textureKeys, textureVals

local texBlending = {
	highlight	= "ADD",
	targeting	= "ADD",
	glow 		= "ADD",
	ring		= "ADD",
	rune1		= "ADD",
	rune2		= "ADD",
	rune3		= "ADD",
	rune4		= "ADD",
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
	party = {0.525, 0.6, 0.04, 0.2},
	tank = {0.5, 0.75, 0, 1},
	dps = {0.75, 1, 0, 1},
	healer = {0.25, 0.5, 0, 1},
	paw = {0.124, 0.876, 0.091, 0.903},
	rune4 = {0.032, 0.959, 0.035, 0.959},
	reticle = {0.05, 0.95, 0.05, 0.95}
}

local frameScalars = {
	rune1 = 0.86,
	rune2 = 0.86,
	rune3 = 0.77,
	summon = 0.86,
}

local function UnregisterAllCallbacks(obj)
	-- Cancel all registered callbacks. CBH doesn't seem to provide a method to do this.
	if obj.callbacks.insertQueue then
		for eventname, callbacks in pairs(obj.callbacks.insertQueue) do
			for k, v in pairs(callbacks) do
				callbacks[k] = nil
			end
		end
	end
	for eventname, callbacks in pairs(obj.callbacks.events) do
		for k, v in pairs(callbacks) do
			callbacks[k] = nil
		end
		if obj.callbacks.OnUnused then
			obj.callbacks.OnUnused(obj.callbacks, obj, eventname)--Make sure this doesn't error. :)
		end
	end
end

mod.RegisterTexture = function(self, key, tex, blend, cx1, cx2, cy1, cy2, scalar)
	if key then
		textureLookup[key] = tex
		if blend then texBlending[key] = blend end
		if cx1 and cx2 and cy1 and cy2 then
			texCoordLookup[key] = {cx1, cx2, cy1, cy2}
		end
		if scalar then
			frameScalars[key] = scalar
		end
	end
	wipe(textureKeys)
	for k, v in pairs(textureLookup) do tinsert(textureKeys, k) end
	wipe(textureVals)
	for k, v in pairs(textureLookup) do textureVals[v] = v end
end
mod:RegisterTexture()

mod.UnitIsMappable = function(unit, allowSelf)
	if (not allowSelf and UnitIsUnit("player", unit)) or not UnitPosition(unit) or not UnitIsConnected(unit) then return false end
	return true
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
	return nil
end

local function groupIter(state, index)
	if index < 0 then return end
	local raid, party = GetNumGroupMembers(), GetNumSubgroupMembers()
	local prefix = raid > 0 and "raid" or "party"
	local unit = prefix .. index
	if UnitExists(unit) then
		return index + 1, unit
	elseif raid == 0 then
		return -1, "player"
	end
end

local function group()
	return groupIter, nil, 1
end

mod.group = group

local pointCache, edgeCache = {}, {}
local activePointList, activeEdgeList = {}, {}

local zoomScale, targetZoomScale = 45, 40

do
	local fine, coarse = 1 / 60, 3
	local fineTotal, fineFrames, coarseTotal = 0, 0, 0
	local zoomDelay, fadeInDelay, fadeOutDelay = 0.5, 0.25, 0.5

	local function computeNewScale()
		local px, py = mod:GetUnitPosition("player")
		local maxDistance = 0
		local activeObjects = 0
		for point, _ in pairs(activePointList) do
			local d = point:Distance(px, py, true)
			local maxSize = 200
			if (d > 0 and d < maxSize and not point.persist) or point.alwaysShow then
				activeObjects = activeObjects + 1
			end

			if d > 0 and d < 200 and d > maxDistance then
				maxDistance = d
			end
		end
		if maxDistance < 30 then maxDistance = 30 end
		return maxDistance, activeObjects
	end

	function onUpdate(self, t)
		fineTotal = fineTotal + t
		coarseTotal = coarseTotal + t

		if coarseTotal > coarse then
			coarseTotal = coarseTotal % coarse
		end

		if fineTotal > fine then
			local steps = floor(fineTotal / fine)
			local elapsed = fine * steps
			fineTotal = fineTotal - elapsed

			local zoom
			zoom, mod.activeObjects = computeNewScale()
			targetZoomScale = zoom
			local currentAlpha = mod.canvas:GetAlpha()
			if targetCanvasAlpha and currentAlpha ~= targetCanvasAlpha then
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
	self.canvas = CreateFrame("Frame", "DBMHudMapCanvas", UIParent)
	self.canvas:SetSize(UIParent:GetWidth(), UIParent:GetHeight())
	self.canvas:SetPoint("CENTER")
	self.activeObjects = 0
	self.HUDEnabled = false
end

function mod:Enable()
	if DBM.Options.DontShowHudMap2 or self.HUDEnabled then return end
	DBM:Debug("HudMap Activating", 2)
	self.currentMap = select(8, GetInstanceInfo())
	self.mainFrame:Show()
	self.mainFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self.mainFrame:RegisterEvent("LOADING_SCREEN_DISABLED")
	self.canvas:SetAlpha(1)
	self:UpdateCanvasPosition()

	targetZoomScale = 6
	self.pixelsPerYard = UIParent:GetHeight() / self:GetMinimapSize()
	self:SetZoom()
	self.canvas:SetBackdrop(nil)
	self.HUDEnabled = true
	if not updateFrame.ticker then
		updateFrame.ticker = C_Timer.NewTicker(0.035, function() onUpdate(updateFrame, 0.035) end)
	end
end

function mod:Disable()
	if not self.HUDEnabled then return end
	DBM:Debug("HudMap Deactivating", 2)
	self:FreeEncounterMarkers()
	--Anything else needed? maybe clear all marks, hide any frames, etc?
	self.mainFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self.mainFrame:UnregisterEvent("LOADING_SCREEN_DISABLED")
	self.mainFrame:Hide()
	self.HUDEnabled = false
	if updateFrame.ticker then
		updateFrame.ticker:Cancel()
		updateFrame.ticker = nil
	end
end

do
	local function onEvent(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == ADDON_NAME then
			mod:OnInitialize()
			--mod:Enable()
			mod.mainFrame:UnregisterEvent("ADDON_LOADED")
		elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local timestamp, clevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID = ...
			if clevent == "UNIT_DIED" then
				for k, v in pairs(followedUnits) do
					if sourceName and k and UnitIsUnit(sourceName, k) and not v.persist then
						v:Free()
					end
				end
			end
		elseif event == "LOADING_SCREEN_DISABLED" then
			mod.currentMap = select(8, GetInstanceInfo())
		end
	end

	mod.mainFrame:SetScript("OnEvent", onEvent)
	mod.mainFrame:RegisterEvent("ADDON_LOADED")
end

function mod:PointExists(id)
	for k, v in pairs(activePointList) do
		if(k.id == id) then
			return true
		end
	end
	return false
end

function mod:UpdateCanvasPosition()
	self.canvas:ClearAllPoints()
	self.canvas:SetPoint("CENTER", UIParent, "CENTER")
	self.canvas:SetSize((UIParent:GetHeight() * 0.48) * 2, (UIParent:GetHeight() * 0.48) * 2)
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

		if progress < 0 then progress = 0
		elseif progress > 1 then progress = 1
		end

		local scale = 1 + ((self.pulseTarget - 1) * progress)
		self.regionParent:SetScale(scale)
	end,
	alpha = function(self)
		self.regionParent:SetAlpha(self:GetProgress())
	end,
	fullOpacity = function(self)
		self.regionParent:SetAlpha(1)
	end,
	scaleIn = function(self)
		local scale = 1 + ((1 - self:GetProgress()) * 0.5)
		self.regionParent:SetScale(scale)
	end,
	hideParent = function(self)
		self:GetRegionParent():Hide()
	end,
	replay = function(self)
		self:Play()
	end
}

local function DrawRouteLineCustom(T, C, sx, sy, ex, ey, w, relPoint)
	if (not relPoint) then relPoint = "BOTTOMLEFT"; end

	-- Determine dimensions and center point of line
	local dx,dy = ex - sx, ey - sy;
	local cx,cy = (sx + ex) / 2, (sy + ey) / 2;

	-- Normalize direction if necessary
	local reverse = dx < 0 and -1 or 1
	if (dx < 0) then
		dx,dy = -dx,-dy;
	end

	-- Calculate actual length of line
	local l = sqrt((dx * dx) + (dy * dy));

	-- Quick escape if it's zero length
	if (l == 0) then
		T:SetTexCoord(0,0,0,0,0,0,0,0);
		T:SetPoint("BOTTOMLEFT", C, relPoint, cx,cy);
		T:SetPoint("TOPRIGHT",   C, relPoint, cx,cy);
		return;
	end

	-- Sin and Cosine of rotation, and combination (for later)
	local s,c = -dy / l, dx / l;
	local sc = s * c;

	-- Calculate bounding box size and texture coordinates
	local Bwid, Bhgt, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy;
	if (dy >= 0) then
		Bwid = ((l * c) - (w * s)) * TAXIROUTE_LINEFACTOR_2;
		Bhgt = ((w * c) - (l * s)) * TAXIROUTE_LINEFACTOR_2;
		BLx, BLy, BRy = (w / l) * sc, s * s, (l / w) * sc;
		BRx, TLx, TLy, TRx = 1 - BLy, BLy, 1 - BRy, 1 - BLx; 
		TRy = BRx;
	else
		Bwid = ((l * c) + (w * s)) * TAXIROUTE_LINEFACTOR_2;
		Bhgt = ((w * c) + (l * s)) * TAXIROUTE_LINEFACTOR_2;
		BLx, BLy, BRx = s * s, -(l / w) * sc, 1 + (w / l) * sc;
		BRy, TLx, TLy, TRy = BLx, 1 - BRx, 1 - BLx, 1 - BLy;
		TRx = TLy;
	end
	Bwid = Bwid * reverse
	Bhgt = Bhgt * reverse

	-- Set texture coordinates and anchors
	T:ClearAllPoints();
	T:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy);
	T:SetPoint("BOTTOMLEFT", C, relPoint, cx - Bwid, cy - Bhgt);
	T:SetPoint("TOPRIGHT",   C, relPoint, cx + Bwid, cy + Bhgt);
end

local animationNames = {"fadeOutGroup", "fadeOut", "repeatAnimations", "pulseAnimations", "pulse", "rotate", "fadeInGroup"}
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

		-- print("Acquiring", self.serial)
		self.frame:Show()
		self.frame:SetAlpha(1)
		self.frame:StopAnimating()

		-- This shouldn't be necessary, but some animations aren't stopping.
		for _, anim in ipairs(animationNames) do
			if self[anim] then self[anim]:Stop() end
		end
	end,

	OnFree = function(self, noAnimate)
		if self.freed then return false end
		self.freed = true
		self.callbacks:Fire("Free", self)
		UnregisterAllCallbacks(self)
		self:Hide(noAnimate)
	end,

	ParseSize = function(self, size)
		local yards, fixed, t
		if type(size) == "string" then
			t = size:match("(%d+)px")
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

local object_mt = {__index = Object}
local edge_mt, point_mt = {}, {}

Edge = setmetatable({
	Free = function(self, noAnimate)
		if self:OnFree(noAnimate) == false then return end

		for point, _ in pairs(self.points) do
			point:DetachEdge(self)
		end
		wipe(self.points)
		self.srcPlayer, self.dstPlayer, self.sx, self.sy, self.dx, self.dy = nil, nil, nil, nil, nil, nil
		activeEdgeList[self] = nil

		tinsert(edgeCache, self)
		return nil
	end,
	New = function(self, r, g, b, a, srcPlayer, dstPlayer, sx, sy, dx, dy, lifetime)
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
			-- local line = "Interface\\TaxiFrame\\UI-Taxi-Line"
			local line = "Interface\\AddOns\\DBM-Core\\textures\\line"
			t.texture:SetTexture(line)

			t.fadeOutGroup = t.frame:CreateAnimationGroup()
			t.fadeOut = t.fadeOutGroup:CreateAnimation("alpha")
			-- t.fadeOut:SetMaxFramerate(60)
			t.fadeOut:SetChange(-1)
			t.fadeOut:SetDuration(0.25)
			t.fadeOut:SetScript("OnFinished", animations.hideParent)
		end
		t:OnAcquire()
		t.srcPoint = nil
		t.dstPoint = nil

		t.lifetime = type(lifetime) == "number" and GetTime() + lifetime or nil
		t:SetColor(r, g, b, a)
		t.srcPlayer, t.dstPlayer = srcPlayer, dstPlayer
		t.sx, t.sy, t.dx, t.dy = sx, sy, dx, dy
		activeEdgeList[t] = true
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
	UpdateAll = function(self)
		if(self ~= Edge) then return end
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
			dx, dy = mod:GetUnitPosition(self.dstPlayer)
		elseif self.dstPoint then
			dx, dy = self.dstPoint:Location()
		elseif self.dx and self.dy then
			dx, dy = self.dx, self.dy
		end

		local visible
		if sx and sy and dx and dy then
			local px, py = mod:GetUnitPosition("player")
			local radius = zoomScale * zoomScale 
			local d1 = pow(px - sx, 2) + pow(py - sy, 2)
			local d2 = pow(px - dx, 2) + pow(py - dy, 2)
			visible = d1 < radius or d2 < radius

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
			local hyp = pow((ax*ax) + (ay*ay), 0.5)
			if hyp > 15 then
				self.texture:Show()
				DrawRouteLineCustom(self.texture, mod.canvas, sx, sy, dx, dy, 100);
			else
				self.texture:Hide()
			end
		end
	end,
}, object_mt)

function mod:AddEdge(r, g, b, a, lifetime, srcPlayer, dstPlayer, sx, sy, dx, dy)
	return Edge:New(r, g, b, a, srcPlayer, dstPlayer, sx, sy, dx, dy, lifetime)
end

do
	Point = setmetatable({
		Free = function(self, noAnimate)
			if self:OnFree(noAnimate) == false then return end

			if self.follow then
				followedUnits[self.follow] = nil
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

			return nil
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
			followedUnits[unit] = self
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
			if self.map and mod.currentMap ~= self.map and not self.persist then self:Free(); return end
			if not self.lifetime or self.lifetime > 0 and self.lifetime < GetTime() then self:Free(); return end
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
			local needUpdate = false
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
					local radius = self.radius / (frameScalars[self.texfile] or 1)
					local pixels = mod:RangeToPixels(radius * 2)
					self.frame:SetSize(pixels, pixels)
				end
			elseif self.fixedSize then
				self.frame:SetSize(self.fixedSize, self.fixedSize)
			end
		end,

		UpdateAll = function(self)
			if(self ~= Point) then return end
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

			local norm = 360 / amount
			speed = speed * norm
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
			self.texture:SetTexCoord(a,b,c,d)
			return self
		end,

		Alert = function(self, bool)
			local r, g, b, a
			r = bool and self.alert.r or self.normal.r or 1
			g = bool and self.alert.g or self.normal.g or 1
			b = bool and self.alert.b or self.normal.b or 1
			a = bool and self.alert.a or self.normal.a or 1
			self.texture:SetVertexColor(r, g, b, a)
			if bool then
				self:SetLabel(self.alertLabel)
			end
			return self
		end,

		RegisterForAlerts = function(self, bool, alertLabel)
			if bool == nil then bool = true end
			self.alertLabel = alertLabel
			self.shouldUpdateRange = bool
			return self
		end,

		Distance = function(self, x2, y2, includeRadius)
			local x, y = self:Location()
			if not x or not y or (x == 0 and y == 0) then
				return -1
			end
			local e = x2-x
			local f = y2-y
			return sqrt((e*e)+(f*f)) + (includeRadius and self.radius or 0), x, y
		end,

		Persist = function(self, bool)
			self.persist = bool == nil and true or bool
			return self
		end,

		AlwaysShow = function(self, bool)
			if bool == nil then bool = true end
			self.alwaysShow = bool
			return self
		end,

		UpdateAlerts = function(self)
			if not self.radius then return end
			local x, y = self:Location()

			local alert = false
			if self.shouldUpdateRange == "all" or (self.follow and UnitIsUnit(self.follow, "player")) then
				for index, unit in group() do
					if not UnitIsUnit(unit, "player") and not UnitIsDead(unit) then
						alert = mod:DistanceToPoint(unit, x, y) < self.radius
						if alert then break end
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
			tex:SetTexture(textureLookup[texfile] or texfile or [[Interface\GLUES\MODELS\UI_Tauren\gradientCircle]])
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
					r, g, b, a = unpack(RAID_CLASS_COLORS[cls])
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
				local font = f
				local size = fontSize or 20 or s
				local outline = outline or "THICKOUTLINE" or m
				self.text:SetFont(font, size, outline)
				self.text:SetText(text)
			end

			-- LabelData is for sending to remote clients
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

		EdgeFrom = function(self, point_or_unit_or_x, to_y, lifetime, r, g, b, a)
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
			local edge = Edge:New(r, g, b, a, fromPlayer, unit, self.stickX, self.stickY, x, y, lifetime)
			self:AttachEdge(edge)
			if type(point_or_unit_or_x) == "table" then
				point_or_unit_or_x:AttachEdge(edge)
				edge:SetClipOffset(point_or_unit_or_x.fixedSize and point_or_unit_or_x.fixedSize .. "px" or point_or_unit_or_x.radius)
			else
				edge:SetClipOffset(self.fixedSize and self.fixedSize .. "px" or self.radius)
			end
			return edge
		end,

		EdgeTo = function(self, point_or_unit_or_x, from_y, lifetime, r, g, b, a)
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

			local edge = Edge:New(r, g, b, a, unit, toPlayer, x, y, self.stickX, self.stickY, lifetime)
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

			-- Base
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

			-- Alert
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
				t.text:SetFont(STANDARD_TEXT_FONT, 10, "")
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
				-- t.pulse:SetMaxFramerate(60)
				t.pulse:SetOrder(1)
				t.pulseIn = t.pulseAnimations:CreateAnimation("scale")
				-- t.pulseIn:SetMaxFramerate(60)
				t.pulseIn:SetOrder(2)
				t.pulse:SetScript("OnPlay", animations.onLoad)

				t.rotate = t.repeatAnimations:CreateAnimation("rotation")
				-- t.rotate:SetMaxFramerate(60)

				t.normal, t.alert = {}, {}

				do
					t.fadeInGroup = t.frame:CreateAnimationGroup()

					local scaleOut = t.fadeInGroup:CreateAnimation("scale")
					-- scaleOut:SetMaxFramerate(60)
					scaleOut:SetDuration(0)
					scaleOut:SetScale(1.5, 1.5)
					scaleOut:SetOrder(1)

					t.fadeIn = t.fadeInGroup:CreateAnimation()
					-- t.fadeIn:SetMaxFramerate(60)
					t.fadeIn:SetDuration(0.35)
					t.fadeIn:SetScript("OnPlay", function(self)
						animations.onLoad(self)
						t.fadeOutGroup:Stop()
					end)

					t.fadeIn:SetScript("OnUpdate", animations.alpha)
					t.fadeIn:SetScript("OnStop", animations.fullOpacity)
					t.fadeIn:SetOrder(2)

					local scaleIn = t.fadeInGroup:CreateAnimation("scale")
					-- scaleIn:SetMaxFramerate(60)
					scaleIn:SetDuration(0.35)
					scaleIn:SetScale(1 / 1.5, 1 / 1.5)
					scaleIn:SetOrder(2)
				end

				t.fadeOutGroup = t.frame:CreateAnimationGroup()
				t.fadeOut = t.fadeOutGroup:CreateAnimation("alpha")
				-- t.fadeOut:SetMaxFramerate(60)
				t.fadeOut:SetChange(-1)
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

function mod:UpdateMode()
end

function mod:PlaceRangeMarker(texture, x, y, radius, duration, r, g, b, a, blend, priority)
	local red, green, blue = r, g, b
	local size = radius
	if priority then
		if DBM.Options.HUDColorOverride then
			local colors = priority == 1 and DBM.Options.HUDColor1 or priority == 2 and DBM.Options.HUDColor2 or priority == 3 and DBM.Options.HUDColor3 or priority == 4 and DBM.Options.HUDColor4
			red, green, blue = colors[1], colors[2], colors[3]
			local checkSize = priority == 1 and DBM.Options.HUDSizeOption1 or priority == 2 and DBM.Options.HUDSizeOption2 or priority == 3 and DBM.Options.HUDSizeOption3 or priority == 4 and DBM.Options.HUDSizeOption4
		end
		if checkSize > 0 then--0 means "Let mod decide"
			size = checkSize
		end
	end
	return Point:New(self.currentMap, x, y, nil, duration, texture, size, blend, red, green, blue, a)
end

function mod:PlaceStaticMarkerOnPartyMember(texture, person, radius, duration, r, g, b, a, blend, priority)
	local red, green, blue = r, g, b
	local size = radius
	if priority then
		if DBM.Options.HUDColorOverride then
			local colors = priority == 1 and DBM.Options.HUDColor1 or priority == 2 and DBM.Options.HUDColor2 or priority == 3 and DBM.Options.HUDColor3 or priority == 4 and DBM.Options.HUDColor4
			red, green, blue = colors[1], colors[2], colors[3]
			local checkSize = priority == 1 and DBM.Options.HUDSizeOption1 or priority == 2 and DBM.Options.HUDSizeOption2 or priority == 3 and DBM.Options.HUDSizeOption3 or priority == 4 and DBM.Options.HUDSizeOption4
		end
		if checkSize > 0 then--0 means "Let mod decide"
			size = checkSize
		end
	end
	local x, y = self:GetUnitPosition(person)
	return Point:New(self.currentMap, x, y, nil, duration, texture, size, blend, red, green, blue, a)
end

function mod:PlaceRangeMarkerOnPartyMember(texture, person, radius, duration, r, g, b, a, blend, priority)
	local red, green, blue = r, g, b
	local size = radius
	if priority then
		if DBM.Options.HUDColorOverride then
			local colors = priority == 1 and DBM.Options.HUDColor1 or priority == 2 and DBM.Options.HUDColor2 or priority == 3 and DBM.Options.HUDColor3 or priority == 4 and DBM.Options.HUDColor4
			red, green, blue = colors[1], colors[2], colors[3]
			local checkSize = priority == 1 and DBM.Options.HUDSizeOption1 or priority == 2 and DBM.Options.HUDSizeOption2 or priority == 3 and DBM.Options.HUDSizeOption3 or priority == 4 and DBM.Options.HUDSizeOption4
		end
		if checkSize > 0 then--0 means "Let mod decide"
			size = checkSize
		end
	end
	return Point:New(nil, nil, nil, person, duration, texture, size, blend, red, green, blue, a)
end

local encounterMarkers = {}
local activeMarkers = 0
function mod:RegisterEncounterMarker(spellid, name, marker)
	if DBM.Options.DontShowHudMap2 then return end
	if not self.HUDEnabled then
		self:Enable()
	end
	local key = spellid..name
	encounterMarkers[key] = marker
	activeMarkers = activeMarkers + 1
	marker.RegisterCallback(self, "Free", "FreeEncounterMarker", key)
end

function mod:RegisterPositionMarker(spellid, name, texture, x, y, radius, duration, r, g, b, a, blend, priority)
	local red, green, blue = r, g, b
	local size = radius
	if priority then
		if DBM.Options.HUDColorOverride then
			local colors = priority == 1 and DBM.Options.HUDColor1 or priority == 2 and DBM.Options.HUDColor2 or priority == 3 and DBM.Options.HUDColor3 or priority == 4 and DBM.Options.HUDColor4
			red, green, blue = colors[1], colors[2], colors[3]
			local checkSize = priority == 1 and DBM.Options.HUDSizeOption1 or priority == 2 and DBM.Options.HUDSizeOption2 or priority == 3 and DBM.Options.HUDSizeOption3 or priority == 4 and DBM.Options.HUDSizeOption4
		end
		if checkSize > 0 then--0 means "Let mod decide"
			size = checkSize
		end
	end
	local marker = encounterMarkers[spellid..name]
	if marker ~= nil then return marker end
	marker = Point:New(self.currentMap, x, y, nil, duration, texture, size, blend, red, green, blue, a)
	self:RegisterEncounterMarker(spellid, name, marker)
	return marker
end

function mod:RegisterStaticMarkerOnPartyMember(spellid, texture, person, radius, duration, r, g, b, a, blend, canFilterSelf, priority)
	if DBM.Options.FilterSelfHud and canFilterSelf and UnitIsUnit("player", person) then a = 0 end
	local red, green, blue = r, g, b
	local size = radius
	if priority and a ~= 0 then
		if DBM.Options.HUDColorOverride then
			local colors = priority == 1 and DBM.Options.HUDColor1 or priority == 2 and DBM.Options.HUDColor2 or priority == 3 and DBM.Options.HUDColor3 or priority == 4 and DBM.Options.HUDColor4
			red, green, blue = colors[1], colors[2], colors[3]
			local checkSize = priority == 1 and DBM.Options.HUDSizeOption1 or priority == 2 and DBM.Options.HUDSizeOption2 or priority == 3 and DBM.Options.HUDSizeOption3 or priority == 4 and DBM.Options.HUDSizeOption4
		end
		if checkSize > 0 then--0 means "Let mod decide"
			size = checkSize
		end
	end
	local marker = encounterMarkers[spellid..person]
	if marker ~= nil then return marker end
	local x, y = self:GetUnitPosition(person)
	marker = Point:New(self.currentMap, x, y, nil, duration, texture, size, blend, red, green, blue, a)
	self:RegisterEncounterMarker(spellid, person, marker)
	return marker
end

function mod:RegisterRangeMarkerOnPartyMember(spellid, texture, person, radius, duration, r, g, b, a, blend, canFilterSelf, priority)
	if DBM.Options.FilterSelfHud and canFilterSelf and UnitIsUnit("player", person) then a = 0 end
	local red, green, blue = r, g, b
	local size = radius
	if priority and a ~= 0 then
		if DBM.Options.HUDColorOverride then
			local colors = priority == 1 and DBM.Options.HUDColor1 or priority == 2 and DBM.Options.HUDColor2 or priority == 3 and DBM.Options.HUDColor3 or priority == 4 and DBM.Options.HUDColor4
			red, green, blue = colors[1], colors[2], colors[3]
			local checkSize = priority == 1 and DBM.Options.HUDSizeOption1 or priority == 2 and DBM.Options.HUDSizeOption2 or priority == 3 and DBM.Options.HUDSizeOption3 or priority == 4 and DBM.Options.HUDSizeOption4
		end
		if checkSize > 0 then--0 means "Let mod decide"
			size = checkSize
		end
	end
	local marker = encounterMarkers[spellid..person]
	if marker ~= nil then return marker end
	marker = Point:New(nil, nil, nil, person, duration, texture, size, blend, red, green, blue, a)
	self:RegisterEncounterMarker(spellid, person, marker)
	return marker
end

-- automatically called if marker was registered using RegisterEncounterMarker when "Free" callback fires (when time runs out for example)
function mod:FreeEncounterMarker(key)
	if not self.HUDEnabled then return end
	if not encounterMarkers[key] then return end
	encounterMarkers[key] = nil
	activeMarkers = activeMarkers - 1
	if activeMarkers == 0 then--No markers left, disable hud
		self:Disable()
	end
end

-- should be called to manually free marker
function mod:FreeEncounterMarkerByTarget(spellid, name)
	if not self.HUDEnabled then return end
	local marker = encounterMarkers[spellid..name]
	if not marker then return end
	self.free(marker)
end

function mod:FreeEncounterMarkers()
	if not self.HUDEnabled then return end
	for k, v in pairs(encounterMarkers) do
		encounterMarkers[k] = v:Free()
	end
end

function mod:DistanceToPoint(unit, x, y)
	local x1, y1 = self:GetUnitPosition(unit)
	local x2, y2 = x, y
	local dx = x2 - x1
	local dy = y2 - y1
	return abs(pow((dx*dx)+(dy*dy), 0.5))
end

function mod:UnitDistance(unitA, unitB)
	local x1, y1 = self:GetUnitPosition(unitA)
	local x2, y2 = self:GetUnitPosition(unitB)
	local dx = x2 - x1
	local dy = y2 - y1
	return abs(pow((dx*dx)+(dy*dy), 0.5))
end

function mod:GetUnitPosition(unit)
	if not unit then return nil, nil end
	local x, y = UnitPosition(unit)
	return x, y
end

do
	local a, b
	function mod:Measure(restart)
		local a2, b2 = self:GetUnitPosition("player")
		if restart or not a then
			a, b = a2, b2
		else
			local c, d = (a2 - a), (b2 - b)
			print(math.sqrt((c*c)+(d*d)))
			a, b = nil, nil
		end
	end
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

function mod:Update()
	Point:UpdateAll()
	Edge:UpdateAll()
end

function mod:GetMinimapSize()
	return zoomScale
end

do
	local function ClipPointToRadius(dx, dy, offset)
		local px, py = 0, 0
		local e = px - dx
		local f = py - dy
		local distance = sqrt((e*e)+(f*f)) + offset
		local scaleFactor
		if distance ~= 0 then
			scaleFactor = 1 - ((UIParent:GetHeight() * 0.48) / distance)
			if distance > (UIParent:GetHeight() * 0.48) then
				dx = dx + (scaleFactor * e)
				dy = dy + (scaleFactor * f)
			end
		end
		return dx, dy
	end

	local function ClipPointToEdges(dx, dy, offset)
		local nx, ny
		local px, py = 0, 0
		local z2 = (UIParent:GetHeight() * 0.48)
		dx, dy = ClipPointToRadius(dx, dy, offset)
		nx = min(max(dx, px - z2 + offset), px + z2 - offset)
		ny = min(max(dy, py - z2 + offset), py + z2 - offset)
		return nx, ny, nx ~= dx or ny ~= dy
	end

	function mod:GetFacing()
		return GetPlayerFacing()
	end

	function mod:LocationToMinimapOffset(x, y, alwaysShow, radiusOffset, pixelOffset)
		mod.pixelsPerYard = (UIParent:GetHeight() * 0.48) / zoomScale

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
		local x, y = sin(angle + bearing), cos(angle + bearing)
		nx, ny = -x * hyp, -y * hyp

		if alwaysShow then
			local offset = (radiusOffset and radiusOffset * mod.pixelsPerYard) or (pixelOffset and pixelOffset / 2) or 0
			nx, ny = ClipPointToRadius(nx, ny, offset)
		end
		return nx, ny
	end

	function mod:RangeToPixels(range)
		mod.pixelsPerYard = (UIParent:GetHeight() * 0.48) / zoomScale
		return mod.pixelsPerYard * range
	end
end

------------------------------------
-- Data
------------------------------------

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

function mod:Toggle(flag)
	if flag == nil then
		flag = not self.canvas:IsVisible() or (targetCanvasAlpha == 0)
	end
	if flag then
		self:ShowCanvas()
	elseif not flag then
		self:HideCanvas()
	else
		self:HideCanvas()
	end
end
