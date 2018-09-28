local mod	= DBM:NewMod("BrawlRank4", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(28115)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_START 133212",
	"SPELL_AURA_APPLIED 133129 228981 236155",
	"SPELL_AURA_APPLIED_DOSE 236155",
	"SPELL_AURA_REMOVED 228981"
--	"PLAYER_TARGET_CHANGED"
)

--TODO, stickes stack warning for Aura of Rot
local warnWaterShield			= mod:NewTargetNoFilterAnnounce(228981, 1)--Burnstachio
local warnRockets				= mod:NewCastAnnounce(133212, 4)--Max Megablast (GG Engineering)

local specWarnAuraofRot			= mod:NewSpecialWarningStack(236155, nil, 8, nil, nil, 1, 6)

local timerWaterShield			= mod:NewTargetTimer(15, 228981, nil, nil, nil, 5)--Burnstachio
local timerRockets				= mod:NewBuffActiveTimer(9, 133212, nil, nil, nil, 3)--Max Megablast (GG Engineering)

local countdownWaterShield		= mod:NewCountdownFades(15, 228981)

--mod:AddBoolOption("SetIconOnDominika", true)--Dominika the Illusionist 

local brawlersMod = DBM:GetModByName("Brawlers")
--local DominikaGUID = 0

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133212 then
		warnRockets:Show()
		timerRockets:Schedule(4)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 228981 then
		timerWaterShield:Start(args.destName)
		if brawlersMod:PlayerFighting() then
			countdownWaterShield:Start()
		else
			warnWaterShield:Show(args.destName)
		end
--	elseif args.spellId == 133129 then
--		DominikaGUID = args.destGUID
	elseif args.spellId == 236155 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 8 then
			specWarnAuraofRot:Show(amount)
			specWarnAuraofRot:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 228981 then
		timerWaterShield:Stop(args.destName)
		if brawlersMod:PlayerFighting() then
			countdownWaterShield:Cancel()
		end
	end
end

--[[
function mod:PLAYER_TARGET_CHANGED()
	if self.Options.SetIconOnDominika and not DBM.Options.DontSetIcons and UnitGUID("target") == DominikaGUID and GetRaidTargetIndex("target") ~= 8 then
		SetRaidTarget("target", 8)
	end
end
--]]
