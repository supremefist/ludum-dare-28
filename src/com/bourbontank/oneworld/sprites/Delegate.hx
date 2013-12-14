package com.bourbontank.oneworld.sprites;

import com.bourbontank.oneworld.screen.DebateScreen;
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
import motion.easing.Linear;
/**
 * ...
 * @author 
 */
class Delegate extends EntitySprite
{
	var throwWait:Int = 0;
	var baseThrowRate:Int = 2000;
	var baseThrowVariance:Int = 1000;
	var throwRate:Int;
	var throwError:Float = 100;
	
	var actWait:Int = 0;
	var baseActRate:Int = 2000;
	var baseActVariance:Int = 1000;
	var actRate:Int;
	
	var strafeDistance:Int = 48;
	var strafeVariance:Int = 10;
	
	var crouchRange:Int = 13;
	
	var currentTarget:Sprite = null;
	var chamber:DebateChamber;
	
	var hairColor:UInt = 0x000000;
	var skinColor:UInt = 0x000000;
	var race:Int;
	var tieColor:UInt;
	
	var crouched:Bool = false;
	
	var minX:Float;
	var maxX:Float;
	var rootY:Float;
	
	var actDuration:Int = 300;
	
	public function new(chamber:DebateChamber, x:Float, y:Float) 
	{
		super();
		
		this.x = x;
		this.y = y;
		
		this.chamber = chamber;
		
		minX = x - 50;
		maxX = x + 50;
		rootY = y;
		
		animated = true;
		mobile = true;
		
		var bitmapData:BitmapData = getBitmapData();
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		randomizeAppearance(bitmapData);
		
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 13, 1, 32, 64);
		
		var frameRate = 10;
		spritesheet.addBehavior(new BehaviorData("throw", [0, 1, 2, 3, 0], false, frameRate));
		spritesheet.addBehavior(new BehaviorData("idling", [0, 4, 0, 5, 0], true, frameRate));
		spritesheet.addBehavior(new BehaviorData("strafing", [10, 0, 11, 0], true, frameRate));
		spritesheet.addBehavior(new BehaviorData("surrender", [12], true, frameRate));
		
		animatedSprite = new AnimatedSprite(spritesheet, true);
		addChild(animatedSprite);
		
		animatedSprite.showBehavior("idling");
		
		generateThrowRate();
		generateActRate();
	}
	
	
	public function randomizeAppearance(bitmapData:BitmapData) {
		// Let's randomize some characteristics
		// Race (0: white, 1:black, 2:chinese: 3:indian)
		
		hairColor = 0x000000;
		skinColor = 0x000000;
		race = Math.round(Math.random() * 4);
		tieColor = Math.round(0xffffff * Math.random());
		
		if (Math.random() > 0.75) {
			// Old!
			hairColor = 0xe6e6e6;
		}

		if (race == 0) {
			// Caucasians can have blonde hair
			if (Math.random() > 0.5) {
				hairColor = 0xffff7d;
			}
		}
		else if (race == 1) {
			skinColor = 0x8c5536;
		}
		else if (race == 2) {
			skinColor = 0xe9d3c6;
		}
		else if (race == 3) {
			skinColor = 0xffc39f;
		}
		
		
		// Hair
		if (hairColor != 0x000000) {
			Utils.replaceColor(bitmapData, 0x050505, hairColor);
		}
		if (skinColor != 0x000000) {
			Utils.replaceColor(bitmapData, 0xffdbb6, skinColor);
		}
		
		Utils.replaceColor(bitmapData, 0x0000ff, tieColor);
	}
	
	public function getBitmapData() {
		var bitmapData:BitmapData = Assets.getBitmapData("img/delegate_front.png");
		return bitmapData;
	}
	
	
	public function generateThrowRate() {
		throwRate = Math.round(Utils.generateRandom(baseThrowRate, baseThrowVariance));
	}
	
	public function generateActRate() {
		actRate = Math.round(Utils.generateRandom(baseThrowRate, baseThrowVariance));
	}
	
	public function setCurrentTarget(target:Sprite) {
		currentTarget = target;
	}
	
	public function animateThrow() {
		animatedSprite.showBehaviors(["throw", "idling"]);
	}
	
	public function throwProjectile() {
		animatedSprite.showBehavior("idling");
		animateThrow();
		Actuate.timer (actDuration / 1000).onComplete ( function() {
			// Calculate required velocity
			var projectile:Projectile = new Projectile();
			
			var sourceX:Float = x;
			var sourceY:Float = y;
			
			//var targetX:Float = currentTarget.x;
			//var targetY:Float = currentTarget.y;
			var error:Float = (throwError * Math.random() - throwError / 2);
			trace(error);
			var targetX:Float = chamber.screen.cursor.x + error;
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
		});
		
		
		generateThrowRate();
	}
	
	public function stand() {
		animatedSprite.showBehavior("idling");
		var targetY:Float = rootY;
		Actuate.apply(this, { y: rootY + crouchRange});
		Actuate.tween(this, actDuration / 1000, { y:targetY } );
		crouched = false;
	}
	
	public function crouch() {
		animatedSprite.showBehavior("idling");
		var targetY:Float = rootY + crouchRange;
		Actuate.apply(this, { y: rootY});
		Actuate.tween(this, actDuration / 1000, { y:targetY } );
		crouched = true;
	}
	
	public function strafe() {
		var distance:Float = Utils.generateRandom(strafeDistance, strafeVariance);
		
		var right:Bool = true;
		if (x == minX) {
			right = true;
		}
		else if (x == maxX) {
			right = false;
		}
		else if (Math.random() > 0) {
			right = false;
		}
		
		if (right) {
			// Go right
			var targetX = Math.min(x + distance, maxX);
			Actuate.tween(this, actDuration / 250, { x:targetX } ).ease(Linear.easeNone);
			animatedSprite.showBehavior("strafing");
		}
		else {
			// Go left
			var targetX = Math.max(x - distance, minX);
			Actuate.tween(this, actDuration / 250, { x:targetX } ).ease(Linear.easeNone);
			animatedSprite.showBehavior("strafing");
		}
		
		
	}
	
	public function move() {
		if (crouched) {
			stand();
		}
		else {
			trace(minX + ", " + maxX);
			// Strafe or crouch
			if (Math.random() > 0.66) {
				crouch();
			}
			else {
				strafe();
			}
		}
		generateActRate();
	}
	
	override public function behave(delta:Int) {
		throwWait += delta;
		actWait += delta;
		
		if ((throwWait >= throwRate) && (actWait > actDuration) && (currentTarget != null) && (!crouched)) {
			// Time to throw!
			throwProjectile();
			
			throwWait = 0;
		}
		else if ((throwWait > actDuration) && (actWait > actRate)) {
			// We can move! (crouch, stand, strafe)
			move();
			
			actWait = 0;
		}
	}
	
}