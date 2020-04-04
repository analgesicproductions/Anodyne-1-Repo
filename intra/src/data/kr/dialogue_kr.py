### ENGLISH DIALOGUE ###

####################
### INSTRUCTIONS ###
####################
# 0. If you could comment out the english version when you translate that would be useful for me!
#
# 1. - Any line starting with "#" doesn\'t need to be translated
#
# 2. SPECIAL KEYWORDS THAT SHOULDN\'T BE TRANSLATED:
# Any line starting with: (where "..." is some other keyword , usually an NPC name or area name)
#
# does reset 
# LOOP 
# TOP
# npc ...
# area ...
# scene ...
# end scene 
# end npc 
# end area
# DONE
#
# 3. SPECIAL INSTRUCTIONS SYMBOLS 
# ----------------------------
# [SOMEKEY-C] means that this can change depending on what controls the user uses - it would be "C", "A", "ENTER", etc. Sometimes in the dialogue file I write
# Press
# [SOMEKEY-LEFT]
# set controls.
#
# And that implies that in-game, it will read "Press LEFT to set controls."
#
# 4. SPECIAL CHARACTERS IN DIALOGUE TO BE TRANSLATED
# -----------------------------------------------
# \" and \' are for escaping the quotation characters. You can leave them like that. 
#
# ^  Denotes the player will have to press the progress-dialogue-button again to continue the dialogue - you can leave it there (or move it around as needed in the translated sentence)
# \n denotes newline, you can leave it there.

##################
# BEGIN DIALOGUE #
##################

### 'test' NPC - In DEBUG
npc test
does reset
    area DEBUG
        scene scene_1
# Like music? Talk to that terminal!
음악을 좋아한다고? 터미널이랑 대화해봐!
# Like pain? Head on down south!
고통을 좋아한다고? 남쪽으로 가봐
        end scene
    end area
end npc

### 'arthur' - In CIRCUS
npc arthur
    area CIRCUS
        scene alone
# That acrobat is losing balance!  Where is the safety net?
저 곡예사는 균형을 잃고 있어!  안전망은 어디있는 거지?
...
        end scene
		
		scene holyshit
# WOOAH
우와!
		end scene
    end area
end npc

### 'javiera' - In CIRCUS
npc javiera
    area CIRCUS
        scene alone
# The lions are closing in on that juggler!
사자가 곡예사랑 가까워지고 있어!
...
        end scene
    end area
end npc

### 'briar' 

npc briar
	area GO
		scene before_fight
# Briar: I’m tired, Young.  I’m tired of all of these cycles.  I feel like I’m living the same dream, the same nightmare over and over again.
브라이어: 피곤하군, 영.  난 이럴 때가 피곤해.  마치 같은 악몽속에 다시, 또 다시 살고 있는 것 같아, 
# Briar: ...
브라이어: ...
# Briar: It’s not going to change, Young.  This is all we’ll ever be.
브라이어: 아무리 해도 바뀌지 않을거야, 영.  계속 그대로일 거라고.
		end scene
		
		scene after_fight
# Briar:  Goodbye, Young.
브라이어: 작별이네, 영.
		end scene
		
		scene final
# Briar: Dude, Young.
브라이어: 이봐, 영.
# Briar: Kick your feet.  Move your arms.  Jeez, you wouldn’t last a minute without me!
브라이어: 천천히 다리랑 손을 움직여봐. 이런, 나 없인 움직일 수도 없는 거야?!
# Briar: Well, come on, let’s go get a sandwich or something. 
브라이어: 좋아, 가자, 샌드위치인지 뭔지를 먹으로 가자고.
# Sage: You... you did adequately.  Until we meet again.
현자: 자네... 그 사이에 잘 해낸 것 같아 보이는군.
		end scene
	end area
end npc

### 'sage'
npc sage
    area BLANK
        scene intro
# Mysterious voice: Hello? ...Young?  ^HEY!  ... oh, you can hear me?  Good, now listen.  You are about to wake up.  You will use the arrow keys to move around.
의문의 목소리: 이봐? ...영?  ^이봐!!!  ... 오, 내 말이 들리나?  좋아, 내 말 잘 듣게.  우선 움직이는 법을 알려주겠네.  방향키를 사용해서 움직일 수 있네.
# Note, these next two lines should be assumed to have the keybinding between them when translated (hence the single quotes)
# You will press the \'
아마 \'
# \' key to interact with objects and people around you.
\' 버튼을 눌러서 앞에 있는 사물이나 사람들이랑 상호 작용을 할 수 있을 걸세.
# And you will press the \'
그리고 \'
# \' key to access the menu, which will provide you with information about yourself and your surroundings.  
\' 버튼을 눌러서 메뉴로 갈 수 있네, 메뉴에서 자네에 대한 정보와 환경을 볼 수 있을걸세.
        end scene
    end area
	
	area GO
	
	
		scene posthappy_sage
# Young...  I just wanted to fix everything for you.
영... 난 그냥 자넬 위해 모든 것을 되돌리고 싶네.
# I hope... I hope you can do better than me.
부디... 자네가 나보다 더 나을 거라고 믿네.
		end scene
		
		scene posthappy_mitra
# Good luck, Young.
행운을 빌어. 영.
# Sage is right, in a way.  I want everything to be nice and work out perfectly, and sometimes that makes me ignore reality.
현자의 말이 어느 정도는 맞아.  난 모든 것이 깔끔하고 완벽하게 해결됐으면 좋겠어, 그리고 난 나의 이러한 점 때문에 현실을 무시하게 되버리기도 해.
# I don’t know what you need to do to help The Briar.  I don’t understand how this world works or why everything seems so strange.  But I do want to be your friend, Young.
난 네가 브라이어를 돕기 위해 무엇을 할지 몰라.  난 어떻게 이 세상이 계속 앞을 향해서 나아 가는지, 아니면 왜 모든 것이 신비스럽고 이상한지 이해할 수 없어.  하지만 난 너의 친구가 되고 싶어, 영.
# You are fighting, Young.  You are trying to understand.  I hope you can work things out.
넌 싸우고 있어, 영.  넌 이해하려고 노력하고 있어.  난 네가 해낼 수 있기를 희망해.
		end scene
		scene one
TOP
# Sage: Young... this is my final warning... wait, who is that?
현자: 영... 이건 내 마지막 경고네... 기다려, 저 자는 누구지?
# Mitra: My name is Mitra, and this is my bike, Wares!
미트라: 내 이름은 미트라다. 그리고 이건 내 자전거, 이름은 상품이지!
# Sage: I didn’t ask the name of your bicycle, what are you doing here?  I don’t remember you.
현자: 난 네녀석의 자전거 이름을 묻지 않았다. 여기서 뭐 하는 건가?  처음보는 것 같은데.
# Mitra: I’m here to help my friend, Young..
미트라: 난 내 친구 영을 도우러 이곳에 왔지..
# Sage: Young doesn’t have friends.  Young doesn’t even have Briar.  And if you’re egging him on, then I want you out of my world!
현자: 영은 친구를 사귄 적이 없네.  브라이어랑 친구를 한 적은 더더욱 없네.  그리고 만약 자네가 영을 부추긴다면, 자넬 내 세계에서 내쫓겠네!
# Mitra: What do you mean?  Wares and I--
미트라: 뭐라고 지껄이는 거야?  상품이랑 나는--
# Sage: SHUT UP ABOUT YOUR STUPID BICYCLE!!! 
현자: 너의 좇같은 자전거에 관한 이야기는 그만 짓껄여!!
		end scene 
		
		scene hit
TOP
# Sage: ...
현자: ...
#Mitra: Young!  Are you okay?  That was a beautiful thing you just did... You go on and finish this final punk-ass area!  We know you can do it!
미트라: 영!  괜찮아?  고맙다, 상품아... 자, 가서 이 빌어먹을 곳을 끝내버리자고!  넌 할 수 있어!
# Mitra: Wares!!! 
미트라: 상품!!!
# Mitra: Wares... 
미트라: 상품...
# Mitra: Look, mysterious hooded character, I don’t know who you think you are, but why don’t you just leave us alone?
미트라: 이봐, 정체불명의 후드모자 양반, 당신이 누군진 모르겠지만, 왜 우리를 내버려두지 않는거야?
# Sage: You think you’re Young’s friend because you’ll lie to him and tell him that deep down he’s just perfect and everything will work out.  Well, if that’s what you want, FINE.  Get out of my face, Young.
현자: 자넨 영에게 뭐든지 완벽하고 잘 한다고 거짓말 한 주제에 자신이 영의 친구라고 생각하고 있나보군.  뭐, 그것이 자네가 원하는 거라면, 좋네.  내 눈앞에서 사라지게, 영.
# Sage: Go talk to your \"friend\".
현자: 네 \"친구\" 하고 떠들어 봐.
# Mitra: We're just doing the best we can...
미트라: 우린 그냥 우리가 할 수 있는 최선의 방법을 선택한 거야...
		end scene
	end area
	area NEXUS
	
	
		scene enter_nexus
TOP
# Cloaked Man: Well, it’s about time.  Er...^I mean...^ Greetings, Young!  I am Sage, the Village Elder.  You have been summoned here because The Darkness has spread across The Land.  The Darkness seeks The Legendary Briar, to use The Briar’s power for evil.  You must reach it first. You must protect The Briar.	
망토른 두른 남자: 좋아, 인사할 시간이군.  음...^내 말은...^ 반갑네, 영!  나는 현자라고 하네. 마을의 장로지.  어둠이 대륙으로 손을 뻗어가고 있어서 자넬 이곳으로 소환했네.  어둠이 전설의 브라이어를 찾고 있네. 브라이어들의 힘을 악에게 쓰기 위해서지.  자넨 반드시 어둠보다 먼저 브라이어들에게로 가야하네.	
# Enter the active portal on your left to begin your quest.
자네의 임무를 시작하기 위해 왼쪽에 있는 차원문으로 들어가게.
# *Sigh* it doesn’t bode well that you’re still dallying about here.  Enter the portal to begin your quest.  The Briar and, by extension, the world are in dire need!
*한숨* 아직도 꾸물거리는 건가?  차원문으로 들어가서 임무를 시작하게.  브라이어와, 더 나아가 세계는 매우 도움이 필요하네!
LOOP
# Just go in the damn door!
그냥 빨리 저 망할 문에 가라고!
		end scene
		
	# After entering STREET for the first time
		scene after_ent_str
# Why are you still here?
아직도 여기서 뭐하는 건가?
		end scene
	# After finishing BEDROOM
		scene after_bed
# Continue on, Young. That key you have found, there may be others like it - seek them out.
계속 앞으로 나아가게나, 영. 자네가 찾은 열쇠, 그것과 비슷한 게 다른 장소에 있을 수도 있네.
# Travel to the far reaches of The Land, Young. This is the only way to stop The Darkness.
이 대륙의 머나먼 곳까지 여행하게, 영. 어둠을 멈추려면 이 방법만이 유일한 길이니까.
		end scene
	# After finishing first 3 dungeons
		scene before_windmill
# Take those three keys, Young, and unlock the way to the deeper realms of The Land.
이 세개의 열쇠를 가지고 가게, 영, 그리고 대륙의 깊은 영역으로 가는 길을 열게.
		end scene
#After windmill, but disappears after Sage fight
		scene after_windmill
# You have done what I have asked, Young, though there is still much to be done.  Perhaps if you explore the deeper realms of The Land you will come to greater realizations... perhaps you'll be worth anything to Briar.
부탁한 일을 잘 마무리했군, 영, 아직 대륙의 깊은 영역에서 할 일들이 남아 있지만.  자넨 아마 대륙의 깊은 영역을 탐험하면서 큰 깨달음을 얻을 걸세... 어쩌면 자네가 브라이어에게 가치가 있게 될 수도 있지.
		end scene
		
		scene all_card_first
# Good work, Young. You have found all of the cards in one area of The Land, and as a result, a gem has appeared on top of the area's portal.
잘했네, 영. 이곳의 모든 카드를 찾아냈군, 그 증거로, 보석이 이 지역의 차원문 위에 나타났네.
		end scene
	end area
	
	area OVERWORLD
		scene bedroom_entrance
# Sage: Soon your skills will be put to the test, Young.  In order to make it through this temple alive, you will need both strength and intellect.  And I assume that by this point you have found a weapon?
현자: 곧 자네의 능력을 시험해 봐야 할 거네. 영.  이 사원에서 살아남기 위해서는 힘과 지성이 모두 필요하네.  혹시 쓸만한 무기를 찾았나?
# Young swipes a few times
# Wha-??  ... I-I mean...  Yes of course... a broom!  Er... just as was foretold in The Legend...
뭐-??  ... 내-내 말은...  그래 물론이지... 빗자루!  어... 전설에 예언된 그대로...
# *grumble grumble* ... of all the incompetent--Hey!  What are you still standing here for?
*툴툴거리며* ... 이 무능한--자네!  왜 아직도 거기에 서 있는 건가?
LOOP
# Keep your wits about you, Young.
정신 바짝 차리게, 영
		end scene
	end area
	
	area BEDROOM
		scene after_boss
# Sage fades into room.	
# Sage: At this point, you are still weak. If you hope to protect The Briar from The Darkness, you must face your fears.  The card you will find in this chest, and others like it, are symbols of your growth, so acquiring them is absolutely vital to your quest.
현자: 아직도 자넨 여전히 약하군. 자네가 어둠한테서 브라이어를 보호하고 싶다면, 자넨 자네의 두려움을 극복해야만 하네.  저기 있는 상자에서 카드를 발견할 수 있을걸세, 카드는 자네의 성장을 상징하지, 그러니 카드를 모으는 것은 임무를 수행하는 데 매우 중요하네.
# That key will also play an important role in your quest. You must seek out other keys, as well.  Select the map on the menu screen to teleport back to the temple's entrance, and continue your heroic quest.
열쇠 역시 자네의 임무에 중요한 역할을 하지. 자넨 반드시 문을 열기 위한 여러 열쇠를 찾아야만 하네.  메뉴화면으로 간 다음 맵을 선택해서 사원의 입구로 돌아가기 위해 텔레포트하게나, 그리고 자네의 영웅적인 임무를 계속하게나.
# Travel East and South through the temple grounds... you will find a use for that key.
사원의 정원을 통해 남쪽 또는 북쪽으로 여행을 할 수 있네... 열쇠는 어딘가에서 찾을 수 있을걸세.
LOOP
# What, do you want a piggy back ride to the gate or something??
뭔가, 내가 자네를 목마 태워 관문까지 데려다 주길 바라는 건가??
		end scene
	end area
	
	area TERMINAL
		scene before_fight
# Sage: Why won’t you listen to me?!  If you rush into this like an idiot, you’ll only endanger The Briar, The Land, and everything I’ve worked for!  I’m sorry Young, but if you won’t listen to me, then I’ll have to convince you another way...
현자: 왜 말을 듣지 않는 건가?!  멍청이처럼 돌진했다간 브라이어와 대륙을 위험에 빠뜨리게 될걸세. 이때까지 했던 일들이 헛수고가 되어버리는...! 미안하네, 영. 하지만 자네가 내 말을 듣지 않는다면, 다른 방법으로 내말을 듣게 하는 수밖에 없네..
		end scene
		scene after_fight
# Sage: Young...  This is not how I mean things to be... I meant for you to become a better person.  I meant for you to be able to help The Briar.  But all of this is just a silly game...  I can’t stop you from reaching The Briar.  Just remember what I said when it all goes to hell.
현자: 영...  이럴려던 게 아니었네... 단지 자네가 브라이어들을 도울 수 있을 정도까지 자넬 성장시키기 위해서였지.  하지만 이건 멍청한 놀이에 불가했어...  난 자네가 브라이어에게 가는 걸 막을 수 없네.  그냥 모두가 지옥에 갈 때 내가 했던 말을 기억하게나.
		end scene
		scene entrance
# Sage: Hello, Young.  When you have become a stronger and wiser individual, this path will lead you to The Briar.
현자: 반갑네, 영.  자네가 더욱 강해지고 현명해질 때, 이 길은 자넬 브라이어에게로 인도할 걸세.
# Sage: You’re not ready Young, first you must face more trials in The Land.
현자: 하지만 영, 자넨 아직 준비되지 않았어. 우선 이 대륙에서 더 많은 시련을 극복해야만 하네.
# Sage: You have made progress, Young, but you must collect at least 36 cards to pass this gate.
현자: 많이 성장했군, 영, 하지만 이 관문을 통과하기 위해서는 반드시 36장의 카드를 모아야만 하네.
		end scene
# non idlnig stuff
		scene etc
# Sage: Oh... uh... you have at least 36 cards?  But I am not certain that you are ready for the true test.  In fact, look, we were reading this gate wrong, you actually need...\n...\n........\n92 cards to pass this gate, not 36!
현자: 오... 음... 36장의 카드를 가지고 온건가?  하지만 아직 난 자네가 진정한 시련과 맞설 때가 되지 않았다고 생각하네.  사실, 이걸 보게, 우리가 잘못 읽고 있었네, 진짜로 필요한 카드의 양은...\n...\n........\n36장이 아닌 92장이라고 써져있네!
# Sage: Young, don’t go there, you’re not ready yet!  Think of The Briar!  The Land!  All of this will be for nothing if you are not ready! 
현자: 영, 자넨 아직 준비되지 않았네!  이 대륙과 브라이어를 생각해보게!  만약 자네가 준비되지 않았다면 이 모든 것들은 물거품이 되어버릴걸세! 
		end scene
	end area
	
	
	
	area REDCAVE
		scene one
TOP
# Sage: Excellent work, Young.  You had to conquer not only this monster but also your own fears to prevail!!!
현자: 훌륭하군, 영.  자넨 괴물들 뿐만 아니라 자신의 두려움도 이겨냈군!!!
# Sage: Of course, you still have a long way to go.  Have you been exploring The Land?
현자: 물론, 아직 가야할 길이 머네.  대륙을 전부 탐험해봤나?
		end scene
	end area
	
	area CROWD
		scene one
# Sage: Well done, Young. However, there are still trials to face. Do not let your guard down.
현자: 훌륭하군, 영. 하지만, 아직도 시련이 보이는군. 긴장을 풀지 말게나.
# Sage: Have you found all of the keys yet, Young? If not, go to the beach.
현자: 아직도 모든 열쇠를 찾지 못한 건가, 영? 아직 다 모으지 못했다면, 바닷가로 가보게나.
		end scene
	end area
	
	

end npc

npc cliff_dog
	area CLIFF
		scene top_left
# I'm not like the others! *woof* I won't harm you...
나는 다른 놈들과는 달라! *멍멍* 당신을 해치지 않을게...
# It is a quiet existence up here.
난 조용함과 평화로운 걸 좋아한다고.
# You smell like swiss chard.
당신의 냄새가 근대같은데.
LOOP
# *woof*
*멍멍*
		end scene
	end area
end npc

npc happy_npc
	area HAPPY
		scene beautiful
