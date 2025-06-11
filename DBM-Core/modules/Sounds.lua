local private = select(2, ...)

local tinsert, unpack = table.insert, unpack

local CL = DBM_COMMON_L

---@class DBM
local DBM = DBM

do
	local function _AddSound(soundList, text, value, length, path)
		local sound = {
			text	= text,
			value	= value,
			length = length,
			max = length -- for backwards compatibility
		}
		if path then
			sound.path = string.match(path, "^(.*)\\[^\\]+$") .. "\\"
			DBM:Debug("Adding sound with path: " .. sound.path, 2)
		end
		tinsert(soundList, sound)
	end

	local function AddSoundData(soundList, files)
		for _, file in ipairs(files) do
			if (file.metadata.category and file.metadata.category == "count") then
				_AddSound(soundList, file.metadata.text, file.metadata.value, file.metadata.max or file.metadata.length, file.path)
			elseif file.metadata.type and (file.metadata.type == "soundData" or file.metadata.type == "sound") then
				_AddSound(soundList, file.metadata.text, file.metadata.value or file.path, file.metadata.length or 4)
			end
		end
	end

	--Defeat sounds
	do
		local defeat
		local cachedTable
		defeat = {
			{text = CL.NONE, value  = "None"},
			{text = CL.RANDOM, value  = "Random"}
		}
		local defeatFiles = DBM:getFilesWithMetadata("category", "defeat")
		if private.isWrath or private.isCata or private.isRetail then
			AddSoundData(defeat, DBM:filterFilesByField(defeatFiles, "version", "wrath"))
		end
		if private.isCata or private.isRetail then
			AddSoundData(defeat, DBM:filterFilesByField(defeatFiles, "version", "cata"))
		end
		if private.isRetail then
			AddSoundData(defeat, DBM:filterFilesByField(defeatFiles, "version", "retail"))
		end
		AddSoundData(defeat, DBM:filterFilesByField(defeatFiles, "version", "custom"))

		---@deprecated Use new utility functions
		DBM.Defeat = defeat
		function DBM:GetDefeatSounds()
			if not cachedTable then
				cachedTable = {unpack(defeat)}
			end
			return cachedTable
		end

		function DBM:AddDefeatSound(text, value, length)
			local sound = {
				text = text,
				value = value,
				length = length or 4
			}
			tinsert(defeat, sound)
			cachedTable = nil -- Invalidate cache
		end
	end

	--Victory sounds
	do
		local cachedTable
		local victory = {
			{text = CL.NONE, value  = "None"},
			{text = CL.RANDOM, value  = "Random"}
		}

		AddSoundData(victory, DBM:getFilesWithMetadata("category", "victory"))

		---@deprecated Use new utility functions
		DBM.Victory = victory
		function DBM:GetVictorySounds()
			if not cachedTable then
				cachedTable = {unpack(victory)}
			end
			return cachedTable
		end

		function DBM:AddVictorySound(text, value, length)
			local sound = {
				text = text,
				value = value,
				length = length or 4
			}
			tinsert(victory, sound)
			cachedTable = nil -- Invalidate cache
		end
	end

	--Count sounds
	do
		local counts = {}
		local cachedTable

		AddSoundData(counts, DBM:getFilesWithMetadata("category", "count"))

		---@deprecated Use new utility functions
		DBM.Counts = counts
		function DBM:GetCountSounds()
			if not cachedTable then
				cachedTable = {unpack(counts)}
			end
			return cachedTable
		end

		function DBM:AddCountSound(text, value, path, max)
			local sound = {
				text = text,
				value = value,
				length = max or 5,
				path = path
			}
			tinsert(counts, sound)
			cachedTable = nil -- Invalidate cache
		end
	end

	-- Dungeon music
	do
		local cachedTable
		local dungeonMusic = {
			{text = CL.NONE, value  = "None"},
			{text = CL.RANDOM, value  = "Random"}
		}

		local musicFiles = DBM:getFilesWithMetadata("category", "dungeonMusic")

		if private.isRetail then
			AddSoundData(dungeonMusic, DBM:filterFilesByField(musicFiles, "version", "retail"))
		end
		if private.isRetail or private.isCata then
			AddSoundData(dungeonMusic, DBM:filterFilesByField(musicFiles, "version", "cata"))
		end
		if private.isRetail or private.isCata or private.isWrath then
			AddSoundData(dungeonMusic, DBM:filterFilesByField(musicFiles, "version", "wrath"))
		end
		AddSoundData(dungeonMusic, DBM:filterFilesByField(musicFiles, "version", "custom"))

		---@deprecated Use new utility functions
		DBM.DungeonMusic = dungeonMusic

		function DBM:GetDungeonMusic()
			if not cachedTable then
				cachedTable = {unpack(dungeonMusic)}
			end
			return cachedTable
		end

		function DBM:AddDungeonMusic(text, value, length)
			local sound = {
				text = text,
				value = value,
				length = length or 4
			}
			tinsert(dungeonMusic, sound)
			cachedTable = nil -- Invalidate cache
		end
	end

	--BattleMusic
	do
		local cachedTable
		local battleMusic = {
			{text = CL.NONE, value  = "None"},
			{text = CL.RANDOM, value  = "Random"}
		}
		local musicFiles = DBM:getFilesWithMetadata("category", "battleMusic")

		if private.isRetail then
			AddSoundData(battleMusic, DBM:filterFilesByField(musicFiles, "version", "retail"))
		end
		if private.isWrath or private.isCata or private.isRetail then
			AddSoundData(battleMusic, DBM:filterFilesByField(musicFiles, "version", "wrath"))
		end

		AddSoundData(battleMusic, DBM:filterFilesByField(musicFiles, "version", "custom"))

		---@deprecated Use new utility functions
		DBM.BattleMusic = battleMusic

		function DBM:GetBattleMusic()
			if not cachedTable then
				cachedTable = {unpack(battleMusic)}
			end
			return cachedTable
		end

		function DBM:AddBattleMusic(text, value, length)
			local sound = {
				text = text,
				value = value,
				length = length or 4
			}
			tinsert(battleMusic, sound)
			cachedTable = nil -- Invalidate cache
		end
	end

	--All music
	do
		local cachedTable
		local allMusic = {
			{text = CL.NONE, value  = "None"},
			{text = CL.RANDOM, value  = "Random"}
		}
		local dungeonMusicFiles = DBM:getFilesWithMetadata("category", "dungeonMusic")
		local battleMusicFiles = DBM:getFilesWithMetadata("category", "battleMusic")

		AddSoundData(allMusic, dungeonMusicFiles)
		AddSoundData(allMusic, battleMusicFiles)
		AddSoundData(allMusic, DBM:filterFilesByField(dungeonMusicFiles, "version", "custom"))
		AddSoundData(allMusic, DBM:filterFilesByField(battleMusicFiles, "version", "custom"))

		---@deprecated Use new utility functions
		DBM.Music = allMusic
		function DBM:GetMusic()
			if not cachedTable then
				cachedTable = {unpack(allMusic)}
			end
			return cachedTable
		end

		function DBM:AddMusic(text, value, length)
			local sound = {
				text = text,
				value = value,
				length = length or 4
			}
			tinsert(allMusic, sound)
			cachedTable = nil -- Invalidate cache
		end
	end

	--Sounds
	do
		local cachedTable
		local sounds = {
			{text = CL.NONE, value  = "None"},
			{text = CL.RANDOM, value  = "Random"}
		}
		local soundFiles = DBM:getFilesWithMetadata("category", "sound")
		AddSoundData(sounds, soundFiles)

		---@deprecated Use new utility functions
		DBM.Sounds = sounds
		function DBM:GetSounds()
			if not cachedTable then
				cachedTable = {unpack(sounds)}
			end
			return cachedTable
		end

		function DBM:AddSound(text, value, length)
			local sound = {
				text = text,
				value = value,
				length = length or 4
			}
			tinsert(sounds, sound)
			cachedTable = nil -- Invalidate cache
		end
	end

	--Announcements
	do
		local cachedTable
		local annnouncements = {}
		local annnouncementFiles = DBM:getFilesWithMetadata("category", "specialAnnouncement")
		local classicFiles = DBM:getFilesWithMetadata("category", "classicSound")
		AddSoundData(annnouncements, classicFiles)
		AddSoundData(annnouncements, DBM:filterFilesByField(annnouncementFiles, "version", "classic"))
		AddSoundData(annnouncements, DBM:filterFilesByField(annnouncementFiles, "version", "custom"))
		if private.isWrath or private.isRetail then
			AddSoundData(annnouncements, DBM:filterFilesByField(annnouncementFiles, "version", "wrath"))
		end
		if private.isRetail then
			AddSoundData(annnouncements, DBM:filterFilesByField(annnouncementFiles, "version", "retail"))
		end

		---@deprecated Use new utility functions
		DBM.Announcements = annnouncements
		function DBM:GetSpecialAnnouncements()
			if not cachedTable then
				cachedTable = {unpack(annnouncements)}
			end
			return cachedTable
		end

		function DBM:AddSpecialAnnouncement(text, value, length)
			local sound = {
				text = text,
				value = value,
				length = length or 4
			}
			tinsert(annnouncements, sound)
			cachedTable = nil -- Invalidate cache
		end
	end


end

