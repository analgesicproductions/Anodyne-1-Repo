// This file was automatically generated! Don't touch it!
package data{
public class NPC_Data_PT {
public static var test:Object =
{
	DEBUG: {
		scene_1: {
			dialogue: new Array(
				"Gosta de música? Examine aquele terminal!",
				"Gosta de sofrer? Dirija-se ao sul!")
		}
	}
};

public static var test_state:Object =
{
	does_reset: true,
	DEBUG: {
		scene_1: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var arthur:Object =
{
	CIRCUS: {
		alone: {
			dialogue: new Array(
				"Aquela acrobata está perdendo o equilíbrio! Onde está a rede de segurança?",
				"...")
		}
,
		holyshit: {
			dialogue: new Array(
				"UOAAH")
		}
	}
};

public static var arthur_state:Object =
{
	CIRCUS: {
		alone: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		holyshit: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var javiera:Object =
{
	CIRCUS: {
		alone: {
			dialogue: new Array(
				"Os leões estão encurralando aquela malabarista!",
				"...")
		}
	}
};

public static var javiera_state:Object =
{
	CIRCUS: {
		alone: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var briar:Object =
{
	GO: {
		before_fight: {
			dialogue: new Array(
				"Briar:Estou cansado, Young. Estou cansado de todos esses ciclos. Eu me sinto como se estivesse vivendo o mesmo sonho, o mesmo pesadelo, de novo e de novo.",
				"Briar: ...",
				"Briar:Isso não mudará, Young. Isso é tudo que sempre seremos.")
		}
,
		after_fight: {
			dialogue: new Array(
				"Briar:Adeus, Young.")
		}
,
		final: {
			dialogue: new Array(
				"Briar:Cara, Young.",
				"Briar:Bata seus pés, mova seus braços. Caramba, você não aguentaria um minuto sem mim!",
				"Briar:Bem, vem comigo, vamos comer um sanduíche ou algo assim.",
				"Sábio:Você... você agiu adequadamente. Até o nosso próximo encontro.")
		}
	}
};

public static var briar_state:Object =
{
	GO: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		final: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var sage:Object =
{
	BLANK: {
		intro: {
			dialogue: new Array(
				"Voz Misteriosa: Olá? ...Young? ^EI! ... ah, você pode me ouvir? Bom, agora escute. Você está prestes a acordar. Você usará as setas para se mover.",
				"Você usará a tecla \'",
				"\' para interagir com objetos e pessoas ao seu redor.",
				"E você usará a tecla \'",
				"\' para acessar o menu, que fornecerá informações sobre você e os seus arredores.")
		}
	}
	,
	GO: {
		posthappy_sage: {
			dialogue: new Array(
				"Young... Eu só queria consertar tudo para você.",
				"Eu espero... Eu espero que você se saia melhor que eu.")
		}
,
		posthappy_mitra: {
			dialogue: new Array(
				"Boa sorte, Young.",
				"O Sábio está certo, de certo modo. Eu quero que tudo seja perfeito, e algumas vezes isso me faz ignorar a realidade.",
				"Eu não sei o que você precisa fazer para ajudar O Briar. Eu não entendo como esse mundo funciona ou porque tudo aparenta ser tão estranho. ^Mas eu quero ser sua amiga, Young.",
				"Você está lutando, Young. Você está tentando entender. Eu espero que você consiga se resolver.")
		}
,
		one: {
			dialogue: new Array(
				"Sábio:Young... esse é meu último aviso... espere, quem é ela?",
				"Mitra:Meu nome é Mitra, e esta é minha bicicleta, Wares!",
				"Sábio:Eu não perguntei o nome de sua bicicleta, o que você está fazendo aqui? Não me lembro de você.",
				"Mitra:Estou aqui para ajudar meu amigo, Young.",
				"Sábio:Young não tem amigos. Young sequer tem O Briar. E se você está provocando ele, quero você fora do meu mundo!",
				"Mitra:O que você quer dizer? Wares e Eu--",
				"Sábio:PARE DE FALAR SOBRE SUA MALDITA BICICLETA!!!")
		}
,
		hit: {
			dialogue: new Array(
				"Sábio:...",
				"Mitra:Young! Você está bem?^ Origada pela ajuda. Agora vá e acabe com essa última área de araque! Nós sabemos que você consegue!",
				"Mitra:Wares!!!",
				"Mitra:Wares...",
				"Mitra:Preste atenção, encapuzado misterioso, eu não sei quem você pensa que é, mas que tal nos deixar em paz?",
				"Sábio:Você acha que é amiga de Young só porque você irá mentir e dizer para ele que lá no fundo ele é perfeito e que no fim tudo ficará bem. ^Bem, se é isso que você quer, TUDO BEM. Suma da minha frente, Young.",
				"Sábio:Vá falar com sua amiga.",
				"Mitra:Nós só estamos fazendo o melhor que podemos...")
		}
	}
	,
	NEXUS: {
		enter_nexus: {
			dialogue: new Array(
				"Homem Encapuzado: Bem, já estava na hora. Er...^Quer dizer...^ Saudações, Young! Eu sou o Sábio, o Ancião do Vilarejo. Você foi invocado aqui pois A Escuridão se espalhou pela Terra. A Escuridão procura O Briar Lendário, para usar seu poder para propósitos malignos. Você deve alcançá-lo primeiro. Você deve proteger O Briar.",
				"Entre no portal ativo a sua esquerda para iniciar sua jornada.",
				"*suspiro* Não pega bem ficar pasHan-Tanido por aqui. Entre no portal para iniciar sua busca. O Briar, e por extensão, o mundo estão em grande necessidade!",
				"Apenas entre no maldito portal!")
		}
,
		after_ent_str: {
			dialogue: new Array(
				"Por que você ainda está aqui?")
		}
,
		after_bed: {
			dialogue: new Array(
				"Siga em frente, Young. Essa chave que encontraste, devem existir outras como ela - vá a procura delas.",
				"Vá para os mais longínquos cantos da Terra, Young. Essa é a única maneira de impedir A Escuridão.")
		}
,
		before_windmill: {
			dialogue: new Array(
				"Use essas três chaves, Young, e abra o caminho para os cantos mais profundos da Terra.")
		}
,
		after_windmill: {
			dialogue: new Array(
				"Você fez o que pedi, Young, apesar de ainda existir muito a ser feito. Talvez se você explorar as profundezas da Terra você poderá achar respostas... talvez você será de algum valor para O Briar.")
		}
,
		all_card_first: {
			dialogue: new Array(
				"Bom trabalho, Young. Você encontrou todas as cartas de uma área da Terra, e como resultado uma jóia apareceu no topo do portal dessa área.")
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			dialogue: new Array(
				"Sábio:Em breve suas habilidades serão postas a prova, Young. Para sobreviver a esse templo, você precisará de ambos força e intelecto. Suponho que você tenha encontrado uma arma, correto?",
				"O qu-?? ... Qu-quer dizer... Sim é claro... uma vassoura! Er... exatamente como foi previsto na Lenda...",
				"*resmungos* ... de todos os incopeten--Ei! O que você está fazendo aí parado?",
				"Juízo, Young.")
		}
	}
	,
	BEDROOM: {
		after_boss: {
			dialogue: new Array(
				"Sábio:Neste momento, você ainda está fraco. Se você deseja proteger O Briar da Escuridão, você deve enfrentar seus medos. A carta que encontrará neste baú, e outras como ela, são o símbolo do seu crescimento. Adquirir tais cartas é vital para sua jornada.",
				"Essa chave também terá um papel importante em sua busca. Você deve procurar outras chaves como ela. Selecione o mapa na tela de menu para se teletransportar de volta para a entrada do templo e dar continuação a sua heróica jornada.",
				"Explore o Sudoeste dos terrenos do templo... você encontrará um uso para essa chave.",
				"O que, você quer que eu te carregue nas costas para o portão ou algo assim?")
		}
	}
	,
	TERMINAL: {
		before_fight: {
			dialogue: new Array(
				"Sábio:Por que você não me escuta?! Se você se apressar como um idiota, colocará em perigo não só O Briar, mas também A Terra e tudo para o qual trabalhei! Me desculpe Young, mas se você não me escutar, eu terei que convencê-lo de outra forma...")
		}
,
		after_fight: {
			dialogue: new Array(
				"Sábio:Young... Não era para acabar assim... Eu queria que você se tornasse uma pessoa melhor. Eu queria que você ajudasse O Briar. Mas tudo isso é apenas um jogo estúpido... Não posso lhe impedir de chegar ao Briar. Apenas lembre de minhas palavras quando tudo for para o inferno.")
		}
,
		entrance: {
			dialogue: new Array(
				"Sábio:Olá, Young. Quando você se tornar um indivíduo mais forte e sábio, este caminho lhe levará até O Briar.",
				"Sábio:Você não está preparado Young, primeiro você ainda precisa enfrentar mais desafios na Terra.",
				"Sábio:Você fez algum progresso, Young, mas você deve coletar pelo menos 36 cartas para abrir esse portão.")
		}
,
		etc: {
			dialogue: new Array(
				"Sábio:Ah... umm... você tem pelo menos 36 cartas? Mas eu não acredito de que você esteja pronto para o derradeiro teste. De fato, olhe, nós estávamos lendo este portão errado, você precisa na verdade de\n...\n......\n92 cartas para abrí-lo, e não 36!",
				"Sábio:Young, não vá, você não está preparado! Pense no Briar! Na Terra! Tudo será em vão se você não estiver pronto!")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"Sábio:Excelente trabalho, Young. Você teve não só que conquistar esse monstro mas também seus medos para emergir vitorioso!!!",
				"Sábio:Mas é claro, você ainda tem um longo caminho pela frente. Você tem explorado A Terra?")
		}
	}
	,
	CROWD: {
		one: {
			dialogue: new Array(
				"Sábio:Muito bem, Young. No entanto, ainda existem desafios a serem superados. Não perca seu foco.",
				"Sábio:Você encontrou todas as chaves, Young? Se não, vá para a praia.")
		}
	}
};

public static var sage_state:Object =
{
	BLANK: {
		intro: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	GO: {
		posthappy_sage: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		posthappy_mitra: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		one: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hit: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	NEXUS: {
		enter_nexus: {
			top: true,
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
,
		after_ent_str: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_bed: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		before_windmill: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_windmill: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		all_card_first: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
	,
	BEDROOM: {
		after_boss: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
	,
	TERMINAL: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		entrance: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		etc: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CROWD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var cliff_dog:Object =
{
	CLIFF: {
		top_left: {
			dialogue: new Array(
				"Eu não sou como os outros! *auau* Eu não irei machucá-lo...",
				"É uma existência pacífica aqui em cima.",
				"Você cheira a alcega.",
				"*auau*")
		}
	}
};

public static var cliff_dog_state:Object =
{
	CLIFF: {
		top_left: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
};

public static var happy_npc:Object =
{
	HAPPY: {
		beautiful: {
			dialogue: new Array(
				"Você conseguiu, Young! Você derrotou A Escuridão! Olhe em volta! Que belo!",
				"Tão belo...")
		}
,
		dump: {
			dialogue: new Array(
				"Graças a deus você chegou! Estava preocupado pensando que você poderia estar preso naquela birosca congelada... Aquele lugar é depressivo pra caralho!",
				"Hahaha. Hahahahaha. HAHAHAHAHAHAHA!")
		}
,
		drink: {
			dialogue: new Array(
				"Ei bonitão, deixa eu comprar um drink pra você.",
				"Tome outro drink, seu merda! Hahaha!")
		}
,
		hot: {
			dialogue: new Array(
				"Porra, está quente aqui... Estou suaaaaando...",
				"Droga, malhar me deixa com tesão!")
		}
,
		gold: {
			dialogue: new Array(
				"Você sabia que esse lugar é feito de ouro? Ouro de verdade! Nós poderiamos fugir juntos e viver dos tijolos daqui! Wahahahaha!",
				"Sério mesmo, porque você está aí parado? Me ajude a tirar esse tijolo aqui.")
		}
,
		briar: {
			dialogue: new Array(
				"???:Young... Você finalmente conSeguIU! VoÊc ME ssalvOU AgOrE TuDo FICARÁ beN dE nOvO!!!!")
		}
	}
};

public static var happy_npc_state:Object =
{
	HAPPY: {
		beautiful: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		dump: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		drink: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hot: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gold: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		briar: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var mitra:Object =
{
	OVERWORLD: {
		initial_overworld: {
			dialogue: new Array(
				"CUIDADO!",
				"Desculpe pelo que aconteceu... Eu estava indo muito rápido. Hm, Eu nunca vi você antes! Você é um colega viajante? ... Ahm? Você quer proteger o Briar da maligna Escuridão? ^Bem... Eu não tenho idéia do que você está falando, mas me parece legal!",
				"Eu viajo por aí, pedalando Wares. Wares é o nome da minha bicicleta!",
				"Eu já vou indo, quem sabe a gente se encontra outra hora. Caso eu ouça algo sobre o Briar eu conto pra você.")
		}
	}
	,
	BLUE: {
		one: {
			dialogue: new Array(
				"CUIDADO! Muito bem Wares, vamos lá!",
				"GERÔNIMO!",
				"Vá lá, Young, nós seguramos as pontas aqui!")
		}
	}
	,
	FIELDS: {
		init: {
			dialogue: new Array(
				"Lembra de mim? Esqueci de me apresentar da última vez, só apresentei minha bicicleta, Wares. Meu nome é Mitra.",
				"Lembra de mim? Eu esqueci de me apresentar da última vez, meu nome é Mitra, e essa jovem bicicleta se chama Wares.",
				"Mitra:Com tem ido, Young? ...o que? Como eu sei o seu nome? Você acha estranho? Bem, ele está escrito na parte de trás do seu capuz.",
				"Mitra:Nos vemos por aí, Young!")
		}
,
		quest_event: {
			dialogue: new Array(
				"Mitra:Ei, acabei de lembrar - mais cedo alguém falou que estava procurando algo e que iria para as montanhas. Não entendi do que se tratava.")
		}
,
		game_hints: {
			dialogue: new Array(
				"Nada.",
				"Hm, está perdido? Tentou procurar algo na praia? Talvez exista alguém lá que possa te ajudar. ^Parece que essa sua chave é de uma coleção. Talvez você precise achar mais delas?",
				"Hm, está perdido? Tentou a floresta? ^Essa sua chave - parece que ela é de uma coleção. Talvez você precise achar as outras?",
				"Parece que você achou todas as chaves! ^Eu lembro de ter visto alguns portões no sudeste, talvez você deva usá-las lá?",
				"Ei, eu vi que você ligou a turbina eólica! Sabe se isso teve algum efeito na Terra?",
				"Nossa Young! Você realmente conseguiu uma porrada de cartas! Já descobriu pra que elas servem? Com essa quantidade você pode conseguir um bocado de coisas!",
				"O que é esse novo acessório para vassoura que você tem? Ele permite modificar a estrutura do mundo...? Honestamente, isso é assustador Young. Ainda bem que isso parece não funcionar em qualquer lugar. Talvez só nos lugares mais profundos e estranhos da Terra.",
				"Está gostando dos seus sapatos de pulo? Bem maneiros, não é? Eu estou amando meus novos sapatos para pedalar. Eles fazem Wares e Eu um time ainda melhor!",
				"Maneiro, Young, você achou outra chave. Wares gosta dessa cor! Já descobriu um lugar para usá-la?")
		}
,
		card_hints: {
			dialogue: new Array(
				"Mitra:Young, está a procura de cartas?\Procurou ao redor da área do templo do Aquele que Vê?",
				"Mitra:Young, está a procura de cartas?\nOuvi dizer que existe um labirinto na saída traseira do templo de Aquele que Vê",
				"Mitra:Young, está a procura de cartas?\nVocê deve achar algo perto do lar de Aquele que Vê",
				"Mitra:Young, está a procura de cartas?\nTem uma sala cheia de inimigos no templo de Aquele que Vê, não é?",
				"Mitra:Young, está a procura de cartas?\nJá procurou por todos os lugares do templo de Aquele que Vê?",
				"Mitra:Young, está a procura de cartas?\nTente procurar na área vestigial perto da saída traseira do tempo de Aquele que Vê",
				"Mitra:Young, está a procura de cartas?\Talvez seu vizinho saiba de algo.",
				"Mitra:Young, está a procura de cartas?\nEu sei que o cara no seu apartamento estava escondendo algo...",
				"Mitra:Young, está a procura de cartas?\nEm algum lugar perto da entrada do seu apartamento... procure por lá!",
				"Mitra:Young, está a procura de cartas?\nJá procurou em todos os lugares do seu apartamento?",
				"Mitra:Young, está a procura de cartas?\nExistem uma ilha ao sul daqui. Eu nunca fui lá, mas acho que vale a pena você dar uma olhada.",
				"Mitra:Young, está a procura de cartas?\nMuitas coisas podem ser encontradas se você seguir os rios. Comece por aí!",
				"Mitra:Young, está a procura de cartas?\nEu lembro que alguém deixou uma carta perto da turbina eólica.",
				"Mitra:Young, está a procura de cartas?\nProcure pelos rios na floresta.",
				"Mitra:Young, está a procura de cartas?\nTente procurar na base das montanhas.",
				"Mitra:Young, está a procura de cartas?\nJá tentou procurar no cume das montanhas?",
				"Mitra:Young, está a procura de cartas?\nNo lugar mais longínquo da praia deve ter algo.",
				"Mitra:Young, está a procura de cartas?\nFaça uma caminhada pela floresta vermelha.",
				"Mitra:Young, está a procura de cartas?\As cavernas vermelhas estão cheias de portas trancadas, não é?",
				"Mitra:Young, está a procura de cartas?\nTente a caverna vermelha do norte - siga o rio até o fim!",
				"Mitra:Young, está a procura de cartas?\nNa caverna vermelha ao norte, procure pela nascente do rio!",
				"Mitra:Young, está a procura de cartas?\nHmm... já tentou procurar por todos os lugares do labirinto sombrio?",
				"Mitra:Young, está a procura de cartas?\nLembro de um caminho cheio de lança-chamas em algum lugar. Deve haver algo no fim dele!",
				"Mitra:Young, está a procura de cartas?\nEsse pessoal do circo devem está escondendo alguma coisa. Já olhou por todos os lados?",
				"Mitra:Young, está a procura de cartas?\nJá tentou procurar na área ao redor do poço daquele casal?",
				"Mitra:Young, está a procura de cartas?\nTem um casal que gosta de se encontrar perto de um poço. Eles devem estar escondendo algo.",
				"Mitra:Young, está a procura de cartas?\nAlgumas vezes coisas são escondidas em locais cercados por abismos - especialmente em cavernas nas montanhas!",
				"Mitra:Young, está a procura de cartas?\nTente procurar nos pontos mais altos das cavernas nas montanhas.",
				"Mitra:Young, está a procura de cartas?\nSerá que há algo nas profundezas daquelas cavernas na montanha?",
				"Mitra:Young, está a procura de cartas?\nAquele cubo colorido naquele lugar estranho - provavelmente ele deve ter algo!",
				"Mitra:Young, está a procura de cartas?\nJá tentou falar com aquele cubo cinza naquela área maluca? Talvez ele saiba de algo!",
				"Mitra:Young, está a procura de cartas?\nO andar de cima daquele hotel está meio caído, mas ele deve ter algo!",
				"Mitra:Young, está a procura de cartas?\nVocê já procurou por todos os lugares do terceiro andar do hotel?",
				"Mitra:Young, está a procura de cartas?\nAposto que alguém deixou algo no segundo andar do hotel.",
				"Mitra:Young, está a procura de cartas?\nO dono do hotel deve ter deixado algo para você!",
				"Mitra:Young, está a procura de cartas?\nAquelas pontes quebradas ao noroeste... procure por lá!",
				"...Ahm?! Você não achou *nenhuma* carta? Cara, Young, você está louco! Algumas vezes na vida você tem que ser aventureiro. Abra algumas caixas, saca?")
		}
,
		general_banter: {
			dialogue: new Array(
				"Você achou aquele cara que estava procurando por algo nas montanhas?",
				"Você sabe qual é o sobrenome da minha bicicleta? Waldo! Manja? Wares Waldo! ... Brincadeira, bicicletas não tem sobrenomes.",
				"Acha que eu devo comprar uma trava para bicicletas? Eu odiaria prender Wares assim, mas ouvi dizer que roubos de bicicletas estão em alta.",
				"Então, o que é esse tal de Briar? Algum tipo de artefato de uma cultura perdida?",
				"Por que será que eu não ouvi nada sobre a chegada da Escuridão? Talvez a maioria das pessoas estão ocupadas demais com seus problemas do dia a dia.",
				"Ei Young, eu só queria te dizer que... seu cabelo é irado.")
		}
	}
};

public static var mitra_state:Object =
{
	OVERWORLD: {
		initial_overworld: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLUE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FIELDS: {
		init: {
			cur: "",
			pos: 0,
			loop: 2,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		game_hints: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		card_hints: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		general_banter: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var statue:Object =
{
	NEXUS: {
		enter_nexus: {
			dialogue: new Array(
				"Estátua:O Ancião do Vilarejo é apenas em nome, pois ambos ele não é.")
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			dialogue: new Array(
				"Estátua:Eu vi uma vassoura em uma lenda... estava no mapa de um armário de zelador.")
		}
	}
	,
	BEDROOM: {
		after_boss: {
			dialogue: new Array(
				"Estátua:Adquirir cartas é vital para sua jornada. Adquirir cartões é vital para outras jornadas, como conseguir crédito.")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"Estátua:Excelente trabalho, Sábio. Você teve que conquistar não só o seu temperamento mas também a sua dignidade para dizer uma frase tão manjada!!!")
		}
	}
	,
	TERMINAL: {
		one: {
			dialogue: new Array(
				"Quando você se tornar um indivíduo mais estressado e apático, esse caminho irá lhe levar ao Vinte Sabores.")
		}
	}
};

public static var statue_state:Object =
{
	NEXUS: {
		enter_nexus: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BEDROOM: {
		after_boss: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	TERMINAL: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var sadbro:Object =
{
	OVERWORLD: {
		initial_forced: {
			dialogue: new Array(
				"Eduardo:Há um tempo atrás um homem veio e instalou um espelho no nosso banheiro. Eu tinha medo de que uma câmera estivesse dentro dele. Coloquei sabão em cada centímetro da moldura de madeira na esperança de causar um curto-curcuito. Nunca encontrei nada, é claro.",
				"Eduardo:Esse templo é dedicado a Aquele que Vê. Eu não sei porque vim aqui, estou assustado demais para entrar.")
		}
,
		bedroom_not_done: {
			dialogue: new Array(
				"Eduardo:Está com problemas? Eu já imaginava. Tudo que você tem é uma vassoura, e tudo que uma vassora pode fazer é mover sujeira.")
		}
,
		bedroom_done: {
			dialogue: new Array(
				"Eduardo:Quer dizer que você derrotou Aquele que Vê? Você não entende que não é assim que as coisas funcionam? Você só está colocando sabão no espelho.")
		}
	}
};

public static var sadbro_state:Object =
{
	OVERWORLD: {
		initial_forced: {
			cur: "",
			pos: 0,
			loop: 1,
			dirty: false,
			finished: false
		}
,
		bedroom_not_done: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		bedroom_done: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var sun_guy:Object =
{
	BEDROOM: {
		before_fight: {
			dialogue: new Array(
				"Ah, que adorável. Pequenino Young, brincando de ser herói. Testemunhei todos seus passos na Terra, e tenho que dizer, Young, nem todo mundo aqui é tão honesto quanto eu. Tenha cuidado com quem você confia.")
		}
,
		after_fight: {
			dialogue: new Array(
				"Eu estarei com você, Young, onde quer que você esteja. Lembre-se do meu conselho durante sua pequena aventura.")
		}
	}
};

public static var sun_guy_state:Object =
{
	BEDROOM: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var rock:Object =
{
	BEDROOM: {
		one: {
			dialogue: new Array(
				"Pedra:Visão periférica é o lar do satanás.")
		}
,
		two: {
			dialogue: new Array(
				"Pedra:Lista de Tarefas:Construir um método de transporte para o Nexus. ^Progresso: Aquele que Vê não dará os fundos necessários para realizar esse empreendimento. Teremos que reverter para o método original dos inexplicáveis portais.")
		}
,
		three: {
			dialogue: new Array(
				"Pedra:Estou aprisionado aqui sozinho. O trabalho nesse túnel é constante,  e a cada dia consigo ver um pouco de progresso.")
		}
	}
	,
	BLUE: {
		one: {
			dialogue: new Array(
				"Esta é a roda que usamos para construir a barragem.")
		}
	}
	,
	CIRCUS: {
		one: {
			dialogue: new Array(
				"24 de Junho de 1957:Trapézio quebra. Alice Rutgers voa em direção ao chão, resultando em duas canelas fraturadas.")
		}
,
		two: {
			dialogue: new Array(
				"17 de Julho de 1957:Sete palhaços se aposentam com problemas pulmonares quase fatais. Especialistas suspeitam da marca de maquiagens TERRAMAIS, mas nenhuma investigação formal está em andamento.")
		}
,
		three: {
			dialogue: new Array(
				"21 de Julho de 1957:Seguinte ao mau funcionamento de uma jaula, meu rosto e laterais foram severamente desfigurados por um leão não treinado. Eu sobrevivi, mas agora temo o meu próprio reflexo.")
		}
,
		four: {
			dialogue: new Array(
				"5 de Agosto de 1957:No meu sonho, vi um rosto de pedra com fortes, olhos brilhantes. Ele revelava a verdade da nossa existência e foi o primeiro a oferecer a liberdade da dor.")
		}
,
		five: {
			dialogue: new Array(
				"7 de Agosto de 1957:Quantos de nós sofrerão antes de aceitarmos a verdade do Aquele que Vê?")
		}
,
		six: {
			dialogue: new Array(
				"8 de Agosto de 1957:Cheguei a uma decisão. Alguns disseram que iriam me seguir. Essa é minha última anotação. Que o Aquele que Vê olhe favoravelmente para nós.")
		}
	}
	,
	CLIFF: {
		one: {
			dialogue: new Array(
				"(Rabiscos indecifráveis)")
		}
,
		two: {
			dialogue: new Array(
				"7 de Dezembro de 2010. (Nome Ilegível). Não há nada aqui em cima, exceto essa pedra estúpida!")
		}
,
		three: {
			dialogue: new Array(
				"Perigo! Essa caverna ainda não foi explorada.")
		}
,
		four: {
			dialogue: new Array(
				"Esses penhascos se extendem para o alto e avante, se bem que eu nunca fui alto o suficiente para saber onde é que vai dar.")
		}
	}
	,
	CROWD: {
		one: {
			dialogue: new Array(
				"Pedra:Como?")
		}
,
		two: {
			dialogue: new Array(
				"Pedra:Perigo! Queda vertical, pule por sua conta e risco.")
		}
	}
	,
	DEBUG: {
		one: {
			dialogue: new Array(
				"Essa costumava ser a animação para o portão das cartas. Se aproxime dele mais de uma vez para ver as animações de abrir e fechar!",
				"Eu esqueci porque ela foi removida. Talvez por ser dramática demais.")
		}
,
		two: {
			dialogue: new Array(
				"Aqui estão testes para várias camadas de ladrilhos e colisões! Eu não consegui fazer ladrilhos de mão única para os dois lados (como paredes)",
				"funcionarem bem e acabei removendo esse conceito do jogo... ou algo assim.",
				"Há uma razão para não usá-los. Simplificar o design, o que foi muito importante para nós terminarmos o jogo.")
		}
,
		three: {
			dialogue: new Array(
				"Inimigos costumavam deixar cair chaves. Essa idéia foi removida mesmo sendo bem divertida.",
				"Outra ideia que tivemos foi a de existir portões de desafio, que",
				"ficariam no final de uma arena e só abririam se você os alcançasse sem se ferir.",
				"Queríamos modelar todos os calabouços a partir disso e remover o sistema de vida completamente, mas isso se provou muito difícil!")
		}
,
		four: {
			dialogue: new Array(
				"PRISÃO!!!",
				"NOS SALVE!!!",
				"Por favor!")
		}
,
		five: {
			dialogue: new Array(
				"Bem-vindo ao MUNDO DE TESTES! Você não está mais na Terra, então considere esse mundo(90 POR-CENTO) não canônico.",
				"Antes de muitos conjuntos de ladrinhos estarem completos eu usei ladrilhos bobos como esses para marcar onde as portas deveriam ficar. De fato, todos os calabouços foram projetados com os ladrilhos desta área, e então Marina substituiu pelos seus.")
		}
,
		six: {
			dialogue: new Array(
				"fille")
		}
	}
	,
	DRAWER: {
		five: {
			dialogue: new Array(
				"- ARQUIVOS -",
				"PROSSIGA COM CAUTELA")
		}
,
		four: {
			dialogue: new Array(
				"Oeste. Fenda. Realidade! Baixos valores imobiliários, velho, acabado. Relaxante.")
		}
,
		three: {
			dialogue: new Array(
				"Aquele que Vê pelo que me lem- brbrr,,,,,Momentos Relaxantes em Casa.")
		}
,
		two: {
			dialogue: new Array(
				"CONGELADOR\n\n^ -- A GERÊNCIA")
		}
,
		one: {
			dialogue: new Array(
				"CONTINUE")
		}
	}
	,
	FIELDS: {
		one: {
			dialogue: new Array(
				"Oeste:Praia\n\nLeste:Floresta\n\nSudeste:\n Área Chuvosa\n\nNorte:\nÁrea do Templo\n\nNordeste:Abismo")
		}
	}
	,
	FOREST: {
		one: {
			dialogue: new Array(
				"Oeste:Lago\nSul, em seguida leste:Penhascos")
		}
,
		two: {
			dialogue: new Array(
				"Lagoa do Relaxamento. Fique um pouco, sabemos que você tem tempo.")
		}
,
		three: {
			dialogue: new Array(
				"Eu temo estar preso neste lugar para todo o sempre.")
		}
,
		four: {
			dialogue: new Array(
				"Leste:Penhascos")
		}
	}
	,
	GO: {
		one: {
			dialogue: new Array(
				"O caminho se abrirá quando as peças dos guardiões sombrios forem substituídas pela sua cor espiritual na formação abaixo.")
		}
,
		two: {
			dialogue: new Array(
				"Quando a pedra azul se locomoveu\nLá um novo caminho se revelou\nPassando dos penhascos, através de dimensões\nExiste um hotel para viajantes\n\n\n\"Quem é o guardião?\"Eu pergunto,\n\"Quem comanda esse abarrotado local de negócios ?\"\nApesar de todas as almas humanas\nEu ainda me sinto só.")
		}
,
		three: {
			dialogue: new Array(
				"A vermelha e enferrujada estátua se moveu\nE abriu caminho para poços profundos\nUm labiríntico calabouço seguiu\nLogo após, uma grande tenda de circo\n\n\n\"Quem são os guardiões?\"Eu pergunto\n\"Quem deu a vida para salvar este local?\"\nEu temo a dor, assim como eles\nMas o que realmente temo, é a morte.")
		}
,
		four: {
			dialogue: new Array(
				"A verde, metálica estátua se deslocou\nDando caminho a uma trilha profunda\nCasas suburbanas e calçadas se formam\nO caminho para um apartamento\n\n\n\"Quem é o guardião?\"Eu pergunto\n\"Quem procura conforto nas estrelas?\"\nSozinho, eu me sinto vigiado.\nNão pela amigável luz das estrelas.")
		}
	}
	,
	BLANK: {
		one: {
			dialogue: new Array(
				"Pedra:Este território não foi anexado, portanto ainda não é parte da Terra.")
		}
,
		two: {
			dialogue: new Array(
				"Pedra:Esses -^ círculos são^ promessas... Eu irei^ concêntricos^ tentar completar tudo...^ Brrur, Brur...")
		}
,
		three: {
			dialogue: new Array(
				"Pedra:Veja^ -...mas eu sempre^ - seus passos^ - acabam reaparecendo, não? ^ - quando aqui!")
		}
,
		four: {
			dialogue: new Array(
				"Pedra:Olhando para baixo^ - E eu percebi^ - daqui, você- ^ Eu o amo.^ - consigo ver... nada.")
		}
,
		five: {
			dialogue: new Array(
				"Pedra:Minhas desculpas - ^Sim, nós -^ nessa bagunça aqui -^ devemos manter contato -^ mas aquele portal deve ^ - e eu tentarei dar minhas opiniões para você -^ retornar você para A Terra.")
		}
	}
	,
	NEXUS: {
		one: {
			dialogue: new Array(
				"Algumas pessoas terão coisas novas a dizer se você falar com elas várias vezes.",
				"O mesmo não se aplica para pedras, pedras não curtem esse tipo de coisa.")
		}
,
		two: {
			dialogue: new Array(
				"Pedra:Quase!")
		}
,
		three: {
			dialogue: new Array(
				"Pedra:Curiosidade é algo ótimo.")
		}
,
		four: {
			dialogue: new Array(
				"Pedra:Ah!...?")
		}
,
		five: {
			dialogue: new Array(
				"O terminal do computador tem um e-mail aberto. Partes da tela estão quebradas, assim apenas partes da mensagem estão visíveis entre as manchas pretas\" Olá, Young! Parece que [...] quinquagésima carta [...] talvez você não deva [...] vale a pena considerar! Acha que está pronto? Acorde...\"")
		}
	}
	,
	OVERWORLD: {
		one: {
			dialogue: new Array(
				"Pedra:Aposto que você está lendo uma pedra porque você não tem amigos.")
		}
,
		two: {
			dialogue: new Array(
				"Pedra:Bem vindo a Estação do Sobresolo. Esperamos que tenha desfrutado do seu tempo na Terra.")
		}
,
		three: {
			dialogue: new Array(
				"Pedra:Um explorador você é!",
				"Pedra:Por favor não vá em direção ao sul. Está sob construção.")
		}
,
		four: {
			dialogue: new Array(
				"Pedra:Tesouro em 5,3!")
		}
,
		five: {
			dialogue: new Array(
				"Pedra:Haha, bobo!")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"NÓS NASCEMOS DENTRO DAS RUÍNAS DO CORPO DE NOSSA MÃE.")
		}
,
		two: {
			dialogue: new Array(
				"UM DIA NOSSA MÃE DEIXOU A MÃE DELA E SE AVENTUROU NO NEVOEIRO VENENOSO.")
		}
,
		three: {
			dialogue: new Array(
				"NÓS NÃO QUERIAMOS ISSO. NÃO TERIAMOS COMPRADO NOSSAS VIDAS AS CUSTAS DO SOFRIMENTO DELA.")
		}
	}
	,
	REDSEA: {
		one: {
			dialogue: new Array(
				"Pedra:Sinais indicam que as árvores não foram ativadas por um longo período de tempo.")
		}
,
		two: {
			dialogue: new Array(
				"Pedra:Sul:???^ Norte:???")
		}
,
		three: {
			dialogue: new Array(
				"Pedra:Dizem que o terreno irregular foi formado pelos ancestrais dos habitantes desta área.")
		}
,
		four: {
			dialogue: new Array(
				"Pedra:Eles aparentam ser uma espécie pacífica.")
		}
	}
	,
	SPACE: {
		one: {
			dialogue: new Array(
				"Escrito em o que aparenta ser um marcador permanente:Saudações, colega viajante do ESPAÇO e TEMPO.^ Você se encontra em uma fenda distante da área justaposta de YOUNG.^ Você atravessou um OCEANO ou dois, por assim dizer.^ Não se preocupe com o CONTRASTE, você pode retornar a sua aventura rapidamente.^ Não TEMA esse local, apesar dele parecer AMEAÇADOR e PERIGOSO você irá ver que seus habitantes são bastante AMIGÁVEIS. \n -- A GERÊNCIA",
				"(Abaixo da mensagem, uma escritura:)Aqui jaz (ilegível). Ele se perdeu na floresta.",
				"(Ainda mais abaixo da mensagem:)(apenas não vá para tão longe ao sul)")
		}
,
		two: {
			dialogue: new Array(
				"Aqui jaz (ilegível. Quem escreveu isso?). Ele foi impalado por um arco-íris!",
				"Seria melhor com conquistas.")
		}
,
		three: {
			dialogue: new Array(
				"Aqui jaz Burd. Os penhascos não estavam se sentindo muito amigáveis.")
		}
,
		four: {
			dialogue: new Array(
				"Aqui jaz mochila. Nunca teve uma chance.",
				"Pretensioso!")
		}
,
		five: {
			dialogue: new Array(
				"Aqui jaz Savitch. Ele tentou consertar meu computador na garagem uma vez, e não tomou muito espaço enquanto o fazia. Três anos depois, ele ainda não tinha acabado. Então, ele caiu morto.")
		}
,
		six: {
			dialogue: new Array(
				"Aqui jaz Dave. Ele não era muito inspirador.")
		}
	}
	,
	SUBURB: {
		one: {
			dialogue: new Array(
				"---MUNICÍPIO DE YOUNG---^\nBem vindo ao Município de Young. Por favor tome cuidado com alguns dos cidadãos.^ Eles não sabem brincar... tome cuidado. O Município de Young foi fundado nos anos 90 pelo prefeito Ying como parte de uma série de projetos habitacionais ainda em andamento, o nome foi escolhido levando em conta o fato de que Ying nega possuir o nome de Ying e que afirma possuir o nome Young.^ Esperamos que tenha uma ótima estadia.")
		}
,
		two: {
			dialogue: new Array(
				"Ao Oeste se localizam os lendários templos do Aquele que Vê.^ No leste está a maravilhosa moradia do Prefeito Ying, que está fechada para visitas do público - invasores cuidado.")
		}
,
		three: {
			dialogue: new Array(
				"Em sua quinta visita, Prefeito Ying se frustrou com a falta de estacionamentos. Esse estacionamento reflete a frustração do Prefeito Ying com a falta de estacionamentos. Ying ocasionalmente estacionava nesse estacionamento em suas visitas subsequentes.")
		}
,
		four: {
			dialogue: new Array(
				"Eu lembro das longas frases que eu costumava escrever. Ha! Fragmentadas!")
		}
,
		five: {
			dialogue: new Array(
				"UMA SITUAÇÃO PERIGOSA")
		}
	}
	,
	TRAIN: {
		one: {
			dialogue: new Array(
				"Aquele que Vê sabe de tudo e conduzirá um para a iluminação. O caminho para a iluminação não é iluminado por tochas.")
		}
,
		two: {
			dialogue: new Array(
				"Não se distancie do caminho do Aquele que Vê, nem mesmo pelos tesouros nos mais distantes cantos do labirinto.")
		}
,
		three: {
			dialogue: new Array(
				"Mova-se.")
		}
,
		four: {
			dialogue: new Array(
				"Não irrite os Procuradores com violência.")
		}
	}
	,
	WINDMILL: {
		one: {
			dialogue: new Array(
				"MARCO CÊNICO:Torres Parceiras. Construídas há algum tempo, as Torres Parceiras negligenciavam as montanhas distantes. A primeira torre foi danificada previamente e desde então foi reaproveitada. A segunda ainda está de pé ao leste, alcançando o céu. Devido a motivos de segurança, o caminho para a torre foi desativado até aviso prévio.")
		}
,
		two: {
			dialogue: new Array(
				"AVISO DE SEGURANÇA PÚBLICA:^\nDizem que esta torre, enquanto não danificada, tem uma fenda dimensional no seu topo. Prossiga com cuidado e mente aberta.^\n -- A GERÊNCIA")
		}
	}
};

public static var rock_state:Object =
{
	BEDROOM: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLUE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CIRCUS: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		six: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CLIFF: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CROWD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	DEBUG: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		six: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	DRAWER: {
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FIELDS: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FOREST: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	GO: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLANK: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	NEXUS: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	OVERWORLD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDSEA: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SPACE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		six: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SUBURB: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	TRAIN: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	WINDMILL: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var dungeon_statue:Object =
{
	BEDROOM: {
		one: {
			dialogue: new Array(
				"A estátua não está com cara de que irá mover.")
		}
,
		two: {
			dialogue: new Array(
				"A estátua se moveu.")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"Parece que a estátua está firme.")
		}
,
		two: {
			dialogue: new Array(
				"A estátua se moveu.")
		}
	}
	,
	CROWD: {
		one: {
			dialogue: new Array(
				"Esta estátua não parece ser móvel.")
		}
,
		two: {
			dialogue: new Array(
				"A estátua se moveu.")
		}
	}
};

public static var dungeon_statue_state:Object =
{
	BEDROOM: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CROWD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var splitboss:Object =
{
	APARTMENT: {
		before_fight: {
			dialogue: new Array(
				"Fogo é algo belo, não é? Que pena que o brilho dos postes de rua escondam o fogo das estrelas.")
		}
,
		after_fight: {
			dialogue: new Array(
				"Certo, as estrelas não são feitas de fogo. ^Quem se importa?")
		}
	}
};

public static var splitboss_state:Object =
{
	APARTMENT: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var cube_king:Object =
{
	SPACE: {
		color: {
			dialogue: new Array(
				"Como vai você? Sou o governante dessa partição e interpretação do espaço.",
				"Você quer saber por que eu sou o governante deste local? Eu lhe direi, mas essa é uma longa história. Digo, realmente longa. Ofensivamente longa.",
				"Vai demorar mesmo. Não estou brincando! Tenho tendência a tagarelar. Talvez seja melhor você ir atrás daquele baú alí. Ou ir em direção ao hotel lá longe. Não sei como ele chegou aqui, mas sei que eles cobram barato. Não que o dinheiro tenha algum valor aqui.",
				"Por que eu sou o governante?^... Eu não tenho certeza, meus amigos que me colocaram nessa posição, devido ao estado imediato deste espaço. Talvez seja isso pois cubos são os melhores quando se trata de ficar parado em superfícies planas. Quanto ao porquê de alguém precisar ficar aqui - eu não faço ideia!",
				"Os outros - meus amigos ali - tem seus próprios méritos.^ Não é como se eles não tivessem a capacidade de sentar aqui no futuro, eles apenas são incapazes no momento.^ De vez em quando, nós trocamos de governante, mas todas as vezes, temos de reinterpretar essa região do espaço! Talvez o Sr. ou a Sra. Pirâmide venham até aqui porque decidimos transformar o trono em um formato para melhor encaixá-los, re-imaginando esse mundo, por assim dizer.^ Isso soa meio estranho? Talvez. Mas é assim que as coisas são. Tudo acontece muito rápido. Minutos, horas - náo é necessariamente um longo reinado.",
				"Apesar de que, quando eu sou o governante, eu me sinto estranho...^ De alguma forma me sinto isolado, querendo se afastar dos outros...",
				"...isolado não é palavra que quero, mas ela cobra parte do sentimento. Eu não estou isolado, e eu não desgosto dos outros. Nós nos consideramos amigos, mas você sabe, ninguém passa por aqui a não ser para falar algumas palavras. Assim eu tenho que pensar sobre alguma coisa ou enlouqueço! Talvez seja por causa do isolamento.",
				"Fora as questões fúteis do porque estamos ocupando esse espaço, estou curioso com o porquê de sermos amigos.",
				"Eu gosto de pensar que sempre que estamos de acordo com as interpretações de que sou o melhor para governar, eles me dão conforto em ter a capacidade de manter essa posição pelo tempo que for necessário para atingir a próxima interpretação. Sabe, encorajamento e coisas do tipo, a presença física deles, essas coisas me confortam.",
				"Suponho que isso é o suficiente para me satisfazer, apesar de que seria legal se um ou dois deles entendessem como me sinto como governante. Não que eu esteja reclamando sobre o encorajamento! Talvez um dia, nós possamos ter vários governantes...quem dera! Talvez isso implique que quando eu não sou o governante, devo agir da mesma maneira que às vezes gostaria que agissem...quem sabe se isso pode ser feito.",
				"Já falei demais. Se você for na outra direção, encontrará outra região similar do espaço, apesar de eu achar que ela cheire um pouco diferente.",
				"Foi um prazer lhe conhecer.",
				"Ah, quer ouvir minha história mais uma vez?",
				"Tudo bem, vamos lá.")
		}
,
		gray: {
			dialogue: new Array(
				"Olá. Eu sou o governante dessa parte do espaço.",
				"O que? Quer saber por que eu estou aqui? Tem certeza? Vou precisar de muitas palavras para explicar!",
				"Bem, se você insiste. Embora você se sairia melhor indo para aquele hotel lá longe. Não sei por que o construíram. Se eu tivesse algum dinheiro para ser taxado, certamente reclamaria!",
				"Bem, mesmo eu sendo o governante dessa parte do espaço, eu não governo ninguém.",
				"Esses meus amigos - todos são governantes de suas próprias partes do espaço. Ninguém governa ninguém, estamos todos sós nesse aspecto. Mas não estamos sós quando se trata de falar uns com os outros, e em outras formas também não estamos sozinhos. Esse é apenas um lugar em que eu existo.",
				"Meus amigos e eu - nossas partes do espaço tem muito em comum quando se trata da razão delas existirem e como estão organizadas. Interesses e desejos similares. Nós gostamos de conversar sobre como governar, e coisas do gênero.",
				"Mas o trágico é que raramente nós encontramos em forma física.",
				"Você não está falando com suas formas físicas, mas com suas representações em forma holográfica.",
				"Eu sei, é lamentável. É lamentável porque nós temos tanto em comum, mas estamos limitados em como podemos nos ajudar como amigos.",
				"Algo bem pequeno falta quando você não tem conversas físicas frente a frente o tempo todo.",
				"Mas eu não estou reclamando. É melhor do que nada! Não consigo imaginar como seria sem isso. Algo terrível.",
				"Foi agradável falar com você, boa sorte com o que você estiver fazendo.",
				"Você ainda está aqui? Eu posso te contar tudo outra vez, se você quiser.")
		}
	}
};

public static var cube_king_state:Object =
{
	SPACE: {
		color: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
,
		gray: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
};

public static var forest_npc:Object =
{
	FOREST: {
		bunny: {
			dialogue: new Array(
				"Crickson:Ei valentão! Não tenho medo de você!",
				"Crickson:Ei cabeção! Não vou fugir! Nem mesmo se você tentar me bater!",
				"Crickson:Você é só um vassoureiro, é isso que você é! Você devia ter vergonha nessa cara!")
		}
,
		thorax: {
			dialogue: new Array(
				"Tórax:Eu sou o tórax, eu falo em nome das abelhas.\n^Seu destino é incerto, não faz parte do conhecimento delas.\n^Trabalhadores de certas colônias decolaram!\n^Com isso tais colônias estão morrendo, não é bonito de se ver!",
				"Tórax:Talvez seja um vírus ou um novo pesticida,\n^talvez sejam as larvas das malditas moscas Phoridae!\n^As abelhas estão agindo de forma estranha.\n^O que quer que seja, tem que mudar!",
				"Tórax:Certo, eu não sei o que está acontecendo\n^Temo que meus esforços sirvam para nada além de tagarelar.\n^Mas como eu posso ficar aqui sentado e não fazer nada para ajudar?\n^Já sei - irei postar no Facebook, Twitter e Yelp!")
		}
	}
};

public static var forest_npc_state:Object =
{
	FOREST: {
		bunny: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		thorax: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var shopkeeper:Object =
{
	FIELDS: {
		init: {
			dialogue: new Array(
				"Compre meus produtos!")
		}
	}
};

public static var shopkeeper_state:Object =
{
	FIELDS: {
		init: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var goldman:Object =
{
	FIELDS: {
		outside: {
			dialogue: new Array(
				"O que você está fazendo aqui, mermão? Caí fora! Eu consegui na honestidade!",
				"Não irei largar! Nem em um milhão de anos!")
		}
,
		inside: {
			dialogue: new Array(
				"Ah, veio aqui pra me aterrorizar mais um pouco?",
				"Você está se aliando aos gatos só porque eles são macios e fofinhos.")
		}
,
		etc: {
			dialogue: new Array(
				"O que você está fazendo aqui, mermão? Caí fora! Eu consegui na honestidade!^ AAAAAA!^ Isso aí--^ OUTRO GATO?!?!^ AAAAAAAAHH!!!",
				"Você... você limpou minha casa... Estou emocionado! Aqui, quero lhe dar a minha mais bela posse!",
				"Young abre o baú. Algo se encontra dentro dele!",
				"Icky:Ah, Ei Miao.^\n\nMiao:Ainda bem que você está a salvo!^\n\nIcky:Ah... obrigado pela ajuda, Young.",
				"Icky:Pra ser honesto, eu meio que gosto de sentar em caixas.")
		}
	}
};

public static var goldman_state:Object =
{
	FIELDS: {
		outside: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		inside: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		etc: {
			top: true,
			cur: "",
			pos: 0,
			loop: 4,
			dirty: false,
			finished: false
		}
	}
};

public static var miao:Object =
{
	FIELDS: {
		init: {
			dialogue: new Array(
				"Ah!! Você é Young, O Escolhido!! Aimeudeus, que honra! Meu nome é Miao Xiao Tuan Er, Escolhido-em-treinamento!",
				"Posso acompanhá-lo por um tempo para observar O Escolhido em ação?",
				"Olá mais uma vez, Young! Posso ser sua sombra hoje?")
		}
,
		randoms: {
			dialogue: new Array(
				"Miao:Ei, Young... você já roubou algo?",
				"Miao:Eu gosto da Mitra... e Wares não é uma bicicleta elegante?",
				"Miao:O que é essa coisa feita de pedra, Young? Ela faz você voltar no tempo?",
				"Miao:Estou começando a ficar preocupado com Icky... Young, você viu um gato bem grande recentemente? Icky disse que ia fazer uma caminhada pela pequena floresta ao leste.",
				"Miao:Icky disse que eu não deveria ir para lugares perigosos. Vejo você depois, Young.",
				"Miao:Você já sentou em uma pilha de sacolas de supermercados?",
				"Miao:Ei Young, você acha que é errado usar erva-de-gato?",
				"Miao:Aposto que deve ter dado muito trabalho se tornar O Escolhido, né, Young?")
		}
,
		philosophy: {
			dialogue: new Array(
				"Aquela situação perigosa com o Icky me fez pensar... O que você acha que acontece depois que morremos? Como alguém consegue atingir um propósito em apenas uma vida?",
				"Talvez reencarnemos várias vezes até completar nosso destino. Ou isso deixaria tudo fácil demais?",
				"E qual é a recompensa por completar nossa jornada? Nós apenas se dissolvemos no nada?",
				"Hmm...")
		}
,
		icky: {
			dialogue: new Array(
				"Ah. Oi, Young.",
				"Meu nome real não é Icky. É Ichabod.",
				"Espero que Miao Xiao Tuan Er não tenha se metido em muitos problemas.",
				"Até logo, Young.")
		}
	}
};

public static var miao_state:Object =
{
	FIELDS: {
		init: {
			cur: "",
			pos: 0,
			loop: 2,
			dirty: false,
			finished: false
		}
,
		randoms: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		philosophy: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
,
		icky: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var generic_npc:Object =
{
	DEBUG: {
		melos: {
			dialogue: new Array(
				"E aí firmeza, como vai você? Você me achou! Eu vou continuar aqui, de qualquer forma. Está frio lá fora.",
				"Você pode me culpar por todas essas terríveis salas! Eu as fiz com o editor de mapas DAME.",
				"Eu criei esse jogo com a IDE FlashDevelop e com o framework Flixel AS3!",
				"Ah, é, e eu fiz a trilha sonora com o REAPER. E algumas vezes Audacity.",
				"Eu consigo meus nutrientes através da radiação de todos esses computadores... ^Como assim isso não é biologicamente correto?",
				"Oi mãe! ^E pai!",
				"Quer saber como finalizar o jogo em 20 minutos?",
				"Ha! Como se eu fosse contar pra você!",
				"(...talvez se você pedir gentilmente...)")
		}
,
		marina: {
			dialogue: new Array(
				"Uau ei!",
				"Eu escrevi um monte de diálogos para esse jogo!^ (...mas não esse. Melos está fazendo isso.)",
				"Eu usei Adobe Photoshop CS5, Graphics Gale Free Edition e a Ferramenta de Captura do Windows 7 para fazer os gráficos!")
		}
	}
	,
	REDSEA: {
		first: {
			dialogue: new Array(
				"A umidade aqui é boa para sua pele, mas ruim para seu cabelo.",
				"Eu gosto daqui. Ultimamente, as pessoas passam todo o verão indo do calor infernal para o frio do ar condicionado. Essas mudanças rápidas de temperatura enfranquecem seus ossos.",
				"É como aquele maldito hábito de mastigar cubos de gelo. Minha mãe fazia isso lá pros 25 anos. Agora ela tem fissuras por todos os seus molares.")
		}
,
		second: {
			dialogue: new Array(
				"Lembre de trocar de sapatos e enchê-los de jornais para os deixar secos. Você não quer criar um terreno fértil pra bactérias, não é?",
				"Por que buffets só servem gelatina vermelha? É como se eles quisessem nos dar câncer.")
		}
,
		bomb: {
			dialogue: new Array(
				"Sai de perto.",
				"Falo sério... me deixe em paz.")
		}
	}
	,
	BLUE: {
		one: {
			dialogue: new Array(
				"Não preciso da sua piedade, Young.",
				"Certo, vá viver no seu mundinho feliz, \"Escolhido\"...",
				"Young, amizade é só um truque que as pessoas aplicam em si. Somos todos babacas, e no fim, estamos todos sós.",
				"Hah, eu sabia que você me odiava, Young.",
				"Eu estou bem.",
				"É claro que você não se importa. Ninguém se importa.")
		}
	}
	,
	HOTEL: {
		one: {
			dialogue: new Array(
				"Eu sei que cidades podem ser sujas, lotadas e tudo mais, mas eu gosto de vir aqui e olhar todas as luzes.",
				"É belo de uma forma única. Não é infinito como as estrelas, mas existe algo sobre sua humanidade que adiciona uma camada maravilhosa de complexidade.",
				"Atrás de cada luz se encontra uma pessoa com esperanças, medos e segredos... olhando dessa forma é terrivelmente solitário e ferozmente pessoal.",
				"Eu acho que amo todas as pessoas por atrás de cada janela. Eu amo vocês, pessoas, por serem minhas estrelas. Eu amo vocês não importando o quão fudida sua vida é ou o quanto vocês acham que caíram. Vocês são amáveis nesta noite...",
				"Desculpe, falei demais. Obrigado por escutar.")
		}
	}
	,
	REDCAVE: {
		easter_egg: {
			dialogue: new Array(
				"Eiiiii, parceiiiirooo...descanse um pouco, fique por um tempo, que tal?")
		}
	}
	,
	APARTMENT: {
		easter_egg: {
			dialogue: new Array(
				"Ah! Você me achou!")
		}
	}
	,
	CLIFF: {
		quest_normal: {
			dialogue: new Array(
				"Golem:Você foi atingido por um pedregulho na subida? As vezes eu arremesso pedregulhos quando estou com raiva. Me desculpe se foi atacado por algum.",
				"Golem:Minha mãe sempre dizia que se eu continuar com isso, um dia eu não teria mais montanhas para arremessar.")
		}
,
		second: {
			dialogue: new Array(
				"Golem:Quando você é uma pedra, você presencia geraçôes de pessoas indo e vindo. Você se torna mais ancião e sábio que o mais sagaz dos humanos.",
				"Golem:Pelo menos, essa é a ideia. Eu quebrei meus binóculos um tempo atrás e assim eu não sei mais dizer o que tem ocorrido.",
				"Golem:De fato, eu não sinto falta de assistir as pessoas, é muito entediante.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Golem:Ah, sim, eu conheci alguém que estava meio perdido...ele me contou que estava indo para a praia.")
		}
	}
	,
	BEACH: {
		quest_normal: {
			dialogue: new Array(
				"Não sou uma lagosta, sou um langostino. Meu nome é Hews.",
				"Hews:Sabe qual é a melhor parte do oceano? O horizonte.",
				"Hews:O oceano é como um pedaço salgado do universo.",
				"Hews:Um praia lotada é desprovida de sua graça.")
		}
,
		second: {
			dialogue: new Array(
				"Hews:Já ouviu falar do Estomatópode? Ele possuí 16 fotorreceptores que o permite perceber luz ultravioleta. Você consegue imaginar ver uma grande variedade de cores?",
				"Hews:Talvez seja belo. Enfim, nós já achamos razões demais para nos odiar com as cores que temos.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Hews:Está procurando por alguém, é? Lembro que estava sentado aqui quando algumas nuvens taparam o sol. Nesse momento, alguém veio me perguntar sobre algo. não lembro o que era, mas foi embora dizendo que iria em direção a floresta.")
		}
	}
	,
	FOREST: {
		quest_normal: {
			dialogue: new Array(
				"James:Frutas são um bom tipo de comida. Eu gosto de frutas.",
				"James:Por favor, certifique-se de não defecar nas frutas.",
				"James:Até agora nessa estação do ano eu tive relações sexuais 18 vezes. E também, eu comi 389 porções de frutas.",
				"James:Você tem alguma fruta para James?")
		}
,
		second: {
			dialogue: new Array(
				"James:Eu escrevi um poesia:\n^Eu gosto de comer frutas\n^Elas me deixam batuta\n^Eu gosto muito de frutas\n^Até mais do que trutas!",
				"James:Você prefere framboesas ou mirtilos?",
				"James:Você tem alguma fruta para James?")
		}
,
		quest_event: {
			dialogue: new Array(
				"James:Uma pessoa passou por aqui. Não queria frutas. Ela foi em direção a parte sudeste do lago a oeste.")
		}
	}
	,
	FIELDS: {
		easter_egg: {
			dialogue: new Array(
				"Olivia:Olá, eu sou Olívia a coelha.",
				"Olivia:Eu tenho um monte de cereal para comer ainda! Eu amo cereal.",
				"Olivia:Essa caixa é tão grande. Ela nunca acaba!",
				"Olivia:Cereal infinito!",
				"Olivia:Hmmm...talvez isso não seja algo ruim.")
		}
,
		bush: {
			dialogue: new Array(
				"Rank:Hahaha, Young seu bobo. Uma vassoura não serve para cortar arbustos!")
		}
,
		quest_normal: {
			dialogue: new Array(
				"Rank:Eu corto arbustos para me manter. As vezes quando você corta um arbusto e encontra ouro! Ahaha!",
				"Rank:A economia não vai muito bem debaixo deste arbusto aqui.",
				"Rank:As vezes é díficil manter minha mulher e filhos apenas cortando arbustos--nem sempre temos o suficiente para comer... mas sempre temos uma lareira acesa! Ahaha!")
		}
,
		quest_event: {
			dialogue: new Array(
				"Rank:Ah? Sim! Uma pessoa passou por aqui. Disse que estava indo para o labirinto subterrâneo...Aposto que lá tem uma vários arbustos, né, Young? Ahaha!")
		}
,
		marvin: {
			dialogue: new Array(
				"Marvin:Ah ei, como está se sentindo?",
				"Marvin:Onde está Justin?",
				"Marvin:Não tem nenhum foguete de garrafa por aqui...")
		}
,
		chikapu: {
			dialogue: new Array(
				"Chika Chi!",
				"Chika Chika!!",
				"CHIIIII^\nKAAAA^\nPUUUUUUUUUU!!!!")
		}
,
		hamster: {
			dialogue: new Array(
				"Bob:Bob o Hamster gosta de falar de si mesmo na terceira pessoa.",
				"Bob:Apóstrofos são artimanhas do s'atanás.",
				"Bob:Quieto! Estou ocupado exalando uma aura de ambiência hamstérica.",
				"Bob:... Supunho que você só melhora fazendo... Mas... se você faz algo errado, você se torna melhor a fazer esse erro?",
				"Bob:Um homem de verdade nunca chora... bem, talvez ele deixe uma única lágrima cair do canto de seus olhos através da sua face enrijecida pelo sol enquanto ele dirige sua estilosa Harley através do deserto de Mohave sem usar capacete ou óculos protetor. Mas ele nunca chora.",
				"Bob:Esse jogo foi criado por um número infinito de macacos trabalhando em um número infinito de máquinas de escrever.",
				"Bob:Sinto falta do James...")
		}
,
		electric: {
			dialogue: new Array(
				"Kuribu:Curry é amarelo e apimentado!",
				"Kuribu:Para o oponente sagaz, ferimento aumenta!",
				"Kuribu:Você recebeu a experiência de 2!",
				"Kuribu:Tome meu número de telefone! 0800 meiamolemeiadura")
		}
	}
	,
	TRAIN: {
		quest_normal: {
			dialogue: new Array(
				"O QUE eu estou fazendo aqui? Boa pergunta! Encontrei esse lugar por acaso. Estou me escondendo. Aqui é seguro, se você não se aventurar tão longe e deixar esses caras te encontrarem.",
				"Parece que sou relativamente afortunado. Todos esses mortos espalhados pelo chão - como eles morreram? É um pouco fascinante, tentar imaginar como tudo ocorreu. Foram atacados por monstros? Tropeçaram e caíram nos espinhos?",
				"É um pouco medonho. Espero que isso não aconteça comigo. Dor física é algo térrível para se ter.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Ah... pensando nisso, uma pessoa passou por aqui um tempo atrás. Disse que estava procurando por algo...até parecia um pouco com você! Não lembro quando, desculpe. É díficil manter noção do tempo aqui. Mas lembro que ela estava indo para uma cidade próxima.")
		}
	}
	,
	SUBURB: {
		quest_normal: {
			dialogue: new Array(
				"Olá.",
				"Está procurando por algo?",
				"O que é que você está olhando?",
				"Não, não sou dessa cidade. Estranho, você pode me ver e falar comigo, mas eu não consigo interagir com nenhum deles. Tem um monte de assassinos por aí, e ninguém parece notar. Isso é estranho.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Sim. Eu vi uma pessoa passar por aqui. Ela estava a procura de algo. Não sei o que esse 'algo' possa ser. Foi embora depressa. Disse que estava indo em direção a uma área alternativa do espaço. Me soou extravagante.")
		}
	}
	,
	SPACE: {
		quest_normal: {
			dialogue: new Array(
				"EI EI EI - - - QUEM É VOCÊ ? ? ?",
				"EU SOU UM VAGANTE . . . ESSA É UMA DAS PARADAS MAIS POPULARES NA JORNADA ENTRE B E A .",
				"O QUE É 'A' ? ? ? É MINHA CIDADE NATAL . . . ESTOU VISITANDO UM VELHO AMIGO EM B . . . É UM LONGO CAMINHO . . . MAS EU FAÇO SACRIFÍCIOS . . . VOCÊ NÃO ? ? ? DEIXA A VIDA MAIS ANIMADA ! ! !")
		}
,
		quest_event: {
			dialogue: new Array(
				"AHH - - - PROCURANDO POR OUTRO HUMANO - - - ENTENDO . ^ DEIXE-ME ACESSAR MINHA MEMÓRIA . . . READ ( 0X0C00400 , STDOUT , 100 ) ; \n . . . . . . \n . . . . . . \n A HA . . . \n A PESSOA TEVE UMA IDÉIA SUBITA E DISSE QUE IRIA PARA UMA CABANA EM UM CAMPO BEM CUIDADO. \n PENSANDO NISSO . . . VOCÊ É IDÊNTICO A ESSA PESSOA ! ! ! TEM CERTEZA QUE NÃO ERA VOCÊ ? ? AHN ? MM ?")
		}
	}
	,
	GO: {
		quest_normal: {
			dialogue: new Array(
				"Você estava... ah, um. Bom trabalho.",
				"A reluzente pedra reflete um pouco da luz vinda da sala. Nela há a inscrição:\"Rápido, antes que eu tenha que sair de novo (Estava ficando muito claro aqui, isso sempre acontece) - a parte noroeste da floresta azul - Eu vi outra entrada do templo um pouco mais ao norte, depois dessas árvores - se eu pudesse mover as coisas com o pensamento eu poderia chegar lá...talvez eu faça isso na próxima vez em que eu for visitar esse mundo.\"")
		}
,
		quest_event: {
			dialogue: new Array(
				"A reluzente pedra reflete um pouco da luz vinda da sala. Nela há a inscrição:\"Rápido, antes que eu tenha de sair de novo (Estava ficando muito claro aqui, isso sempre acontece) - a parte noroeste da floresta azul - Eu vi outra entrada do templo um pouco mais ao norte, depois dessas árvores - se eu pudesse mover as coisas com o pensamento eu poderia chegar lá...talvez eu faça isso na próxima vez em que eu for visitar esse mundo.\"")
		}
	}
};

public static var generic_npc_state:Object =
{
	DEBUG: {
		melos: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		marina: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDSEA: {
		first: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		bomb: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLUE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	HOTEL: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		easter_egg: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	APARTMENT: {
		easter_egg: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CLIFF: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BEACH: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 1,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FOREST: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FIELDS: {
		easter_egg: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		bush: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		marvin: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		chikapu: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hamster: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		electric: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	TRAIN: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SUBURB: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SPACE: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	GO: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 1,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var geoms:Object =
{
	SPACE: {
		gray1: {
			dialogue: new Array(
				"OLÁ. JÁ ENCONTROU O cubo?",
				"cubo É UM ÓTIMO GOVERNANTE DESSA PORÇÃO DO ESPAÇO. NÓS OUTROS GOVERNANTES DAMOS NOSSO MELHOR EM NOSSO ESPAÇO TAMBÉM.")
		}
,
		gray2: {
			dialogue: new Array(
				"O QUE VOCÊ ACHA DESSE PEDAÇO DE ESPAÇO? É UM ÓTIMO LUGAR, NÃO É?",
				"UMA INTERCESSÃO DE MUNDOS!")
		}
,
		gray3: {
			dialogue: new Array(
				"NENHUM DE NÓS PIRÂMIDES CINZAS ESTAMOS DE FATO AQUI. USAMOS APARELHOS ESPECIAIS QUE NOS PERMITEM NOS PROJETAR AQUI.",
				"POR QUE FAZEMOS ISSO? PORQUE QUEREMOS FALAR COM NOSSO AMIGO cubo E FAZÊ-LO COMPANIA.")
		}
,
		graydead: {
			dialogue: new Array(
				"*bzrrrrt*")
		}
,
		grayspin: {
			dialogue: new Array(
				"...O APARELHO DE HOLOGRAMA ESTÁ FUNCIONANDO CORRETAMENTE?",
				"NÃO?^...^DROGA!")
		}
,
		color1: {
			dialogue: new Array(
				"Já conheceu o CUBO? Ele faz muitas coisas maneiras! Ouvi dizer que uma vez ele ficou na beirada por quase doze segundos! Sabe o que isso significa para a Liga da Beirada? Não? Muito!")
		}
,
		color2: {
			dialogue: new Array(
				"Cubo faz coisas interessantes!",
				"Você sabia? Aparentemente, minha vez de governar está próxima! Faltam apenas alguns minutos, acredito.")
		}
,
		color3: {
			dialogue: new Array(
				"Eu venho do Pão de Açúcar, em direção a Taipei. Por que estou aqui? Eu parei para cumprimentar o CUBO!",
				"Não fique triste! Esse lugar é uma representação estranha apenas para não amedrontar os visitantes. É praticamente inofensivo, até onde sabemos.")
		}
,
		colordead: {
			dialogue: new Array(
				"(...está tirando um cochilo?)")
		}
	}
};

public static var geoms_state:Object =
{
	SPACE: {
		gray1: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gray2: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gray3: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		graydead: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		grayspin: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		color1: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		color2: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		color3: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		colordead: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var redboss:Object =
{
	REDCAVE: {
		before_fight: {
			dialogue: new Array(
				"CADA GERAÇÃO NASCE DA DOR PARA MORRER EM DOR. NÃO IREMOS SOFRER PARA REPRODUZIR O CICLO. NÓS NÃO IREMOS PARA FORA.")
		}
,
		after_fight: {
			dialogue: new Array(
				"ESTE É O SEU CASTIGO POR NOSSA REBELIÃO?")
		}
	}
};

public static var redboss_state:Object =
{
	REDCAVE: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var circus_folks:Object =
{
	CIRCUS: {
		before_fight: {
			dialogue: new Array(
				"Porque você priva o Aquele que Vê de seus sacrifícios? Por que você roubou de nós nossa salvação?")
		}
,
		after_fight: {
			dialogue: new Array(
				"...Nós falhamos em fazer você pagar por sua interferência. E ainda assim... você nos devolveu a chance de ser livres. Obrigado, Young. Que o Aquele que Vê olhe positivamente para você mais uma vez.")
		}
	}
};

public static var circus_folks_state:Object =
{
	CIRCUS: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var wallboss:Object =
{
	CROWD: {
		before_fight: {
			dialogue: new Array(
				"Muito bom te ver, Yang. Faz tanto tempo. Ainda jogando esses nantendo, não é?")
		}
,
		after_fight: {
			dialogue: new Array(
				"Meu Deus, Yon, quando é que você vai crescer? Você sabe que terá que aprender a lidar com pessoas mais cedo ou mais tarde.")
		}
	}
};

public static var wallboss_state:Object =
{
	CROWD: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var eyeboss:Object =
{
	HOTEL: {
		before_fight: {
			dialogue: new Array(
				"Nós temos as melhores amenidades aqui. O que acha da nossa piscina?")
		}
,
		middle_fight: {
			dialogue: new Array(
				"O que me diz do nosso centro de fitness com tecnologia de ponta?")
		}
,
		after_fight: {
			dialogue: new Array(
				"Esperamos que tenha desfrutado de sua estadia!")
		}
	}
};

public static var eyeboss_state:Object =
{
	HOTEL: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		middle_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var suburb_walker:Object =
{
	SUBURB: {
		words_adult: {
			dialogue: new Array(
				"Hoje é um bom dia.",
				"Obrigado por coçar meu pescoço - Eu não estava conseguindo alcançar.",
				"Ouvi dizer que os ovos do restaurante local são muito bons. E ainda por cima tenho cupons para eles.",
				"Viu o acidente de carro de hoje? Horrível! Ele estava usando celular. Que pena, era tão jovem!",
				"Meu filho não conseguiu entrar para o time júnior do colégo. Decepcionante. Nós investimos tanto em sua carreira esportiva.",
				"Hoje é o dia de ação de graças. Sou grato por muitas coisas. Mal posso esperar para as promoções de amanhã cedo. Vou conseguir um monte de barganhas.",
				"Ah, acho que chegarei atrasado no trabalho.",
				"Estou apressado para chegar em casa, preciso arrumar tudo antes dos sogros chegarem.",
				"Estamos tendo uma venda de garagem!",
				"Bem vindo!")
		}
,
		words_teen: {
			dialogue: new Array(
				"Eu não vi o filme mais recente.")
		}
,
		words_kid: {
			dialogue: new Array(
				"Nunca terei a chance de ver o novo desenho animado!")
		}
,
		family: {
			dialogue: new Array(
				"Bem vindo a nossa casa, estranho! Você me parece familiar. Esta é uma cidade pacata. Bem quieta, sem muitos visitantes.",
				"Você curte Davement? Meu irmão Dave	me mostrou uma música deles muito maneira!")
		}
,
		older_kid: {
			dialogue: new Array(
				"Meus amigos gostam de ouvir 'None Surprises' daquela banda chamada 'Rayhead' e reclamar sobre este local. Tudo bem, é uma espécie de bolha, mas pelo menos mostrem alguém respeito!",
				"Acho que vou escrever para meu blog.",
				"Você parece estar confuso.",
				"Eu tenho problemas para ouvir meus pensamentos quando esportes e coisas do tipo estão passando na TV, mas meus pais gostam disso.")
		}
,
		hanged: {
			dialogue: new Array(
				"Uma anotação no corpo:\"Colocando-me em perigo não mais.\"")
		}
,
		festive: {
			dialogue: new Array(
				"Ah, tem algo acontecendo lá fora? Um festival? Um desfile?",
				"Parece que há uma baita comoção lá fora! Já olhou na janela recentemente? O que será que é?")
		}
,
		paranoid: {
			dialogue: new Array(
				"Minha casa tem muitas janelas. Eu não gosto de janelas. É como se alguém estivesse olhando para dentro. E no fundo você sabe que TEM algo acontecendo lá fora. não pode ser apenas silêncio o tempo todo. É pertubador.",
				"Assassinos? O que? Lá fora? Você tá de brincadeira?",
				"Por favor saia daqui.")
		}
,
		dead: {
			dialogue: new Array(
				"O corpo desta mulher foi atacado por uma arma de ponta cega.",
				"O homem, cegamente, bem...")
		}
	}
};

public static var suburb_walker_state:Object =
{
	SUBURB: {
		words_adult: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		words_teen: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		words_kid: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		family: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		older_kid: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hanged: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		festive: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		paranoid: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		dead: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var suburb_blocker:Object =
{
	SUBURB: {
		one: {
			dialogue: new Array(
				"Ah, é você! Você me parece familiar...Eu não posso me mover até você matar mais desses habitantes da cidade, lembra? Volte aqui mais tarde.",
				"De acordo com esse panfleto...você só tem que matar mais um pouco de pessoas! Continue assim!",
				"Só precisamos de mais um corpo, e depois continuamos.",
				"Muito bem. Sinta-se livre para entrar. Não faço idéia do que tem lá dentro. Nos vemos depois, mesma hora amanhã, certo? Ou na noite seguinte?")
		}
	}
};

public static var suburb_blocker_state:Object =
{
	SUBURB: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var card:Object =
{
	ETC: {
		one: {
			dialogue: new Array(
				"Não me importo em ser observado pelas árvores.",
				"Cadê ela?!",
				"Eu estarei com você Young, sempre que estiver sozinho.",
				"Você é um Ookchot? Mamãe sempre me avisou para ter cuidado com os perigosos Ookchot.",
				"Jello falando, Young! Muito bom finalmente poder lhe conhecer! Por que não fica aqui uns minutos? Eu estou acabando de preparar chá.",
				"Pei, Pei, Pei, Pei, Pei, Pei, Pei, Pei, Pei, Pei, Pei, Pei, Coro, Púlpito, Altar, Janelas de Vidro Tingido...",
				"Oferta por tempo limitado! Compre um, leve dois - apenas hoje!",
				"Lembra daquela vez que você acendeu uma vela quando a energia estava falhando?",
				"Hmmmm, seu travesseiro estava confortável noite passada.",
				"Isso vai lhes mostrar que não devem me chamar do cara da fumi-GAY-ção.",
				"Wares e Eu fazemos uma boa equipe.",
				"Eu sou o Escolhido-em-treinamento!",
				"Você já teve a sensação, de que não importa o que você faça, você não consegue impedir o mundo de morrer?",
				"Cuidado com os cogumelos florestais...",
				"Me desculpe. Essa é minha natureza.",
				"O que você quer dizer com \"só uma pedra\"?? Pedras podem ser cartas também!",
				"Dê um peixe para um homem e ele terá comida por um dia. Ensine um homem a pescar, e ele terá bons momentos com seu filho, Jimmy.",
				"As vezes a resposta é fazer uma caminhada.",
				"Porque morcegos aparecem do nada, sempre quando você chega?",
				"NÃO, *VOCÊ* QUE PRECISA DE APARELHO!",
				"ESTÁ SATISFEITO?",
				"Não venha com violência pra cima de mim.",
				"Sempre quis participar do Iron Chef.",
				"Minha mãe vivia dizendo, 'Se você fizer esse arco por tempo suficiente, sua coluna ficará assim!'",
				"Está entretido, humano?",
				"...",
				"Existem cerca de 4.800 espécies de sapos.",
				"HAHAHAHA! É! Eu sei!",
				"Ah, você coleciona cartas também? Que crescido, Ying.",
				"Todos vivem dizendo, \"Saia do computador! Ou você nunca vai fazer amigos!\"",
				"Eu sou o governante apenas pela duração dessa conversa.",
				"Aposto que você acha que está 'tornando meu trabalho mais interessante'!",
				"Odeio diagonais.",
				"Nem pensei usar essa droga de claritin perto de mim.",
				"Raspe essa carta para destravar a porta para seu quarto!",
				"Estou fazendo um ótimo trbalho.",
				".......??",
				"Quem foi que nos esculpiu mesmo?",
				"Espero que tenha desfrutado de sua estadia.",
				"Para você chegar a esse ponto, você deve ser muito interessante.",
				"Só estou aqui para lhe tirar do caminho.",
				"Você é como uma pirâmide para nós, também!",
				"É a mesma maldita peça, noite após noite, e o salário é uma droga.",
				"Me deixe em paz! Meu nome não é Sachs!",
				"Pelo menos eu não sou um bastão.",
				"Como assim dinheiro não nasce em árvores? Ahahahah!",
				"Eu não passo de uma ilusão.",
				"EU VOU DESCONTAR TUDO EM VOCÊ.")
		}
	}
};

public static var card_state:Object =
{
	ETC: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var misc:Object =
{
	any: {
		controls: {
			dialogue: new Array(
				"Pressione",
				"para configurar\nos controles.",
				"para cancelar.",
				"Cima",
				"Baixo",
				"Esquerda",
				"Direita",
				"Pulo",
				"Ataque",
				"Menu",
				"Pressione",
				"para sair",
				"para configurar os controles.")
		}
,
		title: {
			dialogue: new Array(
				"Por favor use as setas\npara redimensionar a\njanela até que não\nseja possível visualizar\náreas pretas ao redor\ndas bordas. Pressione\n",
				"para finalizar.",
				"ANODYNE",
				"Melos Han-Tani\nMarina Kittaka",
				"any key",
				"Pressione",
				"para iniciar",
				"Versão",
				"Continuar",
				"Novo Jogo",
				"Tem certeza?\nNão\nSim",
				"Mesmo?\nNão\nSim",
				"Não vai ter volta!\nEsqueça\nEu sei",
				"mortes",
				"cartas",
				"Anodyne suporta\na maioria dos controles.\n\nDeseja usar um?\n\nSim Não\n\nSe sim, conecte-o agora.\n\nMova com as setas\n\nEscolha com\nC, ESPAÇO, ou ENTER\n\nEscolhendo \"sim\" em\n",
				"AVISO\n\nSe estiver sofrendo atraso dos comandos durante o jogo,\nfeche e\nabra Anodyne novamente.\n\nPRESSIONE C PARA CONTINUAR",
				"Pressione VOLTAR para sair.")
		}
,
		elevator: {
			dialogue: new Array(
				"Andar?",
				"1\n",
				"2\n",
				"3\n",
				"4\n",
				"Cancelar")
		}
,
		gui: {
			dialogue: new Array(
				"menu=enter",
				"Salvando...")
		}
,
		map: {
			dialogue: new Array(
				"Mapa",
				"Sala Atual",
				"Entrada/Saída",
				"Sem Mapa",
				"Voltar para\no Nexus",
				"Voltar para\na entrada")
		}
,
		items: {
			dialogue: new Array(
				"Itens",
				"Normal",
				"Troca",
				"Extensão",
				"Ampliação",
				"Um par de sapatos com mola - pressione",
				"para pular!",
				"Um par de sapatos de ciclismo.",
				"Uma caixa de papelão vazia.",
				"Uma chave encontrada no Templo do Aquele que Vê.",
				"Uma chave encontrada numa caverna subterrânea vermelha.",
				"Uma chave encontrada numa caverna nas montanhas.")
		}
,
		cards: {
			dialogue: new Array(
				"Cartas",
				"cartas")
		}
,
		save: {
			dialogue: new Array(
				"Salvar",
				"Salvo!",
				"ERRO",
				"Salvar e ir\npara a título",
				"Ir para título",
				"Salvar e sair",
				"Sair do jogo",
				"Mortes:")
		}
,
		config: {
			dialogue: new Array(
				"Config",
				"Definir control",
				"Definir volume",
				"Salvar em\ncheckpoints:",
				"Ligado",
				"Desligado",
				"Mudar Resolução:",
				"Configurar UI",
				"Touch + D-Pad",
				"Somente D-Pad",
				"Apenas Touch",
				"Tipo de Movimento",
				"Resolução:",
				"Janela",
				"Multiplicado",
				"Esticado",
				"Escala:",
				"Idioma:",
				"ja",
				"en",
				"ko",
				"arraste os\nbotões\naté estar\n satisfeito.\n\nDepois, toque\no menu\npara continuar.\n\n",
				"Redimensionar\nJanela",
				"Configurar controle")
		}
,
		secrets: {
			dialogue: new Array(
				"Você está mandando brasa!",
				"Antiga propriedade do Mago das Bolhas.",
				"Se os gráficos ficarem estranhos, procure pela descrição oficial do Pakidex sobre algum Pakimon.",
				"esse coração não tem nome",
				"Por favor visite o mundo dos monstros eletrônicos.",
				"Uma estátua de um gato. Fofo, mas inútil.",
				"Aí meu deus!!!!",
				"Ah não!!!",
				"É preto.",
				"É vermelho.",
				"É verde.",
				"É azul.",
				"É branco.",
				":Selecionar",
				":Voltar")
		}
,
		swap: {
			dialogue: new Array(
				"Desculpe!",
				"A troca não funciona aqui.",
				"Young não tem forças para usar a troca aqui.")
		}
,
		keyblock: {
			dialogue: new Array(
				"Esta porta está trancada.")
		}
,
		treasure: {
			dialogue: new Array(
				"Alguma força estranha impede que este baú se abra.",
				"No cabo da vassoura está escrito:Pressione\"",
				"para varrer.\"",
				"Essa chave pode ser usada uma única vez para abrir uma barreira trancada.",
				"Um misterioso par de sapatos, nele está escrito uma única coisa\"Pressione",
				"\".",
				"As poucas palavras gravadas nesse artefato dizem: \"Equipe o acessório de AMPLIAÇÃO para fazer com que a vassoura solte poeira nociva para a esquerda e direita.\"",
				"As poucas palavras gravadas nesse artefato dizem: \"Equipe o acessório de EXTENÇÃO para fazer com que a vassoura solte poeira nociva para frente.\"",
				"As poucas palavras gravadas nesse artefato dizem: \"Olá, Young. Use esse aparelho de TROCA em dois objetos para trocá-los de posição. Ainda está longe do seu alcance poder usar isto em qualquer lugar, mas por hora irá lhe servir bem.\"",
				"VOCÊ ACHOU UM CORAÇÃO!!! Saúde aumentou em...zero.",
				"Ourudo:O que? Não está aqui? Aquele vendedor deve ter roubado!")
		}
,
		dust: {
			dialogue: new Array(
				"Sua vassoura está cheia de poeira! Ataque novamente para colocá-la.")
		}
,
		checkpoint: {
			dialogue: new Array(
				"Salvar jogo?\n Sim\n Não",
				"Quando estiver em um checkpoint, pressione",
				"para salvar e marcá-lo como ponto para continuar caso você morra.")
		}
,
		rock: {
			dialogue: new Array(
				"Há algo escrito nesta pedra:",
				"CÊ NÃO TEM AMIGOS")
		}
,
		door: {
			dialogue: new Array(
				"O portal não parece estar ativo.")
		}
,
		keyblockgate: {
			dialogue: new Array(
				"O portão permanece, imóvel. Ele não irá abrir até sentir quatro cartas...",
				"Sentindo a presença de quatro cartas, o portão decide abrir...",
				"O portão permanece teimosamente no lugar.",
				"O portão sente a presença de todas as cartas, e decide abrir.",
				"O portão sente a presença de um número suficiente de cartas, e decide abrir.",
				"Abriu!",
				"Permanece fechado.")
		}
,
		solidsprite: {
			dialogue: new Array(
				"A placa aponta para o leste mas as palavras estão muito desbotadas.",
				"A placa aponta para o oeste mas as palavras estão muito desbotadas.",
				"A as palavras desta placa estão muito desbotadas.")
		}
,
		mitra: {
			dialogue: new Array(
				"Ei, young!",
				"Esses sapatos de ciclismo são para mim? Poxa! Obrigado, Young! Eu estava querendo um desses para usar com o Wares. Aqui, Young, tome meus sapatos em troca. Eles tem molas que permitem você pular bem alto! Você pressiona",
				"para pular com eles!",
				"Oi Young! Notou algo de diferente? ^... ^... Ah, bem, eu comprei um novo par de sapatos de ciclismo! Eles encaixam perfeitamente nos pedáis do Wares. Já que não vou mais precisar dos meus sapatos antigos, quero que você os tenha, Young! Eles tem molas que permitem você pular bem alto! Você pressiona",
				"para pular com eles!",
				"Enfim, tome cuidado!",
				"Vá em frente, experimente-os! ...Eles não fedem TANTO assim.",
				"Maneiros, né?",
				"Uau, esses são os sapatos de ciclismo da loja do Finty? Você está dando eles para mim? Obrigada, Young, de verdade! Aqui, tome meus sapatos antigos--Acho que eles serão bem úteis para você. Há uma inscrição neles que diz: \"Pressione",
				"para pular\". Nunca entendi o significado, porque não há um\"",
				"\" em lugar nenhum neles...")
		}
,
		tradenpc: {
			dialogue: new Array(
				"Finty:Bem vindo, bem vindo, meu amigo Young! Meu nome é Prasandhoff--Finty Prasandhoff! Dê uma olhada pela minha loja e veja se algo lhe interessa.",
				"Finty:Eu ainda aprecio essa caixa!",
				"Finty:Ah, uma caixa! Muito obrigado! Agora eu posso carregar todo meu inventário para casa a noite e de volta para cá pela manhã! Como símbolo da minha gratidão, tome essa feiosa--Digo, bela edição de colecionador dessa carta^",
				"Espere...não está aqui! O que será que aconteceu? Bem, aqui, deixe-me aliviar seus ferimentos.",
				"Como símbolo da minha gratidão, tome esses estilosos sapatos de ciclismo!",
				"Bela manhã, não é, meu amigo? Uma bela manhã para compras! Como eu gostaria de ter uma caixa para carregar meu inventário comigo.",
				"Que pena, parece que você não condições de comprar esse item! Volte mais tarde, quando tiver mais grana!",
				"Finty:Ah, você é perspicaz! Você precisa de uma arma nova, não é? Mande seus inimigos para longe por apenas R$1113.73!",
				"Finty:Esse saco de dinheiro permitirá que você acumule mais dinheiro que você acha pela Terra. Ele será seu por meros R$1937.90!",
				"Finty>Ah ha ha, este sim é um item especial: sapatos de ciclismo para você ser veloz E estiloso! A venda por apenas R$668.23!",
				"Finty:Cansado de perder tempo varrendo seu quarto com uma simples vassoura? Erradique toda as partículas de poeira com este aspirador de pó com tecnologia de ponta! Por apenas RS$1670.60 ou por, fáceis, parcelas mensais de R$445.48!",
				"Obrigado!")
		}
,
		ending: {
			dialogue: new Array(
				"Anodyne\n-------\n\n\n\nCriado por\n\nMelos Han-Tani\n\ne\n\nMarina Kittaka\n\n-------------",
				"Criado de\n\nMarço, 2012\n\naté\n\nJaneiro, 2013",
				"DESIGN\n------\nAmbos",
				"PROGRAMAÇÃO\n-----------\nMelos, usando\nFlixel para\nActionscript 3.\n\n\n\nARTE\n---\nMarina\n",
				"MÚSICA/EFEITOS\n---------\nMelos, usando REAPER\ne algumas\nsoundfonts livres.\n\n\n\nDIÁLOGO\n--------------\nPrincipalmente Marina\n",
				"HISTÓRIA\n-----\nAmbos\nLocalização\nJaponesa:\nKakehashi Games",
				"Um grande obrigado\npara nossos testers\nque sofreram\npor você!\n--------------\n\nMarina, por sobreviver\natravés dos bugs\niniciais.\n\nEtan, pelo\nconstante suporte\ndesde o início, pelos\nmuitos bugs,\ndescobertos e por\nser o terceiro\na jogar a maioria/n do jogo.",
				"Olivia - valeu,\nmana!\n\nRunnan, Nick Reineke,\nEmmett, Poe, AD1337,\n Dennis, Andrew,\nAndrew MM\n Carl, Max, Amidos,\nLyndsey, Nathan\n",
				"Melos gostaria de\nagradecer a:\n\nMãe e Pai, pelo\nsuporte contínuo\nnessa empreitada.\n\nS\n\nMuitos TIGSourcers\ne outros devs\nconhecidos pelo\ncaminho!\n\nMarina, por tornar\nesse jogo possível,\ne por melhora-lo\nde formas incontáveis.",
				"Adobe, Adam Saltsman,\ndevs do FlashDevelop,\ndevs do REAPER,\ncriador do DAME,\nDesura, Gamersgate,\nIndieDB, TIGSource\n\n\nE meus outros\namigos\nque mostraram\nseu apoio.\n(Obrigado!)\n\nE por último, mas\nnão menos\nimportante,\nTina Chen,\namiga de longa\ndata, pelo suporte\ne por me apresentar\nao Marina.",
				"Marina gostaria de\nagradecer...\n\nColin Meloy, por\nexpandir\nmeu vocabulário\n\nTsugumo, por\n\"So You Want to\nBe a Pixel Artist?\"\n\nMinha família,\npelo apoio e comida.\n\nDaniel, por ser um\n\"indie game dev\"\ncomigo no passado.",
				"Mo, por acreditar\n em mim.\n\nTina, por me\napresentar ao Melos.\n\nMelos, por fazer\num jogo\ne confiar em mim\ncomo grande parte\ndo processo.",
				"ELENCO\n----\n\n\nGosma\n\n\nChato\n\n\nPei Pei\n\n\nEscudito\n\n\nVisionário",
				"Movedor\n\n\nLiga Desliga\n\n\nQuatro Tiros\n\n\nCortador\n\n\nRogue\n",
				"Cachorro\n\n\nSapo\n\n\nRodador\n\n\nPessoa\n\n\nParede\n\n",
				"Rato\n\n\nCara do Gás\n\n\nPeixinho-de-Prata\n\n\nCorrredor\n\n\nRolador\n\nVigia\n\n\n",
				"Empregada\n\n\nPlanta Explosiva\n\n\nGerente\n\n\n",
				"Leão\n\n\nContorcionista\n\n\nPilar de Fogo\n\n\nServos\nArthur\nJaviera",
				"Seguidor\n\n\nEduardo\n\n\nPescador\n\n\nCaminhante Vermelho\n\nHews",
				"Coelha\n\n\nIcky\n\n\nVendedor\n\nMiao Xiao Tuan Er\n\nRank\n\nOurudo",
				"Tórax\n\nJames\n\nCogumelo\n\nCrickson\n\nGolem\n\nSuburbanos",
				"Perseguidor\n\n\nEntidades\n\n\nCaras Espaciais\n\n\Reis Cubo",
				"Young\n\n\nMitra\n\n\nSage\n\n\nBriar",
				"E nós gostaríamos\nde agradecer a\nVOCÊ!\nPor jogar\nnosso jogo.\nEsperamos que\ntenha gostado.",
				"\n\n\n\n\n\n\n\n",
				"Agora você tem o\npoder de explorar\no mundo de young\nsem (quase) alguma\nlimitação, através\nda troca.")
		}
	}
};

public static var misc_state:Object =
{
	any: {
		controls: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		title: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		elevator: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gui: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		map: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		items: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		cards: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		save: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		config: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		secrets: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		swap: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		keyblock: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		treasure: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		dust: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		checkpoint: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		rock: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		door: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		keyblockgate: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		solidsprite: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		mitra: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		tradenpc: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		ending: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

}
}