# You did it, Young!  You defeated The Darkness!  Look at this place!  It’s beautiful!
해냈군, 영!  마침내 어둠을 막아냈어!  여길 봐!  정말로 아름다워!
# So beautiful...
너무나 아름다워...
		end scene
		
		scene dump
# Oh thank god you’re here!  I was worried you’d get stuck in that snowy dump... It’s fucking depressing over there!  Ha!
오 다행이야! 무사했구나! 그 눈더미에 덮혀서 꼼짝못하고 있을거라고 생각했어... 만약 그랬다면 존나 우울했겠지!  하!
# Hahaha. Hahahahaha. HAHAHAHAHAHAHA!
하하하. 하하하하하. 하하하하하하하!
		end scene
		
		scene drink
# Hey sexy, I’ll buy you a drink!
이봐 거기, 귀여운데? 한잔 할래? 내가 쏠게!
# Have another drink, you little shit!  Hahaha!
한잔 더 할래? 거지같은 새끼야!  하하하!
		end scene
		
		scene hot
# Fuck, it’s hot here...  I’m so hot... and sweatyyy...
씨발, 여기 존나 뜨겁군...  나도 뜨겁고... 땀범벅이 되버렸네...
# Damn, working out makes me horny!
젠장, 운동은 날 불끈불끈하게 하지!!
		end scene
		
		scene gold
# Did you know this place is made of gold?  Like actual gold!  We could run away together and live off this brick right here!  Wahahaha!
이 세계가 금으로 만들어진 곳이라는 걸 알아?  진짜 금 말이야!  둘이서 도망쳐도 이 벽돌로 평생을 놀고먹고 할 수 있는 거지! 와하하하하!
# Seriously, why are you just standing there?  Help me jack this brick!
나 진지하다고, 왜 아직도 거기 서있어?  어서 벽돌 나르는 것을 도와줘!
		end scene
		
		scene briar
# ???: Young... You finally maDe IT!  YuO SsavED ME!  nOE EvERtyhinG WILL bE OKYA AGaIN!!!!!
???: 영... 드디어 해냈구우나!  가너 나를 구줬해어!  이제 든모 일이 시다 잘 풀거릴야!!!!!
		end scene
	end area
end npc

### 'mitra'
npc mitra
	area OVERWORLD
		scene initial_overworld
# HEADS UP!
조심해!
#Mitra swerves to avoid you and crashes
# Sorry about that... I was going way too fast.  Oh, I’ve never seen you before!  Are you a fellow traveller? ... Huh?  You want to protect the Briar from the Evil Darkness?  ...  ^Well... I have no clue what you’re talking about, but sounds cool, I guess!
아 미안해... 너무 흥분했었나 봐.  오, 처음 보는 얼굴인데!  넌 여행자야? ... 뭐?  악한 어둠에게 브라이어를 지키겠다고?  ...  ^음... 네가 무슨 말을 하는지 잘 모르겠지만, 왠지 멋진데!		
# I’ve just been out and about, peddling my wares.... What?  No, I’m not a salesman.  Wares is the name of my bicycle!  
방금 막 나와서, 상품을 좀 타려고 했는데.... 뭐?  아니, 난 잡상인이 아니라고.  상품은 내 자전거 이름이야!  
#Plays if you talk 3 times, or if you leave the screen
# Well, maybe we’ll run into each other again sometime.  I’ll let you know if I hear anything about that Briar.  
분명히 다시 만나게 될 거야,  혹시 내가 브라이어에 관한 정보를 듣게 되면 너한테 알려줄게.  
#Mitra bikes away
		end scene
	end area
	area BLUE
		scene one
# HEADS UP!  All right Wares, let’s do this!
꼼작 마!  좋아 상품아, 시작하자!
# Annnd presto!
쨔자안!
# Keep going, Young, we’ve got your back!
계속 가라고, 영. 우린 네 뒤에 있을게!
		end scene
	end area
	
	area FIELDS
		scene init
# Remember me?  I forgot to introduce myself the last time, I only introduced my bicycle, Wares.  My name is Mitra.
날 기억해?  저번에 자기소개하는 걸 까먹었었지, 내 자전거 상품만 소개 했었어.  그래, 내 이름은 미트라야.
# Remember me?  I forgot to introduce myself the last time, I’m Mitra, and this fine young bicycle is named Wares.
날 기억해?  저번에 자기소개하는 걸 까먹었었지, 나는 미트라야, 그리고 이 크고 아름다운 자전거 이름은 상품이고!
LOOP
# Mitra: So how have you been, Young?  ...what?  How did I know your name?  You think it’s weird, eh?  Well, I saw it on the back of your hoodie.  
미트라: 그래서, 어떻게 지냈어 영?  ...잠시만?  내가 어떻게 네 이름을 알지?  이상하다고 생각하지 않아, 응?  뭐, 사실 네 옷 뒤에 적힌 걸 봤었어.  
# Mitra: See you around, Young!
미트라: 다음에 또 봐, 영!
		end scene
		scene quest_event
# Mitra: Hey, I just remembered - someone said they were trying to find something earlier. I wasn't sure what they were talking about, so they said they were going to the mountains - ran off in a hurry.
미트라: 이봐, 기억났어 - 누군가 무엇을 빨리 찾는 중이라고 했어. 그 사람들이 무엇에 대해 말 했는지 확신하진 못 하겠지만, 그사람들이 산으로 간다는 말을 하고 - 서둘러 도망치듯 가던데.
		end scene
		
# Hints for the game - not cards
		scene game_hints
# The ordering matters in these (indexed in-game, so just keep them numbered)
# 0 ignore this
# Nothing.
아무것도 아니다.
# 1. Beach hint (no dungeons finshed)
# Oh, you're lost? Have you looked around the beach? Maybe someone there can help you out. It looks like that key of yours comes in a set. Maybe you need to find more?
오, 포기하려는 거야? 바닷가는 둘러봤어? 혹시 그곳에 있는 누군가가 널 도와줄 수도 있지 않을까? 어쩌면 열쇠를 사용할 장소를 발견할 수도 있고 다른 열쇠가 있지도 있지 않을까?
# 2. Forest hint (no dungeons finished)
# Oh, you're lost? Have you looked in the forest to the east?  That key you have - it looks like it comes in a set. Maybe you need to find others?
오, 포기하려는 거야? 동쪽의 숲은 둘러봤어?  어쩌면 열쇠를 - 사용할 장소를 발견할 수도 있고 다른 열쇠가 있지도 있지 않을까?
# 3. Windmill hint
# Look at all of those keys! I think I saw some gates to the southeast. Maybe you could use them there?
열쇠를 찾았네! 아까 남동쪽으로 가는 잠겨진 관문을 본 것 같아. 그 열쇠로 열 수 있지 않을까?
# 4. Generic hint to go past statues
# Hey, I saw that you turned on the wind turbine!  Do you know if it had any effect on The Land?
이봐, 풍력 터빈이 켜져 있는 걸 봤는데, 바람이 엄청 세던데!  이 대륙에 어떤 영향이 있지 않을까?
# 5. finished 6 bosses, all 36...
# Hey Young.  Wow!  You've really been racking up those cards!  Have you figured out what they're for yet?  Seems like you could really cash in with all those!
이봐 영,  오!  카드를 잔뜩 모았네!  근데 이건 뭐에 쓰는 걸까?  팔면 꽤 돈이 될 것 같은데.
# 6. hints for go things
# What is that new broom attachment you have?  It lets you alter the structure of the world...?  Honestly, that is really scary Young.  I'm glad it doesn't seem to work anywhere, perhaps just in the deepest, strangest recesses of the Land
빗자루에 붙어있는 게 뭐야?  그걸로 네가 세계의 구조를 변경할 수 있어...?  솔직히, 그건 정말 무서워 영.  그 이상한 게 아무 데서나 작동하지 않는다는 게 정말 다행이네, 근데 깊은 영역 말고도 딴데서도 쓸 수 있지 않을까?
# 7.  crowd finished but not redcave
# How are my jump shoes working for you?  Pretty nifty, eh?  I’m loving my new bike shoes.  They make Wares and I an even better team!
새 점프신발은 어때?  꽤 멋지지 않아, 응?  난 내 새 자전거용 신발이 마음에 들어.  이 신발을 만든 회사가 내 상품을 만들었고 나랑 상품은 더 찰떡궁합이 될 거야!
#8. redcave finished but not crowd
# Cool, Young, you found another key!  Wares likes the color!  Have you found a place to use them yet?
멋진데, 영, 또 열쇠를 찾아냈구나!  상품도 그 색이 좋다고 하네!  근데 아직 그 열쇠에 맞는 입구는 찾지 못한거야?
		end scene
# Hints for the cards. Play after the 6 dungeons are finished.		
		scene card_hints
# Mitra: Hey Young, looking for a card?\nHave you checked around the area of the Seeing One's temple?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n관측자의 사원 근처는 둘러봤어?
# Mitra: Hey Young, looking for a card?\nI heard there's a maze around the back exit of the Seeing One's temple.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n그러고보니, 관측자의 사원의 뒤쪽 출구에 미로가 있다고 들은 적이 있어.
# Mitra: Hey Young, looking for a card?\nYou might find something near the Seeing One's lair.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n관측자의 은신처 근처에서 뭔가를 찾을 수 있을지도 몰라.
# Mitra: Hey Young, looking for a card?\nThere was a room filled with enemies in the Seeing One's temple, right?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n관측자의 사원에 있는 적들이 가득 찬 방이 있었는데, 그곳에 있지 않을까?
# Mitra: Hey Young, looking for a card?\nHave you looked all over the Seeing One's temple?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n관측자의 사원은 전부 둘러봤어?
# Mitra: Hey Young, looking for a card?\nTry looking in the vestigial area near the back exit of the Seeing One's lair.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n관측자의 은신처 근처의 아직 가보지 못한 구역들을 뒤져봐.
# Mitra: Hey Young, looking for a card?\nMaybe your neighbor knows something about it.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n너의 이웃이 알고 있을지도?
# Mitra: Hey Young, looking for a card?\nI know the guy in your apartment was hiding something...
미트라: 이봐 영, 카드를 찾고 있는 거야?\n네 아파트에 살고 있는 사람이 뭔가를 숨기는 것 같던데...
# Mitra: Hey Young, looking for a card?\nSomewhere near the entrance of your apartment...look around there!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n네 아파트 입구 주변... 거기에 있을 지도?
# Mitra: Hey Young, looking for a card?\nHave you looked *everywhere* in your apartment?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n정말 네 아파트에 있는 *모든 곳*을 다 둘러봤어?
# Mitra: Hey Young, looking for a card?\nJust south of here is an island! I haven't gone there, but you should check it out.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n여기에서 바로 남쪽으로 가면 섬이 있어! 난 가본적 없지만, 한 번 가서 찾아보는 게 어때?
# Mitra: Hey Young, looking for a card?\nThere's a lot of stuff to be found if you follow the rivers. Look around!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n강가에는 여러 물건들이 있어. 잘 찾아보는게 어때?
# Mitra: Hey Young, looking for a card?\nI know someone left a card near the windmill.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n누가 풍차 근처에 카드를 두고 간 것 같은데.
# Mitra: Hey Young, looking for a card?\nLook around the rivers in the forest...
미트라: 이봐 영, 카드를 찾고 있는 거야?\n숲에 있는 강 주변을 둘러봐...
# Mitra: Hey Young, looking for a card?\nTry poking around the base of the mountains.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n산기슭 주변을 둘러보지그래?
# Mitra: Hey Young, looking for a card?\nTry going to the summit of the mountains.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n산의 정상에 뭔가 있을 것 같지 않아?
# Mitra: Hey Young, looking for a card?\nThe far end of the beach may hold something.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n바닷가의 끝에 무언가 있을지도?
# Mitra: Hey Young, looking for a card?\nTake a walk in the crimson woods.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n진홍의 숲을 산책해 보는 건 어때?
# Mitra: Hey Young, looking for a card?\nThere were a lot of locked doors in one of those red caves, right? 
미트라: 이봐 영, 카드를 찾고 있는 거야?\n붉은 동굴 중 하나가 잠겨진 문들이 많았었어, 가보는 게 어때?
# Mitra: Hey Young, looking for a card?\nTry looking around the northern red cave - follow the river to its end!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n북쪽에 있는 붉은 동굴은 확인해 봤어? 강을 따라가면서 찾아봐!
# Mitra: Hey Young, looking for a card?\nGo to the northern red cave, check out the source of the river!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n북쪽에 있는 붉은 동굴로 가서, 강의 원류로 거슬러 올라가 봐!
# Mitra: Hey Young, looking for a card?\nHmm...did you look all over that dark labyrinth?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n흠...어두운 미로는 다 뒤져봤어?
# Mitra: Hey Young, looking for a card?\nI remember there was a pretty grim looking path of flamethrowers somewhere. Something's gotta be at the end of it!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n그러고 보니 불이 뿜어져 나오던 길 있었잖아? 그 안쪽이나 주변에 뭔가 있을 것 같지 않아?
# Mitra: Hey Young, looking for a card?\nThose circus folks have got to be hiding something. Did you look everywhere?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n서커스 단원들이 뭔가를 숨기는 것 같아 보이던데, 그 주변은 찾아 봤어?
# Mitra: Hey Young, looking for a card?\nHave you looked around the area on the perimeter of that couple's large pit?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n한 커플이 떨어진 구멍 기억나? 그 근처는 둘러봤어?
# Mitra: Hey Young, looking for a card?\nThere's this couple that like to hang around a pit. They must be hiding something.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n구멍 근처에서 뭔가를 하던 커플이 무언가를 숨기고 있는 것 같던데.
# Mitra: Hey Young, looking for a card?\nSometimes there are things hidden across chasms - especially in mountain caves!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n깊은 계곡이라던지 어딘가에 뭔가 있을 것 같지않아? - 특히 산의 동굴에 뭔가 있을 것 같아!
# Mitra: Hey Young, looking for a card?\nHave you scoured the highest parts of the mountain cave?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n산에 있는 동굴의 꼭대기는 가봤어?
# Mitra: Hey Young, looking for a card?\nIs there anything in the depths of that mountain cave?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n그 산에 있던 동굴 안쪽에는 가봤어?
# Mitra: Hey Young, looking for a card?\nThat colorful cube in that weird place - it has probably got something!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n아마 그곳에 무언가가 있을거야! - 그 이상한 곳에 있던 컬러풀한 큐브라던가,
# Mitra: Hey Young, looking for a card?\nHave you talked to that grayscale cube in that wild-lookin' area? Maybe it knows something.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n그 수수께기 공간에 있는 검은 큐브랑을 대화해봤어? 그 큐브라면 뭔가를 알지 않을까?
# Mitra: Hey Young, looking for a card?\nThe top floor of that hotel is a little run down, but it's gotta have something!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n그 호텔의 가장 위층은 고급스러워 보이진 않았어, 하지만 거긴 무언가가 있을거야!
# Mitra: Hey Young, looking for a card?\nDid you walk into all of the rooms on the 3rd floor of the hotel?
미트라: 이봐 영, 카드를 찾고 있는 거야?\n호텔 3층에 있는 방은 다 찾아봤어?
# Mitra: Hey Young, looking for a card?\nI bet someone left something lying around the 2nd floor of the hotel.
미트라: 이봐 영, 카드를 찾고 있는 거야?\n호텔 2층에 누군가가 두고간 게 있던데.
# Mitra: Hey Young, looking for a card?\nThe owner of the hotel might have left something for you! 
미트라: 이봐 영, 카드를 찾고 있는 거야?\n호텔의 오너가 널 위해 뭔가를 두고 갔을 거야!
# Mitra: Hey Young, looking for a card?\nThose broken bridges to the northwest...look around there!
미트라: 이봐 영, 카드를 찾고 있는 거야?\n북동쪽에 있는 부서진 다리... 거기가 수상하지 않아?
# and a bonus one if for some reason you make it this far without finding any...
# ...What? You haven't found *any* cards? Man, Young, that's crazy! Sometimes in life you just need to be adventurous, open a few boxes, you know? 
...뭐? *한 장도* 찾지 못했어? 이봐, 영, 그건 미친 짓이라고! 가끔은 살면서 모험가가 될 필요도 있다고, 지나가다가 보이는 상자들을 열어봐, 알겠어? 
		end scene
		
#General random stuff 
		scene general_banter
# Did you find that guy who was looking for something in the mountains?
산에서 뭔가를 찾고 있는 것같아 보이던 남자는 만나봤어?
# Do you know what my bike’s surname is?  ...Waldo!  Get it?  Wares Waldo!  ...Just kidding, bicycles don’t have surnames.
내 자전거의 성이 뭔지 알아?  ...왈도!  힘세고 강한 성이지?  상품 왈도!  ...농담이야, 자전거는 성을 가질 수 없어.
# Do you think I should get a U-Lock?  I’d hate to tie up Wares like that, but you do hear a lot about stolen bikes these days...
혹시 자전거 자물쇠를 파는 곳을 알아?  상품을 묶는 건 싫지만 요즘 자전거 도난이 늘고 있다고 해서 말이야...
# So what is The Briar?  Some sort of ancient artifact from a lost culture?
그래서 브라이어는 뭐야?  잃어버린 문명속의 고대유물 같은 거야?
# I wonder why I haven't heard anything about The Darkness coming.  I guess most people in the land are just caught up in their own daily struggles.
난 왜 내가 어둠이 다가오고 있다는 사실을 전혀 몰랐는지 궁금해.  아마도 대륙에 사는 대부분의 사람들이 자신들의 일상과의 투쟁에 사로잡혀 있어서가 아닐까?
# Hey Young, I just wanted to tell you... your hair is awesome.
이봐 영, 이 말을 하고 싶었는데... 너 머리스타일 개쩐다.
		end scene
		
	end area
end npc

### Statue (wise crackin' statue) 
npc statue
	area NEXUS
		scene enter_nexus
# Statue: The Village Elder in name only, for he is neither.		
동상: 마을의 장로라는건 이름뿐이고, 마을따윈 없고 장로도 아니다.		
		end scene
	end area
	
	area OVERWORLD
		scene bedroom_entrance
# Statue: I’ve seen a broom in a legend... it was on the map of a janitor closet.		
동상: 전설의 빗자루가 있는 위치...  그건 지도에 표시된 청소부의 옷장에 있다.		
		end scene
	end area
	
	area BEDROOM
		scene after_boss
# Statue: Acquiring cards is vital to your quest.  Acquiring cards is also vital for other quests, such as earning credit or purchasing alcoholic beverages.		
동상: 카드를 획득하는 것은 임무를 진행하는 데 아주 중요하다.  물론 다른 임무를 할 때도 중요하고, 예를 들자면 돈을 벌거나 술을 사는 것?		
		end scene
	end area
	area REDCAVE
		scene one
# Statue: Excellent work, Sage.  You had to conquer not only your temperament but also your own self-respect to deliver such a cheesy line!!!
동상: 현자는 훌륭한 자이다.  짜증내지 않고 자기 도취도 하지 않고 제대로 상용구 같은 말을 하니까!!!
		end scene
	end area
	area TERMINAL
		scene one
