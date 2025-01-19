if GetLocale() ~= "ptBR" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD					= "Bem vindo ao " .. L.DBM .. " Digite /dbm help para obter uma lista dos comandos disponíveis. Para acessar as opções, digite /dbm no seu bate-papo para começar a configuração. Carregue zonas específicas manualmente para configurar opções específicas de cada chefe para o seu gosto pessoal. O " .. L.DBM .. " tenta fazer isso automaticamente para você, observando sua spec na primeira vez que é executado. De qualquer forma, você pode querer ativar outras opções."
L.SILENT_REMINDER 					= "Lembrete: " .. L.DBM .. " ainda está em modo silencioso."
L.NEWS_UPDATE						= "|h|c11ff1111Notícias|r|h: Esta atualização altera a estrutura do módulo para que o clássico e o principal agora usem módulos unificados (iguais). Isso significa que os módulos Vanilla, TBC, Wrath e Cata agora são instalados separadamente usando os mesmos pacotes que o jogo original. Leia mais sobre isso |Hgarrmission:DBM:news|h|cff3588ff[aqui]|r|h"
L.NEWS_UPDATE_REPEAT				= "|h|c11ff1111Notícias|r|h: Esta atualização altera a estrutura do módulo para que o clássico e o principal agora usem módulos unificados (iguais). Isso significa que os módulos Vanilla, TBC, Wrath e Cata agora são instalados separadamente usando os mesmos pacotes que o jogo original. Você está atualmente em um raide que está com um módulo ausente. Esta mensagem continuará aparecendo (e você não terá alertas funcionais para esta zona) até que você tenha instalado o módulo de raide ausente."

L.COPY_URL_DIALOG_NEWS 				= "Para ler as últimas notícias, visite o link abaixo"

L.LOAD_MOD_ERROR					= "Erro ao carregar módulo %s: %s "
L.LOAD_MOD_SUCCESS					= "Módulo '%s' carregado. Para mais opções, digite /dbm ou /dbm help no bate-papo"
L.LOAD_MOD_COMBAT					= "Carregamento de '%s' adiado até que você saia de combate"
L.LOAD_GUI_ERROR					= "Não foi possível carregar interface gráfica: %s"
L.LOAD_GUI_COMBAT					= "A interface gráfica não pode ser carregada em combate e será assim que você o sair. Quando estiver carregada, você poderá chama-la em combate."
L.BAD_LOAD							= L.DBM .. " detectou que a sua mod desta área falhou ao tentar carregar por completo por estar em combate. Use o comando /reloadui assim que sair de combate para corrigir o problema."
L.LOAD_MOD_VER_MISMATCH				= "%s não foi carregado por não cumprir os requerimentos. Uma atualização da mod é necessária. Obrigado."
L.LOAD_MOD_EXP_MISMATCH 			= "%s não pôde ser carregado porque foi projetado para uma expansão do WoW que não está atualmente disponível. Quando a expansão estiver disponível, este módulo funcionará automaticamente."
L.LOAD_MOD_TOC_MISMATCH 			= "%s não pôde ser carregado porque foi projetado para um patch do WoW (%s) que não está atualmente disponível. Quando o patch estiver disponível, este módulo funcionará automaticamente."
L.LOAD_MOD_DISABLED 				= "%s está instalado, mas atualmente desativado. Este mod não será carregado a menos que você o ative."
L.LOAD_MOD_DISABLED_PLURAL 			= "%s estão instalados, mas atualmente desativados. Estes mods não serão carregados a menos que você os ative."

L.COPY_URL_DIALOG 					= "Copiar URL"
L.COPY_WA_DIALOG 					= "Copiar Chave WA"

--Post Patch 7.1
L.TEXT_ONLY_RANGE 					= "O quadro de distância está limitado apenas a texto devido a restrições de API nesta área."
L.NO_RANGE 							= "O quadro de distância não pode ser usado devido a restrições de API nesta área."
L.NO_ARROW 							= "A seta não pode ser usada em instâncias."
L.NO_HUD 							= "O HUDMap não pode ser usado em instâncias."

L.DYNAMIC_DIFFICULTY_CLUMP			= L.DBM .. " desativou o quadro de distância dinâmico nesta luta, por falta de informação sobre o número de jogadores à ficarem amontoados para um grupo desse tamanho."
L.DYNAMIC_ADD_COUNT					= L.DBM .. " desativou anúncio da contagem de adds nesta luta, por falta de informação da quantidade de adds para um grupo deste tamanho."
L.DYNAMIC_MULTIPLE					= L.DBM .. " desativou varias funções desta luta por causa da falta de informação sobre certas mecânicas para um grupo deste tamanho."

L.LOOT_SPEC_REMINDER				= "A sua especialização atual é %s. A sua escolha atual de saque é %s."

L.BIGWIGS_ICON_CONFLICT				= L.DBM .. " detectou que você tem ícones ativados tanto no BigWigs quanto no " .. L.DBM .. ". Por favor desabilite um dos dois para evitar conflitos com o líder da raide"

L.MOD_AVAILABLE						= "%s esta disponível para este conteúdo. Você pode baixá-lo no Curse, Wago, WoWI ou Github."
L.MOD_MISSING						= "Sem módulo de raide"

L.COMBAT_STARTED					= "%s na mira. Boa sorte e divirta-se! :)"
L.COMBAT_STARTED_IN_PROGRESS		= "Entrando em uma luta em progresso contra %s. Boa sorte e divirta-se! :)"
L.GUILD_COMBAT_STARTED				= "%s engrenou em combate com a guilda"--Uncomment when updated, args have changed
L.SCENARIO_STARTED					= "%s começou. Boa sorte e divirta-se! :)"
L.SCENARIO_STARTED_IN_PROGRESS		= "Juntando-se à %s em progresso. Boa sorte e divirta-se! :)"
L.BOSS_DOWN							= "%s derrotado após %s!"
L.BOSS_DOWN_I						= "%s derrotado! você tem %d vitorias no total."
L.BOSS_DOWN_L						= "%s derrotado após %s! Sua última vitória levou %s, sua vitória mais rápida %s. Você tem um total de %d vitórias."
L.BOSS_DOWN_NR						= "%s derrotado após %s! Esse é um novo recorde! (Recorde antigo era %s). Você tem um total de %d vitórias."
L.RAID_DOWN							= "%s derrotado após %s!"
L.RAID_DOWN_L						= "%s derrotado após %s! Sua última vitória levou %s."
L.RAID_DOWN_NR						= "%s derrotado após %s! Esse é um novo recorde! (Recorde antigo era %s)."
L.GUILD_BOSS_DOWN					= "%s foi derrotado pela guilda após %s!"--Uncomment when updated, args have changed
L.SCENARIO_COMPLETE					= "%s completado após %s!"
L.SCENARIO_COMPLETE_I				= "%s completado! Você tem %d vitórias no total."
L.SCENARIO_COMPLETE_L				= "%s completado após %s! A sua ultima vitória demorou %s e a mais rápida %s. Você tem %d vitórias no total."
L.SCENARIO_COMPLETE_NR				= "%s completado após %s! Esse é o seu novo recorde! (Ultimo recorde era %s). Você tem %d vitórias no total."
L.COMBAT_ENDED_AT					= "Combate contra %s (%s) encerrado após %s."
L.COMBAT_ENDED_AT_LONG				= "Combate contra %s (%s) encerrado após %s. Você tem um total de %d derrotas nessa dificuldade."
L.GUILD_COMBAT_ENDED_AT				= "Guilda foi derrotada por %s (%s) após %s."--Uncomment when updated, args have changed
L.SCENARIO_ENDED_AT					= "%s finalizado após %s."
L.SCENARIO_ENDED_AT_LONG			= "%s finalizado após %s. Você tem %d de vitórias parciais nessa dificuldade."
L.COMBAT_STATE_RECOVERED			= "Luta contra %s começou %s atrás, reajustando cronômetros..."
L.TRANSCRIPTOR_LOG_START			= "Gravação do Transcritor começou."
L.TRANSCRIPTOR_LOG_END				= "Gravação do Transcritor finalizado."

