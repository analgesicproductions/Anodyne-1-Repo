package entity.interactive.npc 
{
	import data.CLASS_ID;
	import entity.decoration.Water_Anim;
	import flash.geom.Point;
	import global.Registry;
	import helper.DH;
	import helper.EventScripts;
	import org.flixel.AnoSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.EndingState;
	
	
	public class Shadow_Briar extends AnoSprite 
	{
		
		private const IDX_BEACH:int = 0;
		private const IDX_FOREST:int = 1;
		private const IDX_HAPPY:int = 2;
		private const IDX_BLUE:int = 3;
		private const IDX_GO:int = 4;
		
		private var idx:int;
		private var ctr:int;
		
		// Flipped when cutscene finished or xml.alive is false
		// notifies the other events to start (gate raising, mitra appearing)
		
		private static var is_finished_blue:Boolean = false;
		private static var is_finished_happy:Boolean = false;
		
		private var mitra:FlxSprite;
		private var t:Number = 0;
		private var wheel:FlxSprite;
		public var cid:int = 0;
		
		[Embed(source = "../../../res/sprites/npcs/shadow_briar.png")] public static var embed_shadow_briar:Class; 
		[Embed(source = "../../../res/sprites/npcs/briar.png")] public static var embed_briar:Class;
		[Embed(source = "../../../res/sprites/npcs/hamster_wheel.png")] public static var embed_wheel:Class;
		public function Shadow_Briar(args:Array) 
		{
			super(args);
			
			
			// MARINA_ANIMS
			loadGraphic(embed_briar, true, false, 16, 16);
			addAnimation("idle_d", [20], 12);
			addAnimation("idle_l", [26], 12);
			addAnimation("idle_r", [22], 12);
			addAnimation("idle_u", [24], 12);
			addAnimation("walk_d", [20, 21], 4);
			addAnimation("walk_l", [26,27], 4);
			addAnimation("walk_r", [22,23], 4);
			addAnimation("walk_u", [24,25], 4);
			play("idle_d");
			
			alpha = 0; 
			ctr = 0;
		
			idx = parseInt(xml.@frame);
			
			if (xml.@alive == "false") {
				exists = false;
			}
			if (Registry.CURRENT_MAP_NAME == "BLUE") {
				
				if (exists) {
					mitra = new FlxSprite(tl.x + 160, tl.y + 76 );
					mitra.loadGraphic(Mitra.mitra_on_bike_sprite, true, false, 20, 20);
					
					mitra.addAnimation("bike_r", [2,3], 8);
					mitra.addAnimation("bike_l", [2, 3], 8);
					mitra.addAnimation("idle", [2], 8);
					mitra.play("bike_l");
					mitra.scale.x = -1;
					mitra.visible = false;
					parent.sortables.add(mitra);
					
				}
				
				// MARINA_ANIMS_HAMSTER_WHEEL
				//wheel = new FlxSprite(tl.x + 48, tl.y + 4 * 16);
				//wheel.loadGraphic(embed_wheel, true, false, 32, 32);
				//wheel.addAnimation("idle", [0], 10);
				//wheel.addAnimation("spin1", [0, 1], 5);
				//wheel.addAnimation("spin2", [0, 1], 10);
				//wheel.addAnimation("spin3", [0, 1], 15);
				//wheel.addAnimation("backspin", [1, 0], 20);
				//if (Registry.GE_States[Registry.GE_Briar_Blue_Done]) {
					//wheel.play("spin3");
				//} else {
					//wheel.play("idle");
				//}
				//parent.fg_sprites.add(wheel);
				ctr = -1;
				
			}
			
			
		}
		
		override public function destroy():void 
		{
			parent.sortables.remove(mitra, true);
			mitra = null;
			DH.dont_need_recently_finished();
			wheel = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			
			switch (idx) {
				case IDX_BEACH:
					update_beach();
					break;
				case IDX_HAPPY:
					update_happy();
					break;
				case IDX_BLUE:
					update_blue();
					break;
				case IDX_FOREST:
					update_forest();
					break;
				case IDX_GO:
					update_go();
					break;
			}
			super.update();
		}
		
		private function update_go():void {
			
		
			
			
			
		}
		//private var wheel_start_pt:Point = new Point(0, 0);
		//private var t_wheel_snd:Number = 0;
		//private var tm_wheel_snd:Number = 0.2;
		private var total_ticks:int = 100;
		private function update_blue():void {
			switch (ctr) {
				// 1. Hamster wheel waits. If close enough..
				// 2. Fadeout song.
				// 3. Fade in MITRA.
				case -1:
					/// something about presing buttons
					if (player.x < tl.x + 76 && player.y < tl.y + 47 && player.state == player.S_GROUND) {
						player.be_idle();
						DH.disable_menu();
						ctr++;
					}
					break;
				//case -2:
					//player.x = wheel_start_pt.x;
					//player.y = wheel_start_pt.y;
					//if (Registry.keywatch.LEFT) {
						//t_wheel_snd += FlxG.elapsed;
						//
						//if (t_wheel_snd > tm_wheel_snd) {
							//t_wheel_snd = 0;
							//total_ticks --;
							//Registry.sound_data.play_sound_group(Registry.sound_data.dialogue_blip_group);
							//if (total_ticks < 45) {
								//tm_wheel_snd = 0.05;
								//wheel.play("spin3");
							//} else if (total_ticks < 84) {
								//tm_wheel_snd = 0.09;
								//wheel.play("spin2");
							//} else {
								//wheel.play("spin1");
							//}
						//}
					//}
					//if (total_ticks < 0) {
						//ctr--;
						//FlxG.shake(0.01, 0.5);
						//Registry.sound_data.hitground1.play();
						//wheel.play("idle");
						//player.state = player.S_INTERACT;
					//}
					//break;
				//case -3:
					//player.x = wheel_start_pt.x;
					//player.y = wheel_start_pt.y;
					//t_wheel_snd += FlxG.elapsed;
					//if (t_wheel_snd > 1) {
						//player.play("walk_r");
						//wheel.play("backspin");
						//FlxG.shake(0.01, 0.5);
						//Registry.sound_data.hitground1.play();
						//ctr--;
						//t_wheel_snd = 0;
						//total_ticks = 50;
					//}
					//break;
				//case -4:
					//player.x = wheel_start_pt.x;
					//player.y = wheel_start_pt.y;
					//t_wheel_snd += FlxG.elapsed;
					//if (t_wheel_snd > tm_wheel_snd) {
						//t_wheel_snd = 0;
						//Registry.sound_data.play_sound_group(Registry.sound_data.dialogue_blip_group);
						//total_ticks--;
						//if (total_ticks < 0) {
							//wheel.play("idle");
							//Registry.sound_data.player_hit_1.play();
							//ctr--;
						//}
					//}
					//break;
				//case -5:
					//player.play("slumped");
					//if (EventScripts.send_property_to(player, "x", tl.x + 140,2) ){
						//FlxG.shake(0.02, 0.76);
						//Registry.sound_data.hitground1.play();
						//ctr = 0;
					//}
					//break;
				case 0:
					ctr++;
					DH.disable_menu();
					player.state = player.S_INTERACT;
					player.be_idle();
					mitra.y = tl.y + 33;
					mitra.visible = true;
					break;
				case 1:
					Registry.volume_scale -= 0.04;
					if (Registry.volume_scale <= 0) {
						Registry.sound_data.stop_current_song();
						ctr++;
					}
					break;
				case 2:
					Registry.volume_scale += 0.01;
					if (Registry.volume_scale > 0.5) {
						Registry.sound_data.start_song_from_title("MITRA");
						ctr++;
						DH.start_dialogue(DH.name_mitra, DH.scene_mitra_blue_one);
					}
					break;
				// 4. Mitra Bikes in. 
				// 5. Mitra sas hi
				case 3:
					if (DH.a_chunk_is_playing() == true) break;
					if (Registry.volume_scale < 1) Registry.volume_scale += 0.01;
					mitra.play("bike_l");
					mitra.velocity.x = -70;
					player.be_idle();
					player.state = player.S_INTERACT;
					x = mitra.x;
					y = mitra.y;
					cid = CLASS_ID.MITRA;
					if (mitra.x < tl.x + 75) { // ?
						Registry.GRID_PUZZLES_DONE += 3;
						mitra.velocity.x = 0;
						mitra.play("idle");
						ctr++;
						// says something else?
						DH.start_dialogue(DH.name_mitra, DH.scene_mitra_blue_one);	
					}
					break;
					// Mitra goes across buttons and they presumably open
				case 4:
					if (DH.a_chunk_just_finished()) {
						ctr++;
						player.state = player.S_INTERACT;
					}
					break;
				// 8. Gate opens.
				// 9. Mitra says BYE!
				case 5:
						ctr++;
						parent.dialogue_latency = -1;
						DH.start_dialogue(DH.name_mitra, DH.scene_mitra_blue_one);	
					break; 	
				// 10. Mitra bikes to right.
				case 6:
					if (DH.a_chunk_just_finished() || false == DH.a_chunk_is_playing()) {
						ctr++;
						player.state = player.S_INTERACT;
						
						mitra.velocity.x = 40;
						mitra.play("bike_r");
						mitra.scale.x = 1;
					}
				// 11. Song fades out.
				case 7:
					if (mitra.x > tl.x + 160) {
						mitra.exists = false;
						Registry.volume_scale -= 0.03;
						if (Registry.volume_scale < 0) {
							Registry.volume_scale = 0;
							Registry.sound_data.stop_current_song();
							ctr = 69;
						}
					}
					break;
				case 69:
					t += FlxG.elapsed;
					if (t  > 1.5) {
						t = 0;
						ctr = 8;
						y = tl.y;
						x = tl.x + 48;
					}
					break;
				// 12. Briar fades in
				case 8:
					alpha += 0.02;
					if (alpha > 0.5) {
						ctr++;
						play("walk_d");
					}
					break;
				// 13. Briar walks down, while GO fades in
				case 9:
					alpha += 0.02;
					Registry.volume_scale += 0.02;
					if (Registry.volume_scale > 0.5) {
						velocity.y = 20;
						Registry.sound_data.start_song_from_title("GO");
						Water_Anim.START_WATER_ANIMF();
						ctr++;
					}
					break;
				case 10:
					alpha += 0.02;
					if (Registry.volume_scale < 1) {
						Registry.volume_scale += 0.02;
					} else {
						Registry.volume_scale = 1;
					}
					
					if (y > tl.y + 43) {
						velocity.y = 0;
						velocity.x = -20;
						Registry.GE_States[Registry.GE_Briar_Blue_Done] = true;
						play("walk_l");
						ctr++;
					}
					break;
				case 11:
					if (x < tl.x - 16) {
						ctr++;
					}
					break;
				case 12:
					is_finished_blue = true;
					xml.@alive = "false";
					exists = false;
					player.state = player.S_GROUND;
					DH.enable_menu();
					break;
					
				// 15. Briar walks left and elaves.	
			}
		}
		
		private function update_happy():void {
			
			switch (ctr) {
				case 0: // Wait until switch is pressed
					if (Registry.GRID_PUZZLES_DONE > 0) {
						ctr++;
						player.be_idle();
						player.state = player.S_INTERACT;
						DH.disable_menu();
						play("walk_d");
					}
					break;
				case 1:
					Registry.volume_scale -= 0.01;
					if (Registry.volume_scale <= 0) {
						ctr++;
						Registry.sound_data.stop_current_song();
						Registry.GE_States[Registry.GE_Briar_Happy_Done] = true;
					}
					break;
				case 2:
				// walk downwards a bit, fading in. remove palyer control
					alpha += 0.004;
					Registry.volume_scale += 0.004;
					if (alpha > 0.4) {
						velocity.y = 20;
						if (Registry.sound_data.current_song != null && !Registry.sound_data.current_song.playing ) {
							Water_Anim.START_WATER_ANIMF();
							Registry.sound_data.start_song_from_title("GO");
						}
					}
					if (y >= tl.y + 44) {
						velocity.y = 0;
						velocity.x = 20;
						play("walk_r");
						alpha = 1;
						ctr++;
					}
					break;
				case 3:
				// walk to the right, out of the screen
					if (x > tl.x + 16 * 10) {
						visible = false;
						velocity.x = 0;
						ctr++;
					}
					break;
				case 4:
					player.state = player.S_GROUND;
					DH.enable_menu();
					is_finished_happy = true;
					Registry.GE_States[Registry.GE_Briar_Happy_Done] = true;
					xml.@alive = "false";
					exists = false;
					break;
			}
		}
		
		private function update_beach():void {
			
			switch (ctr) {
				case 0:
					play("walk_d");
					velocity.y = 20;
					alpha += 0.007;
					if (alpha >= 1) {
						ctr++;
						play("idle_d");
					}
					break;
				case 1:
					velocity.y = 0;
					
					if (player.overlaps(this)) {
						ctr++;
						velocity.y = 15;
						play("walk_d");
						xml.@alive = "false";
					}
					break;
				case 2:
					alpha -= 0.01;
					break;
					
			}
		
		}
		
		private function update_forest():void {
			switch (ctr) {
				case 0:
					play("walk_u");
					velocity.y = -20;
					alpha += 0.005;
					if (y < tl.y - 16) {
						xml.@alive = "false";
						exists = false;
					}
					
					break;
				case 1:
					break;
				case 2:
					break;
			}
		}
	}

}