# When you have become a more stressed and apathetic individual, this path will lead you to the Breyers.  Comfort by the pint, loser!  
네가 더 스트레스를 받고 냉담해 졌을 때, 이 길은 널 브라이어들에게로 이끌거야.   위로의 메세지를 파인트가, 이 패배자야! 
		end scene
	end area
end npc

### sadbro (outside of bedroom)
npc sadbro
	area OVERWORLD
		scene initial_forced
# This line must be played once before anything else can
# Edward: Once a man came and installed a mirror in our bathroom.  I was afraid that there was a hidden camera inside of it.  I scoured every inch of the wooden frame, spraying Merphi’s Oil Soap into the cracks, thinking I might short-circuit the wires.  Of course, I never found anything.
에드워드: 저번에 화장실에 거울을 설치하려고 사람을 부른 적이 있었어.  거기에 카메라를 숨겨놔서 들킬까봐 무서웠지.  난 모든 나무틀 사이 사이에 마피 오일 비누칠을 해서 틈새를 막고, 전선을 합선시킬까 생각도 했었지.  하지만 결국, 아무것도 발견되지 못했어.
LOOP
# Edward: This temple is dedicated to The Seeing One.  I don’t know why I came here, and I’m too afraid to go inside.			
에드워드: 이 사원은 관측자를 모시는 사원이야.  내가 여기에 왜 온 건지 모르겠지만, 안에 들어가는 게 무서워.			
		end scene
		
		scene bedroom_not_done
# Edward: Having trouble?  Well I’d imagine so.  All you have is a broom, and all brooms can do is move dirt.		
에드워드: 문제라도 있어?  그런 것 같아 보이는데,  네가 가지고 있는 빗자루, 그리고 전 세계에 있는 모든 빗자루는 먼지를 쓸 수 있어. 알겠어?		
		end scene
		
		scene bedroom_done
# Edward: You say you defeated the Seeing One?  Ha.  Don’t you get that it doesn’t work that way?  You’re just spraying oil soap in the cracks.		
에드워드: 관측자를 막아냈다고?  하.  헛소리하지 마, 넌 그냥 틈새에 오일 비누칠을 하고 있을 뿐이잖아.
		end scene
		
	end area
end npc

# sun_guy (Bedroom boss)
npc sun_guy
	area BEDROOM
		scene before_fight
# Oh, isn’t it cute?  Precious little Young, playing the hero.  But I have witnessed every step you have taken in "The Land", and let me tell you, Young, not everyone here is as honest as me.  Be careful who you trust!
오,영.  사랑스럽고 귀여운 영웅놀이를 하고 있네.  하지만 난 네가 \"대륙\"에서 한 모든 짓을 목격했지, 말해볼까? 영,여기있는 모든 사람이 나처럼 정직하지 않다고.  부디 너가 신뢰하고 있는 사람을 조심해!
		end scene
		scene after_fight
# I will be with you, Young, whenever you are alone.  And remember my advice on your little "adventure".		
네가 혼자일 때마다 난 네 옆에 있을 거야, 영.  그리고 반드시 내 충고를 너의 작은 \"모험\"을 하면서 잊지 마.		
		end scene
	end area
end npc

# rock (Rock with words)
npc rock

	area BEDROOM
		scene one
# Rock: Peripheral vision is the hive of demons.	
바위: 이곳에서 시력이 감소된 이유는 악마의 저주 때문입니다.	
		end scene
		scene two
# Rock: To-do: Construct method of transportation to Nexus. Progress: Halted - Seeing One will not give the required funds to make the venture possible. We will have to revert to the original method of the inexplicable door portal. 
바위: 해야 할 일: 연결체에 이동 수단을 만들어야 함. 지금 상태: 중단 - 관측자에게 예산을 얻지 못 할 것 같음. 그 수수께끼의 차원문을 사용해야 함.
		end scene
		scene three
# Rock: I'm trapped here all by myself. Work is steady on this tunnel, and at least I can see a little bit of progress every day.
바위: 실수로 이곳에 갇혀버렸습니다. 이 굴에서 항상 무슨 일들이 일어나고 있고, 약간의 변화들을 매일 조금씩 볼 수 있어요.
		end scene
	end area
	
	area BLUE
		scene one
# This wheel is used to lift the dam.
댐을 여는 손잡이다.
		end scene
	end area
	area CIRCUS

		scene one
# June 24th, 1957: Trapeze swing breaks.  Alice Rutgers is flung into the ground, resulting in two fractured shins.
1957년 6월 24일: 공중 그네가 부서졌다.  앨리스 러트거스는 두 정강이가 골절되고 땅으로 떨어졌다.
		end scene
		scene two
# July 17th, 1957: Seven clowns retire with near fatal lung issues.  LANDBLEND brand makeup is suspect, but no formal investigation occurs.
1957년 7월 17일: 일곱명의 광대가 폐가 안 좋아져서 은퇴했다.  랜드블랜드 브랜드의 메이크업이 의심되지만, 형식적인 조사조차 수행되지 않았다.
		end scene
		scene three
# July 21st, 1957: Following a cage malfunction, my face and side are severely mauled by an untamed lion.  I survive, but now shudder to look at my own reflection.
1957년 7월 21일: 동물 우리가 망가지는 바람에, 야생 사자에게 얼굴과 옆구리를 심하게 당했다.  다행히 나는 살아남았다, 하지만 언제나 거울에 비친 내 모습을 보면 그때가 생각나서 공포에 몸이 떨린다.
		end scene
		scene four
# August 5th, 1957: In my dream, I saw a stone face with fierce, shining eyes.  He spoke of the truth of our existence and was the first to offer freedom from the pain.
1957년 8월 5일: 꿈에서, 난 사나운 얼굴과 반짝이는 눈을 가진 돌을 보았다.  돌은 나에게 우리의 존재에 대한 진리를 말하며 나를 고통에서 해방시켜주며 자유를 선사하였다.
		end scene
		scene five
# August 7th, 1957: How many of us will suffer before we accept the truth of the Seeing One?
1957년 8월 7일: 얼마나 많은 사람들이 관측자를 따르기 전까지 고통받으면서 살아왔을까?
		end scene
		
		scene six
# August 8th, 1957: I have come to my decision.  A few of the others have said they will follow me.  This will be my final entry.  May the Seeing One look favorably upon us all.
1957년 8월 8일: 결정할 때가 왔다.  몇명은 나를 따르겠다고 했다.  오늘로 이 일기도 마지막 장이다.  관측가의 가호가 있기를.
		end scene
	end area
	area CLIFF
		scene one
# (Indecipherable markings)
(처음 보는 문자로 뭔가가 써져 있다)
		end scene
		scene two
# December 7th, 2010. (name unreadable). There's nothing up here, except this stupid rock!
2010년 12월 7일  (이름은 흐릿해서 보이지 않는다)  이 거지같은 바위를 빼면 이곳엔 아무것도 없다!
		end scene
		scene three
# Danger! This cave is unexplored.
위험하다! 이 동굴은 누군가 들어온 흔적도 없다!
		end scene
		scene four
# These cliffs extend far and upwards, though I've never gone high enough to find out where they lead.
이 절벽은 위쪽으로 길게 뻗어있다. 끝이 보이지도 않아서 위가 어떤지도 모르겠군.
		end scene
	end area
	
	
	area CROWD
		scene one
# Rock: How?
바위: 어떻게?
		end scene
		scene two
# Rock: Warning! Vertical drop, jump at your own risk.
바위: 조심하세요! 떨어지면 그 누구의 탓도 아닙니다.
		end scene
	end area
	
	area DEBUG
		scene one
# This used to be a placeholder animation for the card gates. Approach it twice to see the locked and open animations! 
가까이 가거나 멀리 떨어지면 문이 열렸다 닫혔다 할거야!
# I forget why we ended up scrapping it. Perhaps too dramatic.
난 왜 이걸 쓰지 않았는지 까먹었어. 너무 드라마틱해서인가?
		end scene
		
		scene two
# Here are tests for various tile layers and collisions! I couldn't get one way tiles from both sides (i.e., walls) working very well so I just ended up scrapping the idea entirely...or something. 
이곳은 다양한 타일과 레이어와 충돌을 테스트했어! 일방통행 타일을 양쪽(i.e., walls)에 두거나 했지만 잘 되지 않아서 뺐다... 랄까.
# There was some reason why we didn't use them. Simplifying design, which was important for us to finish the game.
이곳에는 왜 우리가 이것들을 쓰지 않은지 이유가 있어. 설계를 단순하게 하는 것. 이것이 게임을 완성하는 데 중요했기 때문이지.
		end scene
		
		scene three
# Enemies used to be able to drop keys. I scrapped this idea even though it was slightly amusing. 
처음에는 적을 쓰러트리고 열쇠를 얻을 수 있게 하려고 했는데, 이 아이디어는 안 쓰기로 했어. 꽤 마음에 들었었는데. 
# Another idea we played with was having challenge gates, which lay at the end of a gauntlet, and only opened when you reached them without getting hurt. 
다른 아이디어는 도전 관문을 게임에 넣으려고 한 건데, 이건 대미지를 입지 않고 시련을 클리어 할 때에만 열리는 관문이었지.
# We wanted to model all dungeons around this and scrap health entirely, but that turned out to be far too hard!
예전에 모든 던전에서 체력을 없애면 어떨까 하고 생각했는데, 너무 어렵다고 해서 못했어!
		end scene
		
		scene four
# PRISON!!!
감옥이야!!!
# Save us!!!
도와줘!!!
# Please!
부탁해!
		end scene
		
		scene five
# Welcome to the DEBUG WORLD! You've stepped outside of \"The Land\", so consider this world (90 PER-CENT) \"Non-canon\". Anyways.
디버그 세상에 오신 것을 환영합니다! 이곳은 \"대륙\"이 아니라서, 게임의 진행과는 (90%) \"무관합니다\". 잘 쉬다가세요.
# Before there were tilesets for many of the areas I used silly tiles like these to mark where doors went. In fact, every dungeon was mocked up in this area's tileset, and then Marina tiled over them with his tilesets.
맵의 타일 세트가 완성 될 때까지 이런 임시 타일 맵을 써. 게임의 던전은 사실 전부 그렇게 만들어서, 마무리로 존이 타일 세트를 넣지.
		end scene
		
		scene six
# fille
젊은 여자
		end scene
	end area
	
	area DRAWER
		scene five
# -ARCHIVES-
-기록보관소-
# PROCEED WITH CAUTION
신중하게 진행하자.
		end scene
		scene four
# West. Rift. Reality! Low real estate values, hurricane, old, run down. Relaxing. 
서쪽. 땅에 균열이 생김. 실제 상황! 부동산은 떨어지고, 허리케인이 일어나고, 부식되고, 무너지고. 하... 진정하자. 
		end scene
		scene three
# The Seeing One from what I can rem- rmrr,,,,,,a Good Time At The Home.
내가 뭘 할 수 있을지 찾아봐야 게엤- 어으,,,,,,그냥 집에서 행복한 시간이나 보내야 겠군.
		end scene
		scene two
# COLD STORAGE\n\n^  -- THE MGMT
냉장실\n\n^  -- 관리
		end scene
		scene one
# CONTINUE
계속
		end scene
	end area
	
	area FIELDS
		scene one
# West: Beach\n\nEast: Forest\n\nSoutheast:\n  Rainy Area\n\nNorth: \nTemple Grounds\n\nNorthwest: Chasm
서쪽: 바닷가\n\n동쪽: 숲\n\n동남쪽:\n  비내리는 지역\n\n남쪽: \n사원 안\n\n북서쪽: 깊은 틈
		end scene
	end area
	
	area FOREST
		scene one
# West: Land Lake\nSouth, then east: Cliffs
서쪽: 대륙의 호수\n남쪽으로 가서 동쪽으로: 낭떠러지
		end scene
		scene two
# Relaxation pond. Stay a while, we know you have the time.
휴식 연못. 잠시 쉬어가세요, 잠시 쉴 시간정돈 있잖아요?
		end scene
		scene three
# I'm afraid I may be stuck on this tiny corner forever.
난 내가 영원히 이 작은 모퉁이에 남아있을까 봐 두려워.
		end scene
		scene four
# East: Cliffs
동쪽: 낭떠러지
		end scene
	end area
	
	area GO
		scene one
#  The path will open when the dark guardian tiles are replaced by the stone of their spirit color on the square grid below.
  어두운 수호자 타일을 정사각형의 격자무늬 아래에 있는 영혼의 색을 띤 돌로 바꾼다면, 길이 열릴 것이다.
		end scene
		
		scene two
# When the blue stone statue shifted\nThere a new path was revealed\nPast the cliffs, through strange dimensions\nStands a travelers' hotel\n\n\n\"Who is the guardian?\" I ask,\n\"Who rules this crowded business place?\"\nDespite the many human souls\nI still feel alone.
파란 석상이 움직일 때\n새로운 길이 열렸다.\n절벽을 지나 이상한 차원으로 가니\n여행자의 호텔이 있었다.\n\n\n\"관리인은 누구지?\" 그곳에게 물었다,\n\"파수꾼은 누구지?\"\n많은 사람의 영혼이 있음에도 불구하고\n나는 여전히 외로움을 느낀다.
		end scene
		
		scene three
# The red and rusty statue moved\nAnd paved the way to deeper pits\nA labyrinthine dungeon follows\nThen a big-top circus tent\n\n\n\"Who are the guardians?\" I ask,\n\"Who gave up life to flee this place?\"\nI fear the pain, the same as they\nBut fear it more to die.
붉게 녹슨 동상이 움직였다.\n그리고 안으로 통하는 길이 열렸다.\n미로 던전을 따라가니\n커다란 서커스 텐트가 보였다.\n\n\n\"파수꾼은 누구지?\" 물었다,\n\"누가 이곳에서 도망치기 위해 목숨을 버렸지?\"\n내가 고통을 두려워하듯이 그들도 두려워했고\n고통보다 죽음을 더 무서워했다.
		end scene
		
		scene four
# The green, metallic statue shifted\nOpening a deeper trail\nSuburban homes and sidewalks form\nA path to an apartment.\n\n\n\"Who is the guardian?\" I ask,\n\"Who looks for comfort in the stars?\"\nAlone, I feel like I am watched\nAnd not by friendly starlight.
녹색 금속 동상이 움직였다.\n난 안쪽으로 들어갔다.\n교외 주택 및 보도 형태\n아파트로 가는 길로.\n\n\n\"파수꾼은 누구지?\" 그곳에게 물었다,\n\"누가 별에서의 편안함을 찾는가?\"\n홀로, 나는 감시당하고 있다는 느낌이 들었다.\n그건은 항상 친근했던 별빛과는 다른 것이었다.
		end scene
		

	end area
	
	area BLANK
	#initial entrance from windmill
		scene one
# Rock: This is unclaimed territory - not yet a part of The Land. 
바위: 아직 이곳은 주인없는 대륙의 일부분중 하나인 - 영토입니다.
		end scene
		#concentric circles
		scene two
# Rock: These -^ me and my^ - circles are^ - promises...I'll^ - concentric^ - really try to get everything done...^ - circles. Bzrt, bzrt.
바위: 이 -^ 내것과 나^ - 원은^ - 약속이다....나는^ - 동심원의^ - 정말로 모든 것을 끝내려고...^ - 원. Bzrt, bzrt.
		end scene
			#islands
		scene three
# Rock: Watch^ -...but I always^  - your step^ - manage to reappear no?^ - when here! 
바위: 보고 있어^ -...하지만 나는 항상^  - 너의 행보를^ - 네가 다시 이곳에^ - 나타나 줬으면! 
		end scene
		#mazeish place, not near the portal
		scene four
# Rock: Looking down^ - And I realized:^ - from here, you- ^ I'm in love with him.^ - can see...nothing, really.
바위: 내려다 봐^ - 그리고 난 깨달았지:^ - 이곳에서, 너- ^ 나는 그를 사랑해.^ - 사실... 볼 수 없었어, 정말로.
		end scene
		#left part of the 48 gate
		scene five
# Rock: My apologies -^ But yeah, we -^  on the mess here -^ ought to keep in touch-^ but that portal should^ - and I will try give you my opinions - ^ return you to to The Land.
바위: 미안해 -^ 그렇지만 우린 -^  이곳의 엉망 -^ 계속 연락하기로 -^ 하지만 저 관문은^ - 그리고 내 의견을 제시하고 싶어 - ^ 대륙으로 돌아와 줘.
		end scene
	end area
	
	
	area NEXUS
		scene one
# Sometimes if you talk to people multiple times, they have new things to say.
가끔 사람들에게 여러번 대화를 하면, 그들은 새로운 주제를 가지고 대화를 할 수도 있습니다.
# But not rocks.  Rocks don’t do that.
하지만 바위는 아니죠. 바위는 그럴 수 없어요.
		end scene
		#before 49 card agate
		scene two
# Rock: So close! If only...
돌: 정말 아쉬웠어! 만약에...
		end scene
		#door that goes nowhere
		scene three
# Rock: Curiosity is a great thing.
돌: 호기심은 좋다고.
		end scene
		#below treasure box
		scene four
# Rock: Oh!...?
돌: 오!...?
		end scene
		scene five
# The computer terminal has an e-mail open. Parts of the screen are broken, so only parts of the message are visible in between black blotches. The e-mail reads: \"Hello, Young! It seems that [...] fiftieth card [...] maybe you shouldn't... [...] worth thinking about! Do you think you're ready? Wake up...\" 
컴퓨터 터미널에 이메일이 띄워져 있다. 화면 일부분은 박살 나 있다. 그래서 오로지 검은 얼룩들 사이의 몇 부분들만 볼 수 있다. 이메일 내용: \"안녕, 영! 보이네[...] 50번째 카드 [...] 아마도 넌 [...] 의 가치에 대해서 생각해봐! 네가 준비됐다고 생각해? 일어나...\" 
		end scene
	end area
	
	
	area OVERWORLD
		scene one
# Rock: I’ll bet you’re reading a rock because you don’t have any friends.	
바위: 넌 친구가 한 명도 없어서 이 바위에 적힌 글자를 읽고 있다는 데 내 손모가지를 걸지.
		end scene
		scene two
# Rock: Welcome to Overworld Station. We hope you enjoyed your time in The Land. 
바위: 오버월드 정거장에 온 것을 환영합니다. 대륙에서 즐거운 시간을 보내셨길 바랍니다.
		end scene
		scene three
# Rock: An explorer is you!
바위: 탐험가는 당신입니다!
# Rock: Please don't go south. It's under construction.
바위: 남쪽으로 가지 마십시오. 그 곳은 공사중입니다.
		end scene
		scene four
# Rock: Treasure in 5,3!
바위: 5,3에 보물이 있다!
		end scene
		scene five
# Rock: Haha, gotcha!
바위: 하하, 잡았다!
		end scene
	end area
	
	area REDCAVE
		scene one
# WE ARE BORN INTO THE DECAY OF OUR MOTHER’S BODY.
우리는 어머니의 부해한 몸에서 태어났다.
		end scene
		scene two
