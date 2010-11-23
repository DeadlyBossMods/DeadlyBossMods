local WowBuild = select(2, GetBuildInfo())
if tonumber(WowBuild) < 13329 then return end

DBM:RegisterMapSize("OnyxiasLair",
	1, 483.117988586426, 322.078788757324
)