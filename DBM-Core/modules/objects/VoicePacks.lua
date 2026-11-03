-- TODO: migrate this properly, currently just using it for Announce/SpecialWarning shared variables

---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

---@class DBM
local DBM = private:GetPrototype("DBM")

private.voiceSessionDisabled = false
private.swFilterDisabled = 20

local minVoicePackVersion = 20

---@param name string
---@return boolean
function DBM:IsVoiceOverrideSoundSupported(name)
	if name:match("^Thogar/") or name == "1695gorak" or name == "1695uktar" or name == "1695ukurogg" then
		return false
	end
	local voice = self.Options.ChosenVoicePack2
	local version = not self:IsNoneValue(voice) and self.VoiceVersions[voice]
	if not version or private.voiceSessionDisabled then
		return false
	end
	local requiredVersion = private:GetVoicePackSounds()[name]
	return requiredVersion ~= nil and requiredVersion <= version
		and self:ValidateSound("Interface\\AddOns\\DBM-VP" .. voice .. "\\" .. name .. ".ogg")
end

---@param mediaType string
---@param media number|string
---@return number|string|nil
function DBM:GetVoiceOverrideSound(mediaType, media)
	if mediaType == "sound" then
		if not self:IsNoneValue(media) and self:ValidateSound(media) then
			return media
		end
	elseif mediaType == "voice" and type(media) == "string" and self:IsVoiceOverrideSoundSupported(media) then
		return "Interface\\AddOns\\DBM-VP" .. self.Options.ChosenVoicePack2 .. "\\" .. media .. ".ogg"
	end
end

---@return number|string|nil
function DBM:GetGTFOOverrideSound()
	if not self.Options.GTFOOverrideEnabled then return end
	return self:GetVoiceOverrideSound(self.Options.GTFOOverrideSoundType, self.Options.GTFOOverrideSound)
end

---@return table<VPSound, number>
function DBM:GetVoicePackSounds()
	return private:GetVoicePackSounds()
end

function DBM:CheckVoicePackVersion(value)
	local activeVP = self.Options.ChosenVoicePack2
	--Check if voice pack out of date
	if not self:IsNoneValue(activeVP) and activeVP == value then
		-- User might reselect "missing" entry shown in GUI if previously selected voice pack is uninstalled or disabled
		if self.VoiceVersions[value] then
			private.voiceSessionDisabled = false
			if self.VoiceVersions[value] < minVoicePackVersion then--Version will be bumped when new voice packs released that contain new voices.
				if self.Options.ShowReminders then
					self:AddMsg(L.VOICE_PACK_OUTDATED)
				end
				private.swFilterDisabled = self.VoiceVersions[value]--Set disable to version on current voice pack
			else
				private.swFilterDisabled = minVoicePackVersion
			end
		else
			private.voiceSessionDisabled = true
		end
	end
end
