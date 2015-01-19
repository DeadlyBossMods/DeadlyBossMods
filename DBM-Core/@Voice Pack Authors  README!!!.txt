Voice Pack TOC File:
	"## X-DBM-Voice: 1" Enables voice pack detection
	"## X-DBM-Voice-Name" Should be long name you want to appear in dropdown menu
	"## X-DBM-Voice-ShortName" should be short name that matches folder name after DBM-VP. So for example, DBM-VPHarry would be "Harry" for a short name.
	"## X-DBM-Voice-Version" should be a single number identifying whether or not the voice pack is new enough to enable special warning sound filter.
		--Version 1: Contains All files in Highmaul currently present in DBM 6.0.10
		--Version 2: Contains All files in Highmaul currently present in DBM 6.0.11 and 6.0.12
		--Version 3: TBD
	"## X-DBM-Voice-HasCount: 1" Enables voice pack countdown injection. Voice pack supports adding it's own countdown to dbm countdown options.

Example TOC File:

## Interface: 60000
## X-Min-Interface: 60000
## Title:|cffffe00a<|r|cffff7d0aDBM|r|cffffe00a>|r |cff69ccf0Voicepack VEM|r
## Title-zhCN:|cffffe00a<|r|cffff7d0aDBM|r|cffffe00a>|r |cff69ccf0VEM语音包|r
## Title-zhTW:|cffffe00a<|r|cffff7d0aDBM|r|cffffe00a>|r |cff69ccf0VEM語音包|r
## DefaultState: enabled
## RequiredDeps: DBM-Core
## Author: Chouu, Iceoven
## Version: 1.0
## X-DBM-Voice: 1
## X-DBM-Voice-Name: VEM English Female
## X-DBM-Voice-ShortName: VEM
## X-DBM-Voice-Version: 1
## X-DBM-Voice-HasCount: 1

File structure:
You can learn proper file structure by following the VPDemo
http://wow.curseforge.com/addons/dbm-voicepack-demo/

Additional Information:
*The special warning sound filter will only work if Voice Pack version is accepted by current DBM version, to ensure no situations where users have both missing special warnings AND missing voices. The voice pack will still be full functional and is never disabled by DBM. Only the special warning sound filter is disabled and user presented with an message that their voice pack may be out of date and to look for an update. Do not set this version higher to avoid filter disable or user message if your voice pack is missing files needed by encounter modules.
*Countdown sounds can now be injected into countdown options if files 1.ogg through 10.ogg are placed within "count" folder inside your voice pack. DBM will auto add these sounds to countdown options if you have ## X-DBM-Voice-HasCount: 1.