# ONE DAY OUR MOTHER LEFT HER MOTHER AND VENTURED INTO THE POISONOUS FOG.
어느 날, 우리의 어머니는 그녀의 어머니를 떠났다. 그리고 독 안개속으로 모험을 떠났다.
		end scene
		scene three
# WE NEVER ASKED FOR THIS.  WE WOULD NOT HAVE BOUGHT OUR LIVES WITH HER SUFFERING.
우리는 물어볼 수 없었지.  우린 그녀의 고통과 우리의 삶을 만들고 싶지 않아.
		end scene
	end area
# area for redsea
	area REDSEA
		scene one
# Rock: Signs indicate the trees have not been active for an extended period of time.
바위: 표지판은 오랜 시간동안 죽어있던 나무를 나타낸다.
		end scene
		scene two
# Rock: South: ???^   North: ???
바위: 북쪽: ???^   남쪽: ???
		end scene
		scene three
# Rock: The uneven terrain is said to have been formed by the ancestors of the area's inhabitants.
바위: 이 지역의 일그러진 지형은 선주자의 조상이 이룬 것이라고 알려져있다.
		end scene
		scene four
# Rock: They appear to be a peaceful species.
바위: 그들은 평화로운 생물이다.
		end scene
	end area
	
	
	area SPACE
		#middle
		scene one
# 			Scribbled in what appears to be permanent marker: Greetings, fellow traveler of SPACE and TIME. You have stepped into a rift far away from the juxtaposing area of YOUNG. You've crossed an OCEAN or two, so to speak. Don't worry about the CONTRAST, you can return to your normal adventure shortly. Do not FEAR this place, though it appears FORBODING and DANGEROUS you will find its denizens to be quite FRIENDLY.\n      -- The MGMT
			유성 매직 같은 걸로 써져 있다: \"공간\"과 \"시간\"의 여행자여, 환영합니다. 당신이 발을 디딘 곳은 \"영\"의 차원 균열과 인접합니다. 당신은 \"바다\"를 하나둘 넘어왔습니다, 그래서 말하는데. 부디 평소랑 다른 \"차이\"를 두려워하지 마세요, 당신은 곧 다시 당신의 평범한 모험으로 돌아가겠죠. 이 장소는 \"불길\"하고 \"위험\"해 보일 수도 있지만 부디 \"두려워\"하지 마세요, 이곳의 주민들은 모두 매우 \"친절\"합니다.\n      -- MGMT
# 			(Below the message, an engraving:) Here lies ____ (unreadable). He got lost in the woods.
			(메시지 아래에 문자가 새겨져있다) 숲에서 길을 잃은 ____ (읽을 수 없다), 이곳에 잠들다.
# 			(Even further below the message:) (just don't go too far south.)
			(그 밑에 아직도 메시지가있다) (남쪽으로 너무 멀리 가지 마라.)
		end scene
		# extra color
		scene two
# Here lies ____ (unreadable. Who wrote this?). He was impaled by rainbows!
무지개에 찔려죽은 ____ (읽을 수 없군. 누가 쓴거야?), 이곳에 잠들다. 
# Would've been better with achievements.

		end scene
		#grey graves
		scene three
# Here lies Burd. The cliffs weren't feeling too friendly.
절벽과 친해지지 못했던 버드, 이곳에 잠들다.
		end scene
		scene four
# Here lies bag. It never had a chance.
한 번도 쓰인적이 없는 가방이 있다.
# Pretentious!
안쓰럽네!
		end scene
		# color graves
		scene five
# Here lies Savitch. He tried to fix my computer in the garage once, and didn't take up much space while doing so. Three years later, he still hadn't finished. Then, he dropped dead.
차고에 있는 컴퓨터를 수리하려고 자리잡고 앉아서 작업했지만 3년이 지나도 수리해지 못하고 어디선가 떨어져 죽은 세비치 이곳에 잠들다.
		end scene
		scene six
# Here lies Dave. He wasn't very inspirational.
내세울게 하나도 없던 데이브, 이곳에 잠들다.
		end scene
	
	end area
	
	area SUBURB
		scene one
# 			---YOUNG TOWN---^\nWelcome to Young Town. Please beware of some of the citizens. They do not play well with others...tread carefully. Now, Young Town was founded sometime in the '90s by Mayor Ying as a part of a series of ongoing housing projects, the name chosen as a reflection of Ying's denial of possessing the name Ying, and assertion of possessing the name Young. We'll hope you enjoy your stay.
			---영 타운---^\n영 타운에 오신 것을 환영합니다. 몇몇 시민들은 다른 사람과 잘 어울리지 못하니... 주의해주세요. 영 타운은 시장 잉 씨의 택지 개발 정책의 일환으로 90년대에 개발 된 마을입니다, 마을의 이름은 시장의 이름인 잉(그늘)씨가 자신의 이름을 거절하고 스스로 선택한 영(양지)라고 정한 것에 유래됐습니다. 편히 지내시기 바랍니다.
		end scene
		
		scene two
# 			To the west are the legendary temples of the Seeing One. To the east is our wonderful Mayor Ying's apartment, which has been since closed off from visits to the public - trespassers beware. 
			서쪽에는 전설의 관측자 사원이 있습니다. 동쪽에는 우리의 훌륭하신 시장님 잉씨의 아파트 입니다. 지금 아파트는 개방되지 않고 있습니다. - 방문시 주의해 주세요.
		end scene
		
		scene three
# 			On his fifth visit, Mayor Ying grew frustrated at the lack of parking lots. This parking lot reflects Ying's frustration of the lack of parking lots. Ying would occasionally park in this parking lot on subsequent visits.
			5번째 방문 때, 잉시장은 주차장이 적음에 강한 불만을 느꼈습니다. 이 주차장은 잉시장이 느낀 주차장이 적음을 반영한 것입니다. 이후 잉시장은 방문할 때마다 이 주차장을 이용합니다.
		end scene
		
		scene four
# 			I remember the long sentences I used to write. Ha! Fragmented.
			예전에 긴문장을 썼던게 기억나네. 하! 집어쳐!
		end scene
		
		scene five
# 			A DANGEROUS SITUATION
			위험한 상황
		end scene
	end area
	
	
# Area for TRAIN (it's actually CELL sorry)
	area TRAIN
		scene one
# The Seeing One knows all and will lead one to enlightenment. The road to enlightenment is unlit by any torches.
관측자는 모든것을 알고있고, 깨달음으로 이끈다. 깨달음으로 가는 길을 비추는 빛은 없다.
		end scene
		scene two
# Do not stray from the way of the Seeing One, not even for the treasures lying at the far corners of the maze.
관측자의 길에서 이탈하면 안 된다. 비록 미로의 구석에 보물상자가 있더라도.
		end scene
		scene three
# Move along.
홀로 이동했다.
		end scene
		scene four
# Do not anger the Chasers with violence.
체이서를 화나게 하지 마세요.
		end scene
	end area
	
	area WINDMILL
		scene one
# SCENIC LANDMARK: Partner Towers. Built some time ago, the Partner Towers overlook the distant mountains. The first tower was damaged a while ago and has since been repurposed. The second still stands to the east, reaching into the sky. Due to safety concerns, the path to the tower has been cut off until further notice.
관광 명소: \"쌍둥이 탑\". 최근에 건설된 이 탑은, 멀리 있는 산까지 볼 수 있습니다. 첫 번째 탑은 망가진 이후로 다른 용도로 사용되고 있습니다. 두 번째 탑은 여전히 동쪽에 위치하며, 하늘까지 뻗어 있습니다. 안전상의 문제로 이 탑으로 가는 길은 추후 공지가 있을 때까지 봉쇄되어 있습니다.
		end scene
		scene two
# PUBLIC SAFETY NOTICE:^\nThis tower, while not damaged, has been said to have a dimensional rift at the top. Proceed with caution and an open mind.^\n      -- The MGMT
안전에 관한 안내문:^\n이 탑은 손상되지 않았지만 꼭대기에 차원의 균열이 생기고 있습니다. 주의해주세요.^\n      -- MGMT
		end scene
	end area 
end npc

# dungeon statue (Dungeon statue)
npc dungeon_statue
	area BEDROOM
		scene one
# The statue does not look like it will be moving anytime soon.
맨날 움직일 것 같게 생기지는 않은 동상이군.
		end scene
		scene two
# The statue has moved.
동상이 움직였군.
		end scene
	end area
	
	area REDCAVE
		scene one
# It looks like this statue is firmly in place.
이 동상은 움직이지 않고 계속 여기에 서 있을 것 같군.
		end scene
		scene two
# The statue has moved.
동상이 움직였군.
		end scene
	end area
	
	area CROWD
		scene one
# This statue does not seem to be movable.
움직일 것같이 생긴 동상은 아니군.
		end scene
		scene two
# The statue has moved.
동상이 움직였군.
		end scene
	end area
end npc

# APT splitboss
npc splitboss
		area APARTMENT
		scene before_fight
# Fire is beautiful, isn't it?  What a shame that the glow and glare of streetlights hides the fire of the stars.
불은 아름다워, 그렇지 않아?  하지만 마을의 불빛들이 별의 빛을 가려 버리는 건 수치스러운 일이야.
		end scene
		scene after_fight
# Okay, so stars aren't really made of fire.  ^Who gives a shit anyway?
그렇구나, 별은 불덩어리가 아니지.  ^넌 자세히 알고 있구나...
		end scene
	end area
end npc

npc cube_king
	area SPACE
	# kings are supposed to offer info on 
		scene color
#			How are you today? I'm the ruler of this partition and interpretation of space.
			잘 지냈나? 난 이 구역의 통치자이고 이 공간의 성립되는 모든 것 그 자체이네.
#			You want to know why I'm the ruler of this place? I'll tell you, but it will take a while. Like, a long while. An obnoxiously long while.
			내가 어떻게 이곳의 통치자가 됐는지 이유를 알고 싶나? 알려주지, 하지만 시간이 필요해. 아마, 긴 시간 말이야. 역겨울 정도로 오랜 시간이.
#			Like, quite a while. No really, I'm warning you! I tend to ramble. Maybe you'd be better off just scooping out the contents of that chest over there. Or heading off to the hotel in the distance. Don't know how that got there, I heard they have relatively cheap rates. Not that money matters here.
			그래, 꽤 오랫동안. 아니, 정말로, 경고하는데! 아, 내가 좀 횡설수설한 경향이 있어. 어쩌면 그냥 바로 저기에 있는 상자 안을 보는 게 더 나을지도 모르겠네. 아니면 멀리 있는 호텔로 향하거나. 그게 거기 있는지는 모르지만, 거기는 상대적으로 저렴한 가격이라고 들었어. 돈 따위 의미 없지만.
			LOOP
#			Why am I the ruler?^...I'm not sure why, but my friends around here saw it fit to put me in this position, because of the immediate state of this space. Maybe this is the case because cubes are best at sitting still on flat surfaces. As for why someone needs to sit up here - that's beyond me!
			왜 내가 통치자가 됐나고?^...왜냐고 물으니 확신하기 어렵군, 하지만 주변에 있던 내 친구들이 날 보고 이 적합한 위치에 넣어준거지, 이 공간의 상태에 즉각적인 이유지. 어쩌면 경우일지도 몰라. 왜냐하면 큐브는 평면에 서있기 최적의 형태를 가지고 있지. 왜 누군가가 여기에 앉고 싶어한다고 묻는다면 이렇게 대답하지. -  그건 나랑 상관없는 일이네!
# 			The others - my friends over there - have merits of their own. It's not like they couldn't sit up here in the future, they just can't do it now. Sometimes, we switch off who is the ruler, but every time, we always have to reinterpret this region of space! Perhaps Mr. or Ms. Pyramid comes up here because we decide to make the throne shaped in a way that best fits them, by re-imagining this world, so to speak. Does that sound silly? It might be. But that's how it is. It happens quite fast. Minutes, hours - not necessarily a long reign.
			그리고 또 - 내 친구들도 - 역시 장점은 있어. 그 친구도 언젠가 통치자가 될 가능성이 있고 지금은 할 수 없어서 내가 하는 것이지. 가끔은, 통치자를 누가 할 것인가 정하기도 해. 하지만 대부분, 우린 공간의 영역을 재해석해야 하네! 다시 말하자면, 신사 또는 숙녀 피라미드는 여기에 온다는 거지. 왜냐하면 우린 왕좌 모양을 가장 잘 맞는 방법으로 만들기로 결심했기 때문이지. 이 세상을 다시 상상함으로 인해서 말이야. 말하자면, 바보같은 소리라고? 그럴지도 모르지. 하지만 그렇지만 이건 방법이야. 그 상황은 매우 빠르게 초, 분, 시로 발생하지. - 필요치 않은 긴 통치. 왕좌 모양.
# 			Though, when I am ruler, it feels slightly strange...I somewhat feel isolated, wanting to be avoidant of others...
			하지만, 내가 통치자가 됐을 때, 약간 이상한 느낌이 들었지...뭔가 고립된 느낌, 다른 사람을 피하고 싶었지...
# 			...but isolation is not the right word, though it covers parts of the feeling. I'm not isolated, and I don't dislike the others. We consider ourselves all friends, but you know, no one really comes up here except to say a few words. So I have to think about things or I might go crazy! Maybe that's part of the isolation. 
			...하지만 고립은 옳지 않아, 그래도 이건 느낌의 일부분을 다루고 있지만. 나는 고독하지 않네. 그리고 다른 사람을 싫어하지도 않지. 우린 모든 친구를 고려해야 하고, 하지만 말일세, 몇 단어를 제외하고 대부분의 사람들이 여기에 오지 않는다네. 그래서 나는 그런 것들에 대해 생각하거나 미쳐가고 있을 걸세! 어쩌면 이것도 고립의 한 부분일지도 모르지.
# 			Outside of those inane questions about *why* we're here occupying this space, I'm curious as to why we're even friends.
			그 이외에 *왜*냐는 어리석은 질문에 대한 답인데, 우린 여기에 이 공간을 점령한채로 있네. 아, 왜 우리가 친구인지 계속 신경쓰이는 거야.
# 			I like to think that whenever we're under the interpretations that I'm best to rule, that they give me comfort in being able to hold this position for as long as it takes to reach the next interpretation. You know, encouragement and the like, their physical presence, those are comforting.
			나는 우린 항상 내가 통치자에 최고로 적합하다는 해석 아래에 있다고 생각하고 싶네. 그들은 나에게 존재 할 수 있는 곳에서 이 위치를 유지하기 위해 편안함을 제공했지. 다음 차례의 해석을 할때 까지 말일세, 자네도 알다시피, 격려 같은거 말일세, 물리적 존재는 그 위안이 된다네.
#			I suppose that's enough to satisfy me, though it would be nice to have one or two of them try and understand how I feel about being a ruler. Not that I'm complaining about encouragement! But maybe then, we could have multiple rulers...what a thought! Maybe that implies that when I am not ruler, I must act the same way I sometimes wish they would...who knows if that can be done.
			그것들이 날 만족시키기에 충분하다고 가정한다면, 그래도 멋진 것, 아니 멋진 것들일거야. 내가 왜 통치자가 됐는지 이해되는군. 나는 격려에 대해 불평하고 있지 않네! 하지만 어쩌면 그 다음, 우린 여러명의 통치자가 있을 수...내가 무슨 생각을! 그러니까 내가 통치자가 아닐 때, 같은 방식으로 행동해야 하네, 나는 가끔 그들...그럴 수 있을지 누가 알겠어?
#			I've gone on too long. If you head off in the other direction, there's another similar region of space, though I think it smells a bit different. 
			난 너무 멀리 가버렸네. 자네가 만약 다른 방향으로 간다면, 거긴 여기랑 다르지만 비슷한 공간의 영역이 있겠지. 그래도 냄새는 약간 다를거라고 생각한다네.
#			It was nice to meet you.
			만나서 반가웠네.
#			Oh, you want to hear my story again?
			오, 내 이야기를 다시 한 번 듣고 싶나?
#			Okay, sit tight.
			좋아, 제대로 앉아.
		end scene
		
		scene gray
# 		Hello there. I'm the ruler of this part of space.
		오, 안녕하신가. 난 이 공간의 통치자이네.
# 		What's that? You want to know why I'm here? Are you sure? It'll take me quite a few words to explain why!
		뭐? 내가 왜 이곳에 있는지 알고 싶다고? 진심인가? 설명하려면 매우 많은 단어들이 필요할 거야!
# 		Well, if you insist. Though you might be better off just walking off to that hotel in the distance. Don't know why they went through with the construction of it. If I had any money to be taxed, I'd surely be complaining!
		
		LOOP
# 		Well, even though I'm the ruler of this part of space, I am not really ruling over anyone.
		흠, 내가 이 공간의 통치자긴 하지만 다른 이들에게 그렇게 간섭을 한 적은 없네만.
# 		Those friends of mine - they're all rulers of their own parts of space. Ruling no one really, either - we're all alone in that respect. But we're not alone in that we talk to each other, and in other ways we are not alone, too. This is just one place in which I exist.
		내 친구들 - 그러니까 다 각자 구역을 갖고 있는 친구들도 그렇게 참견은 하지 않아. 그렇게 보자면 우리를 각자 하나의 객체라고 봐도 무방하네만, 우리가 서로 대화 하는 방식이나, 그 외 여러가지를 보자면 하나가 아니기도 하지. 이곳은 단지 내가 있는 장소들 중 하나에 불과하다네.
# 		My friends and I - our parts of space have a lot of commonality to them in why they exist and how they're organized. Similar interests and desires, and the like. We like to talk a lot about how to rule, and so forth.
		내 친구들과 나 - 그러니까 우리 공간들은 왜 존재하고 어떻게 조직되어있는가에 대한 지대한 공통점이 있다네. 유사한 취향과 욕구, 그리고 취미들같은 것 말일세.  우리는 우리의 지배방식과 같은 여타의 안건에 대해 심도있는 토의를 하는것을 즐겨하지.
# 		But the tragic thing is that we rarely, if ever, get to meet eachother in the physical form. 
		하지만 슬픈 사실은 우리가 물리적 형태를 취한 상태로는 거의 만나지 못한다는 점일세.
# 		So you're not actually talking to their physical forms, but a representation of them in some holographic form.
		그렇지. 자네는 그들의 물리적 신체와 대화 한 것이 아닐세. 그건 그저 어떤 홀로그래픽으로 구현된 대체제였을 뿐이지.
# 		I know, it's unfortunate. It's unfortunate because we share so much in common, but we can only help eachother as friends so much.
		이것이 어떤 하나의 불행이라는 것은 나도 잘 알고 있네. 우리가 이렇게 많은 공통점을 가지고 많은것을 공유함에도 불구하고 각자를 하나의 친구로써만 도울 수 있다는 점은 그야말로 큰 불행 아닌가.
# 		There's just a small thing lacking when you can't have a one-on-one physical conversation all the time.
		물리적인 일 대 일 대화를 못하는 것에서 촉발되는 소소한 단점들이지.
# 		But I'm not complaining. It's better than nothing at all! I can't imagine what it would be like otherwise. Something terrible.
		하지만 나는 불만없네. 아무도 없는 것 보다는 낫지 않은가! 만약 그랬다면 어땠을까 하는 상상은 할 수 조차 없다네. 아마도 끔찍하겠지.
