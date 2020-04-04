/**
 * FlxDelay
 * -- Part of the Flixel Power Tools set
 * 
 * v1.4 Modified abort so it no longer runs the stop callback (thanks to Cambrian-Man)
 * v1.3 Added secondsElapsed and secondsRemaining and some more documentation
 * v1.2 Added callback support
 * v1.1 Updated for the Flixel 2.5 Plugin system
 * 
 * @version 1.4 - July 31st 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel.plugin.photonstorm 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	import org.flixel.*;
	
	/**
	 * A useful timer that can be used to trigger events after certain amounts of time are up.
	 * Uses getTimer so is low on resources and avoids using Flash events.
	 * Also takes into consideration the Pause state of your game.
	 * If your game pauses, when it starts again the timer notices and adjusts the expires time accordingly.
	 */
	
	public class FlxDelay extends Sprite
	{
		/**
		 * true if the timer is currently running, otherwise false
		 */
		public var isRunning:Boolean;
		
		/**
		 * If you wish to call a function once the timer completes, set it here
		 */
		public var callback:Function;
		
		/**
		 * The duration of the Delay in milliseconds
		 */
		public var duration:int;
		
		private var started:int;
		private var expires:int;
		private var pauseStarted:int;
		private var pausedTimerRunning:Boolean;
		private var complete:Boolean;
		
		/**
		 * Create a new timer which will run for the given amount of ms (1000 = 1 second real time)
		 * 
		 * @param	runFor	The duration of this timer in ms. Call start() to set it going.
		 */
		public function FlxDelay(runFor:int)
		{
			duration = runFor;
		}
		
		/**
		 * Starts the timer running
		 */
		public function start():void
		{
			started = getTimer();
			expires = started + duration;
			isRunning = true;
			complete = false;
			
			pauseStarted = 0;
			pausedTimerRunning = false;
			
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		/**
		 * Has the timer finished?
		 */
		public function get hasExpired():Boolean
		{
			return complete;
		}
		
		/**
		 * Restart the timer using the new duration
		 * 
		 * @param	newDuration	The duration of this timer in ms.
		 */
		public function reset(newDuration:int):void
		{
			duration = newDuration;
			
			start();
		}
		
		/**
		 * The amount of seconds that have elapsed since the timer was started
		 */
		public function get secondsElapsed():int
		{
			return int((getTimer() - started) / 1000);
		}
		
		/**
		 * The amount of seconds that are remaining until the timer completes
		 */
		public function get secondsRemaining():int
		{
			return int((expires - getTimer()) / 1000);
		}
		
		private function update(event:Event):void
		{
			//	Has the game been paused?
			if (pausedTimerRunning == true && FlxG.paused == false)
			{
				pausedTimerRunning = false;
				
				//	Add the time the game was paused for onto the expires timer
				expires += (getTimer() - pauseStarted);
			}
			else if (FlxG.paused == true && pausedTimerRunning == false)
			{
				pauseStarted = getTimer();
				pausedTimerRunning = true;
			}
			
			if (isRunning && pausedTimerRunning == false && getTimer() > expires)
			{
				stop();
			}
		}
		
		/**
		 * Abors a currently active timer without firing any callbacks (if set)
		 */
		public function abort():void
		{
			stop(false);
		}
		
		private function stop(runCallback:Boolean = true):void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			
			isRunning = false;
			complete = true;
			
			if (callback is Function && runCallback == true)
			{
				callback.call();
			}
			
		}
		
	}

}