L.MOVIE_SKIPPED 					= L.DBM .. " tentou pular uma cena automaticamente."
L.MOVIE_NOTSKIPPED 					= L.DBM .. " detectou uma cena cortável, mas não a pulou devido a um bug da Blizzard. Quando esse bug for corrigido, o pulo será reativado."
L.BONUS_SKIPPED 					= L.DBM .. " fechou automaticamente o quadro de saque extra. Se precisar trazer esse quadro de volta, digite /dbmbonusroll dentro de 3 minutos."

L.AFK_WARNING 				= "Você está LDT e em combate (%d por cento de vida restante), disparando alerta sonoro. Se não estiver LDT, limpe sua bandeira de LDT ou desative esta opção em 'Funcionalidades extra'."
L.LOWHEALTH_WARNING			= "Vida baixa (%d por cento de vida restante), reproduzindo alerta sonoro. Você pode desativar essa opção em 'Funcionalidades extra'."
L.ENTERING_COMBAT			= "Entrando em combate"
L.LEAVING_COMBAT			= "Saindo de combate"

L.COMBAT_STARTED_AI_TIMER 			= "Meu CPU é um processador neural; um computador de aprendizado. (Esta luta usará o recurso de IA de cronômetro para gerar aproximações de cronômetro)"

L.PROFILE_NOT_FOUND					= "<" .. L.DBM .. "> Seu perfil atual está corrompido. " .. L.DBM .. " carregara o perfil 'Padrão'."
L.PROFILE_CREATED					= "'%s' perfil criado."
L.PROFILE_CREATE_ERROR				= "Falha ao criar perfil. Nome de perfil inválido."
L.PROFILE_CREATE_ERROR_D			= "Falha ao criar perfil. '%s' perfil já existe."
L.PROFILE_APPLIED					= "'%s' perfil aplicado."
L.PROFILE_APPLY_ERROR				= "Falha ao aplicar perfil. '%s' perfil não existe."
L.PROFILE_COPIED					= "'%s' perfil copiado."
L.PROFILE_COPY_ERROR				= "Falha ao copiar perfil. '%s' perfil não existe."
L.PROFILE_COPY_ERROR_SELF			= "Falha ao copiar perfil, não é possível copiar a si mesmo."
L.PROFILE_DELETED					= "'%s' perfil deletado. Perfil 'Padrão' será aplicado."
L.PROFILE_DELETE_ERROR				= "Falha ao deletar perfil. '%s' perfil não existe."
L.PROFILE_CANNOT_DELETE				= "Não é possível deletar o perfil 'Padrão'."
L.MPROFILE_COPY_SUCCESS				= "%s's (%d spec) preferencias do módulo foram copiadas."
L.MPROFILE_COPY_SELF_ERROR			= "Não é possível copiar às preferencias do char para ele mesmo"
L.MPROFILE_COPY_S_ERROR				= "Origem esta corrompida. Preferencias não foram copias ou foram copiadas parcialmente. Falha ao copiar."
L.MPROFILE_COPYS_SUCCESS			= "%s's (%d spec) preferencias de sons da mod foram copiadas."
L.MPROFILE_COPYS_SELF_ERROR			= "Não é possível copiar as preferencias de sons do char para ele mesmo"
L.MPROFILE_COPYS_S_ERROR			= "Origem esta corrompida. Preferencias de sons não foram copiadas ou foram copiadas parcialmente. Falha ao copiar."
L.MPROFILE_DELETE_SUCCESS			= "%s's (%d spec) preferencias da mod deletadas."
L.MPROFILE_DELETE_SELF_ERROR		= "Não é possível deletar preferencias que estão em uso."
L.MPROFILE_DELETE_S_ERROR			= "Origem esta corrompida. Preferencias não foram deletadas ou foram deletadas parcialmente. Falha ao deletar."

L.NOTE_SHARE_SUCCESS 				= "%s compartilhou sua nota para %s"
L.NOTE_SHARE_LINK 					= "Clique aqui para abrir a nota"
L.NOTE_SHARE_FAIL 					= "%s tentou compartilhar o texto da nota com você para %s. No entanto, o mod associado a essa habilidade não está instalado ou não está carregado. Se você precisar desta nota, certifique-se de carregar o mod para o qual eles estão compartilhando notas e peça para eles compartilharem novamente"

L.NOTEHEADER 						= "Digite o texto da sua nota aqui para %s. Ao incluir o nome de um jogador entre ><, ele será colorido conforme a classe. Para alertas com várias contagens, separe as notas com '/'"
L.NOTEFOOTER 						= "Pressione 'Ok' para aceitar as alterações ou 'Cancelar' para rejeitar as alterações"
L.NOTESHAREDHEADER 					= "%s compartilhou o texto da nota abaixo para %s. Se você aceitar, ela substituirá sua nota existente"
L.NOTESHARED 						= "Sua nota foi enviada para o grupo"
L.NOTESHAREERRORSOLO 				= "Solitário? Não deveria estar passando notas para você mesmo"
L.NOTESHAREERRORBLANK 				= "Não é possível compartilhar notas em branco"
L.NOTESHAREERRORGROUPFINDER 		= "As notas não podem ser compartilhadas em CBs, LFR ou LFG"
L.NOTESHAREERRORALREADYOPEN 		= "Não é possível abrir um link de nota compartilhada enquanto o editor de nota já estiver aberto, para evitar que você perca a nota que está editando atualmente"

L.ALLMOD_DEFAULT_LOADED				= "Foram carregadas preferencias padrões para todas as mods desta area."
L.ALLMOD_STATS_RESETED				= "Todas as estatísticas da mod foram apagadas."
L.MOD_DEFAULT_LOADED				= "Foram carregadas opções padrão para esta luta."

L.WORLDBOSS_ENGAGED					= "%s foi possivelmente puxado no seu reino %s por cento de vida. (Enviado por %s)"
L.WORLDBOSS_DEFEATED				= "%s foi possivelmente derrotado no seu reino (Enviado por %s)."
L.WORLDBUFF_STARTED					= "%s buff começou em seu reino para a facção da %s (Enviado por %s)."

L.TIMER_FORMAT_SECS					= "%.2f |4segundo:segundos;"
L.TIMER_FORMAT_MINS					= "%d |4minuto:minutos;"
L.TIMER_FORMAT						= "%d |4minuto:minutos; e %.2f |4segundo:segundos;"

L.MIN								= "min"
L.MIN_FMT							= "%d min"
L.SEC								= "seg"
L.SEC_FMT							= "%s seg"

L.GENERIC_WARNING_OTHERS			= "e mais um"
L.GENERIC_WARNING_OTHERS2			= "e %d outros"
L.GENERIC_WARNING_BERSERK			= "Frenético em %s %s"
L.GENERIC_TIMER_BERSERK				= "Frenético"
L.OPTION_TIMER_BERSERK				= "Exibir cronômetro para $spell:26662"
L.BAD								= "Mau"

L.OPTION_CATEGORY_TIMERS			= "Barras"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS			= "Categoria de anúncios"
L.OPTION_CATEGORY_WARNINGS_YOU		= "Anúncios pessoais"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Anúncios de alvo"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "Anúncios de função"
L.OPTION_CATEGORY_SPECWARNINGS		= "Anúncios especiais"

L.OPTION_CATEGORY_SOUNDS			= "Sons"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS			= "Menus suspensos"--Still put in MISC sub grooup, just used for line separators since multiple of these on a fight (or even having on of these at all) is rare.
L.OPTION_CATEGORY_YELLS 			= "Gritos"
L.OPTION_CATEGORY_NAMEPLATES 		= "Placas de nome"
L.OPTION_CATEGORY_ICONS 			= "Ícones"
L.OPTION_CATEGORY_PAURAS 			= "Auras privadas"

