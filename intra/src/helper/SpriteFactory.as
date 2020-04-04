package helper 
{
	import entity.decoration.*;
	import entity.enemy.apartment.*;
	import entity.enemy.bedroom.*;
	import entity.enemy.circus.*;
	import entity.enemy.crowd.*;
	import entity.enemy.etc.*;
	import entity.enemy.hotel.*;
	import entity.enemy.redcave.*;
	import entity.enemy.suburb.Suburb_Killer;
	import entity.enemy.suburb.Suburb_Walker;
	import entity.gadget.*;
	import entity.interactive.*;
	import entity.interactive.npc.Forest_NPC;
	import entity.interactive.npc.Happy_NPC;
	import entity.interactive.npc.Huge_Fucking_Stag;
	import entity.interactive.npc.Mitra;
	import entity.interactive.npc.Redsea_NPC;
	import entity.interactive.npc.Sage;
	import entity.interactive.npc.Shadow_Briar;
	import entity.interactive.npc.Space_NPC;
	import entity.interactive.npc.Trade_NPC;
	import entity.player.*;
	import flash.geom.Point;
	import global.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import states.*;
    public class SpriteFactory {
        
        public static var P_GRID_LOCAL:int = 0;
        public static var P_MAP_LOCAL:int = 1;
        public static var P_GLOBAL:int = 2;
		
		// HI 
		// TODO 
		/* Events come from one spritesheet and the frames  */
		public static var EVENT_TYPE_DARKNESS_ALPHA:int = 0;
		public static var EVENT_TYPE_SCALE_VOLUME:int = 1;
		public static var EVENT_TYPE_SET_ENTRANCE:int = 2;
		public static var EVENT_TYPE_TEXT:int = 3;
		public static var EVENT_TYPE_STATIC_OFF:int = 4;
		
		[Embed (source = "../res/sprites/enemies/enemy_explode_2.png")] public static var SPRITE_ENEMY_EXPLODE_2:Class;
		/**
		 * 
		 * @param	sprite 	the xml reference for this object
		 * @param	id 	deprecated?
		 * @param	gridObjects array ofs tateless/stateful sprites
		 * @param	otherObjects
		 * @param	player	player object
		 * @param	parent_state sometimes we directly add stuff
		 * @return  -1 if no sprite made, otherwise the number of subsprites in addition to main sprites
		 */
        public static function makeSprite(sprite:XML, id:int, gridObjects:Array, otherObjects:Array = null, player:Player=null, parent_state:*=null, darkness:FlxSprite = null):int {
            var newSprite:FlxSprite;
            var x:int = parseInt(sprite.@x);
            var y:int = parseInt(sprite.@y) + Registry.HEADER_HEIGHT;
			var frame_type:int = parseInt(sprite.@frame);
            var permanence:int = parseInt(sprite.@p);
			var name:String = sprite.name();
			
            if (permanence == 0 && sprite.@alive == "false") sprite.@alive = "true";
            if (name == "Slime") {
				if (sprite.@alive == "false") {
					Registry.GRID_ENEMIES_DEAD++;
					return -1;
				}
				if (frame_type == Slime.KEY_T) sprite.@p = P_GLOBAL;
                newSprite = new Slime(x, y, id, frame_type,sprite,player,parent_state);
                gridObjects.push(newSprite);
                return 0;
            }  else if (name == "SinglePushBlock") {
                var spb:SinglePushBlock = new SinglePushBlock(x, y, sprite,player);
                gridObjects.push(spb);
                otherObjects.push(spb.sentinel);
                return 0;
            } else if (name == "Door") {
                newSprite = new Door(x, y, sprite, parent_state);
                parent_state.bg_sprites.add(newSprite);
				if (parseInt(sprite.@type.toXMLString()) == Door.NEXUS_PAD) {
					trace("Faking nexus pad");
					var _npc:NPC = new NPC(EventScripts.fake_xml("NPC",x.toString(),y.toString(),"generic","true","0","2"), parent_state,player);
					gridObjects.push(_npc);
					otherObjects.push(_npc.active_region);
					return 1;
				}
                return -1;
            } else if (name == "Wall_Laser") {
                var newerSprite:Wall_Laser = new Wall_Laser(x, y, sprite.@type, id);
                gridObjects.push(newerSprite);
                otherObjects.push(newerSprite.laser);
                return 1;
            } else if (name == "Eye_Light") {
                var eye_light:Eye_Light = new Eye_Light(x, y, sprite, darkness);
                gridObjects.push(eye_light); 
				otherObjects.push(eye_light.light);
				return 0;
            } else if (name == "Mover") {
                var mover:Mover = new Mover(x, y, player, 1.0,sprite,player,parent_state);
                gridObjects.push(mover); return 0;
            } else if (name == "KeyBlock") {
				if (sprite.@alive == "false") return -1;
				var keyBlock:KeyBlock = new KeyBlock(x, y, frame_type,player, sprite);
				gridObjects.push(keyBlock); return 0;
			} else if (name == "Key") {
				var key:Key = new Key(x, y,player,parent_state,sprite);
				gridObjects.push(key);
			} else if (name == "Hole") {
				var hole:Hole = new Hole(x, y, sprite,player);
				parent_state.bg_sprites.add(hole); return -1;
			} else if (name == "Gate") {
				sprite.@p = "2";
				var gate:Gate = new Gate(x, y, sprite,player);
				
				gridObjects.push(gate); return 0;
			} else if (name == "Treasure") {
				var treasure:Treasure = new Treasure(x, y, sprite,parent_state as FlxState);
				sprite.@p = "2";
				parent_state.fg_sprites.add(treasure.item);
				gridObjects.push(treasure); return 0;
			} else if (name == "CrackedTile") {
				var cracked_tile:CrackedTile = new CrackedTile(x, y, sprite,player);
				parent_state.anim_tiles_group.add(cracked_tile.hole);
				parent_state.anim_tiles_group.add(cracked_tile); //will get drawn because anim tiles added later
				return -1;
			} else if (name == "Button") {
				var button:Button = new Button(x, y, sprite,parent_state);
				parent_state.anim_tiles_group.add(button);
				return -1;
			} else if (name == "Sun_Guy") {
				if (sprite.@alive == "false") {
					Registry.GRID_ENEMIES_DEAD++;
					return -1;
				}
				var sun_guy:Sun_Guy = new Sun_Guy(x, y, darkness, parent_state as PlayState, sprite,player);
				gridObjects.push(sun_guy);
				return 0;
			} else if (name == "Dust") {
				var dust:Dust = new Dust(x, y, sprite, parent_state);
				parent_state.bg_sprites.add(dust);
				return -1;
			} else if (name == "Event") {
				//var event_script:EventScripts = new EventScripts();
				//gridObjects.push(event_script); //For consistency
				deal_with_event(sprite, parent_state);
				return -1;
					
			} else if (name == "Shieldy") {
				if (sprite.@alive == "false") {
					Registry.GRID_ENEMIES_DEAD++;
					return -1;
				}
				var shieldy:Shieldy = new Shieldy(x, y, sprite,parent_state as PlayState);
				gridObjects.push(shieldy); return 0;
			} else if (name == "Pew_Laser") {
				var pew_laser:Pew_Laser = new Pew_Laser(x, y, sprite, parent_state as PlayState);
				gridObjects.push(pew_laser); return 0;
			} else if (name == "Annoyer") {
				var annoyer:Annoyer = new Annoyer(x, y, sprite, player,parent_state);
				gridObjects.push(annoyer); return 0;
			} else if (name == "Console") {
				var console:Console = new Console(x, y, sprite,player);
				gridObjects.push(console);
				return 0;
			} else if (name == "Follower_Bro") {
				var fb:Follower_Bro = new Follower_Bro(sprite, player);
				fb.y += Registry.HEADER_HEIGHT;
				gridObjects.push(fb);
				return 0;
			} else if (name == "Sadbro") {
				var sadbro:Sadbro = new Sadbro(sprite, player);
				sadbro.y += Registry.HEADER_HEIGHT;
				gridObjects.push(sadbro);
				return 0;
			} else if (name == "Red_Walker") {
				var redwalker:Red_Walker = new Red_Walker(sprite,player);
				redwalker.y += Registry.HEADER_HEIGHT;
				gridObjects.push(redwalker);
				return 0;
			} else if (name == "Four_Shooter") {
				var fsht:Four_Shooter = new Four_Shooter(sprite, parent_state as PlayState, player);
				fsht.y += Registry.HEADER_HEIGHT;
				gridObjects.push(fsht);
				return 0;
			} else if (name == "Slasher") {
				var slasher:Slasher = new Slasher(sprite, parent_state as PlayState, player);
				slasher.y += Registry.HEADER_HEIGHT;
				gridObjects.push(slasher);
				return 0;
			}  else if (name == "On_Off_Laser") {
				var oolasser:On_Off_Laser = new On_Off_Laser(sprite,player);
				oolasser.y += Registry.HEADER_HEIGHT;
				oolasser.laser.y += Registry.HEADER_HEIGHT;
				gridObjects.push(oolasser);
				otherObjects.push(oolasser.laser);
				return 0;
			} else if (name == "Red_Pillar") {
				var red_pillar:Red_Pillar = new Red_Pillar(sprite,player,parent_state);
				red_pillar.y += Registry.HEADER_HEIGHT;
				gridObjects.push(red_pillar);
				return 0;
			} else if (name == "Solid_Sprite") {
				var ss:Solid_Sprite = new Solid_Sprite(sprite,false,player);
				ss.y += Registry.HEADER_HEIGHT;
				gridObjects.push(ss);
				ss.y += 0;
				return 0;
			} else if (name == "Big_Door") {
				var bigdoor:Big_Door = new Big_Door(sprite, player);
				bigdoor.y += Registry.HEADER_HEIGHT;
				otherObjects.push(bigdoor.active_region);
				gridObjects.push(bigdoor);
				parent_state.fg_sprites.add(bigdoor.locked_squares);
				parent_state.fg_sprites.add(bigdoor.white_flash);
				parent_state.fg_sprites.add(bigdoor.score_text_1);
				parent_state.fg_sprites.add(bigdoor.score_text_2);
				return 0;
			} else if (name == "Fisherman") {
				var fisherman:Fisherman = new Fisherman(sprite, player);
				fisherman.y += Registry.HEADER_HEIGHT;
				gridObjects.push(fisherman);
				return 0;
			} else if (name == "Jump_Trigger" || name == "Spring_Pad") {
				var jt:Jump_Trigger = new Jump_Trigger(sprite, player,parent_state);
				jt.y += Registry.HEADER_HEIGHT;
				gridObjects.push(jt);
				
				return 0;
			} else if (name == "NPC") {
				var npc:NPC = new NPC(sprite, parent_state,player);
				npc.y += Registry.HEADER_HEIGHT;
				gridObjects.push(npc);
				otherObjects.push(npc.active_region);
				return 0;
			} else if (name == "Red_Boss") {
				var redboss:Red_Boss = new Red_Boss(sprite, parent_state as PlayState, player);
				redboss.y += Registry.HEADER_HEIGHT;
				gridObjects.push(redboss);
				return 0;
			} else if (name == "Propelled") {
				var propelled:Propelled = new Propelled(sprite, player, parent_state);
				propelled.y += Registry.HEADER_HEIGHT;
				parent_state.bg_sprites.add(propelled);
				return -1;
			} else if (name == "Stop_Marker") {
				var stopmarker:Stop_Marker = new Stop_Marker(sprite, parent_state);
				stopmarker.y += Registry.HEADER_HEIGHT;
				gridObjects.push(stopmarker);
				return 0;
			} else if (name == "Person") {
				var person:Person = new Person(sprite, player, parent_state);
				person.y += Registry.HEADER_HEIGHT;
				gridObjects.push(person);
				return 0;
			} else if (name == "Rotator") {
				var rotator:Rotator = new Rotator(sprite, player);
				rotator.y += Registry.HEADER_HEIGHT;
				gridObjects.push(rotator);
				otherObjects.push(rotator.sprite_ball);
				return 0;
			} else if (name == "Frog") {
				var frog:Frog = new Frog(sprite, player, parent_state);
				frog.y += Registry.HEADER_HEIGHT;
				gridObjects.push(frog);
				return 0;
			}else if (name == "Spike_Roller") {
				var spike_roller:Spike_Roller = new Spike_Roller(sprite, player, parent_state);
				spike_roller.y += Registry.HEADER_HEIGHT;
				gridObjects.push(spike_roller);
				//adding done inside class
				return 0;
			} else if (name == "Dog") {
				var dog:Dog = new Dog(sprite, player, parent_state);
				dog.y += Registry.HEADER_HEIGHT;
				gridObjects.push(dog);
				return 0;
			} else if (name == "WallBoss") {
				var wallboss:WallBoss  = new WallBoss(sprite, player, parent_state);
				gridObjects.push(wallboss);
				return 0;
			} else if (name == "Pillar_Switch") {
				var psw:Pillar_Switch = new Pillar_Switch(sprite, player, parent_state);
				psw.y += 20; gridObjects.push(psw); return 0;
			} else if (name == "Switch_Pillar") {
				var ssss:Switch_Pillar = new Switch_Pillar(sprite, player, parent_state);
				ssss.y += 20; parent_state.bg_sprites.add(ssss); return -1;
			} else if (name == "Silverfish") {
				var silverfish:Silverfish = new Silverfish(sprite, player, parent_state);
				silverfish.y += Registry.HEADER_HEIGHT; gridObjects.push(silverfish); return 0;
			} else if (name == "Rat") {
				var rat:Rat = new Rat(sprite, player, parent_state);
				rat.y += Registry.HEADER_HEIGHT; gridObjects.push(rat); return 0;
			} else if (name == "Teleguy") {
				var teleguy:Teleguy = new Teleguy(sprite, player, parent_state);
				teleguy.y += Registry.HEADER_HEIGHT; gridObjects.push(teleguy); return 0;
			} else if (name == "Dash_Trap") {
				var dashtrap:Dash_Trap = new Dash_Trap(sprite, player, parent_state);
				dashtrap.y += Registry.HEADER_HEIGHT; gridObjects.push(dashtrap); return 0;
			} else if (name == "Gasguy") {
				var gasguy:Gasguy = new Gasguy(sprite, player, parent_state);
				gasguy.y += Registry.HEADER_HEIGHT; gridObjects.push(gasguy); return 0;
				
			} else if (name == "Terminal_Gate") {
				var tgate:Terminal_Gate = new Terminal_Gate(sprite, player, parent_state);
				tgate.y += Registry.HEADER_HEIGHT; gridObjects.push(tgate); return 0;
			} else if (name == "Dustmaid") {
				var dustmaid:Dustmaid = new Dustmaid(sprite, player, parent_state);
				dustmaid.y += Registry.HEADER_HEIGHT; gridObjects.push(dustmaid); return 0;
			} else if (name == "Splitboss") {
				var splitboss:Splitboss = new Splitboss(sprite, player, parent_state);
				splitboss.y += Registry.HEADER_HEIGHT; gridObjects.push(splitboss); return 0;
			} else if (name == "Nonsolid") {
				var nonsolid:Nonsolid = new Nonsolid(sprite);
				nonsolid.y += Registry.HEADER_HEIGHT; gridObjects.push(nonsolid); return 0;
			} else if (name == "Steam_Pipe") {
				var steam_pipe:Steam_Pipe = new Steam_Pipe(sprite, player, parent_state);
				steam_pipe.y += Registry.HEADER_HEIGHT; gridObjects.push(steam_pipe); return 0;
			} else if (name == "Burst_Plant") {
				var burstplant:Burst_Plant = new Burst_Plant(sprite, player, parent_state);
				burstplant.y += Registry.HEADER_HEIGHT; gridObjects.push(burstplant); return 0;
			} else if (name == "Dash_Pad") {
				var dashpad:Dash_Pad  = new Dash_Pad(sprite, player, parent_state);
				dashpad.y += Registry.HEADER_HEIGHT; parent_state.bg_sprites.add(dashpad); return -1;
			} else if (name == "Elevator") {
				var elevator:Elevator = new Elevator(sprite, player, parent_state);
				elevator.y += Registry.HEADER_HEIGHT; parent_state.fg_sprites.add(elevator);
				return -1;
			} else if (name == "Eye_Boss") {
				var eyeboss:Eye_Boss = new Eye_Boss(sprite, player, parent_state);
				eyeboss.y += Registry.HEADER_HEIGHT; 
				if (Eye_Boss.global_state != eyeboss.gs_water) {
					gridObjects.push(eyeboss);
				} else {
					parent_state.bg_sprites.add(eyeboss);
				}
				return -1;
			} else if (name == "HealthPickup") {
				var healthpickup:HealthPickup = new HealthPickup(x, y + 20, parseInt(sprite.@type), parent_state, sprite);
				
				gridObjects.push(healthpickup); return 0; //broken
			} else if (name == "Contort") {
				var contort:Contort = new Contort(sprite, player, parent_state);
				contort.y += Registry.HEADER_HEIGHT;
				gridObjects.push(contort); return 0;
			} else if (name == "Lion") {
				var lion:Lion = new Lion(sprite, player, parent_state);
				lion.y += Registry.HEADER_HEIGHT; 
				gridObjects.push(lion); return 0;
			} else if (name == "Circus_Folks") {
				var circus_folk:Circus_Folks = new Circus_Folks(sprite, player, parent_state);
				circus_folk.y += Registry.HEADER_HEIGHT; 
				gridObjects.push(circus_folk); return 0;
				
			} else if (name == "Fire_Pillar") {
				var fire_pillar:Fire_Pillar = new Fire_Pillar(sprite, player, parent_state);
				fire_pillar.y += Registry.HEADER_HEIGHT;
				gridObjects.push(fire_pillar); return 0;
			} else if (name == "solid_tile") {
				var g:FlxTilemap;
				var tx:int;
				var ty:int;
				
				g = parent_state.curMapBuf;
				tx = int((x % 160) / 16);
				ty = int(((y - 20) % 160) / 16);
				g.setTileByIndex(10 * ty + tx,1, false);
				
				// Now set the BG2 and FG2 layers since they don't load dynamically.
				tx = int(x / 16);
				ty = int((y - 20)/ 16);

				g = parent_state.map_bg_2;
				g.setTileByIndex(g.widthInTiles * ty + tx, 1, false);
				g = parent_state.map_fg;
				g.setTileByIndex(g.widthInTiles * ty + tx, 1, false);
				
			} else if (name == "Sage") {
				var sage:Sage = new Sage(player, parent_state, sprite);
				sage.y += Registry.HEADER_HEIGHT;
				gridObjects.push(sage); return 0;
			} else if (name == "Mitra") {
				var mitra:Mitra = new Mitra(player, parent_state, sprite);
				mitra.y += Registry.HEADER_HEIGHT;
				gridObjects.push(mitra); return 0;
			} else if (name == "Health_Cicada") {
				var hc:Health_Cicada = new Health_Cicada(player, parent_state, sprite);
				hc.y += Registry.HEADER_HEIGHT;
				parent_state.header_group.add(hc.boxes);
				parent_state.header_group.add(hc);
				
				Registry.subgroup_destroyems.push(hc);
				return -1;
			} else if (name == "Dungeon_Statue") {
				var dunst:Dungeon_Statue = new Dungeon_Statue(player, parent_state, sprite);
				dunst.y += Registry.HEADER_HEIGHT;
				gridObjects.push(dunst);
				return 0;
			} else if (name == "Chaser") {
				var chaser:Chaser = new Chaser(sprite, player, parent_state);
				chaser.y += Registry.HEADER_HEIGHT;
				gridObjects.push(chaser);
				return 0;
			} else if (Registry.CURRENT_MAP_NAME == "SUBURB") {
				if (name == "Suburb_Walker") {
					var subwalk:Suburb_Walker = new Suburb_Walker(new Array(sprite, player, parent_state,true));
					gridObjects.push(subwalk);
					return 0;
				} else if (name == "Suburb_Killer") {
					var subkiller:Suburb_Killer = new Suburb_Killer(new Array(sprite, player, parent_state,true));
					gridObjects.push(subkiller);
					return 0;
				}
			} else if (name == "Space_Face") {
				var space_face:Space_Face = new Space_Face(new Array(sprite, player, parent_state,true));
				gridObjects.push(space_face);
				return 0;
			} else if (name == "Water_Anim") {
				var waternaim:Water_Anim = new Water_Anim(new Array(sprite, player, parent_state));
				gridObjects.push(waternaim);
				return 0;
			} else if (name == "Go_Detector") {
				var gd:Go_Detector = new Go_Detector(new Array(sprite, player, parent_state,true));
				gridObjects.push(gd);
				return 0;
			} else if (name == "Sage_Boss") {
				var sbb:Sage_Boss = new Sage_Boss(new Array(sprite, player, parent_state, true));
				gridObjects.push(sbb);
				return 0;
			} else if (name == "Shadow_Briar") {
				if (Registry.CURRENT_MAP_NAME == "GO") {
					var briarboss:Briar_Boss = new Briar_Boss(new Array(sprite, player, parent_state, true));
					gridObjects.push(briarboss);
					return 0;
				}
				var sbri:Shadow_Briar = new Shadow_Briar(new Array(sprite, player, parent_state, true));
				gridObjects.push(sbri);
				return 0;
			} else if (name == "Trade_NPC") { //cat, monster, shopkeeper - in FIELDS
				var tradenpc:Trade_NPC = new Trade_NPC(new Array(sprite, player, parent_state, true));
				// only add to statelesses or wahetvver if it isnt the cat 
				if (parseInt(sprite.@frame) != 0) {
					gridObjects.push(tradenpc);
					return 0;
				}
				return -1;
			} else if (name == "Forest_NPC") {
				var forestnpc:Forest_NPC = new Forest_NPC(new Array(sprite, player, parent_state, true));
				gridObjects.push(forestnpc);
				return 0;
			} else if (name == "Redsea_NPC") {
				var redseanpc:Redsea_NPC = new Redsea_NPC(new Array(sprite, player, parent_state, true));
				gridObjects.push(redseanpc);
				return 0;
			} else if (name == "Happy_NPC") {
				var hapnpc:Happy_NPC = new Happy_NPC(new Array(sprite, player, parent_state, true));
				gridObjects.push(hapnpc);
				return 0;
			} else if (name == "Space_NPC") {
				var spacenpc:Space_NPC = new Space_NPC(new Array(sprite, player, parent_state, true));
				gridObjects.push(spacenpc);
				return 0;
			} else if (name == "Huge_Fucking_Stag") {
				var hfs:Huge_Fucking_Stag = new Huge_Fucking_Stag(new Array(sprite, player, parent_state, true));
				gridObjects.push(hfs);
				return 0;
			} else if (name == "Black_Thing") {
				var blackthing:Black_Thing = new Black_Thing(new Array(sprite, player, parent_state, true));
				gridObjects.push(blackthing);
			}
			
			 
			
            return -1;
        }
		
		public static function deal_with_event(e:XML,parent:*=null):int {
			var event_type:int = parseInt(e.@frame);
			
			switch (event_type) {
			case EVENT_TYPE_DARKNESS_ALPHA:
				Registry.EVENT_CHANGE_DARKNESS_ALPHA = true;
				Registry.EVENT_CHANGE_DARKNESS_ALPHA_TARGET = parseFloat(e.@type);
				break;
			case EVENT_TYPE_SCALE_VOLUME:
				Registry.EVENT_CHANGE_VOLUME_SCALE = true;
				Registry.EVENT_CHANGE_VOLUME_SCALE_TARGET = parseFloat(e.@type); 
				break;	
			case EVENT_TYPE_SET_ENTRANCE:
				var checkpoint:Checkpoint = new Checkpoint(parent.player, parent, e);
				checkpoint.y += Registry.HEADER_HEIGHT;
				parent.bg_sprites.add(checkpoint);
				break;
			case EVENT_TYPE_TEXT:
				var font:FlxBitmapFont;
				if (e.@type.toString() == "street1") {
					font = EventScripts.init_bitmap_font(" ", "center", 0, 0, new Point(1, 1), "apple_white");
				} else {
					font = EventScripts.init_bitmap_font(" ", "center", 0, 0, new Point(1, 1), "apple_black");
				}
				font.setText(set_text_event(e.@type.toString()),true,0,0,"center",true);
				font.x = parseInt(e.@x);
				font.y = parseInt(e.@y);
				parent.bg_sprites.add(font);
				//parent.sortables.add(font);
				font.y += Registry.HEADER_HEIGHT;
				return 1;
				
				break;
			case EVENT_TYPE_STATIC_OFF:
				PlayState.GFX_STATIC_ALWAYS_ON = false;
				parent.dec_over.exists = false;
				break;
			}
			return 0;
		}
        
		public static function set_text_event(type:String):String {
			if (type == "blank1") {
				return "                 \nMove with \n" + Registry.controls[Keys.IDX_UP] +", " + Registry.controls[Keys.IDX_DOWN]
					 + ",\n" + Registry.controls[Keys.IDX_LEFT] + ", " + Registry.controls[Keys.IDX_RIGHT];
			} else if (type == "blank2") {
				return "Interact with\nthe " + Registry.controls[Keys.IDX_ACTION_1] + " key.";
			} else if (type == "blank3") {
				if (!Intra.is_demo) {
					return "Press " + Registry.controls[Keys.IDX_PAUSE] + " \nto open the menu \nand save the game.\n";
				} else {
					return " ";
				}
				
			} else if (type == "street1") {
				return "Attack to pick up\nand drop dust.";
			}
			return "a";
			
		}
    }

}