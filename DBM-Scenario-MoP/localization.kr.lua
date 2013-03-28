if GetLocale() ~= "koKR" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "테라모어의 몰락"
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "파멸의 투기장"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "사자의 상륙지"
else
	landfall = "지배령 거점"
end

L:SetGeneralLocalization({
	name = landfall
})

L:SetWarningLocalization({
	WarnAchFiveAlive	= "\"불사전설\" 업적 실패"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "\"불사전설\" 업적 실패시 알림 보기"
})


--------------------------------
-- Troves of the Thunder King --
--------------------------------

L= DBM:GetModLocalization("Troves")

L:SetGeneralLocalization{
	name = "천둥왕의 보물"
}

------------------------
-- Warlock Green Fire --
------------------------

L= DBM:GetModLocalization("GreenFire")

L:SetGeneralLocalization{
	name = "Warlock Green Fire"--No idea what real name is. It's not something i can test or verify.
}

L:SetWarningLocalization({
	specWarnLostSouls		= "Lost Souls!",
	specWarnEnslavePitLord	= "Pit Lord - Enslave Now!"
})

L:SetTimerLocalization({
	timerLostSoulsCD		= "Lost Souls CD"
})

L:SetOptionLocalization({
	specWarnLostSouls		= "Show special warning when Lost Souls spawn",
	specWarnEnslavePitLord	= "Show special warning to enslave demon when Pit Lord activates/breaks free",
	timerLostSoulsCD		= "Show cooldown timer for next Lost Souls spawn"
})

L:SetMiscLocalization({
	LostSouls				= "Face the souls of those your kind doomed to perish, Warlock!"
})
