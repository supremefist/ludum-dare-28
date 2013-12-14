package com.bourbontank.oneworld.sprites;

import flash.display.BitmapData;
import flash.display.Sprite;
import spritesheet.AnimatedSprite;
import openfl.Assets;
import com.bourbontank.oneworld.Utils;

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
	public var baseSpeed:Float = 0.2;
	public var baseVariance:Float = 0.05;
	public var speed:Float;
	public var potency:Int = 20;
	
	public function new() 
	{
		super();
		
		animated = true;
		mobile = true;
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/projectile.png");
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width, bitmapData.height);
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 12, 1, 16, 16);
		
		spritesheet.addBehavior(new BehaviorData("moving", [0, 1, 2, 3], true, 10));
		
		
		animatedSprite = new AnimatedSprite(spritesheet, true);
		addChild(animatedSprite);
		
		animatedSprite.showBehavior("moving");
		
		generateSpeed();
	}
	
	public function generateSpeed() {
		speed = Utils.generateRandom(baseSpeed, baseVariance);
	}
	
	
	
}