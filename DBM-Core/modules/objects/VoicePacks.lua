-- TODO: migrate this properly, currently just using it for Announce/SpecialWarning shared variables

---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

---@class DBM
local DBM = private:GetPrototype("DBM")

private.voiceSessionDisabled = false
private.swFilterDisabled = 12

local minVoicePackVersion = 18

function DBM:CheckVoicePackVersion(value)
	local activeVP = self.Options.ChosenVoicePack2
	--Check if voice pack out of date
	if activeVP ~= "None" and activeVP == value then
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