# 		It was nice talking at you, good luck with whatever you're up to.
		대화 즐거웠네. 자네가 하는 일, 모두 잘 풀리길 바라겠네.
# 		You're still here? I can tell you everything again, if you'd like.
		계속 여기 있겠나? 했던 말을 몇 번이고 계속해줄 수 있네, 만약 자네가 마음에 든다면 말이지.
		end scene
	end area
end npc

npc forest_npc
	area FOREST
		scene bunny
# Crickson: Hey ya big bully!  I’m not afraid of you!
크릭슨: 야! 크기만 한 깡패 녀석! 너따위 두렵지 않아!
# Crickson: Ya big lunkhead!  I won’t run away!  Not even if you try to slug me a good one!
크릭슨: 야! 크기만 한 바보 녀석!  난 도망치지 않아!  네가 날 한 대 치더라도 절대 도망가지 않아!
# Crickson: Yer just a big dumb broomy pants, that’s what you are!  You oughtta be ashamed of yourself!
크릭슨: 야! 크기만 한 멍청한 녀석!  그래 이 멍청한 녀석아!  부끄러운줄 알라고!
		end scene
		
		scene thorax
# Thorax: I am the thorax, I speak for the bees.\n^Their fate is uncertain, it’s not the bee’s knees!\n^Some colonies’ workers have all took to flight!\n^These colonies die then, it’s no pretty sight!
토렉스: 나는 토렉스야, 꿀벌의 대변자야.\n^꿀벌들의 운명은 불확실하지, 이건 좋은 일이 아니라고!\n^어떤 곳에 있는 식민지의 노동자들은 투쟁을 했데!\n^결국 그 식민지는 멸망했다고 하고, 투쟁후의 그곳의 모습은 더 좋은 관경을 찾기 힘들정도로 멋질거야!
# Thorax: Perhaps it’s a virus or new pesticide,\n^perhaps it’s the larva of foul phorid flies!\n^That’s making these honeybees all act so strange.\n^Whatever it is, it must certainly change!
토렉스: 아마 이건 바이러스이거나 새로운 농약이야,\n^아니면 파리 애벌래의 짓인가!\n^모든 것들이 꿀벌을 이상하게 만들고 있어.\n^그게 뭐든간에, 반드시 바꿔야만 해!
# Thorax: Okay, so I don’t really know what’s the matter\n^I worry my efforts are nothing but chatter.\n^But how can I sit and do nothing to help?\n^So I’ll post it to Facebook and Twitter and Yelp!  
토렉스: 좋아, 그래서 난 뭐가 더 좋은지 알고 싶지 않아\n^내가 노력했던 게 헛수고로 돌아가는 게 싫거든.\n^하지만 어떻게 앉아서 가만히 보고만 있겠어?\n^그러니 난 페이스북이랑 트위터에 포스트하고 외칠거야! 
		end scene
	end area
end npc

npc shopkeeper
	area FIELDS
		scene init
# Buy my stuff
쇼핑은 이곳에서~
		end scene
	end area
end npc

npc goldman
	area FIELDS
		scene outside
TOP
# What are you doing here, punk?  Get lost!  I caught it fair and square!  
여기서 뭐 하는 거야, 임마?  당장 나가!  내가 정정당당하게 잡았다고!	
# I won’t let it go!  Not in a million years!
절대 놓치지 않을거야!  만 년이 지나더라도!
		end scene
		
		scene inside
# Oh, did you come here to terrorize me some more?
오, 날 또 공포에 떨게 만드려고 오셨나?
# You’re just siding with the cats because they are cute and furry.
넌 그 고양이들 편이지. 왜냐하면 고양이들은 귀엽고 털로 덮혔으니까.
		end scene
		
		scene etc
TOP
# What are you doing here, punk?  Get lost!  I caught it fair and square!^  Wauugh!^  Is that--?^  ANOTHER CAT???^  WAUUGHHH!!! 
여기서 뭐하는 거야, 임마?  당장 나가!  내가 정정당당하게 잡았다고!^  어라아!^  이건--?^  또 다른 고양이???^  이러어어언!!! 
# You... you cleaned up my house...  I’m touched!  Here, I want to give you my most beautiful possession! 
너... 내 집을 청소했군...  감동했다!  여기, 내가 가지고 있던 것 중 가장 아름다운 녀석을 주지! 
# Young opens and takes the box. Something is inside it!
영은 상자를 열어보았다. 무언가 안에 들어 있다!
# Icky: Oh.  Hey Miao.^\n\nMiao: I’m so glad you’re safe!^\n\nIcky: Uh... thanks for the hand, Young.
이키: 오.  안녕 미아오.^\n\n미아오: 너가 안전한 걸 보니 너무 기뻐!^\n\n이키: 음... 도와줘서 고마워, 영.
LOOP
# Icky: To be honest, I kind of like sitting in boxes.
이키: 솔직히 말해서, 난 상자위에 앉아 있는 걸 좋아해.
		end scene
	end area
end npc

npc miao
	area FIELDS
	
		scene init
# Oh!!  You are Young, The Chosen One!!!  Omigosh, what an honor!  My name is Miao Xiao Tuan Er, Chosen One-in-training!
오!!  당신이 선택받은 사람이라고 하던 영이군요!!!  이런 맙소사, 만나서 영광입니다!  제 이름은 미아오 샤오 투안 어, 선택된 훈련자죠!
# Could I follow you around for a bit to watch a Chosen One in action? 
제가 조금만 당신은 따라다니면서 선택받은 사람의 기술을 볼 수 있을까요? 
LOOP
# Hello again, Young!  Can I shadow you today? 
다시 만나서 반가워요, 영!  오늘 당신을 따라다녀도 될까요? 
		end scene
		
		scene randoms
# 0. after talk to shopkeep
# Miao: Hey, Young... have you ever stolen anything?
미아오: 저기요, 영... 당신은 태어나서 한 번도 도둑질을 해본 적이 없나요?
# 1. AFter talk to mitra
# Miao: I like Mitra... and isn’t Wares a handsome bike?
미아오: 난 미트라가 마음에 드는데요... 잘생긴 자전거 상품 말고요.
# 2. Nexus pad
# Miao: What’s that cool stone thing, Young?  Does it make you go back in time?!
미아오: 저 돌은 뭐죠, 영?  이 돌이 시간을 거슬러 갈 수 있게 해주는 건가요?!
# 3. Random if Icky not saved
# Miao: I’m starting to get worried about Icky... Young, have you seen a bigger cat around recently? Icky last said he was going to walk around the small forest to the east.
미아오: 좀 이키에 대한 걱정이 드네요... 영, 최근에 커다란 고양이를 본 적이 있어요? 저번에 이키가 저한테 동쪽에 있는 작은 숲으로 산책하러 간다고 말했거든요.
# 4. leave map
# Miao: Icky said I shouldn’t go where it's unsafe. I’ll see you later, Young.
미아오: 이키가 위험한 데는 가지 말라고 했어요. 나중에 봐요, 영.
# 5, 6, 7 - only after you've seen 0, 1, 2
# Miao: Have you ever sat in a bunch of grocery bags?
미아오: 지금 쇼핑백 더미위에 앉아있는 거에요?
# Miao: Hey Young, do you think it’s wrong to do catnip?
미아오: 이봐요 영, 이게 고양이가 좋아할 캣닙이 맞을까요?
# Miao: I bet it must have taken a lot of work to become The Chosen One, huh, Young?
미아오: 선택받은 사람이 되기 위해서 많은 일을 해야 할거야, 어, 영?
		end scene
# musing after you save icky	
		scene philosophy 
# That scary situation with Icky got me thinking...  What do you think happens after we die?  How could any of us fulfill our full purpose in the span of one life?  
이키가 나를 생각했다는 건 매우 무서운 상황이에요...  우리가 죽은 후 무슨 일이 일어날 거라고 생각해요?  어떻게 단 한 번뿐인 삶에서 모든 목적을 달성할 수 있을까요? 
# Maybe we are reincarnated again and again until we fulfill our destiny.  Or would that make things too easy?
어쩌면 우린 운명을 다할 때까지 계속 다시 태어나지 않을까요?  그러면 너무 쉬운걸까요?
# And then what is our reward for completing our journey?  Do we just fade away?
그리고 그 여정의 끝에는 무엇이 있는 걸까요? 단지 시간에 휩쓸려서 사라지는 것 뿐일까요?
LOOP
# Hmm...
흠...
		end scene
# icky talking after yoh save icky
		scene icky
# Oh.  Hi, Young.  
오, 안녕, 영.  
# My name’s not really Icky.  It’s Ichabod.
사실 내 이름은 이키가 아니야.  그건 남자 이름이지.
# I hope Miao Xiao Tuan Er hasn’t been too much trouble.
미아오 샤오 투안 어가 문제를 일으키진 않아?
# See you later, Young.
다음에 봐, 영.
		end scene
	end area
end npc

npc generic_npc

	area DEBUG
		scene melos
# Oh howdy, how is it going? You found me! I'm going to stay here, though. It's cold outside.
이런, 들켜버렸네, 안녕! 난 여기 남아있을래. 밖은 너무 추워.
# You can blame me for all of those awful rooms! I made them with the DAME map editor.
끔찍한 방들은 마음껏 나를 욕해! 그 방들은 내가 DAME map editor로 만든 거야.
# I made this game with FlashDevelop IDE and the Flixel AS3 framework!
난 이 게임을 FlashDevelop IDE 와 Flixel AS3 framework로 만들었어!
# Oh yeah, and I made the music using the REAPER DAW. And sometimes Audacity.
오 예, 그리고 음악은 REAPER DAW로 만들었어. 가끔은 Audacity도 쓰면서 말이야.
# I actually get my nutrition from the radiation from all of these computers... ^what do you mean that's not biologically accurate?
사실 모든 컴퓨터들이 내 몸에 방사능을 뿌려서 영향을... ^생물학적으로 정확하지 않다는 건 무슨 소리야?
# Hi mom! ^And dad!
안녕 엄마! ^그리고 아빠도!
# Want to know how to finish the game in 20 minutes?
이 게임을 20분안에 클리어 하는 법을 알아?
# Ha! Like I'd tell you!
하! 안 알려 줄건데-에!
# (...maybe if you ask me nicely...)
 (...정중하게 물어보면 알려줄지도...)
		end scene
		scene marina
# Woah hey!
우후, 이봐!
# I wrote a ton of dialogue for this game!^ (...but not this dialogue. Melos is doing this.)
내가 이 게임의 대사를 대부분 썼어!^ (...이 대사는 숀이 쓰고 있지만.)
# I used Adobe Photoshop CS5 , Graphics Gale Free Edition and Windows 7 Snipping Tool to do the art!
난 Adobe Photoshop CS5, Graphics Gale Free Edition, 그리고 Windows 7 캡쳐 도구를 이용해서 그림을 그려!
		end scene
	end area
# both redsea done in Redsea_NPC.as
	area REDSEA
		scene first
# The humidity here is good for your skin, but bad for your hair.
여긴 수분이 많아서 피부에 좋지만, 머리카락에 안 좋네.
# I like standing here.  These days, people spend the whole summer rushing back and forth between sweltering heat and freezing cold AC.  Those quick temperature changes weaken your bones.
난 여기 서있는 걸 좋아해.  요즘, 사람들은 여름에 밖에 나갔다가 에어컨 바람을 쬐러 안으로 왔다갔다 한다고. 급격한 온도 변화는 뼈에 좋지 않아.
# It’s like that rotten habit of chewing your ice cubes.  My mother chewed her ice cubes into her late 20s.  Now she’s got hairline cracks all over her molars.
얼음 조각을 씹는 나쁜 버릇처럼.  우리 엄마는 20대 후반에 얼음 조각을 씹어먹었지.  지금 우리 엄마는 어금니에 금이 가있어.
		end scene

		scene second
# Make sure you change out of those shoes and stuff them with newspapers to dry them out.  Wouldn’t want to create a breeding ground for bacteria.
신발을 벋으면 제대로 신문지에 넣어 말려줘.  눅눅한 상태로 두면 박태리아가 번식해 버린다고.
# Why do buffets only ever have RED jello cubes?  It’s like they want us to get cancer.
왜 뷔페에서 마음대로 가져갈 수 있는건 빨간 젤리 큐브지?  이건 손님을 암에 걸리게 하고 싶다는 것 같아.
		end scene	

		scene bomb
# Get away from me.
내게서 떨어져.
# I’m serious... leave me alone now.
심각하다고... 지금은 날 내버려둬.
		end scene

	end area
    area BLUE
		scene one
# I don’t need your pity, Young.
네 동정따윈 필요없어, 영.
# Right, just go on living in your happy little world, "Chosen One"...
좋아, \"관측자\"의 행복한 세상속에서 살아가라고...
# You know, Young, friendship is just a trick people play on themselves.  We’re all assholes, and in the end, we’re all alone.  
이봐, 영. 우정 따윈 서로 속이면서 성립되는 거라고.  우린 전부 병신들이고,\n마지막 순간에는 항상 홀로있지.  
# Hah, I knew you hated me, Young.
영, 네가 날 싫어하고 있다는 걸 모를 것 같아?
# I’m doing fine.
난 잘하고 있다고.
# Of course you don’t care, no one does.
물론 넌 신경쓰고 있지 않겠지만, 아무도 신경 쓰지 않지.
		end scene
	end area

	area HOTEL
		scene one
# I know cities can be dirty and crowded and everything, but I like to come out here and look out over all the lights.
거리는 지저분하고 주변은 사람들로 가득하지. 알고 있는데도 가끔은 이곳의 불빛을 보는 걸 좋아해.
# It's beautiful in its own way.  It’s not nearly as infinite as the stars, but there is something about its humanness that adds a layer of wonderful complexity.
도시는 도시만의 아름다움이 있는 걸까? 별의 반짝임처럼 영원하진 않지만 인간성이라는 게 아름다움에 깊이를 더하는 것 같아.
# Behind every light is a person with hopes and fears and secrets... looking out is both terrifyingly lonely and fiercely personal.
각각의 불빛들 옆에 기대와 우려, 비밀 같은 걸 안고 있는 사람들이 있어. 그래서 도시의 불빛은 무서운 정도로 고독하지만 사람 다운게 있어.
# I think I love every person behind every window.  I love you, people, for being my stars.  I love you no matter how fucked up your life is or how far you think you’ve fallen.  You are lovely for tonight...
난 창문 뒤에 있는 모든 사람을 사랑하는 것 같아. 모두! 내 별이 돼줘서 사랑해요! 인생이 좇같아지고 바닥까지 떨어졌다고 해도 난 너를 사랑할 거야.  오늘밤은 빛으로 가득 찼어...
# I’m sorry, I’m babbling.  Thanks for listening.
미안해. 좀 떠들었지?  들어줘서 고마워.
		end scene
	end area
	
	area REDCAVE
		scene easter_egg
# Heeyyyy, mannn...take a load off, stay a whilleee, eh?
이봐아아아, 천천히 가라고! 응?
		end scene
	end area
	
	area APARTMENT
		scene easter_egg
# Ah! You found me!
아! 들켜버렸네!
		end scene
	end area
	
# quest_normal and quest_event are the dialogue quest (pseudo-trading) people.
# quest_normal is what htey say normally, quest_event is what they say when it's their turn for a clue.
	area CLIFF
	
		scene quest_normal
# Golem: Did you get hit by a boulder on your way up?  Sometimes I throw boulders when I’m angry.  I’m sorry if I hit you.
골렘: 오면서 큰 바위가 떨어지지 않았어?  내가 가끔 화나면 바위를 집어던지거든.  혹시 맞았으면 미안해.
# Golem: My mother always said that if I kept doing it, I’d run out of mountain to throw.  Back before she was fracked.
골렘: 엄만 항상 내게 \"그렇게 계속 바위를 던진다면 널 산에서 던져버리겠어!\"라고 했지.  정말로 그랬을까?
		end scene
		
		scene second
# Golem: When you’re a rock, you see many generations of people come and go.  You become ancient and wiser than the wisest among men.
골렘: 네가 바위가 된다면, 바위는 수명이 길어서 정말로 오랫동안 수많은 세대의 사람들이 오고 가는 걸 볼 수 있어.  그렇게 나이를 계속 먹다 보면 그 누구보다 현명해지지.
# Golem: At least, that’s the idea.  I broke my binoculars a while back so I haven’t been able to tell what’s going on.
골렘: ...이라고 말하긴 하지만, 사실 오래전에 쌍안경 부숴버려서 무슨 일이 일어나고 있는지 잘 몰라.
# Golem: Actually, I don’t miss watching people much, it’s a bore.
골렘: 사실, 많은 사람을 보는 것은 지루해.
		end scene
		
		scene quest_event
# Golem: Oh, yes, I met someone who was little lost...they told me they were going off to look around the beach.
골렘: 오, 맞아, 저번에 뭔가를 잃어버린 사람을 만난 적이 있어... 바닷가로 간다고 했던 것 같은데.
		end scene
	end area
	
	
	area BEACH
		scene quest_normal
# I’m not a lobster, I’m a langostino.  The name’s Hews.
나는 랍스터가 아니야. 난 랜고스티노.  이름은 휴즈라고.
LOOP
# Hews: You know what the best part of the ocean is?  Being able to see the horizon.
휴즈: 바다의 가장 중요한 것이 뭔지 알아?  수평선을 볼 수 있다는 거지.
# Hews: The ocean is like a salty taste of infinity.
휴즈: 바다는 짠맛이 끝없이 느껴지는 곳이야.
# Hews: A crowded beach is robbed of its grace.
휴즈: 붐비는 바닷가는 흐린 보석과도 같은 거야.
		end scene
		
		scene second
# Hews: Have you heard of the mantis shrimp?  It has 16 photoreceptors that allow it to perceive ultraviolet light.  Can you imagine seeing a wider range of colors?
휴즈: 갯가재 소리를 들어본 적 있어?  갯가재는 자외선을 감지할 수 있도록 16개의 광수용체가 있다고 해.  무수히 많은 색이 떠오르지 않아?
# Hews: Maybe it would be beautiful.  Then again, we’ve found plenty of ways to hate each other with just the colors we have.
휴즈: 분명 매우 아름답겠지.  하지만, 우린 단순히 서로가 가진 색으로 서로 놀리면서 차별하고 있어.
		end scene
		
		scene quest_event
# Hews: You're looking for someone, huh? I remember I was sitting here when a few clouds passed by the sun. While the sun was occluded, someone walked up to me and asked where something was. I don't remember what it was, but the person ran off, saying they were heading to the forest.
휴즈: 누굴 찾고 있다고? 응? 예전에 약간의 구름이 태양을 지날 때 이곳에 앉아 있었던 기억이 나. 태양이 가려진 동안, 누군가 내게 걸어왔고 뭔가가 어디에 있느냐고 물어봤었어. 그게 뭔진 기억나지 않네. 하지만 그 사람이 숲으로 도망치고 있었던 건 확실히 기억나.
		end scene
	end area
	
	area FOREST
		scene quest_normal	
