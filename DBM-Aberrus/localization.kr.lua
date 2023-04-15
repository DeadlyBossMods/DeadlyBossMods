if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Kazzara --
---------------------------
--L= DBM:GetModLocalization(2522)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  The Amalgamation Chamber --
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "1페이즈에서 각 보스간 거리 검사를 적극적으로 해서 근처에 없는 보스의 특정 경고와 타이머 자동으로 숨김 (43미터 이상)"
})

---------------------------
--  The Forgotten Experiments --
---------------------------
--L= DBM:GetModLocalization(2530)

---------------------------
--  Assault of the Zaqali --
---------------------------
L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "큰 쫄 (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "새 수렵꾼이나 경비병이 성루를 타고 올라오는 타이머 보기"
})

L:SetMiscLocalization({
	northWall		= "지휘관이 북쪽 성루를 타고 오릅니다!",
	southWall		= "지휘관이 남쪽 성루를 타고 오릅니다!"
})

---------------------------
--  Rashok --
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "탱커 교대시 모드 작동 방식 설정",
	OnlyIfDanger		= "다른 탱커가 위험한 공격을 받을 때 도발 경고 보기",
	MinMaxSoak			= "연계 공격에서 첫번째 공격 직후 또는 다른 탱커가 위험한 공격을 받을때  도발 경고 보기",
	DoubleSoak			= "연계 공격이 끝난 후 또는 다른 탱커가 위험한 공격을 받을 때 도발 경고 보기"--Default
})

---------------------------
--  The Vigilant Steward, Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}바닥 %d",--<icon> Pool 1,2,3
	soakpool	= "바닥 밟기"
})

---------------------------
--  Echo of Neltharion --
---------------------------
--L= DBM:GetModLocalization(2523)

---------------------------
--  Scalecommander Sarkareth --
---------------------------
--L= DBM:GetModLocalization(2520)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"에베루스 일반몹"
})
