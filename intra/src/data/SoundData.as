package data 
{
	import helper.Cutscene;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
    import org.flixel.FlxBasic;
	import global.Registry;
    import org.flixel.FlxSound;
    public class SoundData 
    {
		
		
		[Embed (source = "../../../mp3/title.mp3")] public static var Title_Song:Class;
		public var TITLE:FlxSound = new FlxSound();
		private var Title_Samples:int = 2491776; //checked 9-15-12
		
		[Embed (source = "../../../mp3/gameover.mp3")] public static var GameOver_Song:Class; 
		public var GameOver:FlxSound = new FlxSound();
		private var GameOver_Samples:int = 1397376; //checked 9-15-12
		
		[Embed (source = "../../../mp3/blank.mp3")] public static var Blank_Song:Class;
		public var BLANK:FlxSound = new FlxSound();
		private var Blank_Samples:int = 1568576;//checked 9-15-12
		
		[Embed (source = "../../../mp3/nexus.mp3")] public static var Nexus_Song:Class;
		public var NEXUS:FlxSound = new FlxSound();
		private var NEXUSSAMPLES:int = 2983680; //checked 9-15-12
		
		[Embed (source = "../../../mp3/street.mp3")] public static var Street_Song:Class; //street
		public var STREET:FlxSound = new FlxSound();
		private var Street_Samples:int = 2118528; //checked 9-15-12
		 
		[Embed (source = "../../../mp3/overworld.mp3")] public static var Overworld_Song:Class; //OVERWORLD
		public var OVERWORLD:FlxSound = new FlxSound();
		private var Overworld_Samples:int = 3646080; //checked 9-15-12
		
		[Embed (source = "../../../mp3/mitra.mp3")] public static var Mitra_Song:Class;
		public var MITRA:FlxSound = new FlxSound();
		private var MITRASAMPLES:int = 2290176; //checked 9-15-12
        
        [Embed (source = "../../../mp3/bedroom.mp3")] public  static var Bedroom_Song:Class; //Bedroom
        public  var BEDROOM:FlxSound = new FlxSound();
		private var Bedroom_Samples:int = 5293440; //checked 9-15-12
		
	
		public var BOSS:FlxSound = new FlxSound();
		
		[Embed (source = "../../../mp3/bedroom-boss.mp3")] public static var BedroomBoss_Song:Class;
		public var BEDROOMBOSS:FlxSound = new FlxSound();
		private var BEDROOMBOSSSAMPLES:int = 1580491;
		
		
		[Embed (source = "../../../mp3/fields.mp3")] public static var Fields_Song:Class;
		public var FIELDS:FlxSound = new FlxSound();
		private var FIELDSSAMPLES:int = 6298125; //checked 9-15-12
		
		///*
		[Embed (source = "../../../mp3/beach.mp3")] public static var Beach_Song:Class; 
		public var BEACH:FlxSound = new FlxSound();
		private var Beach_Samples:int = 3479040;
		
		
		
		[Embed (source = "../../../mp3/red_cave.mp3")] public static var Red_Cave_Song:Class;
		public var REDCAVE:FlxSound = new FlxSound(); //checked 10-7-12
		private var Red_Cave_Samples:int = 4021920;
		
		
		
		[Embed (source = "../../../mp3/red_sea.mp3")] public static var Red_Sea_Song:Class;
		public var REDSEA:FlxSound = new FlxSound();
		private var Red_Sea_Samples:int = 2723328;
		
		[Embed (source = "../../../mp3/redcave-boss.mp3")] public static var RedcaveBoss_Song:Class;
		public var REDCAVEBOSS:FlxSound = new FlxSound();
		private var REDCAVEBOSSSAMPLES:int = 1881600;
		
		[Embed (source = "../../../mp3/windmill.mp3")] public static var Windmill_Song:Class;
		public var WINDMILL:FlxSound = new FlxSound();
		private var WINDMILLSAMPLES:int = 5019267; // checked 10-20-12
		
		// END EXTENDED DEMO
		
		[Embed (source = "../../../mp3/apartment.mp3")] public static var Apartment_Song:Class;
		public var APARTMENT:FlxSound = new FlxSound();
		private var APARTMENTSAMPLES:int = 8192009;
		
		
		[Embed (source = "../../../mp3/forest.mp3")] public static var Forest_Song:Class;
		public var FOREST:FlxSound = new FlxSound();
		private var FORESTSAMPLES:int = 6542962; // 10-26
		[Embed (source = "../../../mp3/cliff.mp3")] public static var Cliff_Song:Class;
		public var CLIFF:FlxSound = new FlxSound();
		private var CLIFFSAMPLES:int = 5840402; // 10-26
		[Embed (source = "../../../mp3/crowd.mp3")] public static var Crowd_Song:Class;
		public var CROWD:FlxSound = new FlxSound(); //checked 10-7-12
		private var CROWDSAMPLES:int = 6919426;
		[Embed (source = "../../../mp3/space.mp3")] public static var Space_Song:Class; 
		public var SPACE:FlxSound = new FlxSound(); //1-8-12
		private var SPACESAMPLES:int = 4907395;
		[Embed (source = "../../../mp3/terminal.mp3")] public static var Terminal_Song:Class;
		public var TERMINAL:FlxSound = new FlxSound();
		private var TERMINALSAMPLES:int = 7560503; // 1-8-12
		[Embed (source = "../../../mp3/cell.mp3")] public static var Cell_Song:Class;
		public var CELL:FlxSound = new FlxSound();
		private var CELLSAMPLES:int = 5409600; //11-3-12
		
		[Embed (source = "../../../mp3/suburb.mp3")] public static var Suburb_Song:Class;
		public var SUBURB:FlxSound = new FlxSound();
		private var SUBURBSAMPLES:int = 3182553;
		
		
		[Embed (source = "../../../mp3/roof.mp3")] public static var Roof_Song:Class;
		public var ROOF:FlxSound = new FlxSound();
		private var ROOFSAMPLES:int = 7112084;
		
		
		[Embed (source = "../../../mp3/circus.mp3")] public static var Circus_Song:Class;
		public var CIRCUS:FlxSound = new FlxSound();
		private var CIRCUSSAMPLES:int = 7566553;
		
		[Embed (source = "../../../mp3/hotel.mp3")] public static var Hotel_Song:Class;
		public var HOTEL:FlxSound = new FlxSound(); // 12-2-12
		private var HOTELSAMPLES:int = 9328688;
		
		[Embed (source = "../../../mp3/happy.mp3")] public static var Happy_Song:Class;
		public var HAPPY:FlxSound = new FlxSound();
		private var HAPPYSAMPLES:int = 4456421; //checked 11-3-12
		
		
		
		
		[Embed (source = "../../../mp3/blue.mp3")] public static var Blue_Song:Class;
		public var BLUE:FlxSound = new FlxSound();
		private var BLUESAMPLES:int = 6755745; //12-8-12
		
		
		
		[Embed (source = "../../../mp3/go.mp3")] public static var Go_Song:Class;
		public var GO:FlxSound = new FlxSound();
		private var GOSAMPLES:int = 8090854;
		
		
		[Embed (source = "../../../mp3/sagefight.mp3")] public static var Sagefight_Song:Class;
		public var SAGEFIGHT:FlxSound = new FlxSound(); // checked 10-20-12
		private var SAGEFIGHTSAMPLES:int = 7467224;
		private var SAGEFIGHTLOOP:int = 2061770;
		
		
		
		[Embed (source = "../../../mp3/happy-init.mp3")] public static var Happyinit_song:Class;
		public var HAPPYINIT:FlxSound = new FlxSound();
		private var HAPPYINITSAMPLES:int = 1128960;
		
		[Embed (source = "../../../mp3/ending.mp3")] public static var Ending_Song:Class;
		public var ENDING:FlxSound = new FlxSound();
		private var ENDINGSAMPLES:int = 15323054;
		
		[Embed (source = "../../../mp3/briar-fight.mp3")] public static var BriarFight_Song:Class;
		public var BRIARFIGHT:FlxSound = new FlxSound();
		private var BRIARFIGHTSAMPLES:int = 5171605; // 11-25-12
		
		
		[Embed (source = "../../../mp3/pre_terminal.mp3")] public static var PreTerminal_Song:Class;
		public var PRETERMINAL:FlxSound = new FlxSound();
		private var PRETERMSAMPLES:int = 1226195;
		
		
		
		[Embed (source = "../../../mp3/soft.mp3")] public static var Soft_Song:Class;
		public var SOFT:FlxSound = new FlxSound();
		private var SOFTSAMPLES:int = 5007429;
		
		[Embed (source = "../../../mp3/crowd_boss.mp3")] public static var CrowdBoss_Song:Class;
		public var CROWDBOSS:FlxSound = new FlxSound();
		private var CROWDBOSSSAMPLES:int = 1128960;
		
		[Embed (source = "../../../mp3/apartment-boss.mp3")] public static var ApartmentBoss_Song:Class;
		public var APARTMENTBOSS:FlxSound = new FlxSound();
		private var APARTMENTBOSSSAMPLES:int = 1411199;
		
		[Embed (source = "../../../mp3/hotel-boss.mp3")] public static var HotelBoss_Song:Class;
		public var HOTELBOSS:FlxSound = new FlxSound();
		private var HOTELBOSSSAMPLES:int = 1394129;
		
		[Embed (source = "../../../mp3/circus-boss.mp3")] public static var CircusBoss_Song:Class;
		public var CIRCUSBOSS:FlxSound = new FlxSound();
		private var CIRCUSBOSSSAMPLES:int = 1299789;
		
		//*/
		
		
		/* Gadgets */
		[Embed (source = "../../../sfx/unlock.mp3")] private  var S_UNLOCK:Class; // Open locked door 
		[Embed (source = "../../../sfx/open.mp3")] private  var S_OPEN:Class; // Gate open jingle
		[Embed (source = "../../../sfx/pushblock.mp3")] private var S_PUSH_BLOCK:Class;
		[Embed (source = "../../../sfx/gettreasure.mp3")] private  var S_GET_TREASURE:Class;
		[Embed (source = "../../../sfx/keyget.mp3")] private  var S_GET_KEY:Class; //
		[Embed (source = "../../../sfx/button_up.mp3")] public static var S_BUTTON_UP:Class;
		[Embed (source = "../../../sfx/button_down.mp3")] public static var S_BUTTON_DOWN:Class;
		[Embed (source = "../../../sfx/floor_crack.mp3")] public static var S_FLOOR_CRACK:Class;
		[Embed (source = "../../../sfx/big_door_locked.mp3")] public static var S_Big_Door_Locked:Class;
		[Embed (source = "../../../sfx/fall_1.mp3")] public static var sfall1:Class; //Falling - spike roller
		[Embed (source = "../../../sfx/hit_ground_1.mp3")] public static var shitground1:Class; //Spike roller hits walls
		[Embed (source = "../../../sfx/sparkle_1.mp3")] public static var sparkle_1_c:Class; 
		[Embed (source = "../../../sfx/sparkle_2.mp3")] public static var sparkle_2_c:Class; 
		[Embed (source = "../../../sfx/sparkle_3.mp3")] public static var sparkle_3_c:Class; 
		[Embed (source = "../../../sfx/dash_pad_1.mp3")] public static var embed_dash_pad_1:Class; //
		[Embed (source = "../../../sfx/dash_pad_2.mp3")] public static var embed_dash_pad_2:Class; 
		[Embed (source = "../../../sfx/spring_bounce.mp3")] public static var embed_spring_bounce:Class; 
		
		
		
		/* Other things */
		[Embed (source = "../../../sfx/cicada_chirp.mp3")] public static var cicada_chirp_c:Class; 
		[Embed (source = "../../../sfx/cross2.mp3")] public static var embed_cross2:Class; 
		[Embed (source = "../../../sfx/cross3.mp3")] public static var embed_cross3:Class; 
		[Embed (source = "../../../sfx/cross4.mp3")] public static var embed_cross4:Class; 
	
		
		
		
		/* Bedroom  */
		[Embed (source = "../../../sfx/laser-pew.mp3")] public static var S_LASER_PEW:Class;
		[Embed (source = "../../../sfx/shieldy-hit.mp3")] public static var S_SHIELDY_HIT:Class;
		[Embed (source = "../../../sfx/shieldy_ineffective.mp3")] public static var shieldy_ineffective_embed:Class;
		[Embed (source = "../../../sfx/slime_walk.mp3")] public static var slime_walk_embed:Class;
		[Embed (source = "../../../sfx/slime_splash.mp3")] public static var slime_splash_embed:Class;
		[Embed (source = "../../../sfx/slime_shoot.mp3")] public static var slime_shoot_embed:Class;
		
		/* Sun boss */
		[Embed (source = "../../../sfx/sun_guy_scream2.mp3")] public static var S_SUN_GUY_SCREAM:Class; //softer
		[Embed (source = "../../../sfx/sun_guy_charge.mp3")] public static var S_SUN_GUY_CHARGE:Class; //
		
		/* Redcave */
		[Embed (source = "../../../sfx/slasher_atk.mp3")] public static var slasher_atk_embed:Class; // 
		[Embed (source = "../../../sfx/on_off_laser_shoot.mp3")] public static var on_off_laser_shoot_embed:Class;
		[Embed (source = "../../../sfx/4sht_shoot.mp3")] public static var four_shooter_shoot:Class;
		[Embed (source = "../../../sfx/4sht_pop.mp3")] public static var four_shooter_pop:Class;
		[Embed (source = "../../../sfx/mover_die.mp3")] public static var mover_die:Class;
		[Embed (source = "../../../sfx/mover_move.mp3")] public static var mover_move:Class;
		[Embed (source = "../../../sfx/red_cave_rise.mp3")] public static var embed_red_cave_rise:Class;
		
		/* Red boss */
		[Embed (source = "../../../sfx/bubble_loop.mp3")] public static var embed_bubble_loop:Class;
		[Embed (source = "../../../sfx/bubble_1.mp3")] public static var embed_bubble_1:Class;
		[Embed (source = "../../../sfx/bubble_2.mp3")] public static var embed_bubble_2:Class;
		[Embed (source = "../../../sfx/bubble_3.mp3")] public static var embed_bubble_3:Class;
		[Embed (source = "../../../sfx/bubble_triple.mp3")] public static var embed_bubble_triple:Class;
		[Embed (source = "../../../sfx/redboss_moan.mp3")] public static var embed_redboss_moan:Class;
		[Embed (source = "../../../sfx/small_wave.mp3")] public static var embed_small_wave:Class;
		[Embed (source = "../../../sfx/big_wave.mp3")] public static var embed_big_wave:Class;
		[Embed (source = "../../../sfx/redboss_death.mp3")] public static var embed_redboss_death:Class;
		
	
		/* Crowd */
		[Embed (source = "../../../sfx/dog_bark.mp3")] public static var embed_dog_bark:Class; //
		[Embed (source = "../../../sfx/dog_dash.mp3")] public static var embed_dog_dash:Class;
		[Embed (source = "../../../sfx/talk_1.mp3")] public static var embed_talk_1:Class;
		[Embed (source = "../../../sfx/talk_2.mp3")] public static var embed_talk_2:Class;
		[Embed (source = "../../../sfx/talk_3.mp3")] public static var embed_talk_3:Class;
		
		//wallboss
		[Embed (source = "../../../sfx/wb_hit_ground.mp3")] public static var embed_wb_hit_ground:Class;
		[Embed (source = "../../../sfx/wb_tap_ground.mp3")] public static var embed_wb_tap_ground:Class;
		[Embed (source = "../../../sfx/wb_shoot.mp3")] public static var embed_wb_shoot:Class;
		[Embed (source = "../../../sfx/wb_moan.mp3")] public static var embed_wb_moan:Class;
		[Embed (source = "../../../sfx/wb_moan_2.mp3")] public static var embed_wb_moan_2:Class;
		[Embed (source = "../../../sfx/talk_death.mp3")] public static var embed_talk_death:Class;
		
		
		//apt
		
		[Embed (source = "../../../sfx/teleguy_up.mp3")] public static var embed_teleguy_up:Class;
		[Embed (source = "../../../sfx/teleguy_down.mp3")] public static var embed_teleguy_down:Class;
		[Embed (source = "../../../sfx/gasguy_shoot.mp3")] public static var embed_gasguy_shoot:Class;
		[Embed (source = "../../../sfx/gasguy_move.mp3")] public static var embed_gasguy_move:Class;
		[Embed (source = "../../../sfx/sf_move.mp3")] public static var embed_sf_move:Class;
		[Embed (source = "../../../sfx/rat_move.mp3")] public static var embed_rat_move:Class;
		
		//splitboss
		
		[Embed (source = "../../../sfx/sb_split.mp3")] public static var embed_sb_split:Class;
		[Embed (source = "../../../sfx/sb_ball_appear.mp3")] public static var embed_sb_ball_appear:Class;
		[Embed (source = "../../../sfx/sb_hurt.mp3")] public static var embed_sb_hurt:Class;
		[Embed (source = "../../../sfx/sb_dash.mp3")] public static var embed_sb_dash:Class;
		/* hotel */
		
		[Embed (source = "../../../sfx/dustmaid_alert.mp3")] public static var embed_dustmaid_alert:Class;
		[Embed (source = "../../../sfx/elevator_open.mp3")] public static var embed_elevator_open:Class;
		[Embed (source = "../../../sfx/elevator_close.mp3")] public static var embed_elevator_close:Class;
		
		
		/* Circus */
		
		[Embed (source = "../../../sfx/flame_pillar.mp3")] public static var embed_flame_pillar:Class;
		[Embed (source = "../../../sfx/fireball.mp3")] public static var embed_fireball:Class;
		
		/* etc */
		[Embed (source = "../../../sfx/briar_shine.mp3")] public static var embed_briar_shine:Class; //
		[Embed (source = "../../../sfx/stream.mp3")] public static var embed_stream:Class;
		[Embed (source = "../../../sfx/dust_explode.mp3")] public static var embed_dust_explode:Class;
		
		
		/* Explosions/rumbles */
		[Embed (source = "../../../sfx/hit_wall.mp3")] public static var S_HIT_WALL:Class; //Bat die, sun guy hit wall
		[Embed (source = "../../../sfx/sun_guy_death_long.mp3")] public static var S_SUN_GUY_DEATH_L:Class;
		[Embed (source = "../../../sfx/sun_guy_death_short.mp3")] public static var S_SUN_GUY_DEATH_S:Class;
		[Embed (source = "../../../sfx/broom_hit.mp3")] public static var embed_broom_hit:Class;
		
		
		/* Player */
		[Embed (source = "../../../sfx/player_hit_1.mp3")] public static var S_PLAYER_HIT_1:Class; //Hitting an enemy
		[Embed (source = "../../../sfx/noise_step_1.mp3")] public static var S_NOISE_STEP_1:Class;
		[Embed (source = "../../../sfx/water_step.mp3")] public static var water_step:Class;
		[Embed (source = "../../../sfx/enter_door.mp3")] public static var embed_enter_door:Class;
		
		[Embed (source = "../../../sfx/fall_in_hole.mp3")] private  var S_FALL_IN_HOLE:Class; //
		[Embed (source = "../../../sfx/get_small_health.mp3")] public static var S_GET_SMALL_HEALTH:Class;
		[Embed (source = "../../../sfx/swing_broom_1.mp3")] public static var swing_broom_1:Class;
		[Embed (source = "../../../sfx/swing_broom_2.mp3")] public static var swing_broom_2:Class;
		[Embed (source = "../../../sfx/swing_broom_3.mp3")] public static var swing_broom_3:Class;
		
		[Embed (source = "../../../sfx/player_jump_up.mp3")] private static var player_jump_up_sound:Class;
		[Embed (source = "../../../sfx/player_jump_down.mp3")] private static var player_jump_down_sound:Class;
		[Embed (source = "../../../sfx/puddle_up.mp3")] private static var embed_puddle_up:Class;
		[Embed (source = "../../../sfx/puddle_down.mp3")] private static var embed_puddle_down:Class;
		[Embed (source = "../../../sfx/puddle_step.mp3")] private static var embed_puddle_step:Class;
		[Embed (source = "../../../sfx/ladder_step_2.mp3")] private static var embed_ladder_step_2:Class;
		[Embed (source = "../../../sfx/ladder_step_1.mp3")] private static var embed_ladder_step_1:Class;
		
		
		[Embed (source = "../../../sfx/teleport_up.mp3")] public static var S_TELEPORT_UP:Class; //
		[Embed (source = "../../../sfx/teleport_down.mp3")] public static var S_TELEPORT_DOWN:Class;
		
		/* Ambient */
		[Embed (source = "../../../sfx/wavesandwind.mp3")] private var S_BEACH_WAVES:Class;
		[Embed (source = "../../../sfx/rain.mp3")] private var embed_rain:Class;
		
		/* Menu */
		[Embed (source = "../../../sfx/menu_move.mp3")] public static var S_MENU_MOVE:Class;
		[Embed (source = "../../../sfx/menu_select.mp3")] public static var S_MENU_SELECT:Class;
		[Embed (source = "../../../sfx/pause_sound.mp3")] public static var S_PAUSE_SOUND:Class;
		[Embed (source = "../../../sfx/dialogue_bloop.mp3")] public static var dialogue_bloop_embed:Class;
		[Embed (source = "../../../sfx/dialogue_blip.mp3")] public static var dialogue_blip_embed:Class;
		
		public var unlock:FlxSound = new FlxSound();
		public var open:FlxSound = new FlxSound();
		public var fall_in_hole:FlxSound = new FlxSound();
		public var push_block:FlxSound = new FlxSound();
		public var button_up:FlxSound = new FlxSound();
		public var button_down:FlxSound = new FlxSound();
		public var floor_crack:FlxSound = new FlxSound();
		public var get_treasure:FlxSound = new FlxSound();
		public var get_key:FlxSound = new FlxSound();
		public var dash_pad_1:FlxSound = new FlxSound();
		public var dash_pad_2:FlxSound = new FlxSound();
		public var spring_bounce:FlxSound = new FlxSound();
		public var waves:FlxSound = new FlxSound();
		public var waves_samples:int = 1322496; //why is this here
		public var rain:FlxSound = new FlxSound();
		public var puddle_up:FlxSound = new FlxSound();
		public var puddle_down:FlxSound = new FlxSound();
		public var puddle_step:FlxGroup = new FlxGroup(2);
		public var rain_samples:int = 236955;
		public var ladder_step:FlxGroup = new FlxGroup(2);
		
		public var sun_guy_death_l:FlxSound = new FlxSound();
		public var sun_guy_death_s:FlxSound = new FlxSound();
		public var sun_guy_scream:FlxSound = new FlxSound();
		public var sun_guy_charge:FlxSound = new FlxSound();
		
		public var player_jump_down:FlxSound = new FlxSound();
		public var player_jump_up:FlxSound = new FlxSound();
		public var enter_door:FlxSound = new FlxSound();
		public var player_hit_1:FlxSound = new FlxSound();
		public var broom_hit:FlxSound = new FlxSound();
		
		public var teleport_up:FlxSound = new FlxSound();
		public var teleport_down:FlxSound = new FlxSound();
		
		public var shieldy_hit:FlxSound = new FlxSound();
		public var shieldy_ineffective:FlxGroup = new FlxGroup(4);
		
		//redcave
		
		public var red_cave_rise:FlxSound = new FlxSound();
		
		public var bubble_loop:FlxSound = new FlxSound();
		public var redboss_moan:FlxSound = new FlxSound();
		public var small_wave:FlxSound = new FlxSound();
		public var big_wave:FlxSound = new FlxSound();
		public var redboss_death:FlxSound = new FlxSound();
		
		//crod
		public var dog_dash:FlxGroup = new FlxGroup(3);
		
		public var talk_group:FlxGroup = new FlxGroup(5);
	
		public var wb_tap_ground:FlxSound = new FlxSound();
		public var wb_hit_ground:FlxSound = new FlxSound();
		public var wb_shoot:FlxSound = new FlxSound();
		public var wb_moan:FlxSound = new FlxSound();
		public var wb_moan_2:FlxSound = new FlxSound();
		
		public var talk_death:FlxSound = new FlxSound();
		
		//apt
		public var teleguy_up:FlxSound = new FlxSound();
		
		public var teleguy_down:FlxSound = new FlxSound();
		public var gasguy_shoot:FlxSound = new FlxSound();
		public var gasguy_move:FlxGroup = new FlxGroup(2);
		public var rat_move:FlxGroup = new FlxGroup(2);
		
		public var sb_split:FlxSound = new FlxSound();
		public var sb_hurt:FlxSound = new FlxSound();
		public var sb_dash:FlxSound = new FlxSound();
		public var sb_ball_appear:FlxGroup = new FlxGroup(5);
		
		public var sf_move:FlxGroup = new FlxGroup(3);
		//hotel
		
		public var dustmaid_alert:FlxSound = new FlxSound();
		public var elevator_open:FlxSound = new FlxSound();
		public var elevator_close:FlxSound = new FlxSound();
		
		//circus
		public var flame_pillar_group:FlxGroup= new FlxGroup(2);
		public var fireball_group:FlxGroup= new FlxGroup(4);
		
		public var get_small_health:FlxSound = new FlxSound();
		public var big_door_locked:FlxSound = new FlxSound();
		public var hitground1:FlxSound = new FlxSound();
		public var fall1:FlxSound = new FlxSound();
		public var slasher_atk:FlxSound = new FlxSound();
		public var on_off_laser_shoot:FlxSound = new FlxSound();
		public var dialogue_bloop:FlxSound = new FlxSound();
		public var cicada_chirp:FlxSound = new FlxSound();
		
		// Etc
		
		public var briar_shine_group:FlxGroup = new FlxGroup(8);
		public var stream_sound:FlxSound = new FlxSound();
		public var dust_explode_group:FlxGroup = new FlxGroup(3);
		public var mushroom_sound_group:FlxGroup = new FlxGroup(3);
		
		/* Groups of sounds! */
		public var slime_walk_group:FlxGroup = new FlxGroup(5);
		public var slime_splash_group:FlxGroup = new FlxGroup(8);
		public var slime_shoot_group:FlxGroup = new FlxGroup(2);
		
		public var four_shooter_shoot_group:FlxGroup = new FlxGroup(2);
		public var four_shooter_pop_group:FlxGroup = new FlxGroup(3);
		public var mover_move_group:FlxGroup = new FlxGroup(2);
		public var mover_die_group:FlxGroup = new FlxGroup(2);
		
		public var bubble_group:FlxGroup = new FlxGroup(4);
		public var bubble_triple_group:FlxGroup = new FlxGroup(4);
		
		public var laser_pew_group:FlxGroup = new FlxGroup(2);
		public var menu_move_group:FlxGroup = new FlxGroup(3);
		public var menu_select_group:FlxGroup = new FlxGroup(2);
		public var pause_sound_group:FlxGroup = new FlxGroup(2);
		public var enemy_explode_1_group:FlxGroup = new FlxGroup(5);
		public var swing_broom_group:FlxGroup = new FlxGroup(3);
		public var water_step_group:FlxGroup = new FlxGroup(3);
		public var dialogue_blip_group:FlxGroup = new FlxGroup(5);
		public var sparkle_group:FlxGroup = new FlxGroup(5);

		public var dog_bark_group:FlxGroup = new FlxGroup(2);
		
		public var current_song_name:String = "BEDROOM";
		public var current_song:FlxSound = new FlxSound();
		
		public function SoundData() {
			/* Init usually-one-off-noises. */
			unlock.loadEmbedded(S_UNLOCK, false);
			open.loadEmbedded(S_OPEN, false);
			push_block.loadEmbedded(S_PUSH_BLOCK, false);
			get_treasure.loadEmbedded(S_GET_TREASURE, false);
			get_key.loadEmbedded(S_GET_KEY, false);
			waves.loadEmbedded(S_BEACH_WAVES, true, waves_samples);
			rain.loadEmbedded(embed_rain, true, rain_samples);
			fall_in_hole.loadEmbedded(S_FALL_IN_HOLE, false);
			button_down.loadEmbedded(S_BUTTON_DOWN);
			button_up.loadEmbedded(S_BUTTON_UP);
			floor_crack.loadEmbedded(S_FLOOR_CRACK);
			big_door_locked.loadEmbedded(S_Big_Door_Locked);
			hitground1.loadEmbedded(shitground1);
			fall1.loadEmbedded(sfall1);
			dash_pad_1.loadEmbedded(embed_dash_pad_1);
			dash_pad_2.loadEmbedded(embed_dash_pad_2);
			spring_bounce.loadEmbedded(embed_spring_bounce);
			puddle_up.loadEmbedded(embed_puddle_up, false);
			puddle_down.loadEmbedded(embed_puddle_down, false);
			init_sound_group(puddle_step, embed_puddle_step);
			init_multi_sound_group(ladder_step, new Array(embed_ladder_step_1, embed_ladder_step_2), false);
			
			slasher_atk.loadEmbedded(slasher_atk_embed, false);
			on_off_laser_shoot.loadEmbedded(on_off_laser_shoot_embed, false);
			
			sun_guy_death_l.loadEmbedded(S_SUN_GUY_DEATH_L);
			sun_guy_death_s.loadEmbedded(S_SUN_GUY_DEATH_S);
			sun_guy_scream.loadEmbedded(S_SUN_GUY_SCREAM);
			sun_guy_charge.loadEmbedded(S_SUN_GUY_CHARGE);
			
			//redcave
			
			red_cave_rise.loadEmbedded(embed_red_cave_rise);
			bubble_loop.loadEmbedded(embed_bubble_loop, true, 89508);
			redboss_moan.loadEmbedded(embed_redboss_moan);
			big_wave.loadEmbedded(embed_big_wave, false);
			small_wave.loadEmbedded(embed_small_wave, false);
			redboss_death.loadEmbedded(embed_redboss_death);
			
			//crowd
			init_sound_group(dog_dash, embed_dog_dash);
			
			init_multi_sound_group(talk_group, new Array(embed_talk_1, embed_talk_1, embed_talk_2, embed_talk_3, embed_talk_3));
			wb_hit_ground.loadEmbedded(embed_wb_hit_ground);
			wb_tap_ground.loadEmbedded(embed_wb_tap_ground);
			wb_shoot.loadEmbedded(embed_wb_shoot);
			wb_moan.loadEmbedded(embed_wb_moan);
			wb_moan_2.loadEmbedded(embed_wb_moan_2);
			talk_death.loadEmbedded(embed_talk_death);
			
			//apt
			teleguy_down.loadEmbedded(embed_teleguy_down);
			teleguy_up.loadEmbedded(embed_teleguy_up);
			gasguy_shoot.loadEmbedded(embed_gasguy_shoot);
			init_sound_group(gasguy_move, embed_gasguy_move)
			init_sound_group(rat_move, embed_rat_move);
			
			sb_split.loadEmbedded(embed_sb_split);
			init_sound_group(sb_ball_appear, embed_sb_ball_appear);
			sb_dash.loadEmbedded(embed_sb_dash);
			sb_hurt.loadEmbedded(embed_sb_hurt);
			
			init_sound_group(sf_move, embed_sf_move);
			
			
			//hotel
			dustmaid_alert.loadEmbedded(embed_dustmaid_alert);
			elevator_close.loadEmbedded(embed_elevator_close);
			elevator_open.loadEmbedded(embed_elevator_open);
			//circus
			init_sound_group(flame_pillar_group, embed_flame_pillar);
			init_sound_group(fireball_group, embed_fireball);
			
			player_hit_1.loadEmbedded(S_PLAYER_HIT_1);
			enter_door.loadEmbedded(embed_enter_door);
			player_jump_down.loadEmbedded(player_jump_down_sound);
			player_jump_up.loadEmbedded(player_jump_up_sound);
			broom_hit.loadEmbedded(embed_broom_hit);
			
			teleport_down.loadEmbedded(S_TELEPORT_DOWN);
			teleport_up.loadEmbedded(S_TELEPORT_UP);
			shieldy_hit.loadEmbedded(S_SHIELDY_HIT, false);
			init_sound_group(shieldy_ineffective, shieldy_ineffective_embed);
			get_small_health.loadEmbedded(S_GET_SMALL_HEALTH, false);
			dialogue_bloop.loadEmbedded(dialogue_bloop_embed);
			cicada_chirp.loadEmbedded(cicada_chirp_c);
			
			GameOver.loadEmbedded(GameOver_Song);
			
			stream_sound.loadEmbedded(embed_stream);
			init_sound_group(dust_explode_group, embed_dust_explode);
			
			/* Init repeated noises */
			init_sound_group(laser_pew_group, S_LASER_PEW,false,0.1);
			init_sound_group(slime_walk_group, slime_walk_embed);
			init_sound_group(slime_shoot_group, slime_shoot_embed);
			init_sound_group(slime_splash_group, slime_splash_embed);
			init_sound_group(briar_shine_group, embed_briar_shine);
			
			init_sound_group(four_shooter_pop_group, four_shooter_pop);
			init_sound_group(four_shooter_shoot_group, four_shooter_shoot);
			init_sound_group(mover_move_group, mover_move);
			init_sound_group(mover_die_group, mover_die);
			
			init_multi_sound_group(bubble_group, new Array(embed_bubble_1, embed_bubble_1, embed_bubble_2, embed_bubble_3));
			init_sound_group(bubble_triple_group, embed_bubble_triple);
			
			init_sound_group(dog_bark_group, embed_dog_bark);
			
			init_multi_sound_group(mushroom_sound_group, new Array(embed_cross2, embed_cross3, embed_cross4), false, 1);
			init_sound_group(menu_move_group, S_MENU_MOVE);
			init_sound_group(menu_select_group, S_MENU_SELECT);
			init_sound_group(dialogue_blip_group, dialogue_blip_embed);
			init_sound_group(pause_sound_group, S_PAUSE_SOUND);
			init_sound_group(enemy_explode_1_group, S_HIT_WALL, false, 0.3);
			init_sound_group(water_step_group, water_step, false, 1);
			init_multi_sound_group(swing_broom_group, new Array(swing_broom_1, swing_broom_2, swing_broom_3), false, 1);
			init_multi_sound_group(sparkle_group, new Array(sparkle_1_c, sparkle_1_c, sparkle_2_c, sparkle_2_c,sparkle_3_c), false, 1);
		
		}
       
		public function init_sound_group(g:FlxGroup, embed_sound:Class, looped:Boolean=false,volume:Number=1):void {
			for (var i:int = 0; i < g.maxSize; i++) {
				var s:FlxSound = new FlxSound();
				s.loadEmbedded(embed_sound, looped);
				s.volume = volume;
				g.add(s);
			}
		}
		
		public function init_multi_sound_group(g:FlxGroup, sounds:Array, looped:Boolean = false, volume:Number = 1):void {
			for each (var sound:Class in sounds) {
				var s:FlxSound = new FlxSound;
				s.loadEmbedded(sound, looped, volume);
				g.add(s);
			}
		}
		
		/**
		 * Given a sound object to reference what to play and
		 * the title of the song, play it.
		 * 
		 * @param	song
		 * @param	title
		 */
		public  var trigger_soft:Boolean = false;
        public function start_song_from_title(title:String):void {
			if (current_song == null) current_song = new FlxSound();
			if (current_song.playing) current_song.stop();
			
			if (!Registry.sound_data.hasOwnProperty(title)) {
				if (title == "TRAIN") {
					title = "CELL"; // <_<
				} else if (title == "DRAWER") {
					// No music in post-death area
					if (true == Registry.GAMESTATE.in_death_room) {
						return;
					}
					title = "SUBURB";
				} else {
					title = "BEDROOM";
				}
			}
			if (Registry.E_PLAY_ROOF) {
				if (Registry.CURRENT_MAP_NAME == "REDCAVE" || Registry.CURRENT_MAP_NAME == "REDSEA") {
					title = "REDCAVE";
				} else {
					title = "ROOF";
				}
				Registry.E_PLAY_ROOF = false;
			} 
			
			if (title == "HAPPY") {
				if (!Registry.GE_States[Registry.GE_Happy_Started]) {
					title = "HAPPYINIT";
				}
			}
			
			
			if (title == "TERMINAL") {
				if (false == Registry.GE_States[Registry.GE_Sage_Dead_Idx]) {
					title = "PRETERMINAL";
				}
			}
			
			if (title == "SUBURB") {
				if (trigger_soft) {
					trigger_soft = false;
					title = "SOFT";
				}
			}
			
			if (title == "BOSS") {
				switch (Registry.CURRENT_MAP_NAME) {
					case "BEDROOM":
						title = "BEDROOMBOSS";
						break;
					case "REDCAVE":
						title = "REDCAVEBOSS";
						break;
					case "CROWD":
						title = "CROWDBOSS";
						break;
					case "APARTMENT":
						title = "APARTMENTBOSS";
						break;
					case "HOTEL":
						title = "HOTELBOSS";
						break;
					case "CIRCUS":
						title = "CIRCUSBOSS";
						break;
					default:
						title = "BEDROOMBOSS";
						break;
						
				}
			}
			
			//title = "TITLE"; // remove
			Registry.sound_data[title] = null;
			Registry.sound_data[title] = new FlxSound();
			//Registry.sound_data[title].loadEmbedded(Title_Song, true, Title_Samples); // remove
			///*
			if (title == "BEDROOM") {
                Registry.sound_data.BEDROOM.loadEmbedded(Bedroom_Song, true, Bedroom_Samples);
            } else if (title == "OVERWORLD") {
				Registry.sound_data.OVERWORLD.loadEmbedded(Overworld_Song, true, Overworld_Samples);
			} else if (title == "STREET") {
				Registry.sound_data.STREET.loadEmbedded(Street_Song, true, Street_Samples);
			} else if (title == "BLANK") {
				Registry.sound_data.BLANK.loadEmbedded(Blank_Song, true, Blank_Samples);
			} else if (title == "TITLE") {
				Registry.sound_data.TITLE.loadEmbedded(Title_Song, true, Title_Samples);
			}else if (title == "MITRA") {
				Registry.sound_data.MITRA.loadEmbedded(Mitra_Song, true, MITRASAMPLES);
			} else if (title == "FIELDS") {
				Registry.sound_data.FIELDS.loadEmbedded(Fields_Song, true, FIELDSSAMPLES);
			}else if (title == "NEXUS") {
				Registry.sound_data.NEXUS.loadEmbedded(Nexus_Song, true, NEXUSSAMPLES);
			}  else if (title == "BEDROOMBOSS") {
				Registry.sound_data.BEDROOMBOSS.loadEmbedded(BedroomBoss_Song, true, BEDROOMBOSSSAMPLES);
			}
			///*
			  else if (title === "BEACH") {
				Registry.sound_data.BEACH.loadEmbedded(Beach_Song, true, Beach_Samples);
			} else if (title == "REDSEA") {
               Registry.sound_data.REDSEA.loadEmbedded(Red_Sea_Song, true, Red_Sea_Samples);
			} else if (title == "REDCAVE") {
                Registry.sound_data.REDCAVE.loadEmbedded(Red_Cave_Song, true, Red_Cave_Samples);
			}  else if (title == "REDCAVEBOSS") {
				Registry.sound_data.REDCAVEBOSS.loadEmbedded(RedcaveBoss_Song, true, REDCAVEBOSSSAMPLES);
			} else if (title == "WINDMILL") {
				Registry.sound_data.WINDMILL.loadEmbedded(Windmill_Song, true, WINDMILLSAMPLES);
			}else if (title == "APARTMENT") {
				Registry.sound_data.APARTMENT.loadEmbedded(Apartment_Song, true, APARTMENTSAMPLES);
			}else if (title == "FOREST") {
				Registry.sound_data.FOREST.loadEmbedded(Forest_Song, true, FORESTSAMPLES);
			} else if (title == "SPACE") {
				Registry.sound_data.SPACE.loadEmbedded(Space_Song, true, SPACESAMPLES);
			} else if (title == "CLIFF") {
				Registry.sound_data.CLIFF.loadEmbedded(Cliff_Song, true, CLIFFSAMPLES);
			}  else if (title == "TERMINAL") {
				Registry.sound_data.TERMINAL.loadEmbedded(Terminal_Song, true, TERMINALSAMPLES);
			} else if (title == "CROWD") {
				Registry.sound_data.CROWD.loadEmbedded(Crowd_Song, true, CROWDSAMPLES);
			} else if (title == "CELL") {
				Registry.sound_data.CELL.loadEmbedded(Cell_Song, true, CELLSAMPLES);
			}  else if (title == "SUBURB") {
				Registry.sound_data.SUBURB.loadEmbedded(Suburb_Song, true, SUBURBSAMPLES);
			} else if (title == "ROOF") {
				Registry.sound_data.ROOF.loadEmbedded(Roof_Song, true, ROOFSAMPLES);
			} else if (title == "CIRCUS") {
				Registry.sound_data.CIRCUS.loadEmbedded(Circus_Song, true, CIRCUSSAMPLES,2009500);
			} else if (title == "HOTEL") {
				Registry.sound_data.HOTEL.loadEmbedded(Hotel_Song, true, HOTELSAMPLES);
			} else if (title == "GO") {
				Registry.sound_data.GO.loadEmbedded(Go_Song, true, GOSAMPLES);
			} else if (title == "HAPPY") {
				Registry.sound_data.HAPPY.loadEmbedded(Happy_Song, true, HAPPYSAMPLES);
			} else if (title == "BLUE") {
				Registry.sound_data.BLUE.loadEmbedded(Blue_Song, true, BLUESAMPLES);
			} else if (title == "SAGEFIGHT") {
				Registry.sound_data.SAGEFIGHT.loadEmbedded(Sagefight_Song, true, SAGEFIGHTSAMPLES,SAGEFIGHTLOOP);
			} else if (title == "HAPPYINIT") {
				Registry.sound_data.HAPPYINIT.loadEmbedded(Happyinit_song, true, HAPPYINITSAMPLES);
			} else if (title == "ENDING") {
				Registry.sound_data.ENDING.loadEmbedded(Ending_Song,false, ENDINGSAMPLES);
			} else if (title == "BRIARFIGHT") {
				Registry.sound_data.BRIARFIGHT.loadEmbedded(BriarFight_Song, true, BRIARFIGHTSAMPLES);
			} else if (title == "PRETERMINAL") {
				Registry.sound_data.PRETERMINAL.loadEmbedded(PreTerminal_Song, true, PRETERMSAMPLES);
			} else if (title == "DRAWER") {
				Registry.sound_data.SUBURB.loadEmbedded(Suburb_Song, true, SUBURBSAMPLES);
			} else if (title == "SOFT") {
				Registry.sound_data.SOFT.loadEmbedded(Soft_Song, true, SOFTSAMPLES);
			} else if (title == "CIRCUSBOSS") {
				Registry.sound_data.CIRCUSBOSS.loadEmbedded(CircusBoss_Song, true, CIRCUSBOSSSAMPLES);
			} else if (title == "HOTELBOSS") {
				Registry.sound_data.HOTELBOSS.loadEmbedded(HotelBoss_Song, true, HOTELBOSSSAMPLES);
			} else if (title == "APARTMENTBOSS") {
				Registry.sound_data.APARTMENTBOSS.loadEmbedded(ApartmentBoss_Song, true, APARTMENTBOSSSAMPLES);
			} else if (title == "CROWDBOSS") {
				Registry.sound_data.CROWDBOSS.loadEmbedded(CrowdBoss_Song, true, CROWDBOSSSAMPLES);
			}
			
			//*/
			
			current_song = Registry.sound_data[title];
			current_song_name = title;
			if (Registry.GAMESTATE != null) {
				Registry.GAMESTATE.last_song_time = 0; // avoid issues with changing song midmap
			}
			//current_song.volume = FlxG.volume;
			current_song.play();
			
			if (title == "WINDMILL" && Registry.CUTSCENES_PLAYED[Cutscene.Windmill_Opening] == 0) {
				current_song.stop();
			}
        }
		
		/**
		 * 
		 * @param	g	Group of the (loaded) flxsoudns ya wanna play
		 * @return	1 if a sound was played, 0 otherwise (too many playing);
		 */
		 
		public function play_sound_group(g:FlxGroup,vol:Number=1):int {
			for each (var s:FlxSound in g.members) {
				if (!s.playing) {
					s.volume = vol;
					s.play();
					
					return 1;
				}
				
			}
			return 0;
		}
		
		public function play_sound_group_randomly(g:FlxGroup):int {
			var a:Array = new Array;
			for (var i:int = 0; i < g.length; i++) {
				a.push(i);
			}
			
			for (i = 0; i < g.length; i++) {
				var r:int = (g.length - i) * Math.random(); // Get a random index into the the array of sound gruop indices to check
				var v:int = a[r]; // Store the sound group index to check
				a.splice(r, 1); // Remove the sound group index so we dont check again
				if (!g.members[v].playing) {
					g.members[v].play();
					return 1;
					break;
				}
				
			}
			return 0;
		}
		/*
		 * Stops the input song and resets it.
		 * */
		
		public function stop_current_song():void {
			if (current_song != null && current_song.playing) {
				current_song.stop();
			}
		}

    }

}