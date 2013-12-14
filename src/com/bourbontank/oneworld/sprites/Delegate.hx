package com.bourbontank.oneworld.sprites;

import com.bourbontank.oneworld.screen.DebateScreen;
import flash.display.BitmapData;
import flash.display.Sprite;
import spritesheet.AnimatedSprite;
import openfl.Assets;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;
import motion.Actuate;
/**
 * ...
 * @author 
 */
class Delegate extends EntitySprite
{
	var throwWait:Int = 0;
	var throwRate:Int = 2000;
	
	var currentTarget:Sprite = null;
	var chamber:DebateChamber;
	
	public function new(chamber:DebateChamber) 
	{
		super();
		
		this.chamber = chamber;
		
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
		
		animatedSprite.showBehaviors(["idling"]);
		
	}
	
	public function setCurrentTarget(target:Sprite) {
		currentTarget = target;
	}
	
	public function animateThrow() {
		animatedSprite.showBehavior("throw");
	}
	
	public function throwProjectile() {
		trace("Throwing!");
		trace("Animating...");
		animateThrow();
		trace("Projectiling");
		Actuate.timer (0.5).onComplete ( function() {
			trace("Calculating...");
			// Calculate required velocity
			var projectile:Projectile = new Projectile();
			
			var sourceX:Float = x;
			var sourceY:Float = y;
			
			//var targetX:Float = currentTarget.x;
			//var targetY:Float = currentTarget.y;
			var targetX:Float = chamber.screen.cursor.x;
			var targetY:Float = chamber.screen.cursor.y;
			
			var projectile = new Projectile();
			projectile.x = sourceX;
			projectile.y = sourceY;
			
			var diffX:Float = targetX - sourceX;
			var diffY:Float = targetY - sourceY;
			
			var angle:Float = Math.atan(diffX / diffY);
			projectile.velocityX = projectile.speed * Math.sin(angle);
			projectile.velocityY = projectile.speed * Math.cos(angle);
			
			if (diffY < 0) {
				projectile.velocityX = -1 * projectile.velocityX;
				projectile.velocityY = -1 * projectile.velocityY;
			}
			
			chamber.addProjectile(projectile);
			trace("Done!");
		});
		trace("Threw!");
		
	}
	
	override public function behave(delta:Int) {
		
		throwWait += delta;
		
		if ((throwWait >= throwRate) && (currentTarget != null)) {
			throwWait -= throwRate;
			
			// Time to throw!
			throwProjectile();
		}
	}
	
}