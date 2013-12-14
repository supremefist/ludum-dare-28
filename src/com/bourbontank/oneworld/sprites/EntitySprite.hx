package com.bourbontank.oneworld.sprites;

import flash.display.Sprite;
import spritesheet.AnimatedSprite;

/**
 * ...
 * @author 
 */
class EntitySprite extends Sprite
{
	public var velocityX:Float = 0;
	public var velocityY:Float = 0;
	public var mobile:Bool = false;
	public var animated = false;
	public var animatedSprite:AnimatedSprite;
	
	public function new() 
	{
		super();
	}
	
	public function update(delta:Int)
	{
		this.behave(delta);
		
		if (mobile) {
			x += velocityX * delta;
			y += velocityY * delta;
		}
		
		if (animated) {
			animateSprite(delta);
		}
	}
	
	public function animateSprite(delta:Int):Void {
		animatedSprite.update(delta);
	}
	
	public function behave(delta:Int) {
		
	}
}