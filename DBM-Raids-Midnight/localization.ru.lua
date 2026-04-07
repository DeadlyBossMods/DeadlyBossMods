if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  LightblindedVanguard (3180) --
---------------------------
L= DBM:GetModLocalization(2737)

L:SetMiscLocalization({
	JudgementShield	= "Правосудие - Щит праведника)",
	JudgementFV		= "Правосудие - Окончательный приговор)"
})

---------------------------
--  Beloren, Child of Alar (3182) --
---------------------------
L= DBM:GetModLocalization(2739)

L:SetMiscLocalization({
	ColorSwap		= "Смена цвета"
})

---------------------------
--  Midnight Falls (3183) --
---------------------------

L= DBM:GetModLocalization(2740)

L:SetMiscLocalization({
	MemoryGame		= "Игра на запоминание"
})
