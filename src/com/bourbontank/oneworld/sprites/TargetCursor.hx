package com.bourbontank.oneworld.sprites;

import flash.display.Sprite;
import flash.display.LineScaleMode;

/**
 * ...
 * @author 
 */
class TargetCursor extends Sprite
{

	public var hitBox:Sprite;
	
	public function new() 
	{
		super();
		
		var lines:Sprite = new Sprite();
		var spaceRadius:Int = 10;
		var lineRadius:Int = 20;
		
		lines.graphics.beginFill(0xFFFFFF, 1.0);
		lines.graphics.lineStyle(2, 0xAAFFAA, 1.0, false, LineScaleMode.NONE);
		
		// Right
		lines.graphics.moveTo(spaceRadius, 0);
		lines.graphics.lineTo(lineRadius, 0);
		
		// Left
		lines.graphics.moveTo(-spaceRadius, 0);
		lines.graphics.lineTo( -lineRadius, 0);
		
		// Top
		lines.graphics.moveTo(0, -spaceRadius);
		lines.graphics.lineTo(0, -lineRadius);
		
		// Bottom
		lines.graphics.moveTo(0, spaceRadius);
		lines.graphics.lineTo(0, lineRadius);
		
		addChild(lines);
		
		var bullseye:Sprite = new Sprite();
		
		bullseye.graphics.beginFill(0xAAFFAA, 1.0);
		bullseye.graphics.drawRect( -1, -1, 3, 3);
		addChild(bullseye);
		
	}
	
}