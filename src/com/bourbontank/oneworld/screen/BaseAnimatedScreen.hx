package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import flash.display.Sprite;
import flash.events.Event;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;

/**
 * ...
 * @author 
 */
class BaseAnimatedScreen extends Screen
{

	var animatedSprites:Array<AnimatedSprite>;
	
	function new(display:Display, control:Control) 
	{
		super(display, control);
		
		animatedSprites = new Array<AnimatedSprite>();
		
	}
	
	public function addAnimatedSprite(animatedSprite:AnimatedSprite) {
		animatedSprites.push(animatedSprite);
	}
	
	public function animateSprites(delta:Int):Void {
		for (animatedSprite in animatedSprites) {
			animatedSprite.update(delta);
		}
	}
}