L.AUTO_RESPONDED					= "Respondido automaticamente"
L.STATUS_WHISPER					= "%s: %s, %d/%d pessoas vivas"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s está ocupado lutando contra %s (%s, %d/%d pessoas vivas)"
L.WHISPER_COMBAT_END_KILL			= "%s derrotou %s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s derrotou %s! Eles tem um total de %d vitórias."
L.WHISPER_COMBAT_END_WIPE_AT		= "%s foi derrotado por %s em %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s foi derrotado por %s em %s. Eles tem um total de %d derrotas nessa dificuldade."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s esta ocupado em %s (%d/%d pessoas vivas)"
L.WHISPER_SCENARIO_END_KILL			= "%s foi completado %s!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s foi completado %s! Eles tem um total de %d vitórias."
L.WHISPER_SCENARIO_END_WIPE			= "%s não foi completado %s"
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s não foi completado %s. Eles tem um total de %d vitórias parciais nesta dificuldade."

L.VERSIONCHECK_HEADER				= "Módulo de chefe - Versões"
L.VERSIONCHECK_ENTRY				= "%s: %s (%s)"
L.VERSIONCHECK_ENTRY_TWO			= "%s: %s (%s) & %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM			= "%s: " .. L.DBM .. " não instalado"
L.VERSIONCHECK_FOOTER				= "Encontrados %d jogadores com " .. L.DBM .. " & %d jogadores com Bigwigs"
L.VERSIONCHECK_OUTDATED				= "Os seguintes %d jogadores estão com versões desatualizadas de boss mods: %s"
L.YOUR_VERSION_OUTDATED				= "Sua versão do " .. L.DEADLY_BOSS_MODS .. " está desatualizada. Por favor, acesse no Curse, Wago, WoWI ou Github para baixar a versão mais recente."
L.VOICE_PACK_OUTDATED				= "O pacote de vozes do seu " .. L.DBM .. " pode estar sem alguns dos sons suportados por esta versão do " .. L.DBM .. ". O filtro de anúncio especial sonoro foi desativado. Por favor, baixe a versão mais recente do pacote de vozes ou entre em contato com o autor para obter um pacote que contenha os sons mencionados."
L.VOICE_MISSING						= "Você tinha um pacote de vozes " .. L.DBM .. " selecionado que não pode ser encontrado. Sua seleção foi restaurada para 'Nenhum'. Caso seja um erro, certifique-se de que o pacote está instalado corretamente e ativado em addons."
L.VOICE_DISABLED					= "Você atualmente tem pelo menos um pacote de voz do " .. L.DBM .. " instalado, mas nenhum está ativado. Se pretende usar um pacote de voz, certifique-se de que está selecionado em 'Alertas falados'. Caso contrário, desinstale os pacotes de voz não utilizados para ocultar esta mensagem."
L.VOICE_COUNT_MISSING				= "Voz de contagem regressiva %d esta selecionada para um pacote de voz que não pode ser encontrado. Foi restaurada a configuração padrão."
L.BIG_WIGS							= "BigWigs" -- OPTIONAL
L.WEAKAURA_KEY						= " (|cff308530Chave WA:|r %s)"

L.UPDATEREMINDER_HEADER				= "Sua versão de " .. L.DEADLY_BOSS_MODS .. " está desatualizada.\nA versão %s (%s) está disponível para download nos sites Curse, Wago, WoWI ou Github."
L.UPDATEREMINDER_HEADER_SUBMODULE	= "Seu módulo %s está desatualizado.\nA versão %s está disponível para download nos sites Curse, Wago, WoWI ou Github."
L.UPDATEREMINDER_FOOTER 			= "Pressione " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar o link de download para a área de transferência."
L.UPDATEREMINDER_FOOTER_GENERIC 	= "Pressione " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar para a área de transferência."
L.UPDATEREMINDER_DISABLE			= "AVISO: Seu " .. L.DBM .. " foi desativado por estar drasticamente desatualizado (pelo menos %d revisões). Atualize para utilizá-lo novamente. Isso garante que versões antigas ou códigos incompatíveis não prejudiquem sua experiência de jogo ou a de sua raide."
L.UPDATEREMINDER_DISABLETEST		= "AVISO: Seu " .. L.DEADLY_BOSS_MODS .. " foi desativado devido à sua versão desatualizada neste reino de teste/beta. Ele não pode ser usado até ser atualizado, garantindo que mods antigos não afetem o feedback de teste."
L.UPDATEREMINDER_HOTFIX				= "Sua versão de " .. L.DBM .. " contém cronômetros ou alertas incorretos para este chefe. Isso foi corrigido em uma versão mais recente (ou na versão alfa mais atual)."
L.UPDATEREMINDER_HOTFIX_ALPHA 		= "Sua versão de " .. L.DBM .. " possui problemas conhecidos neste encontro de chefe, corrigidos em uma próxima atualização (ou na versão alfa mais recente)."
L.UPDATEREMINDER_MAJORPATCH			= "AVISO: Seu " .. L.DBM .. " foi desativado por estar drasticamente desatualizado (pelo menos %d revisões). Atualize para utilizá-lo novamente. Baixe a versão mais recente em deadlybossmods.com ou Curse o mais breve possível."
L.VEM								= "AVISO: Você está usando " .. L.DBM .. " e Voice Encounter Mods. " .. L.DBM .. " não funcionará corretamente nessa configuração e, portanto, não será carregado."
L.OUTDATEDPROFILES					= "AVISO: " .. L.DBM .. "-Profiles não é compatível com esta versão de " .. L.DBM .. ". Remova-o para evitar conflitos e permitir que " .. L.DBM .. " funcione corretamente."
L.OUTDATEDSPELLTIMERS 				= "AVISO: DBM-SpellTimers interfere no " .. L.DBM .. " e deve ser desativado para que ele funcione corretamente."
L.OUTDATEDRLT 						= "AVISO: DBM-RaidLeadTools interfere no " .. L.DBM .. ". Este addon não é mais suportado e deve ser removido para evitar conflitos."
L.VICTORYSOUND 						= "AVISO: DBM-VictorySound não é compatível com esta versão do " .. L.DBM .. ". Remova-o para evitar conflitos e garantir o funcionamento adequado."
L.DPMCORE 							= "AVISO: Os módulos Deadly PvP foram descontinuados e não são compatíveis com esta versão do " .. L.DBM .. ". Remova-os para evitar conflitos."
L.DBMLDB 							= "AVISO: O DBM-LDB agora está incorporado ao DBM-Core. Embora não cause problemas, é recomendável remover 'DBM-LDB' da pasta de addons."
L.DBMLOOTREMINDER 					= "AVISO: O módulo de terceiros DBM-LootReminder está instalado. Ele não é mais compatível com o cliente do WoW Retail e causa problemas no " .. L.DBM .. ", impedindo o envio de cronômetros de puxada. Recomenda-se desinstalá-lo."
L.UPDATE_REQUIRES_RELAUNCH			= "AVISO: Esta versão de " .. L.DBM .. " exige que o jogo seja reiniciado por completo para funcionar corretamente. A atualização inclui novos arquivos ou alterações no .toc que não podem ser carregadas via ReloadUI. Continuar sem reiniciar pode causar erros ou funcionalidades quebradas."
L.OUT_OF_DATE_NAG 					= "Sua versão do " .. L.DBM .. " está desatualizada, e este módulo de luta possui recursos mais recentes ou correções de bugs. Atualize para melhorar sua experiência neste encontro."
L.PLATER_NP_AURAS_MSG 				= L.DBM .. " possui um recurso avançado que exibe cronômetros de recarga inimigos como ícones nas placas de nome. Isso está ativado por padrão para a maioria dos usuários, mas desativado nas opções do Plater. Para aproveitar ao máximo o DBM e o Plater, ative essa função no Plater em 'Buff Special'. Para não ver esta mensagem novamente, desative a opção 'Ícones de recarga nas placas de nome' nas configurações do DBM."

L.MOVABLE_BAR						= "Arraste-me!"

L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h te enviou um cronômetro do " .. L.DBM .. ": '%2$s'\n|Hgarrmission:DBM:cancel:%2$s:nil|h|cff3588ff[Cancelar esse cronômetro]|r|h  |Hgarrmission:DBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar cronômetros de %1$s]|r|h"
L.PIZZA_CONFIRM_IGNORE				= "Você tem certeza de que realmente deseja ignorar cronômetros de %s até o fim desta sessão?"
L.PIZZA_ERROR_USAGE					= "Uso: /dbm [broadcast] timer <tempo> <texto>"

