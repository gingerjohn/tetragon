/*
 *      _________  __      __
 *    _/        / / /____ / /________ ____ ____  ___
 *   _/        / / __/ -_) __/ __/ _ `/ _ `/ _ \/ _ \
 *  _/________/  \__/\__/\__/_/  \_,_/\_, /\___/_//_/
 *                                   /___/
 * 
 * Tetragon : Game Engine for multi-platform ActionScript projects.
 * http://www.tetragonengine.com/ - Copyright (C) 2012 Sascha Balkau
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package tetragon.command.env
{
	import tetragon.command.CLICommand;
	import tetragon.debug.Log;
	import tetragon.util.env.getRuntimeVersion;

	import flash.display.StageDisplayState;
	
	
	/**
	 * CLI command to toggle fullscreen mode.
	 */
	public class ToggleFullscreenCommand extends CLICommand
	{
		//-----------------------------------------------------------------------------------------
		// Public Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function execute():void
		{
			var state:String = main.contextView.stage.displayState;
			var supportsInteractiveFS:Boolean = StageDisplayState["FULL_SCREEN_INTERACTIVE"] != null
				&& getRuntimeVersion().isEqualOrHigherThan(11, 3);
			
			/* Runtime supports interactive fullscreen mode. */
			if (supportsInteractiveFS)
			{
				if (state == StageDisplayState.FULL_SCREEN_INTERACTIVE)
				{
					state = StageDisplayState.NORMAL;
				}
				else
				{
					state = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				}
			}
			/* No interactive support available! */
			else
			{
				if (state == StageDisplayState.FULL_SCREEN)
				{
					state = StageDisplayState.NORMAL;
				}
				else
				{
					state = StageDisplayState.FULL_SCREEN;
				}
			}
			
			try
			{
				main.contextView.stage.displayState = state;
			}
			catch (err:Error)
			{
				Log.error("Could not apply displayState \"" + state
					+ "\" to stage. (Error was: " + err.message + ")", this);
			}
			
			complete();
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Getters & Setters
		//-----------------------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function get name():String 
		{
			return "toggleFullscreen";
		}
	}
}
