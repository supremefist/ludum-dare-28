package com.bourbontank.oneworld.sprites;

import flash.display.Sprite;
import flash.display.LineScaleMode;

/**
 * ...
 * @author 
 */
class ClickCursor extends Sprite
{

	public function new() 
	{
		super();
		
		graphics.beginFill(0xFFFFFF, 1.0);
		graphics.drawRect(0, 0, 5, 5);
	}
	
}