L.MINIMAP_TOOLTIP_HEADER			= L.DEADLY_BOSS_MODS --Technically redundant -- OPTIONAL
L.MINIMAP_TOOLTIP_FOOTER			= "Mantenha Shift e arraste para mover"

L.RANGECHECK_HEADER					= "Verificação de distância: (%d m)"
L.RANGECHECK_HEADERT				= "Verificação de distância (%dy-%dP)"
L.RANGECHECK_RHEADER				= "R-Verificação de distância (%dy)"
L.RANGECHECK_RHEADERT				= "R-Verificação de distância (%dy-%dP)"
L.RANGECHECK_SETRANGE				= "Definir distância"
L.RANGECHECK_SETTHRESHOLD			= "Definir limite para jogador"
L.RANGECHECK_SOUNDS					= "Sons"
L.RANGECHECK_SOUND_OPTION_1			= "Soar quando um jogador entrar na distância"
L.RANGECHECK_SOUND_OPTION_2			= "Soar quando mais de um jogador entrar na distância"
L.RANGECHECK_SOUND_0				= "Sem som"
L.RANGECHECK_SOUND_1				= "Som padrão"
L.RANGECHECK_SOUND_2				= "Bip irritante"
L.RANGECHECK_SETRANGE_TO			= "%d m"
L.RANGECHECK_OPTION_FRAMES			= "Quadros"
L.RANGECHECK_OPTION_RADAR			= "Exibir quadro do radar"
L.RANGECHECK_OPTION_TEXT			= "Exibir quadro de texto"
L.RANGECHECK_OPTION_BOTH			= "Exibir ambos"
L.RANGERADAR_HEADER					= "Radar (%d m)"
L.RANGERADAR_RHEADER				= "R-distância:%d Jogadores:%d"
L.RANGERADAR_IN_RANGE_TEXT			= "%d em distância (%0.1fy)"--Multi
L.RANGECHECK_IN_RANGE_TEXT			= "%d em distância"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE		= "%s (%0.1fy)"--One target

L.INFOFRAME_TITLE					= "Quadro de info"
L.INFOFRAME_SHOW_SELF				= "Sempre exibir seu poder"		-- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES				= "Linhas máximas"
L.INFOFRAME_SETCOLS					= "Colunas máximas"
L.INFOFRAME_LINESDEFAULT			= "Definido pelo mod"
L.INFOFRAME_LINES_TO				= "%d linhas"
L.INFOFRAME_COLS_TO					= "%d colunas"
L.INFOFRAME_POWER					= "Poder"
L.INFOFRAME_AGGRO					= "Agro"
L.INFOFRAME_MAIN					= "Principal:"--Main power
L.INFOFRAME_ALT						= "Secundária:"--Alternate Power

L.LFG_INVITE						= "Aceitar convite"

L.SLASHCMD_HELP						= {
	"Comandos disponíveis:",
	"-----------------",
	"/range <número> ou /distance <número>: Mostra o quadro de distância. /rrange ou /rdistance para inverter as cores.",
	"/hudar <número>: Mostra o buscador de distância baseado em HUD.",
	"/dbm timer: Inicia um cronômetro personalizado do " .. L.DBM .. ", veja '/dbm timer' para detalhes.",
	"/dbm arrow: Mostra a seta do " .. L.DBM .. ", veja /dbm arrow help para detalhes.",
	"/dbm hud: Mostra o HUD do " .. L.DBM .. ", veja '/dbm hud' para detalhes.",
	"/dbm help2: Mostra comandos de gerenciamento de raide."
}
L.SLASHCMD_HELP2					= {
	"Comandos disponíveis:",
	"-----------------",
	"/dbm pull <seg>: Dispara um cronômetro para iniciar a luta em <seg> segundos. Dá a todos os integrantes da raide um cronômetro para iniciar a luta (requer status de líder/assistente).",
	"/dbm break <min>: Inicia um cronômetro de intervalo de <min> minutos. Dá a todos os integrantes da raide um cronômetro de intervalo (requer status de líder/assistente).",
	"/dbm version: Realiza uma verificação de versão de toda a raide. (ou: ver).",
	"/dbm version2: Realiza uma verificação de versão de toda a raide e sussurra para avisando os membros que estão desatualizados (alias: ver2).",
	"/dbm lag: Realiza uma verificação de latência em toda a raide.",
	"/dbm durability: Realiza uma verificação de durabilidade em toda a raide."
}
--Translate all of these
L.TIMER_USAGE						= {
	"Comandos de cronômetro do DBM:",
	"-----------------",
	"/dbm timer <tempo> <texto>: Inicia um cronômetro de " .. L.DBM .. " de <x> segundos com o nome <texto>.",
	"/dbm ltimer <tempo> <texto>: Inicia um cronômetro que também é automaticamente repetido até ser cancelado.",
	"('Broadcast' na frente de qualquer cronômetro também o compartilha com a raide se o líder/assistente)",
	"/dbm timer endloop: Interrompe qualquer ltimer em loop."
}

L.ERROR_NO_PERMISSION				= "Você não tem as permissões necessárias para fazer isso."
L.ERROR_NO_PERMISSION_COMBAT		= "O cronômetro de puxada/pausa não pode ser enviado enquanto o encontro está em andamento."
L.PULL_TIME_TOO_SHORT 				= "O cronômetro de puxada deve ser maior que 3 segundos."
L.PULL_TIME_TOO_LONG				= "O cronômetro de puxada não pode ser maior que que 60 segundos."

L.BREAK_USAGE 						= "O cronômetro de pausa não pode ser maior que 60 minutos. Certifique-se de inserir o tempo em minutos e não em segundos."
L.BREAK_START						= "Pausa começando agora - você tem %s!"
L.BREAK_MIN							= "Pausa encerra-se em %s minutos!"
L.BREAK_SEC							= "Pausa encerra-se em %s segundos!"
L.TIMER_BREAK						= "Pausa!"
L.ANNOUNCE_BREAK_OVER				= "A pausa acabou"

L.TIMER_PULL						= "Puxando em"
L.ANNOUNCE_PULL						= "Puxando em %d seg"
L.ANNOUNCE_PULL_NOW					= "Puxando agora!"
L.ANNOUNCE_PULL_TARGET				= "Puxando %s em %d seg. (Enviado por %s)"
L.ANNOUNCE_PULL_NOW_TARGET			= "Puxando %s agora!"
L.GEAR_WARNING 						= "Aviso: Verifique o equipamento. Seu nível de item equipado está %d abaixo do nível de item do inventário."
L.GEAR_WARNING_WEAPON 				= "Aviso: Verifique se sua arma está corretamente equipada."
L.GEAR_FISHING_POLE 				= "Vara de Pesca"

L.ACHIEVEMENT_TIMER_SPEED_KILL		= "Vitória mais rápida."

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.you				= "%s em VÔCE"
L.AUTO_ANNOUNCE_TEXTS.target			= "%s em >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetsource		= ">%%s< lança %s em >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount		= "%s (%%s) em >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell				= "%s"
L.AUTO_ANNOUNCE_TEXTS.incoming 			= "Penalidade %s se aproximando"
L.AUTO_ANNOUNCE_TEXTS.incomingcount 	= "Penalidade %s se aproximando (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends 				= "%s terminado"
L.AUTO_ANNOUNCE_TEXTS.endtarget 		= "%s terminado: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades 			= "%s desapareceu"
L.AUTO_ANNOUNCE_TEXTS.addsleft			= "%s restantes: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast				= "Lançando %s: %.1f seg"
L.AUTO_ANNOUNCE_TEXTS.soon				= "%s em breve"
L.AUTO_ANNOUNCE_TEXTS.sooncount			= "%s (%%s) em breve"
L.AUTO_ANNOUNCE_TEXTS.countdown			= "%s em %%ds"
--
L.AUTO_ANNOUNCE_TEXTS.prewarn			= "%s em %s"
L.AUTO_ANNOUNCE_TEXTS.bait				= "%s em breve - isca agora"
--
L.AUTO_ANNOUNCE_TEXTS.stage				= "Fase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage			= "Fase %s em breve"
L.AUTO_ANNOUNCE_TEXTS.count				= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack				= "%s em >%%s< (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto			= "%s - mover para >%%s<"