#npc james
# James: Berries are a good kind of food.  I like berries.
제임스: 나무열매들은 좋은 과일이지.  난 나무열매들을 좋아해.
# James: Please make sure not to defecate on the berries.
제임스: 조심해, 소중한 열매들 위에 똥 누지 말라고.
# James: So far I have had sexual intercourse 18 times this season.  Also, I have eaten 389 pawfuls of berries.
제임스: 올해엔 짝짓기를 18번 했어.  또, 389개의 나무열매들을 먹었고.
# James: Do you have any berries for James?
제임스: 혹시 이 제임스를 위한 열매가 있니?
		end scene
		
		scene second
# James: I wrote a poem:\n^I like to eat berries\n^They make me merry\n^How much do I like berries?\n^I would have to say very!
제임스: 내가 시를 한편 써봤어. 들어봐:\n^나는 열매가 좋아\n^열매는 나에게 열정을 주지\n^: 얼마나 열렬히 좋아하냐고?\n^ 하루라도 안 먹으면 열받을 만큼!
# James: Do you like blueberries or raspberries more?
제임스: 넌 블루베리를 좋아하니? 아니면 산딸기를 좋아해?
# James: Do you have any berries for James?
제임스: 혹시 이 제임스를 위한 딸기가 있니?
		end scene
		
		scene quest_event
# James: Someone came by. They did not want berries. Went to southeast part of lake to the west.
제임스: 누군가 왔다 갔는데 딸기를 원하지 않었어. 서쪽 호수의 남동쪽으로 가던데.
		end scene
		
	end area
#npc rank
#npc olive
	area FIELDS
		scene easter_egg
# Olive: Hi, I'm Olive the rabbit.
올리브: 안녕, 난 토끼 올리브야.
# Olive: I have so much cereal left to eat! I love cereal.
올리브: 난 시리얼이 정말 많이 있어! 나는 시리얼을 사랑해!
# Olive: The box is so big. It never ends!
올리브: 시리얼 박스가 너무 커. 시리얼이 절대 떨어지지 않을거야!
# Olive: Neverending cereal!
올리브: 끝없는 시리얼이지!
# Olive: Hmmm...maybe that's not such a bad thing.
올리브: 흐으으음...그렇게 나쁜 일이 아니라고.
		end scene
		
		scene bush
# Rank: Eheheh, silly Young! A broom’s no tool for cutting bushes!
랭크: 에헤헤, 멍청이 영! 빗자루는 관목을 자를 수 없다고!
		end scene
		scene quest_normal
# Rank: I cut down the bushes for a living.  Sometimes when you cut the bushes you find gold!  Eheheh!
랭크: 난 살아가기 위해서 관목을 잘라.  관목을 자르면 가끔 금을 발견할 수 있을거야!  으하하!
# Rank: The economy has been really struggling under this bush...
랭크: 부시 이후로 경제는 정말 어려움을 겪고 있어...
# Rank: Sometimes it’s tough to support the wife and kids on bush cutting--we don’t always have enough to eat... but we’ve always got a roaring fireplace!  Eheheh!
랭크: 관목을 자른다고 해서 항상 아내와 아이들을 먹여 살릴 수 있는 건--아니야. 하지만 난로는 항상 따뜻하지!  으하하!
		end scene
		scene quest_event
# Rank: Eh? Yes! Someone came by here. Said they were going to an underground labyrinth...I bet they've got a lot of bushes there, eh Young? Eheheh!
랭크: 어? 맞아! 어떤 사람이 이곳에 들렀다가 갔었어. 아마 지하 미로에 간다고 말했던 것 같은데...거긴 계속 베어도 끝없을 만큼의 관목이 있는 걸까? 으하하!
		end scene
		
		scene marvin
# Marvin: Oh hey, how are you feeling?
마빈: 오, 반가워!
# Marvin: Where is Justin?
마빈: 저스틴은 어디갔을까?
# Marvin: There's no bottle rockets around...
마빈: 주위에 로켓 병은 없는 것 같아...
		end scene
		
		scene chikapu
# Chika Chi!
치카 치!
# Chika Chika!!
치카 치카!
# CHIIIII^\nKAAAA^\nPUUUUUUUUUU!!!!
치이이이^\n카아아아^\n푸우우우우우우!!!!
		end scene
		
		scene hamster
# Bob: Bob the Hamster likes to refer to himself in the third person.
밥: 햄스터 밥은 자신을 3인칭으로 지칭하는 것을 좋아한다.
# Bob: Apostrophes are the root of all e'vil.
밥: 
# Bob: quiet! I am busy exuding an aura of hamstery ambiance.
밥: 조용해! 난 햄스터틱한 분위기에 스며드느라 바쁘다고.
# Bob: ... I suppose you only get better by doing... But... if you do something wrong, are you just getting better at doing it wrong?
밥: ... 너가 뭔가를 해서 더 나아진다고 가정해보자고... 하지만... 만약 잘못된 일이라도 더 나아질 수 있다면 계속 할 거야?
# Need more fix(Korean)
# Bob: A real man never cries... well, maybe he lets a single tear slide back from the corner of his eye across his sun-hardened face as he rides his bad, bad, Harley across the wind-swept Mohave desert wearing no helmet or goggles. But he never cries.
밥: 진정한 남자는 절대 울지 않아... 뭐, 할리를 타고 모래사막을 가로지르는 사람이 헬멧도 고글도 없다면 햇볕에 탄 얼굴의 눈에서 한 방울의 눈물이 잠깐 뺨을 타고 흘러내릴 순 있지만. 그래도 남자는 울지 않아.
# Bob: This game was created by an infinite number of monkeys working on an infinite number of typewriters.
밥: 이 게임은 수많은 원숭이가 수많은 타자기를 이용해서 만들었어.
# Bob: I miss James...
밥: 제임스가 그리워...
		end scene
		
		scene electric
# Kuribu: Curry is yellow and spicy!
쿠리부: 카레는 노랗고 매워!
# Kuribu: For the clever opponent, injure increase!
쿠리부: 동전을 넣어!
# Kuribu: You got the experience of 2!
쿠리부: 넌 2에서 경험을 얻었어!
# Kuribu: I tell you my phone number!  0*1-51*7-*4386
쿠리부: 내 전화번호를 알려주지!  0*1-51*7-*4386
		end scene
		
	end area
	
	
	area TRAIN
		scene quest_normal
# What AM I doing here? Good question! I just stumbled upon here. I'm in hiding. It's safe here, if you don't venture too far out and let those guys get you.
내가 여기서 뭐하고 있었냐고? 좋은 질문이야! 난 우연히 이곳에 오게 됐고, 숨어있었지. 여기는 안전하고 그 이상한 거에 잡히고 싶지 않거든.
# It looks like I'm relatively fortunate. All these dead people strewn all over the place - how did they die? It's a little fascinating, to try and think of how it happened. Were they attacked by the monsters? Tripped and fell onto the spikes?
난 비교적 다행인 것 같네. 이곳은 사방에 죽은 사람들 천지야 - 그러고 보니 이 사람들은 어떻게 죽은 걸까? 조금 흥미로운데, 왜 이 일이 일어났는가 생각해보자고. 괴물의 공격을 받은 걸까? 함정에 걸려 못으로 가득한 곳에 떨어진 건가?
# It is a a bit grim. I hope it doesn't happen to me. Physical pain is a terrible prospect.
슬픈 일이야. 나한테 이런 일이 일어나지 않았으면 좋겠어. 육체적인 고통은 정말로 끔직할거야.
		end scene
		scene quest_event
# Oh...now that I think about it, a person walked by here a while ago. Said they were looking for something...even looked a bit like you! I don't remember when, sorry. It's hard to tell the time in here. But they said they were going to head off to a nearby town.
오...지금은 그것에 대해서 생각하자고, 한 사람이 얼마 전에 이곳에 왔다 갔지. 그들이 뭔가를 찾고 있다고 했는데...그리고 조금 너랑 닮을 것 같네! 언제인진 기억나지 않아, 미안. 시간도 잘 기억나지 않네. 하지만 주변에 있는 마을이랑 떨어진 곳에 간다고 했던 것 같아.
		end scene
	end area
	
	area SUBURB
		scene quest_normal
# Hello.
안녕.
# Are you looking for something?
무언가 찾고 있는 건가?
# What are you looking at?
무엇을 보고 있는거지?
# No, I'm not a citizen of this town. What's weird is you can see and talk to me, but I can't interact with any of them. There are all of these killers running around, and no one seems to notice. It is strange. 
아니, 난 이 도시의 시민이 아니야. 그러니 마을에서 이상한 걸 보면 나랑 이야기 할 수 있을거야, 하지만 난 마을 사람들과는 대화할 수 없어. 하지만 주변에는 살인자가 돌아다니고, 마을 사람들은 아무도 그 사실을 몰라. 뭔가 이상하지 않아? 
		end scene
		scene quest_event
# Yes. I observed a person walk by. They were looking for something. I don't know where their 'something' could be. The person went off in a hurry. Said they needed to head to an alternate area of space. Sounds fancy.
응. 지나간 사람이 있었어. 뭔가를 찾고 있다고 말한 것 같은데, 그 '뭔가'가 어디에 있는 지는 모르겠네. 그 사람은 서둘러 가더라. 다른 공간에 간다는 말은 한 것 같은데, 무슨 말인지 몰라도 뭔가 멋진데.
		end scene
	end area
	
	area SPACE
		scene quest_normal
# WHOA WHOA WHOA - - - WHO ARE YOU ? ? ? 
너어 너어 너어 - - - 너는 누구야 ? ? ? 
# I AM A DRIFTER . . . THIS IS ONE OF THE MORE POPULAR PIT STOPS ALONG THE JOURNEY FROM A TO B .
나는 평범한 나그네 . . . 이곳은 A에서 B로 가는 꽤 인기있는 휴식 장소야.
# WHAT IS 'A' ? ? ? IT'S MY HOME TOWN . . . I AM VISITING AN OLD FRIEND IN B . . . IT IS A LONG JOURNEY . . . BUT I MAKE SACRIFICES . . . DON'T YOU ? ? ? MAKES LIFE MORE EXCITING ! ! !
'A'가 뭐냐고 ? ? ?  내 고향이야 . . . 오랜 친구를 만나러 가는 길이야 . . . 오랜 여행이였지만 . . . 그건 약간의 희생이지 . . . 너도 그렇게 생각하지 ? ? ? 인생을 더 자극적이게 살아보자고 ! ! !
		end scene
		scene quest_event
# OHH - - - LOOKING FOR ANOTHER HUMAN - - - I SEE . ^ LET ME ACCESS MY MEMORY . . . READ ( 0X0C00400 , STDOUT , 100 ) ; \n . . . . . . \n . . . . . . \n A HA . . . \n THE PERSON HAD A FLASH OF INSIGHT AND SAID THEY WERE HEADING OFF TO A SHED IN SOME WELL-KEPT FIELD. \n NOW THAT I THINK ABOUT IT . . . YOU LOOK SIMILAR TO THEM ! ! ! ARE YOU SURE IT WASN'T YOU ? ?  HUH ? MM ?
그런건가 - - - 다른 사람을 찾고 있는 건가 - - - 알겠어 . ^ 내 메모리에 액세스 할게 . . . 읽는중 ( 0X0C00400 , STDOUT , 100 ) ; \n . . . . . . \n . . . . . . \n 그 래 . . . \n 그 사람은 갑자기 번쩍 떠올린듯이 어딘가에 있는 오두막으로 간다고 했어. \n 그 사람은 . . . 넌 그사람과 매우 닮았어 ! ! ! 정말로 그 사람이 아닌거야 ? ?  응 ? 음음 ?
		end scene
	end area
	
	area GO
		scene quest_normal
# You actually were...uh, ah. Well done.
너는 정말로... 음, 어. 좋다고.
LOOP
# The shiny rock reflects only a bit of the light from the room. There is writing etched into it: \"Quickly, before I have to leave again (It is getting very light in here, this always happens) - the northwest part of the blue forest - I saw another temple entrance just to the north, past those trees - if only I could switch things at will to get through there...maybe I'll do this the next time I revisit this world.\"
한 바위가 방의 불빛을 반사시키고 있다. 표면에 무언가 써져있다: \'빠르게, 다시 떠나야 하기 전에 (점점 밝아지고 있어, 항상 일어나는 일이지) - 푸른 숲의 북서쪽 부분 - 나는 나무들을 지나 북쪽에서, 처음보는 사원의 입구를 보게 되었다 -  버튼을 마음대로 누를 수 있다면 좋겠지만...아마도 난 다시 이 세계를 방문해서 그것을 할 것이다.\"
		end scene
		scene quest_event
# The shiny rock reflects only a bit of the light from the room. There is writing etched into it: \"Quickly, before I have to leave again (It is getting very light in here, this always happens) - the northwest part of the blue forest - I saw another temple entrance just to the north, past those trees - if only I could switch things at will to get through there...maybe I'll do this the next time I revisit this world.\"
한 바위가 방의 불빛을 반사시키고 있다. 표면에 무언가 써져있다: \'빠르게, 다시 떠나야 하기 전에 (점점 밝아지고 있어, 항상 일어나는 일이지) - 푸른 숲의 북서쪽 부분 - 나는 나무들을 지나 북쪽에서, 처음보는 사원의 입구를 보게 되었다 -  버튼을 마음대로 누를 수 있다면 좋겠지만...아마도 난 다시 이 세계를 방문해서 그것을 할 것이다.\"
		end scene
	end area
end npc
npc geoms
	area SPACE
		scene gray1
# HELLO. HAVE YOU MET cube YET?
안녕하신가. 큐브는 만나본건가?
# cube IS A VERY GOOD RULER OF THIS PORTION OF SPACE. US OTHER RULERS DO OUR BEST IN OUR SPACES AS WELL.
큐브는 주변 공간을 통치하는 매우 좋은 통치자이지. 나나 다른 통치자들도 자신의 구역에서 통치를 잘 하고 있지만.
		end scene
		
		scene gray2
# WHAT DO YOU THINK OF THIS CHUNK OF SPACE? IT IS A NICE WAYPOINT, NO?
이 공간에 대해서 어떻게 생각해? 여긴 멋진 중간 지점이야? 아니면 별로야?
# AN INTERSECTION OF WORLDS!
세계의 교차로지!
		end scene
		scene gray3
# NONE OF US GRAY PYRAMIDS ARE ACTUALLY HERE. WE USE SPECIAL DEVICES THAT LET US PROJECT OURSELVES HERE.
회색 피라미드는 사실 여기가 아니야. 특별한 시스템에서 홀로그램으로 비추고 있는 것이지.
# WHY DO WE DO THAT? BECAUSE WE WANT TO TALK TO OUR FRIEND cube AND KEEP cube COMPANY.
왜 그런일을 하냐고? 왜냐하면 우리의 친구 큐브와 대화하고 싶거든, 그리고 큐브의 회사를 유지하기 위해서지.
		end scene
		
		
		scene graydead
# *bzrrrrt* 
*잠자는 소리* 
		end scene
		
		scene grayspin
# ...IS THE HOLOGRAM DEVICE WORKING CORRECTLY?
...홀로그램 장치는 제대로 작동중이야?
# NO?^...^DAMN!
아니야?^...^제기랄!
		end scene
		
		
		scene color1
# Have you met CUBE? It does such cool things! I heard once it stood on an edge for nearly twelve seconds. Oh man! Do you know what that means for the League of Edge Standers? No? Well, a lot!
큐브를 만나봤어? 그는 정말 멋진 일을 하고 있지! 듣기로 그는 절벽 끝에서 십이 초 동안 서 있을 수 있다던데. 대단하지 않아? '절벽 끝에서 서 있는 자들의 리그' 회원이라면 그 대단함을 이해할 수 있을 거야! 뭐? 모른다고? 아무튼, 대단하다고!
		end scene
		
		scene color2
# CUBE does a lot of interesting work!
큐브는 재미있는 일을 많이 해!
# Did you hear? Apparently, it will be my turn to rule soon! In just a few minutes, I believe.
들려? 분명히, 곧 내가 통치하게 될 차례가 올 거야! 단 몇 분 정도, 그렇게 믿고 있어.
		end scene
		
		scene color3
# I'm from Sugar Loaf, in transit to Taipei. Why am I here? Oh, I stopped by to say hi to CUBE!
나는 타이베이에서 운송된, 설탕 덩어리에서 왔어. 내가 왜 여기에 있는 거지? 이런, 큐브에게 인사하려고 들린 거였지!
# Don't look so down! This place is just an odd representation so as to not shock all of the visitors. It's mostly harmless, as far as we can tell.
너무 우올해 하지 마! 이곳을 찾는 사람들이 놀라지 않게 하려고 이상한 모습을 하고 있는 거야. 아무런 피해 없다고.
		end scene
		
		scene colordead
# (...is it taking a nap?)
(...낮잠 자고 있는 건가?)
		end scene
	end area
end npc

npc redboss
	area REDCAVE
		scene before_fight
# EACH GENERATION IS BORN FROM PAIN TO DIE IN PAIN.  WE WILL NOT SUFFER TO REPRODUCE THE CYCLE.  WE WILL NOT GO OUTSIDE.
모든 세대는 고통 속에서 태어나 고통 속에서 죽는 것을 반복하지. 우린 밖에 나가지 않음으로써 고통받지 않고 살고 있어.
		end scene
		scene after_fight
# IS THIS YOUR PUNISHMENT FOR OUR REBELLION?
이것이 우리에게 반란을 일으킨 너의 형벌인가?
		end scene
	end area
end npc

npc circus_folks
	area CIRCUS
		scene before_fight
# Why did you deprive the Seeing One of his sacrifices?  Why did you steal from us our salvation?
당신은 왜 관측자의 희생을 빼앗아 간 거지? 당신은 왜 우리의 구원을 훔쳐간 거지?
		end scene
		scene after_fight
# ...We have failed to make you pay for your interference.  And yet... you have given us back our chance to be free.  Thank you, Young.  May the Seeing One look upon you in favor once more.  
...우린 너에게 합당한 보상을 주지 못한 것 같아.  너는 우리에게 자유를 돌려주었어.  정말 고마워. 영. 관측자가 너에게 한 번 더 호의를 베풀며 바라볼 거야.
		end scene
	end area
end npc

npc wallboss
	area CROWD
		scene before_fight
# So good to see you, Yang.  Been too long.  Still playing those nintendos, I see?
다시 봐서 반갑다, 양.  오랜만이야.  아직도 닌텐도 가지고 노니?
		end scene
		scene after_fight
# Jesus, Yon, when are you just going to grow up?  You know, you're going to have to learn to deal with people sooner or later.
맙소사, 연,  아직도 어린애니?  알겠지만, 어차피 결국 다른 사람과 사귀게 된다고.
		end scene
	end area
end npc

npc eyeboss
	area HOTEL
		scene before_fight
# We have all the finest amenities here.  How do you like the Pool?
저희 호텔은 뭐든지 최고의 시설을 갖추었습니다.  수영장은 어떠십니까?
		end scene
		scene middle_fight
