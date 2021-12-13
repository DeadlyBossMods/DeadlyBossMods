if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Vigilant Guardian --
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

---------------------------
--  Dausegne, the Fallen Oracle --
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox --
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon --
---------------------------
L= DBM:GetModLocalization(2460)

L:SetMiscLocalization({
	Deathtouch		= "죽음의손길",
	Dispel			= "해제",
	Sin				= "죄악",
	Stacks			= "중첩"
})

---------------------------
--  Lihuvim, Principal Architect --
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --
---------------------------
--L= DBM:GetModLocalization(2465)

---------------------------
--  Halondrus the Reclaimer --
---------------------------
--L= DBM:GetModLocalization(2463)

---------------------------
--  Anduin Wrynn --
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "신성 모독의 모드 작동 방식을 설정합니다. DBM 사용시 공대장의 설정이 적용됩니다",
	Auto				= "'당신이 걸림' 경고시 자동으로 짝이 지정됩니다. 같은 짝끼리 고유 상징이 말풍선으로 표시됩니다",
	Generic				= "'당신이 걸림' 경고시 짝을 지정하지 않습니다. 2종류 디버프에 각각 별도의 상징이 말풍선으로 표시됩니다",--Default
	None				= "'당신이 걸림' 경고시 짝을 지정하지 않습니다. 말풍선도 나오지 않습니다"
})

---------------------------
--  Lords of Dread --
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon --
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer --
---------------------------
L= DBM:GetModLocalization(2464)

L:SetMiscLocalization({
	Pylon		= "파일런"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"매장터 일반몹"
})