local prewarnOption						= "Exibir anúncio antecipado para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you 			= "Exibir anúncio quando $spell:%s estiver em você"
L.AUTO_ANNOUNCE_OPTIONS.target			= "Exibir anúncio para alvos de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetNF 		= "Exibir anúncio para alvos de $spell:%s (ignora filtro global de alvos)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource 	= "Exibir anúncio para alvos de $spell:%s (com fonte)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount		= "Exibir anúncio para alvos de $spell:%s (com contagem)"
L.AUTO_ANNOUNCE_OPTIONS.spell			= "Exibir anúncio para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.spellsource		= "Exibir anúncio para $spell:%s (com fonte)"
L.AUTO_ANNOUNCE_OPTIONS.incoming 		= "Exibir anúncio quando $spell:%s tiver penalidades se aproximando"
L.AUTO_ANNOUNCE_OPTIONS.incomingcount 	= "Exibir anúncio quando $spell:%s tiver penalidades se aproximando (com contagem)"
L.AUTO_ANNOUNCE_OPTIONS.ends 			= "Exibir anúncio quando $spell:%s tiver terminado"
L.AUTO_ANNOUNCE_OPTIONS.endtarget 		= "Exibir anúncio quando $spell:%s tiver terminado (com alvo)"
L.AUTO_ANNOUNCE_OPTIONS.fades 			= "Exibir anúncio quando $spell:%s tiver desaparecido"
L.AUTO_ANNOUNCE_OPTIONS.addsleft 		= "Exibir anúncio para quantos $spell:%s ainda restam"
L.AUTO_ANNOUNCE_OPTIONS.cast			= "Exibir anúncio quando $spell:%s está sendo lançado"
L.AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.countdown		= "Exibir anúncio antecipado com contagem regressiva para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.prewarn			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait			= "Exibir anúncio antecipado (para iscar) para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stage			= "Exibir anúncio para fase %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange		= "Exibir anúncio para mudanças de fase"
L.AUTO_ANNOUNCE_OPTIONS.prestage		= "Exibir anúncio antecipado para fase %s"
L.AUTO_ANNOUNCE_OPTIONS.count			= "Exibir anúncio para $spell:%s (com contagem)"
L.AUTO_ANNOUNCE_OPTIONS.stack			= "Exibir anúncio para empilhamento de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.moveto			= "Exibir anúncio para quando se mover para alguém ou algum lugar para $spell:%s"