# How about our state-of-the-art fitness center?
최첨단 피트니서 센터는 어떠십니까?
		end scene
		scene after_fight
# We hope you enjoyed your stay!
즐거운 시간 보내셨길 바랍니다.
		end scene
	end area
end npc

npc suburb_walker
	area SUBURB
		scene words_adult
# Today is a nice day.
오늘은 매우 멋진 날이지.
# Thanks for scratching that itch on my neck - I can't seem to reach it.
목을 긁어줘서 고마워 - 거기에 손이 닿질 않았거든.
# I've heard the eggs at the local diner are quite good. I have a coupon for them, too.
로컬 디너에서 파는 계란이 맛있다고 들었어. 쿠폰도 가지고 있다고.
# Did you see the car accident today? So horrible! He was texting. Such a shame, so young!
오늘 자동차 사고를 본 적 있어? 정말 끔찍했지! 운전사가 문자를 쓰다가 순간 훅 갔어. 아직 젊은 남자였는데!
# My son did not make the junior varsity team. Such a disappointment. We invested so much in his sports career.
내 아들은 주니어 대표팀에 못 들어가서 실망했어. 그토록 스포츠에 투자를 많이 해줬는데...
# Thanksgiving is today. I am thankful for a lot of things. Can't wait for tomorrow's early morning sales. Gonna get a lot of bargains.
오늘은 추수감사절이라 여러 가지에 감사하고 있어. 내일 새벽에 있을 장사가 너무 기대돼! 화끈한 거래를 많이 하겠지?
# Ah, I think I might be late for work.
아, 아마 좀 늦을 것 같아.
# I am in a bit of a rush to get home, I need to tidy up before the in-laws come over.
빨리 집에 가야 해, 친척들이 오기 전에 청소를 마쳐야 하는데...
# We're having a garage sale!
차고에서 물건을 팔아-요!
# Welcome!
환영해!
		end scene
		
		scene words_teen
# I didn't see the latest movie.
최신 영화를 안 봤어.
		end scene
		
		scene words_kid
# I never gotta see the new cartoon!
더이상 만화를 볼 수 없어!
		end scene
		
		scene family
# inside of a house, parent (insightful kid) - 73
# Welcome to our house, stranger! You look familiar. This is a peaceful town. Pretty quiet, not many visitors.
저희 집에 오신 것을 환영합니다. 낮선이여! 어디선가 본적이 있는 것 같은데... 이 마을은 평화로운 마을입니다. 꽤 조용하고, 방문자가 많이 없거든요.
#inside of house, younger kid
# Do you like Davement? My brother Dave showed me this really cool song by them!
혹시 데이브먼트 좋아해요? 데이브 형이 저에게 끝내주는 이 노래를 저에게 알려줬어요!
		end scene
		
		scene older_kid
# inside of a house, olderkid
# My friends like to listen to that 'None Surprises' song by 'Rayhead' and complain about this place. Sure, it's a bit of a bubble, but hell, at least show some gratitude! Or do something about it! They're all just...oh, sorry. I tend to do that sometimes..
내 친구들은 'Rayhead'의 'None Surprises'라는 노래를 듣는 걸 좋아해. 이 마을을 불평하는 노래인데, 여기가 지옥이 아니라는 걸 감사해야 한다고! 스스로 바꾸려고 하지 않으면 ...아, 미안. 너무 떠들었네..
# I guess I'll just go write in my blog.
난 그냥 블로그에 글이나 쓸래.
# You sure look like you're in a daze.
너 좀 피곤해 보이는데.
# I have trouble hearing my thoughts with sports and the like playing on the TV, but my parents like it.
난 TV랑 스포츠에 관련된 이야기를 잘 못하지만, 부모님이 좋아하셔...
		end scene
		
#inside of hanged man house 74
		scene hanged
# A note on the corpse: \"Placing myself in danger no more.\"
시체위에 있는 쪽지: \"이제 위험으로부터 해방이다\"
		end scene
		
		scene festive
#Inside of another house, (festival people) - 75
# Oh, is there something going on outside? A festival? A parade?
오, 누가 밖으로 나가나? 축제인가? 아니면 퍼레이드?
# There seems to be quite the commotion outside! Have you looked out the window recently? I wonder what it could be.
밖이 너무 조용한 것 같은데? 창밖을 봤어? 무슨 일인지 궁금한데...
		end scene
#78 
		scene paranoid
# My house has a lot of windows. I don't like windows. It's as if someone is always looking in. And you know there HAS to be something going on outside there. It can't just be that silent all the time, so silent and calm - it's disturbing to me.
제 집은 창문이 많아요. 하지만 전 창문을 좋아하지 않죠. 계속 감시당하는 느낌이 들거든요. 근데 밖에서 무슨 일이 일어나고 있는 것 같은데, 항상 시끄러워서 저한테 방해가 됐었거든요. - 왜 이렇게 조용한거지?
# Murderers? What? Outside? What are you talking about? Are you kidding me? There haven't been any murders in this town before, but still...you're starting to worry me...maybe you should just leave.
살인자? 뭐라고? 밖에서? 대체 무슨 말을 하는 거죠? 장난치는 거예요? 이 마을에는 살인자가 나타난 적이 없어요, 하지만 당신이...계속 조심하라고 경고하니...당신은 당장 이 마을을 떠나야 될 것 같네요.
# Please get out.
죄송하지만 나가주세요.
		end scene
# 76
		scene dead 
# The body of this woman has been beaten to death by a blunt weapon.
둔기로 얻어맞은 것 같은 여자의 시체이다.
# The man, to put it bluntly, well...
남자의 시체이다.
		end scene
		
	end area
end npc

npc suburb_blocker
	area SUBURB
		scene one
# Oh, it's you! You look familiar...I can't move until you keep killing more of these townsfolk, remember? Come back in a bit.
오, 너구나! 왠지 익숙한 얼굴인데...난 너가 마을 사람들을 더 죽일 때까진 움직일 수 없어, 기억나지? 조금있다가 봐.
# According to this pamphlet...you only need to kill a few more people! Keep it up.
이 책자에 따르면... 넌 몇 명만 더 죽이면 돼! 계속 하라고.
# We only need one more body, and then we can keep going.
한 명만 더 죽이면 돼, 그러고 나면 계속 나아갈 수 있다고.
# Well done. Feel free to go inside. I have no idea what's there. I'll see you again, same time tomorrow, right? Or the night after?
잘 했어. 자유로움을 느끼며 안으로 들어가. 안에 무엇이 있는지 모르지만, 아무튼 다시 만나. 내일 같은 시간에 말이야. 알겠지? 아니면 그 다음날 저녁에 볼까?
		end scene
	end area
end npc
# dialogue for the cards
# don't enclose in quotes
npc card
	area ETC
		scene one
#0 sadbro
# I don't mind being watched by the trees.
나무한테 감시당한다고 해도 상관없어.
#1 Bat(?) - extra overworld area
# Where is she?!
그년 어딨어?!
#2 sunguy
# I will be with you Young, whenever you are alone.
너가 혼자일 때마다 내가 함께할 것이다, 영.
#3 Shieldy
# Are you an Ookchot?  My mom always warned me about the Dangerous Ookchot.
너가 오크샤였어?  엄만 항상 오크샤가 위험하다고 경고했었어.
#4 slime
# Jello there, Young!  So goo to flanly meet you!  Why don't you set for a minute?  I was just pudding on some tea!
반가워어, 영!  이렇게 만나서 반가워어!  왜 날 올리지 않는 거야?  난 그냥 차 위에 얹어서 먹는 푸딩이라고!
#5 post-statue area in BEDROOM
# Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Chancel, Pulpit, Altar, Stained Glass Windows...
퓨, 퓨, 퓨, 퓨, 퓨, 퓨, 퓨, 퓨, 퓨, 퓨, 퓨, 퓨, 성단소, 설교단, 제단, 스테인드글라스 창문...
#6 SUBURB inside of house past blocker
# Limited time offer! Buy one, get one free - only today!
한정 판매중! 오늘만 특별히 하나를 사면 - 하나가 공짜!
# 7 APT Boss
# Remember the time that you lit a candle when the power was out?
전기가 나갔을 때 촛불을 밝혔던 때가 기억나나요?
# 8 APT Silverfish
# Mmmm, your pillow was cozy last night.
으으으음, 어젯밤에 네 베개는 편안했어.
# 9 APT gasguy
# This'll teach 'em for calling me the fumi-GAY-tion guy.
날더러 게이새끼라고? 이걸로 맛 좀 보여주지 이새끼들.
# 10 FIELDS 1 (island) - mitra 
# Wares and I make a good team.
상품과 나는 좋은 팀이야.
# 11 FIELDS 2 (alcove) - Miao
# I'm the Chosen One-in-training!!!
난 선택받은 사람 견습생이야!!!
#12 Base of WINDMILL windmill
# Do you ever feel like, no matter what you do, you can't stop the world from dying?
가끔, 자신이 무슨 짓을 했는데 세상이 죽어가는 것을 막을 수 없게 된 느낌을 알아?
#13 Hidden up a river in FOREST
#  Beware the forest mushrooms...
숲의 버섯을 조심해...
#14 Bottom of ladder-mini-maze on CLIFF
# I am sorry.  It is my nature.
정말 미안해.  본능적으로...
#15 Top of Cliff
# What do you mean, 'Only a rock'??  Rocks can be on cards too, you know!
'그냥 바위야'라니?? 바위도 카드가 될 수 있다고!
#16 Western end of BEACH past spikes
# Give a man a fish and he will eat for a day.  Teach a man to fish, and he will have bonding times with his son, Jimmy.
한명의 남자에게 물고기 한 마리를 준다면 하루 만에 다 먹겠지.  하지만 물고기 잡는 법을 알려준다면 아들 지미와 부자 관계가 더욱 돈독해지겠지?
#17 At end of path through the woods in REDSEA
# Sometimes the answer is taking a walk.
때로는 걸으면서 대화하면 답이 생기기도 해.
#18 MOVER Redcave  - Past 2 locks in central redcave
# Why do bats suddenly fly down, every time you're around?
박지는 왜 갑자기 날아올라서, 너의 주변을 돌아야 해?
#19 SLASHER Redcave - West end of Northern redcveave
# NO, *YOU* NEED BRACES!
꽃구경 이야기는 이제 그만해!
#20 REDBOSS Redcave - post boss
# ARE YOU HAPPY NOW?
행복해?
#21 NW corner of CELL - chaser
# Don't get violent around me.
내 주변엔 폭력이 없어.
#22 FIRE PILLAR circus -  the field of fire pillars north of entrance
# I've always wanted to be on Iron Chef.
난 항상 철 요리사가 되고 싶었어.
#23 CONTORT circus - contort + firepillar room in SW chunk
# My mom always told me, 'If you do that arch long enough, your spine will stay that way!'
엄만 항상 내게 '허리를 계속 굽히고 있으면 그대로 허리가 굳어버린단다!'라고 말했었지.
#24 LION circus - end of northern gauntlet bordering boss room
# Are you amused yet, human?
아직 즐겁지 않은건가, 인간?
#25 A+J BOSS circus - basement (post boss)
...
#26 FROG crowd - North of entrance
# Scientifically speaking, toads are a subset of frogs.
과학적으로 말해서, 두꺼비는 개구리의 부분 집합이야.
#27 CROWD GUY crowd - 2nd floor
# HAHAHAHA!  Yeah!  I know!
하하하하!  그래!  알고 있어!
#28 WALL BOSS crowd - post boss
# Oh, you collect cards, too?  Real classy, Ying.
오, 당신도 카드를 모으는 건가요?  정말 고급스러우시네요, 잉.
#29 end of grey end of space, for grey cube king
# They always said, \"Get off the computer! Or you'll never make friends!\"
그들은 항상 내게 \"컴퓨터 끄거라! 아니면 평생 친구를 사귀지 마렴!\"이라고 말했었지.
#30 end of colorful end of SPACE, for color cube king
# I'm only the ruler for the extent of a conversation.
지금 나는 오로지 대화의 범위안을 통치한다.
#31 DUSTER hotel - end of 4th floor moving platform area
# I'll bet you think you're 'making my job interesting'!
당신은 '내가 일을 즐겁게 하고 있다'라고 생각하는 것 같아요!
#32 DASH TRAP hotel - Dash trap room on 3rd floor
# I hate diagonals.
난 대각선이 싫어.
#33 BURST PLANT hotel - SE corner floor 2
# Don't even try that claritin clear shit with me.
나의 꽃가루? 히스타민따위 듣지 않는다고.
#34 EYE BOSS hotel - post-boss
# Swipe this card to unlock the door to your room!
당신의 방문 잠금을 풀기 위해서 카드를 스와이프하세요!
#35 end of left-most TERMINAL bridge - sage
# I'm doing a great job.
나만 믿게나.
#36 Young (drawer APT)
.......??
#37 old BDRM (dialogue rock)
# Who carved all of us anyways?
누가 우리를 조각한거지?
#38 hotel room
# I hope you enjoyed your stay.
즐겁게 머물다 가셨길 바랍니다.
#39 end of debug minidungeon (old player sprite)
# Seening as you've gotten to this point, you must be quite Intrasting.
이때까지 있었던 너의 행적을 봤어. 너 재미있는데,
#40 end of cell - Torch? 
# I'm just here to lead you astray.
네가 길을 잃게 하도록 여기 있는 거야.
#41 end of SPACE - faces/entities
# You like like a pyramid to us, too!
우리에겐 너도 피라미드지만 말이야!
#42 end uf suburb (killer)
# It's the same damn play, night after night, and the pay sucks.
매일 밤마다 계속대는 지랄맞는 놀이, 월급도 개같지.
#43 GOldma's room - goldman
# Leave me alone! My last name isn't Sachs!
날 내버려둬! 내 성은 삭스가 아니란 말이야!
#44 blank, ISlands - Broom
# At least I'm not a stick.
적어도 나는 막대기 아니에요.
#45 fields, bottom right - (Rank)
# What do you mean money doesn't grow on trees? Eheheheh!
돈은 나무에서 나오지 오지 않는다니 무슨 소리야? 으하하!
#46 street, bottom (Follower bro)
# I'm nothing but an illusion.
나는 아무것도 아니다. 환각일 뿐이다.
#47 redsea, bottom eft (Bomb npc)
# I'LL TAKE IT OUT ON YOU.
그냥 화풀이 하는 거야.
		end scene
	end area
end npc

npc misc
	area any
	
		scene controls 
# Press
-
# [SOMEKEY-LEFT]
# to set controls. 
을(를) 눌러 조작설정
# [SOMEKEY-ENTER]
# to cancel.
을(를) 눌러 취소
# Up
상	
# Down
하
#5
# Left
좌
# Right
우
# Jump
점프
# Attack
공격
# Menu
메뉴
#10
# Press
버튼
# [SOMEKEY-ENTER]
# to exit
을(를) 눌러 나가기
# [SOMEKEY-LEFT]
# to set controls.
을(를) 눌러 조작설정
		end scene 
		
		scene title
#Please use the\narrow keys to resize\nthe window until\nyou cannot see\nany black around\n the borders.\n\nPress
방향키를 움직여\n화면에 검은 부분이\n안 보이도록\n맞춰 주세요.\n\n
# [SOMEKEY-C]
#when done.
을(를) 눌러 진행합니다.
ANODYNE
Melos Han-Tani\nMarina Kittaka 
# any key
아무버튼이나 누르세요
#5
#Press
버튼
# [SOMEKEY-C]
#to start
으(로) 시작합니다
#Version
버전
#Continue 
계속하기
#New Game 
새로시작
#10
#Are you sure?\nNo\nYes
계속하시겠습니까?\n아니오\n네
#Really?\nNah\nYeah 
정말로요?\n아니\n그래
#No going back!\nForget it\nI know
다신 되돌릴 수 없습니다!\n지워버려!\n알겠어
# deaths  
죽은횟수  
# cards
카드
#15
# Anodyne supports\nmost controllers.\n\nWill you use one?\n\nYes   No\n\nIf so, connect it now.\n\nMove with arrow keys\n\nSelect with\nC, SPACE, or ENTER\n\nDefaulting to yes in\n
Anodyne은(는) 대부분의 컨트롤러를\n지원합니다.\n\n지금 연결된 컨트롤러를 사용하시겠습니까?\n\n네   아니오\n\n만약 사용하신다면.\n\n방향키로 조작이 가능하고\n\nC, SPACE, 또는 ENTER\n로 선택이 가능합니다.\n\n예로 기본설정\n
# NOTE\n\nIf you have input\nlag during gameplay,\nreturn to your\nhome screen and\nre-enter Anodyne.\n\nPRESS C TO CONTINUE\n\nGUI displaying wrong?\nPress button below\nthen reorient device.
안내문\n\n만약 연결된 장치가 있으시면\n게임플레이중 지연이 있을 수 있습니다,\n게임을 종료한 후\nAnodyne을(를) 재실행\n해주세요.\n\nC로 계속 진행\n\nGUI가 올바르지 않게 표시됩니까?\n아래 버튼을 누르면\n장치의 방향을 변경합니다.
# Press BACK again\nto exit.\nUnsaved progress\nwill be lost.
BACK을(를) 다시 눌러\n게임을 종료해주세요.\n저장되지 않은 진행은\n잃게됩니다.
		end scene
		
		scene gui
# Note - this below one is a sprite that fits into the gui
menu=enter
# Shows up when you save at a checkpoint
# Saving...
저장중...
		end scene
		
		scene map
# Map
지도
# Current Room  
현재 위치  
# Door/Exit 
문/출구 
# No Map
지도 없음
# Return to\nNexus
연결체로\n돌아가기
# Return to\nentrance
입구로\n돌아가기
		end scene
		
		scene items
# Items
아이템
# Normal
평범한 빗자루
# Swap
변동기
# Extend
확대기
# Widen
확장기
#5
# A pair of spring-loaded shoes - press 
스프링이 장착된 신발 한 켤레 - 
# [SOMEKEY-X]
# to jump!
을(를) 눌러 점프하세요!
# A pair of shoes for biking.
자전거용 시발 한 켤레.
# An empty cardboard box.
비어있는 골판지 상자.
# A key found in the Temple of the Seeing One.
사원에서 발견한 열쇠.
#10
# A key found in a red, underground cave.
붉은곳의 지하 동굴에서 발견한 열쇠.
# A key found in a mountain cave.
산의 동굴에서 발견한 열쇠.
		end scene
		
		scene cards
# Cards
카드
# cards
카드
		end scene
		
		scene save
# Save
저장
# Saved!
저장됨!
# ERROR
오류
# Save and go\nto title
저장후 타이틀로\n
# Go to title
타이틀로
#5
# Save and quit
저장하고 종료
# Quit game
게임 종료
# Deaths:		
죽은 횟수:		
		end scene
		
		scene config
