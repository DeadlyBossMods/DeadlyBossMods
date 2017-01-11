local mod	= DBM:NewMod("BrawlRumble", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(28649)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 228855 229593"
--	"SPELL_AURA_REMOVED"
)

--Todo, fixates probably switch targets when someone dies, so it's probably not workable to have a Cd timer, maybe a target timer instead?
--TODO, mind break spellid?
local warnMooseRun			= mod:NewTargetAnnounce(228855, 4)--Grief Warden
local warnHippoFixate		= mod:NewTargetAnnounce(229593, 4)--Senya

local specWarnMooseRun		= mod:NewSpecialWarningRun(228855)--Grief Warden
local specWarnHippoFixate	= mod:NewSpecialWarningRun(229593)--Senya

--local timerMooseRunCD		= mod:NewAITimer(17, 228855, nil, nil, nil, 3)--Grief Warden
--local timerHippoFixateCD	= mod:NewAITimer(17, 229593, nil, nil, nil, 3)--Senya

mod:RemoveOption("HealthFrame")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 228855 then
		--timerMooseRunCD:Start()
		if args:IsPlayer() then
			specWarnMooseRun:Show()
		else
			warnMooseRun:Show(args.destName)
		end
	elseif args.spellId == 229593 then
		--timerHippoFixateCD:Start()
		if args:IsPlayer() then
			specWarnHippoFixate:Show()
		else
			warnHippoFixate:Show(args.destName)
		end
	end
end
