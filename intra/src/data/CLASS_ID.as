package data 
{
	/**
	 * BECAUSE STRING COMPARISONS ARE SLOW AS FUCK 
	 * IN THE COLLISION LOGIC
	 * 
	 * (I still do comparisons on names in SpriteFactory, though - not 
	 *  really an issue there)
	 * 
	 * (IDs for any object that is compared with its xml name...)
	 * @author Seagaia
	 */
	public class CLASS_ID 
	{
		
		/* ENEMIES */
		public static var SLIME:int = 0;
		public static var MOVER:int = 1;
		public static var PEW_LASER:int = 2;
		public static var SHIELDY:int = 3;
		public static var SUN_GUY:int = 4;
		public static var WALL_LASER:int = 5;
		public static var ANNOYER:int = 6;
		public static var RED_WALKER:int = 7;
		public static var FOUR_SHOOTER:int = 8;
		public static var SLASHER:int = 9;
		public static var ON_OFF_LASER:int = 10;
		public static var RED_BOSS:int = 11;
		public static var ROTATOR:int = 12;
		public static var PERSON:int = 13;
		public static var FROG:int = 14;
		public static var DOG:int = 15;
		public static var SPIKE_ROLLER:int = 16;
		public static var WALLBOSS:int = 17;
		public static var RAT:int = 18;
		public static var SILVERFISH:int = 19;
		public static var GASGUY:int = 20;
		public static var TELEGUY:int = 21;
		public static var DASHTRAP:int = 22;
		public static var DUSTMAID:int = 23;
		public static var BURSTPLANT:int = 24;
		
		
		/* DECORATIONS */
		public static var EYE_LIGHT:int = 100;
		public static var SOLID_SPRITE:int = 101;
		
		/* GADGETS */
		public static var BUTTON:int = 200;
		public static var CRACKEDTILE:int = 201;
		public static var DOOR:int = 202;
		public static var DUST:int = 203;
		public static var GATE:int = 204;
		public static var HOLE:int = 205;
		public static var KEY:int = 206;
		public static var KEYBLOCK:int = 207;
		public static var SINGLEPUSHBLOCK:int = 208;
		public static var TREASURE:int = 209;
		public static var CONSOLE:int = 210;
		public static var GROWTH_GATE:int = 211;
		public static var CHALLENGE_GATE:int = 212;
		public static var BIG_DOOR:int = 213;
		public static var JUMP_TRIGGER:int = 214;
		public static var PROPELLED:int = 215;
		public static var STOP_MARKER:int = 216;
		public static var PILLAR_SWITCH:int = 217;
		
		/* OTHER */
		public static var PLAYER:int = 300;
		public static var HEALTHPICKUP:int = 301;
		public static var BROOM:int = 302;
		public static var EVENT_SCRIPT:int = 303;
		public static var CONTROLSDEITY:int = 304;
		public static var FOLLOWER_BRO:int = 305;
		public static var RED_PILLAR:int = 306;
		public static var FISHERMAN:int = 307;
		public static var NPC_:int = 308;
		public static var TRADE_NPC:int = 309;
		public static var MITRA:int = 310;
		
	}

}