# Config
설정
# Set keybinds
조작 설정
# Set volume 
불륨 설정
# Autosave at\ncheckpoints:
체크 포인트에서\n자동 저장:
# On
켜기
# 5
# Off
끄기
# Change\nResolution:
보기\n설정:
# Config UI
UI 설정
# Touch+D-Pad
화면터치+D-Pad
# D-Pad Only
D-Pad 만
# 10
# Touch Only
화면 터치만
# Move Input:
조작 설정:
# Resolution:
해상도:
# Windowed
창모드
# Int. Scaled
전체화면
# 15
# Stretch
늘리기
# Scaling:
크기:
# Language:
언어:
# ja
일본어
# en
영어
# 20
# Drag the\nbuttons\nuntil you're\nsatisfied.\n\nThen, tap\nthe menu\nto continue.\n\n
만족하실\n때까지\n버튼으로\n조작해주세요.\n\n그다음,\n메뉴를 탭하여\n계속 진행하세요.\n\n
# Resize Window
원도우크기 재설정
# Config Joypad
조이패드 설정
		end scene
		
		scene secrets
# You\'re rolling in it!
너 엄청 부자구나!
# Once the property of a famous Bubble Mage.
한때 유명한 거품 마법사의 소유물이었지.
# If your graphics become scrambled, look at the pokedex entry of an official Pokemon.
만약 그래픽이 깨지면, 공식 포켓몬의 포켓몬 도감에서 확인해.
# This heart has no name.
이 심장은 이름이 없어.
# Please visit the electric monsters\' world.
부디 전기 몬스터 세상에도 방문해줘.
#5
# A kitty statue. Cute, but useless.
키티 동상. 귀엽지만 쓸모 없다.
# Oh my!!!!
오오! 들켜버렸다!!!
# Oh no!!!!
이런! 들켜버렸다!!!
# It\'s black.
검은색이군.
# It\'s red.
빨간색이군.
#10
# It\'s green.
초록색이군.
# It\'s blue.
파란색이군.
# It\'s white.
하얀색이군.
#SOMEKEY-C
# :Select
:선택
#SOMEKEY-X
# :Back
:뒤로
		end scene
		
		scene swap
# Sorry!
미안해!
# The swap won't work here.
여긴 변동기를 사용할 수 없다.
# Young could not muster the strength to use the swap here.		
여기서 변동기를 사용하기엔 힘이 부족하다.		
		end scene
		
		scene keyblock
# This door is locked.		
이 문은 잠겨있어.		
		end scene
		
		scene treasure
# Some strange force stops this treasure box from being opened.
이상한 힘이 보물 상자가 열리는 것을 막고 있다.
#An engraving on the broom handle reads: Press
빗자루의 손잡이에 문자가 새겨져 있다:
#SOMEKEY-C
# to sweep.
을(를) 누르세요.
# This key may be used a single time to open up a locked barrier.
이 열쇠는 아마도 한 번정도 장벽을 여는 데 사용할 수 있을 것 같아.
# A mysterious pair of boots has nothing but the branding on it, which says \"Press
수수께끼의 신발. 브랜드 이름이 쓰여있다:
#SOMEKEY-X
#5
# \".
을(를) 눌러 강한 점프\".
# A few words on the broom extension read \"Equip the WIDEN upgrade in the menu to have the broom release harmful dust to the left and right.\"
빗자루에 무언가 써져 있다:\"메뉴에서 확장기를 장비하시면 빗자루의 나쁜 먼지가 좌우로 약간씩 증가합니다.\"
# A few words on the broom extension read \"Equip the EXTEND upgrade in the menu for the broom to release harmful dust in front of the broom's normal reach.\"
빗자루에 무언가 써져 있다:\"메뉴에서 확대기을 장비하시면 빗자루의 나쁜 먼지의 범위가 증가합니다.\"
# A note next to the broom extension: \"Hello, Young. Use this SWAP upgrade on two tiles to switch their places. It may be a while before you can use this everywhere, but it should serve you well for the time being.\"
빗자루에 무언가 써져 있는 문장의 다음 부분: \"안녕하세요, 영. 변동기를 사용하면 타일 두 개의 위치를 바꿀 수 있습니다. 어디에서나 사용하려면 아직 시간이 필요하지만, 당분간은 변동기를 유용하게 쓸 수 있을겁니다.\"
# YOU FOUND A HEART!!! Maximum Health increased by...zero.
하트를 발견했다!!! 최대 체력이 0증가했다! ...?
#10
# Goldman: What? It's not there? That shopkeeper must have stolen it!		
골드만: 뭐? 거기 없다고? 분명히 그 가게 주인이 훔쳤다고!		
		end scene
		
		scene dust
# Your broom is now full of dust!  Attack again to place it.
이제 빗자루가 먼지로 뒤덮혔습니다!  먼지를 바닥에 두려면 다시 공격하세요.
		end scene
		
		scene checkpoint
# Save game?\n  Yes\n  No
저장하시겠습니까?\n  네\n  아니오
# While standing on a checkpoint, press
체크포인트 위에 서 있을 때,
#SOMEKEY-C
# to save your progress and set it as your respawn point if you die.
을(를) 눌러 진행을 저장하고, 동시에 그곳이 부활 장소로 설정됩니다.
		end scene
		
		scene rock
# There is writing scrawled on this rock:
낙서가 적혀있는 돌:
# YA AINT GOT NO FRIENDS		
		end scene
		
		scene door
# The portal does not appear to be active.
차원문이 작동하지 않을 것 같다.
		end scene
		
		scene keyblockgate
# The gate stares, petrified. It won't open until it senses four cards...
관문을 겁에 질릴 정도로 빤히 쳐다봤지만 열리지 않았다, 네 장의 카드를 가지고 있기 전까지는 열리지 않을 것 같다...
# Sensing four cards, the gate decides to open.
관문이 네 장의 카드를 감지하고, 열리기 시작한다.
# The gate stubbornly remains in place.
관문은 고집스러울 만큼 그대로 있다.
# The gate senses all of the cards, and decides to open.
관문이 모든 카드를 감지하고, 열리기 시작한다.
# The gate senses enough cards, and decides to open.
관문이 충분한 카드를 감지하고, 열리기 시작한다.
#5
# It opens!
열렸어!
# It remains closed.
닫혔군.
		end scene
		
		scene solidsprite
# The sign points to the east but the words on it are faded.
표지판이 동쪽을 가리킨다. 하지만 글자들이 바래서 내용을 알 수 없다.
# The sign points to the west but the words on it are faded.
표지판이 서쪽을 가리킨다. 하지만 글자들이 바래서 내용을 알 수 없다.
# The words on the sign are faded.		
글자들이 바래서 내용을 알 수 없다.		
		end scene
		
		scene mitra
# Hey, Young!
이봐, 영!
# Are those bike shoes for me?  Wow!  Thanks, Young!  I\'ve been thinking about getting these, since Wares has those pedals where you can clip in bike shoes.  Here, Young, take my boots in exchange!  They have these cool springs that let you jump really high! You press
선물로 주는 자전거 신발이라고?  와우!  고마워, 영!  어떻게 신발을 손에 넣을까 생각하고 있었는데, 상품한테 그 자전거 신발에 맞는 클립이 패달에 달려 있거든.  여기, 영. 그냥 받기는 뭐하니까 내 신발이랑 교환하자!  이 신발은 널 엄청 높게 띄어줄 쩌는 스프링이 달려 있어! 뛰어봐! 
#[SOMEKEY-X] 
# to jump with them on!
을(를) 눌러 신발과 점프할 수 있어!
# Hi Young!  Notice anything new? ^... ^... Oh, well, I got new biking shoes, see!  They clip into Wares' pedals.  Since I'll no longer be needing my old boots, I want you to have them, Young!  They have these cool springs that let you jump really high! You press 
안녕 영!  새로운 소식이라도 있어? ^... ^...오, 알았어, 내가 새로운 자전거 신발을 얻었다고, 나도 알아!  이 신발은 상품의 패달에 딱 들어맞지.  이제 더이상 예전에 쓰던 신발이 필요 없어, 그래서 네게 준거지, 영!  이 신발은 널 엄청 높게 띄어줄 쩌는 스프링이 달려 있어! 뛰어봐! 
#[SOMEKEY-X] 
# to jump with them on!
을(를) 눌러 신발과 점프할 수 있어!
#5
# Alright, take care!
좋아, 조심해!
# Go on, try them out!  ...They're not THAT smelly.
가라고, 놈들을 무찔러버려!  ...하지만 냄새나는 놈들은 아니네.
# Cool, huh?
멋지군, 그렇지 않아?
# Wow, are those the biking shoes from Finty's shop?  You're giving them to me?  Thanks, Young, I really appreciate it!  Here, try out my old shoes in return--I think you'll find them really useful!  There's an engraving on the shoes that says \"Press
와우, 그 자전거 신발은 핀티씨네 가게에서 산거야?  혹시 그 신발을 내게 선물로 주지 않겠니?  고마워, 영, 정말로 고마워!  여기, 보답으로 내가 쓰던 신발을 줄게--정말로 고마워! 잘 쓸게!  아마 신발에 적혀 있을거야. 어디보자, \"
#somekey-x
# to jump\".  I've never understood that, though, because there's no \"
을(를) 눌러서 파워 점프\". 의미를 모르겠네. 신발 어디에도 \"
#somekey-x
#10
# \" anywhere on the shoes...
\"버튼 같은 건 보이지 않아!
		end scene
		
		scene tradenpc
# Finty: Welcome, welcome, my friend Young!  The name's Prasandhoff--Finty Prasandhoff!  Take a look around at my shop and see if anything catches your eye!
핀티: 반가워, 반가워, 내 호갱... 아니 친구 영!  내 이름은 프라산도프--핀티 프라산도프야!  혹시 마음에 드는 게 있어? 사양말고 마음껏 둘러보라고!
# Finty: I still appreciate that box!
핀티: 그 상자를 줘서 정말 고마워!
# Finty: Ah, a box! Thank you so much! Now I can carry all my inventory home at night and back in the morning!
핀티: 아, 상자! 정말 고마워! 이제 퇴근할 때 집으로 남은 재고들을 가져갔다가 아침에 다시 들고올 수 있겠다!
# Wait a minute...it's not here! What happened to it? Well, here, let me ease your wounds instead!
잠시만 기다려봐...어? 없잖아! 어디간거지? 음, 여기, 그 물건이 지금 안보여서 대신에 너의 상처라도 완화시켜줄게!
# As a token of my gratitude, take these stylish biking shoes!
감사의 표시로, 이 간지나는 자전거 신발을 가져가!
# 5
# Fine morning out, isn't it, my friend?  A fine morning for shopping! I just wish I had a box to carry my inventory around.
좋은 아침이야. 안 그래, 친구?  장사하기 위한 좋은 아침이지! 이제 내 재고들 들고 다닐 수 있는 상자 하나만 있으면 좋을텐데...
# Too bad, looks like you can't afford this item!  Come back later, when you have the cash!
저런, 넌 아직 이걸 살 형편이 안돼 보이네!  돈이 생겼을 때, 다시 오도록 해!
# Finty: Ah, you have a fine eye! You need a better weapon, don't you? Blow your enemies to pieces for only $499.99!
핀티: 오오, 무기를 보는 그 눈빛! 좋아! 넌 더 좋은 무기가 필요해, 내 말 맞지? 단돈 $499.99에 적들을 녹여버려!
# Finty: That money sack will allow you to accumulate money that you find in The Land! It's yours for a mere $869.99!
핀티: 그 돈자루는 네가 대륙에서 발견하는 돈을 담아 자기한테 저금하는 걸 허락하겠다고 말하고 있어! 단돈 $869.99만 낸다면 바로 네 거라고!
# Finty: Oh ho ho, here's a specialty item indeed: clip-in bike shoes so you can be speedy AND stylish! On sale now for just $299.99!
핀티: 오 호 호, 여기 특수 품목인 간지나고 초고속으로 달릴 수 있게 해주는 클릿이 달린 자전거 신발! 지금만 특별히 단돈 $299.99에 모십니다아-!
#10
# Finty: Tired of shoving dust around with your piddling little broom?  Eradicate harmful dust particles with this state-of-The-Art vacuum cleaner! Just $749.99, or four easy, monthly payments of $199.99!
핀티: 그 빗자루 주변의 먼지때문에 피곤한가?  이 최첨단-진공-청소기와 함께라면 유해한 먼지들의 입자마저 근절시켜 버린다고! 단돈 $749.99에 모십니다~! 아니면 4개월 할부로 달마다 $199.99는 어때?
# As a token of my gratitude, take this ugly--I mean beautiful, collector's edition card!^
감사의 표시로, 이 못생긴--아니 그러니까 아름다운 이걸 가져가! 바로 콜렉터즈 에디션 카드!^
		end scene
		
		#(Translate as much or as little as you see fit - note this is a little different than normal dialogue, so you'll have to keep at most 19 characters on each line, delimited by newlines - if there are multiple newlines keep them there though, but if a translated line goes over, feel free to add a newline in the middle)
		scene ending
# Anodyne\n-------\n\n\n\nA game created by\n\nMelos Han-Tani\n\nand\n\nMarina Kittaka\n\n-------------
Anodyne\n-------\n\n\n\n게임 제작\n\nMelos Han-Tani\n\n그리고\n\nMarina Kittaka\n\n-------------
# Created from\n\nMarch, 2012\n\nto\n\nJanuary, 2013
개발 기간\n\n2012년 4월 부터\n\n\n\n2013년 1월 까지
# DESIGN\n------\nBoth
디자인\n---\n둘이서 함께
# PROGRAMMING\n-----------\nMelos, using the\nFlixel library for\nActionscript 3.\n\n\n\nART\n---\nMarina\n
프로그래밍\n-----\nMelos, using the\nFlixel library for\nActionscript 3.\n\n\n\n미술\n--\nMarina\n
# MUSIC/SFX\n---------\nMelos, using REAPER\nand number of free\nsoundfonts.\n\n\n\nDIALOGUE\n--------------\nMostly Marina\n
음악/효과음\n------\nMelos, using REAPER\nand number of free\nsoundfonts.\n\n\n\n대사\n--\nMostly Marina\n
# STORY\n-----\nBoth\nJapanese Localization:\nKakehashi Games
스토리\n---\n둘이서 함께\n\n현지화\n---\n일본어 현지화\nKakehashi Games\n한국어 현지화\nMiRiKan
Massive thanks to\nour testers, who\nsuffered so you\ndon't have to!\n--------------\n\nMarina, for suffering\nthrough most of the\ninitial bugs.\n\nEtan, for constant\nsupport since the\nbeginning, with\nmany bugs found,\nand the third human\nto play through most\nof the game.
O - thanks, sis!\n\nRunnan, Nick Reineke,\nEmmett, Poe, AD1337,\n Dennis, Andrew,\nAndrew MM\n Carl, Max, Amidos,\nLyndsey, Nathan\n
Melos would like\nto thank:\n\nMom and Dad, for\ntheir constant support\nin this endeavor.\n\nS\n\nMany TIGSourcers and\nother devs met\nalong the way!\n\nMarina, for making\nthis game possible,\nand improving it in\ncountless ways.
Adobe, Adam Saltsman,\nFlashDevelop devs,\nREAPER devs,\nDAME creator,\nDesura, Gamersgate,\nIndieDB, TIGSource\n\n\nAnd my other friends\nwho have shown their\nsupport. (Thanks!)\n\nAnd last, but\nnot least,\nTina Chen,\nlongtime friend,\nfor both support and\nintroducing me to Marina.
Marina would like\nto thank...\n\nColin Meloy, for\nexpanding\nmy vocabulary\n\nTsugumo, for\n\"So You Want to\nBe a Pixel Artist?\"\n\nMy family,\nfor support and food.\n\nDaniel, for being an\n\"indie game dev\"\nwith me growing up.
Molly, for believing\n in me.\n\nTina, for introducing\nme\nto Melos.\n\nMelos, for making\na game\nand trusting me to\nbe a big part of it.
# CAST\n----\n\n\nSlime\n\n\nAnnoyer\n\n\nPew Pew\n\n\nShieldy\n\n\nSeer
캐스트\n---\n\n\n슬라임\n\n\n짜증나는 놈\n\n\n퓨 퓨\n\n\n방패지기\n\n\n탐구자
# Mover\n\n\nOn Off\n\n\nFour Shooter\n\n\nSlasher\n\n\nRogue\n
움직이는 자\n\n\n온 오프\n\n\n사면 발사대\n\n\n슬래셔\n\n\n악당\n
# Dog\n\n\nFrog\n\n\nRotator\n\n\nPerson\n\n\nWall\n\n
개\n\n\n개구리\n\n\n회전자\n\n\n사람\n\n\n벽\n\n
# Rat\n\n\nGasguy\n\n\nSilverfish\n\n\nDasher\n\n\nRoller\n\nWatcher\n\n\n
쥐\n\n\n가스맨\n\n\n좀벌래\n\n\n돌진기\n\n\n롤러\n\n관측자\n\n\n
# Dustmaid\n\n\nBurst Plant\n\n\nManager\n\n\n
먼지광\n\n\n폭발 식물\n\n\n매니저\n\n\n
# Lion\n\n\nContort\n\n\nFlame Pillar\n\n\nServants\nArthur\nJaviera
사자\n\n\n뒤틀린 자\n\n\n불꽃 기둥\n\n\n두 광대들\n아서\n자비에라
# Follower\n\n\nEdward\n\n\nFisherman\n\n\nRed Walker\n\nHews
추종자\n\n\n에드워드\n\n\n낚시꾼\n\n\n붉은 워커\n\n절단자
# Rabbit\n\n\nIcky\n\n\nShopkeeper\n\nMiao Xiao Tuan Er\n\nRank\n\nGoldman
토끼\n\n\n이키\n\n\n가게 주인\n\n미아오 샤오 투안 어\n\n랭크\n\n골드맨
# Thorax\n\nJames\n\nMushroom\n\nCrickson\n\nGolem\n\nSuburbanites
토렉스\n\n제임스\n\n버섯\n\n클릭손\n\n골렘\n\n교외 거주자
# 추격자\n\n\nEntities\n\n\nSpace Faces\n\n\Cube Kings
체이서\n\n\n엔티티\n\n\n공간의 얼굴들\n\n\큐브 왕
# Young\n\n\nMitra\n\n\nSage\n\n\nBriar
영\n\n\n미트라\n\n\n현자\n\n\n브라이어
# And we'd like to\nthank YOU!\nFor playing our game!\n\n\nWe hope you\nenjoyed it.
그리고 게임을 플레이한\n당신께 감사드립니다!\n끝까지 즐겨주셔서 감사합니다!\n\n\n즐거우셨길\n바랍니다.
\n\n\n\n\n\n\n\n    
# Now you have\nthe ability\nto explore Young's\nworld with (almost) no\nlimitations, via \nthe swap.\n
이제 당신은\n변동기를 통해\n영의 세상을\n(거의)제한 없이\n탐험하실 수 있는\n능력을 얻었습니다.\n
		end scene
		
		scene elevator
# Floor?
몇층으로 가시겠습니까?
1\n
2\n
3\n
4\n
# Cancel
취소
		end scene
	end area
end npc

# Tell the python script you're done.
DONE