L.AUTO_SPEC_WARN_TEXTS.spell			= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends 			= "%s terminado"
L.AUTO_SPEC_WARN_TEXTS.fades 			= "%s desaparecido"
L.AUTO_SPEC_WARN_TEXTS.soon 			= "%s em breve"
L.AUTO_SPEC_WARN_TEXTS.sooncount 		= "%s (%%s) em breve"
L.AUTO_SPEC_WARN_TEXTS.bait 			= "%s em breve - isca agora"
L.AUTO_SPEC_WARN_TEXTS.prewarn 			= "%s em %s"
L.AUTO_SPEC_WARN_TEXTS.dispel			= "%s em >%%s< - dissipa agora"
L.AUTO_SPEC_WARN_TEXTS.interrupt		= "%s - interrompa >%%s<"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - interrompa >%%s< (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you				= "%s em você"
L.AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) em você"
L.AUTO_SPEC_WARN_TEXTS.youpos 			= "%s (Posição: %%s) em você"
L.AUTO_SPEC_WARN_TEXTS.youposcount 		= "%s (%%s) (Posição: %%s) em você"
L.AUTO_SPEC_WARN_TEXTS.soakpos 			= "%s (Posição de absorção: %%s)"
L.AUTO_SPEC_WARN_TEXTS.target			= "%s em >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount 		= "%s (%%s) em >%%s< "
L.AUTO_SPEC_WARN_TEXTS.link 			= "%s ligado a >%%s<"
L.AUTO_SPEC_WARN_TEXTS.defensive 		= "%s - defensivo"
L.AUTO_SPEC_WARN_TEXTS.taunt 			= "%s em >%%s< - provoque agora"
L.AUTO_SPEC_WARN_TEXTS.close			= "%s em >%%s< perto de você"
L.AUTO_SPEC_WARN_TEXTS.move				= "%s - saia de perto"
L.AUTO_SPEC_WARN_TEXTS.keepmove 		= "%s - continue se movendo"
L.AUTO_SPEC_WARN_TEXTS.stopmove 		= "%s - pare de se mover"
L.AUTO_SPEC_WARN_TEXTS.dodge 			= "%s - esquive do ataque"
L.AUTO_SPEC_WARN_TEXTS.dodgecount 		= "%s (%%s) - esquive do ataque"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc 		= "%s - esquive de %%s"
L.AUTO_SPEC_WARN_TEXTS.moveaway 		= "%s - afaste-se dos outros"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount 	= "%s (%%s) - afaste-se dos outros"
L.AUTO_SPEC_WARN_TEXTS.moveto 			= "%s - mova-se para >%%s<"
L.AUTO_SPEC_WARN_TEXTS.soak 			= "%s - absorva"
L.AUTO_SPEC_WARN_TEXTS.soakcount 		= "%s - absorva (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump				= "%s - salte"
L.AUTO_SPEC_WARN_TEXTS.run				= "%s - corra para longe"
L.AUTO_SPEC_WARN_TEXTS.runcount			= "%s - corra para longe (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast				= "%s - pare de lançar"
L.AUTO_SPEC_WARN_TEXTS.lookaway 		= "%s em %%s - olhe para longe"
L.AUTO_SPEC_WARN_TEXTS.reflect 			= "%s em >%%s< - pare de atacar"
L.AUTO_SPEC_WARN_TEXTS.count			= "%s! (%%s)" -- OPTIONAL
L.AUTO_SPEC_WARN_TEXTS.stack			= "%s (%%d)"
L.AUTO_SPEC_WARN_TEXTS.switch			= "%s - mude de alvo"
L.AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - mude de alvo (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo 			= "Dano de %%s - afaste-se"
L.AUTO_SPEC_WARN_TEXTS.adds 			= "Adds se aproximando - mude de alvo"--Basicamente um genérico para mudar
L.AUTO_SPEC_WARN_TEXTS.addscount 		= "Adds se aproximando - mude de alvo (%%s)"--Basicamente um genérico para mudar
L.AUTO_SPEC_WARN_TEXTS.addscustom 		= "Adds se aproximando - %%s"--Mesmo que acima, mas com mais informações, praticamente feito para cerca de 3 modificações de chefe, como Akama
L.AUTO_SPEC_WARN_TEXTS.targetchange 	= "Mudança de alvo - mude para %%s"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Exibir anúncio especial para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends 			= "Exibir anúncio especial quando $spell:%s tiver terminado"
L.AUTO_SPEC_WARN_OPTIONS.fades 			= "Exibir anúncio especial quando $spell:%s tiver desaparecido"
L.AUTO_SPEC_WARN_OPTIONS.soon 			= "Exibir anúncio especial antecipado para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.sooncount 		= "Exibir anúncio especial antecipado (com contagem) para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.bait 			= "Exibir anúncio especial antecipado (para iscar) para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Exibir anúncio especial %s segundos antes de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 		= "Exibir anúncio especial para dissipar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Exibir anúncio especial para interromper $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Exibir anúncio especial (com contagem) para interromper $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Exibir anúncio especial quando você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Exibir anúncio especial (com contagem) quando você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youpos 		= "Exibir anúncio especial (com posição) quando você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youposcount 	= "Exibir anúncio especial (com posição e contagem) quando você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakpos 		= "Exibir anúncio especial (com posição) para ajudar a absorver outros afetados por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.target 		= "Exibir anúncio especial quando alguém é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Exibir anúncio especial (com contagem) quando alguém é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.link			= "Exibir anúncio especial quando você estiver ligado a outro jogador por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.defensive 		= "Exibir anúncio especial para usar habilidades defensivas para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt 			= "Exibir anúncio especial para provocar quando o outro tanque for afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Exibir anúncio especial quando alguém próximo de você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Exibir anúncio especial quando você é afetado por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Exibir anúncio especial para continuar se movendo para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Exibir anúncio especial para parar de se mover para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Exibir anúncio especial para esquivar de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount 	= "Exibir anúncio especial (com contagem) para esquivar de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc 		= "Exibir anúncio especial (com localização) para esquivar de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveaway 		= "Exibir anúncio especial para se afastar dos outros para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount 	= "Exibir anúncio especial (com contagem) para se afastar dos outros para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveto 		= "Exibir anúncio especial para se mover para alguém ou algum lugar para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soak 			= "Exibir anúncio especial para absorver para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakcount 		= "Exibir anúncio especial (com contagem) para absorver para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.jump 			= "Exibir anúncio especial para saltar para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Exibir anúncio especial para correr para longe de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.runcount		= "Exibir anúncio especial (com contagem) para correr para longe de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Exibir anúncio especial para o lançamento de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.lookaway 		= "Exibir anúncio especial para olhar para longe de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect 		= "Exibir anúncio especial para parar de atacar $spell:%s"--Spell Reflect
L.AUTO_SPEC_WARN_OPTIONS.count 			= "Exibir anúncio especial (com contagem) para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack 			= "Exibir anúncio especial para pilha >=%d de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switch			= "Exibir anúncio especial para mudar de alvo para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount 	= "Exibir anúncio especial (com contagem) para trocar de alvo para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Exibir anúncio especial para sair de áreas ruins no chão"
L.AUTO_SPEC_WARN_OPTIONS.adds 			= "Exibir anúncio especial para trocar de alvo para adds se aproximando"
L.AUTO_SPEC_WARN_OPTIONS.addscount 		= "Exibir anúncio especial (com contagem) para trocar de alvo para adds se aproximando"
L.AUTO_SPEC_WARN_OPTIONS.addscustom 	= "Exibir anúncio especial para adds se aproximando"
L.AUTO_SPEC_WARN_OPTIONS.targetchange 	= "Exibir anúncio especial para mudanças de alvo prioritárias"

L.AUTO_TIMER_TEXTS.target				= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.targetcount			= "%s (%%2$s): %%1$s"
L.AUTO_TIMER_TEXTS.cast					= "%s"
L.AUTO_TIMER_TEXTS.castcount			= "%s (%%s)"
L.AUTO_TIMER_TEXTS.castsource			= "%s: %%s"
L.AUTO_TIMER_TEXTS.active				= "%s acaba" --Buff/Debuff/event on boss
L.AUTO_TIMER_TEXTS.fades				= "%s desvanece" --Buff/Debuff on players
L.AUTO_TIMER_TEXTS.ai					= "%s IA"

L.AUTO_TIMER_TEXTS.cd					= "%s recarrega"
L.AUTO_TIMER_TEXTS.cdcount				= "%s recarrega (%%s)"
L.AUTO_TIMER_TEXTS.cdsource				= "%s recarrega: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial			= "Habilidade especial"

L.AUTO_TIMER_TEXTS.next					= "Próx. %s"
L.AUTO_TIMER_TEXTS.nextcount			= "Próx. %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource			= "Próx. %s: >%%s<"
L.AUTO_TIMER_TEXTS.nextspecial			= "Habilidade especial"

L.AUTO_TIMER_TEXTS.var					= "%s"
L.AUTO_TIMER_TEXTS.varcount				= "%s (%%s)"
L.AUTO_TIMER_TEXTS.varsource			= "%s: >%%s<"--Now same as next, as the ~ was moved to timer number -- OPTIONAL
L.AUTO_TIMER_TEXTS.varspecial			= "Habilidade especial"--Now same as next, as the ~ was moved to timer number
L.AUTO_TIMER_TEXTS.varcombo				= "%%1$s + %%2$s"--Now same as next, as the ~ was moved to timer number -- OPTIONAL

L.AUTO_TIMER_TEXTS.achievement			= "%s"
L.AUTO_TIMER_TEXTS.stage				= "Fase"
L.AUTO_TIMER_TEXTS.stagecount			= "Fase %%s"--NOT BUGGED, stage is 2nd arg, spellID is ignored on purpose
L.AUTO_TIMER_TEXTS.stagecountcycle		= "Fase %%s (%%s)"--^^. Example: Stage 2 (3) for a fight that alternates stage 1 and stage 2, but also tracks total cycles
L.AUTO_TIMER_TEXTS.stagecontext			= "%s" -- OPTIONAL
L.AUTO_TIMER_TEXTS.stagecontextcount	= "%s (%%s)" -- OPTIONAL
L.AUTO_TIMER_TEXTS.intermission			= "Intervalo"
L.AUTO_TIMER_TEXTS.intermissioncount	= "Intervalo %%s"
L.AUTO_TIMER_TEXTS.adds					= "Adds"
L.AUTO_TIMER_TEXTS.addscustom			= "Adds (%%s)"
L.AUTO_TIMER_TEXTS.roleplay				= GUILD_INTEREST_RP or "Roleplay"--Used mid fight, pre fight, or even post fight. Boss does NOT auto engage upon completion
L.AUTO_TIMER_TEXTS.combat				= "Combate começa"
--This basically clones np only bar option and display text from regular counterparts
L.AUTO_TIMER_TEXTS.cdnp 				= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextnp 				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.cdpnp 				= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextpnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.castpnp				= L.AUTO_TIMER_TEXTS.cast -- OPTIONAL

L.AUTO_TIMER_OPTIONS.target				= "Exibir cronômetro para a penalidade de $spell:%s"
L.AUTO_TIMER_OPTIONS.targetcount		= "Exibir cronômetro (com contagem) para a penalidade de $spell:%s"
L.AUTO_TIMER_OPTIONS.cast				= "Exibir cronômetro para o lançamento de $spell:%s"
L.AUTO_TIMER_OPTIONS.castpnp			= "Exibir cronômetro apenas na placa de nome para o lançamento de $spell:%s"
L.AUTO_TIMER_OPTIONS.castcount 			= "Exibir cronômetro (com contagem) para o lançamento de $spell:%s"
L.AUTO_TIMER_OPTIONS.castsource 		= "Exibir cronômetro (com fonte) para o lançamento de $spell:%s"
L.AUTO_TIMER_OPTIONS.active				= "Exibir cronômetro para a duração de $spell:%s"
L.AUTO_TIMER_OPTIONS.fades				= "Exibir cronômetro para quando $spell:%s desvanecerá dos jogadores"
L.AUTO_TIMER_OPTIONS.ai					= "Exibir cronômetro IA para recarga de $spell:%s"

L.AUTO_TIMER_OPTIONS.cd					= "Exibir cronômetro para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdcount			= "Exibir cronômetro para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdnp 				= "Exibir cronômetro apenas na placa de nome para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdsource			= "Exibir cronômetro para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdspecial 			= "Exibir cronômetro para a recarga de habilidade especial"
L.AUTO_TIMER_OPTIONS.cdcombo 			= "Exibir cronômetro para a recarga de combinação de habilidades"--Used for combining 2 abilities into a single timer

L.AUTO_TIMER_OPTIONS.next				= "Exibir cronômetro para o próximo $spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount			= "Exibir cronômetro para o próximo $spell:%s"
L.AUTO_TIMER_OPTIONS.nextnp 			= "Exibir cronômetro apenas na placa de nome para o próximo $spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource			= "Exibir cronômetro para o próximo $spell:%s"
L.AUTO_TIMER_OPTIONS.nextspecial 		= "Exibir cronômetro para a próxima habilidade especial"
L.AUTO_TIMER_OPTIONS.nextcombo 			= "Exibir cronômetro para o próximo combinação de habilidades"--Used for combining 2 abilities into a single timer

L.AUTO_TIMER_OPTIONS.var				= "Exibir cronômetro (com variação) para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.varcount			= "Exibir cronômetro (com contagem e variação) para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.varnp				= "Exibir apenas o cronômetro na placa de nome (com variação) para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.varpnp				= "Exibir apenas o cronômetro prioritário na placa de nome (com variação) para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.varsource			= "Exibir cronômetro (com fonte e variação) para a recarga de $spell:%s"
L.AUTO_TIMER_OPTIONS.varspecial			= "Exibir cronômetro (com variação) para a recarga de habilidade especial"
L.AUTO_TIMER_OPTIONS.varcombo			= "Exibir cronômetro (com variação) para a recarga de combinação de habilidades"

L.AUTO_TIMER_OPTIONS.achievement		= "Exibir cronômetro para %s"
L.AUTO_TIMER_OPTIONS.stage 				= "Exibir cronômetro para a próxima fase"
L.AUTO_TIMER_OPTIONS.stagecount 		= "Exibir cronômetro (com contagem) para a próxima fase"
L.AUTO_TIMER_OPTIONS.stagecountcycle 	= "Exibir cronômetro (com contagem de fase e contagem de ciclo) para a próxima fase"
L.AUTO_TIMER_OPTIONS.stagecontext 		= "Exibir cronômetro para a próxima fase de $spell:%s"
L.AUTO_TIMER_OPTIONS.stagecontextcount 	= "Exibir cronômetro (com contagem) para a próxima fase de $spell:%s"
L.AUTO_TIMER_OPTIONS.intermission 		= "Exibir cronômetro para o próximo intervalo"
L.AUTO_TIMER_OPTIONS.intermissioncount 	= "Exibir cronômetro (com contagem) para o próximo intervalo"
L.AUTO_TIMER_OPTIONS.adds 				= "Exibir cronômetro para a chegada de adds"
L.AUTO_TIMER_OPTIONS.addscustom 		= "Exibir cronômetro para a chegada de adds"
L.AUTO_TIMER_OPTIONS.roleplay 			= "Exibir cronômetro para a duração do roleplay"--This does need localizing though.
L.AUTO_TIMER_OPTIONS.combat				= "Exibir cronômetro para começo do combate"

L.AUTO_ICONS_OPTION_TARGETS				= "Colocar ícones nos alvos de $spell:%s"
L.AUTO_ICONS_OPTION_TARGETS_TANK_A 		= "Colocar ícones nos alvos de $spell:%s com prioridade para tanque sobre corpo a corpo sobre distância e alfabético como substituto"
L.AUTO_ICONS_OPTION_TARGETS_TANK_R 		= "Colocar ícones nos alvos de $spell:%s com prioridade para tanque sobre corpo a corpo sobre distância e lista de raide como substituto"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A 	= "Colocar ícones nos alvos de $spell:%s com prioridade para corpo a corpo e alfabética"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R 	= "Colocar ícones nos alvos de $spell:%s com prioridade para corpo a corpo e lista de raide"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A 	= "Colocar ícones nos alvos de $spell:%s com prioridade para distância e alfabética"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R 	= "Colocar ícones nos alvos de $spell:%s com prioridade para distância e lista de raide"
L.AUTO_ICONS_OPTION_TARGETS_MRH			= "Colocar ícones nos alvos de $spell:%s com prioridade para corpo a corpo sobre distância sobre curandeiro e lista de raide como substituto"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA 		= "Colocar ícones nos alvos de $spell:%s com prioridade alfabética"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER 		= "Colocar ícones nos alvos de $spell:%s com prioridade da lista de raide"
L.AUTO_ICONS_OPTION_NPCS				= "Colocar ícones no $spell:%s"
L.AUTO_ICONS_OPTION_CONFLICT			= " (Pode entrar em conflito com outras opções)"

L.AUTO_ARROW_OPTION_TEXT 				= "Exibir setas do " .. L.DBM .. " para se mover em direção ao alvo afetado por $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2 				= "Exibir setas do " .. L.DBM .. " para se afastar do alvo afetado por $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3 				= "Exibir setas do " .. L.DBM .. " para se mover em direção a uma localização específica para $spell:%s"

L.AUTO_YELL_OPTION_TEXT.shortyell 		= "Gritar quando você é afetado por $spell:%s"
L.AUTO_YELL_OPTION_TEXT.yell 			= "Gritar (com nome do jogador) quando você é afetado por $spell:%s"
L.AUTO_YELL_OPTION_TEXT.count 			= "Gritar (com contagem) quando você é afetado por $spell:%s"
L.AUTO_YELL_OPTION_TEXT.fade 			= "Gritar (com contagem regressiva e nome do feitiço) quando $spell:%s está desaparecendo"
L.AUTO_YELL_OPTION_TEXT.shortfade 		= "Gritar (com contagem regressiva) quando $spell:%s está desaparecendo"
L.AUTO_YELL_OPTION_TEXT.iconfade 		= "Gritar (com contagem regressiva e ícone) quando $spell:%s está desaparecendo"
L.AUTO_YELL_OPTION_TEXT.position 		= "Gritar (com posição e nome do jogador) quando você é afetado por $spell:%s"
L.AUTO_YELL_OPTION_TEXT.shortposition 	= "Gritar (com posição) quando você é afetado por $spell:%s"
L.AUTO_YELL_OPTION_TEXT.combo 			= "Gritar (com texto personalizado) quando você é afetado por $spell:%s e outros feitiços ao mesmo tempo"
L.AUTO_YELL_OPTION_TEXT.repeatplayer 	= "Gritar repetidamente (com nome do jogador) quando você é afetado por $spell:%s"
L.AUTO_YELL_OPTION_TEXT.repeaticon 		= "Gritar repetidamente (com ícone) quando você é afetado por $spell:%s"

L.AUTO_YELL_ANNOUNCE_TEXT.shortyell		= "%s" -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.yell			= "%s em " .. UnitName("player")
L.AUTO_YELL_ANNOUNCE_TEXT.count			= "%s em " .. UnitName("player") .. " (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade			= "%s desaparecendo em %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade		= "%%d" -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade		= "{rt%%2$d}%%1$d" -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.position 		= "%s %%s em {rt%%d}" ..UnitName("player").. "{rt%%d}"
L.AUTO_YELL_ANNOUNCE_TEXT.shortposition = "{rt%%1$d}%s"--Icon, Spellname -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.combo			= "%s e %%s"--Spell name (from option, plus spellname given in arg)
L.AUTO_YELL_ANNOUNCE_TEXT.repeatplayer	= UnitName("player")--Doesn't need translation, it's just player name spam -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon	= "{rt%%1$d}"--Doesn't need translation. It's just icon spam -- OPTIONAL

L.AUTO_YELL_CUSTOM_POSITION			= "{rt%d}%s"--Doesn't need translating. Has no strings (Used in niche situations such as icon repeat yells) -- OPTIONAL
L.AUTO_YELL_CUSTOM_FADE 				= "%s desaparecido"
L.AUTO_HUD_OPTION_TEXT 					= "Exibir HudMap para $spell:%s (Descontinuado)"
L.AUTO_HUD_OPTION_TEXT_MULTI 			= "Exibir HudMap para vários mecanismos (Descontinuado)"
L.AUTO_NAMEPLATE_OPTION_TEXT 			= "Exibir auras na placa de nome para $spell:%s usando um addon de placa de nome compatível ou "..L.DBM
L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED 	= "Exibir auras na placa de nome apenas para $spell:%s usando apenas "..L.DBM
L.AUTO_RANGE_OPTION_TEXT 				= "Exibir quadro de distância (%s) para $spell:%s" -- string usado para a distância, para que possamos usar coisas como "5/2" como um valor para esse campo
L.AUTO_RANGE_OPTION_TEXT_SHORT 			= "Exibir quadro de distância (%s)" -- Quando um quadro de distância é usado apenas para mais de uma coisa
L.AUTO_RRANGE_OPTION_TEXT 				= "Exibir quadro de distância reverso (%s) para $spell:%s" -- quadro de distância reverso (verde quando os jogadores estão dentro da distância, vermelho quando não estão)
L.AUTO_RRANGE_OPTION_TEXT_SHORT 		= "Exibir quadro de distância reverso (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT 			= "Exibir quadro de informações para $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2 			= "Exibir quadro de informações para visão geral do encontro"
L.AUTO_INFO_FRAME_OPTION_TEXT3 			= "Exibir quadro de informações para $spell:%s (quando o limiar de %%s é atingido)"
L.AUTO_READY_CHECK_OPTION_TEXT 			= "Tocar som de verificação de prontidão quando o chefe for puxado (mesmo que não seja direcionado)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT 			= "Exibir cronômetro para limpeza mais rápida de %s"
L.AUTO_PRIVATEAURA_OPTION_TEXT 			= "Tocar alertas sonoros do DBM para auras privadas de $spell:%s nesta luta."

-- New special warnings
L.MOVE_WARNING_BAR 						= "Anúncio móvel"
L.MOVE_WARNING_MESSAGE 					= "Obrigado por usar " .. L.DEADLY_BOSS_MODS
L.MOVE_SPECIAL_WARNING_BAR				= "Aviso especial móvel"
L.MOVE_SPECIAL_WARNING_TEXT				= "Aviso especial"

L.HUD_INVALID_TYPE 						= "Tipo de HUD definido inválido"
L.HUD_INVALID_TARGET 					= "Nenhum alvo válido fornecido para o HUD"
L.HUD_INVALID_SELF 						= "Não é possível usar o próprio jogador como alvo para o HUD"
L.HUD_INVALID_ICON 						= "Não é possível usar o método de ícone para o HUD em um alvo sem ícone"
L.HUD_SUCCESS 							= "HUD iniciado com sucesso com seus parâmetros. Isso será cancelado após %s, ou digite '/dbm hud hide'."
L.HUD_USAGE								= {
	L.DBM .. "-HudMap uso:",
	"-----------------",
"/dbm hud <tipo> <alvo> <duração>: Cria um HUD que aponta para um jogador pelo tempo desejado",
 "Tipos válidos: seta, ponto, vermelho, azul, verde, amarelo, ícone (requer um alvo com ícone de raide)",
 "Alvos válidos: alvo, foco, <nome do jogador>",
 "Durações válidas: qualquer número (em segundos). Se deixado em branco, será utilizado 20 minutos.",
 "/dbm hud hide: desativa objetos de HUD gerados pelo usuário"
}

L.ARROW_MOVABLE						= "Seta móvel"
L.ARROW_WAY_USAGE 					= "/dway <x> <y>: Cria uma seta que aponta para uma localização específica (usando coordenadas locais do mapa da zona)"
L.ARROW_WAY_SUCCESS 				= "Para ocultar a seta, digite '/dbm arrow hide' ou chegue perto da seta"
L.ARROW_ERROR_USAGE					= {
	"Uso da seta do " .. L.DBM .. ":",
	"-----------------",
	"/dbm arrow <x> <y>: Cria uma seta que aponta para um local específico (0 < x/y < 100)",
	"/dbm arrow map <x> <y>: Cria uma seta que aponta para uma localização específica (usando coordenadas do mapa da zona)",
	"/dbm arrow <jogador>: Cria uma seta que aponta para um jogador específico no seu grupo",
	"/dbm arrow hide: Oculta a seta",
	"/dbm arrow move: Torna móvel a seta"
}

L.SPEED_KILL_TIMER_TEXT				= "Vitória em tempo recorde"
L.SPEED_CLEAR_TIMER_TEXT			= "Limpeza mais rápida"
L.COMBAT_RES_TIMER_TEXT				= "Próxima recarga CR"
L.TIMER_RESPAWN						= "%s Reaparecimento"

L.LAG_CHECKING						= "Verificando a latência da raide..."
L.LAG_HEADER						= L.DEADLY_BOSS_MODS .. " - Resultados de latência"
L.LAG_ENTRY							= "%s: Latência mundial [%d ms] / Latência em casa [%d ms]"
L.LAG_FOOTER						= "Sem resposta: %s"

L.DUR_CHECKING						= "Verificando a durabilidade da raide..."
L.DUR_HEADER						= L.DEADLY_BOSS_MODS .. " - Resultados de durabilidade"
L.DUR_ENTRY							= "%s: Durabilidade [%d porcentagem] / quebrada [%s]"

L.OVERRIDE_ACTIVATED				= "As configurações substituídas foram ativadas para este encontro pelo RL"

--LDB
L.LDB_TOOLTIP_HELP1					= "Clique para abrir " .. L.DBM
L.LDB_TOOLTIP_HELP2					= "Alt-clique para alternar o modo silencioso"
L.SILENTMODE_IS						= "Modo silencioso é "

L.WORLD_BUFFS.hordeOny				= "Povo da Horda, cidadãos de Orgrimmar, venham! Vamos homenagear uma heroína da Horda"
L.WORLD_BUFFS.allianceOny			= "Cidadãos e aliados de Ventobravo, no dia de hoje, fez-se história."
L.WORLD_BUFFS.hordeNef				= "NEFARIAN ESTÁ MORTO! Povo de Orgrimmar"
L.WORLD_BUFFS.allianceNef			= "Cidadãos da Aliança, o Senhor da Rocha Negra foi derrubado!"
L.WORLD_BUFFS.zgHeart				= "Agora só falta um passo para nos livrarmos do Esfolador de Almas"
L.WORLD_BUFFS.zgHeartBooty			= "O Deus Sanguinário, o Esfolador de Almas, foi derrotado! Acabaram-se os nossos temores!"
L.WORLD_BUFFS.zgHeartYojamba		= "Iniciem o ritual, meus servos. Temos que banir o coração de Hakkar de volta para o vórtice!"
L.WORLD_BUFFS.rendHead				= "O falso Chefe Guerreiro, Laceral Mão Negra, caiu!"
L.WORLD_BUFFS.blackfathomBoon		= "Bênção das Profundezas Negras"

-- Annoying popup, especially for classic players
L.DBM_INSTALL_REMINDER_HEADER = "Instalação incompleta do DBM detectada!"
L.DBM_INSTALL_REMINDER_EXPLAIN = "Bem-vindo(a) a %s. Os mods do DBM para chefes aqui estão no %s que você não tem instalado. O DBM não exibirá cronômetros ou anúncios nesta zona, a menos que você instale o %s!"
L.DBM_INSTALL_REMINDER_DISABLE = "Desativar todos os anúncios e cronômetros do DBM nesta zona." -- Used when we believe it's a user error that the mod isn't installed (i.e., current raids)
L.DBM_INSTALL_REMINDER_DISABLE2 = "Não exibir esta mensagem novamente para este pacote." -- Used for unimportant mods, i.e., dungeons
L.DBM_INSTALL_REMINDER_DL_WAGO = "Pressione " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar o link do Wago.io para sua área de transferência."
L.DBM_INSTALL_REMINDER_DL_CURSE = "Pressione " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar o link do Curseforge para sua área de transferência."
--"Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "

L.DBM_INSTALL_PACKAGE_VANILLA = "Pacote de Vanilla e Temporada da Descoberta"
L.DBM_INSTALL_PACKAGE_BCC = "Pacote de Burning Crusade"
L.DBM_INSTALL_PACKAGE_WRATH = "Pacote de Wrath"
L.DBM_INSTALL_PACKAGE_CATA = "Pacote de Cataclysm"
L.DBM_INSTALL_PACKAGE_MOP = "Pacote de Mists of Pandaria"
L.DBM_INSTALL_PACKAGE_DUNGEON = "Pacote de Masmorras, Imersões e Eventos"

-- Tests
L.DBM_TAINTED_BY_TESTS = "O DBM foi usado em modo de teste com distorção temporal na sessão atual, é recomendável recarregar sua interface antes de usar o DBM em uma luta de chefe real. Tudo deve funcionar como esperado, mas sem garantias!"
