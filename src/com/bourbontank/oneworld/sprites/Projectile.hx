package com.bourbontank.oneworld.sprites;

import flash.display.BitmapData;
import flash.display.Sprite;
import spritesheet.AnimatedSprite;
import openfl.Assets;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;
/**
 * ...
 * @author 
 */
class Projectile extends EntitySprite
{
	public var speed:Float = 0.1;
	
	public function new() 
	{
		super();
		
		animated = true;
		mobile = true;
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/projectile.png");
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 12, 1, 16, 16);
		
		spritesheet.addBehavior(new BehaviorData("moving", [0, 1, 2, 3], true, 10));
		
		
		animatedSprite = new AnimatedSprite(spritesheet, true);
		addChild(animatedSprite);
		
		animatedSprite.showBehavior("moving");
		
	}
	
	
	
}