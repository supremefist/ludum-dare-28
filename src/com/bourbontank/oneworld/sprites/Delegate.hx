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
class Delegate extends EntitySprite
{
	public function new() 
	{
		super();
		
		animated = true;
		mobile = true;
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/delegate_front.png");
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 12, 1, 32, 64);
		
		var frameRate = 5;
		spritesheet.addBehavior(new BehaviorData("throw", [0, 1, 2, 3, 0], false, frameRate));
		spritesheet.addBehavior(new BehaviorData("idling", [0, 4, 0, 5, 0], true, frameRate));
		spritesheet.addBehavior(new BehaviorData("strafing", [10, 0, 11, 0], true, frameRate));
		
		animatedSprite = new AnimatedSprite(spritesheet, true);
		addChild(animatedSprite);
		
		animatedSprite.showBehaviors(["throw", "idling"]);
		
	}
	
}