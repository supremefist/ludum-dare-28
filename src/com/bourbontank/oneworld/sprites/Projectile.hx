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

import motion.Actuate;

/**
 * ...
 * @author 
 */
class Projectile extends EntitySprite
{
	public static var PROJECTILE_SPEED_MODIFIER = 0.3;
	
	public var baseSpeed:Float;
	public var baseVariance:Float = 0.05;
	public var speed:Float;
	public var potency:Int = 20;
	
	public var friendly:Bool = false;
	
	public function new(potency:Int) 
	{
		super();
		
		this.potency = potency;
		
		baseSpeed = PROJECTILE_SPEED_MODIFIER;
		
		animated = true;
		mobile = true;
		collidable = true;
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/projectile.png");
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width, bitmapData.height);
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 12, 1, 16, 16);
		
		spritesheet.addBehavior(new BehaviorData("moving", [0, 1, 2, 3], true, 10));
		spritesheet.addBehavior(new BehaviorData("rest", [0], true, 10));
		
		
		animatedSprite = new AnimatedSprite(spritesheet, true);
		addChild(animatedSprite);
		
		animatedSprite.showBehavior("moving");
		
		generateSpeed();
	}
	
	public function generateSpeed() {
		speed = Utils.generateRandom(baseSpeed, baseVariance);
	}
	
	public function hit() {
		mobile = false;
		animatedSprite.showBehavior("rest");
		
		var splashRange:Int = 25;
		
		var xModifier:Float = 1.0;
		var yModifier:Float = 1.0;
		
		if (Math.random() > 0.5) {
			xModifier = -1.0;
		}
		
		if (Math.random() > 0.5) {
			yModifier = -1.0;
		}
		
		var diffX = xModifier * (Math.random() * splashRange + splashRange);
		var diffY = yModifier * (Math.random() * splashRange + splashRange);
		
		Actuate.tween(this, 0.5, { x: x + diffX, y: y + diffY } );
	}
	
	
}