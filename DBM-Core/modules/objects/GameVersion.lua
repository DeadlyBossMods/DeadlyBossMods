---@class DBMCoreNamespace
local private = select(2, ...)

private.wowTOC = select(4, GetBuildInfo())
private.testBuild = IsTestBuild()
private.isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)
private.isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
private.isHardcoreServer = C_GameRules and C_GameRules.IsHardcoreActive and C_GameRules.IsHardcoreActive()
private.currentSeason = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2) and C_Seasons and C_Seasons.HasActiveSeason() and C_Seasons.GetActiveSeason()
private.isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
private.isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)
--private.isCata = WOW_PROJECT_ID == (WOW_PROJECT_CATA_CLASSIC or 99)--NYI in first build
private.isCata = (private.wowTOC >= 40400) and (private.wowTOC < 50000)
private.newShit = (private.wowTOC >= 100207) or private.isCata
