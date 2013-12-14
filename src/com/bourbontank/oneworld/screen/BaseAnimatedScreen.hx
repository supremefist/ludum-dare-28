package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import flash.display.Sprite;
import flash.events.Event;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;
import flash.Lib;

/**
 * ...
 * @author 
 */
class BaseAnimatedScreen extends Screen
{

	var animatedSprites:Array<AnimatedSprite>;
	private var lastTime:Int;
	
	function new(display:Display, control:Control) 
	{
		super(display, control);
		
		animatedSprites = new Array<AnimatedSprite>();
		
		lastTime = Lib.getTimer();
		
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		
		for (animatedSprite in animatedSprites) {
			animatedSprite.update(delta);
		}
		
		//updateBorder(delta);
		lastTime = Lib.getTimer();
		
		
	}
}