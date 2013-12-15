package com.bourbontank.oneworld.sprites;

import flash.display.Sprite;

/**
 * ...
 * @author ...
 */
class TextBackgroundSprite extends Sprite
{

	public var borderOffset:Int = 2;
	public var borderLineWidth:Int = 2;
	
	public function new(width:Float, height:Float) 
	{
		super();
		
		var backgroundSprite:Sprite = new Sprite();
		backgroundSprite.graphics.beginFill(0xbbbbbb);
		backgroundSprite.graphics.drawRect(0, 0, width, height);
		backgroundSprite.graphics.lineStyle( borderLineWidth, 0x000000, 1 );
		addChild(backgroundSprite);
		
		var borderSprite:Sprite = new Sprite();
		borderSprite.graphics.lineStyle( borderLineWidth, 0x000000, 1 );
		borderSprite.graphics.moveTo(borderOffset, borderOffset);
		borderSprite.graphics.lineTo(width - borderOffset, borderOffset);
		borderSprite.graphics.lineTo(width - borderOffset, height - borderOffset);
		borderSprite.graphics.lineTo(borderOffset, height - borderOffset);
		borderSprite.graphics.lineTo(borderOffset, borderOffset);
		addChild(borderSprite);
		
	}
	
}