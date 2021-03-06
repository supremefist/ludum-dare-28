package com.bourbontank.oneworld.sprites;
import flash.display.BitmapData;
import flash.display.Sprite;
import openfl.Assets;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;


/**
 * ...
 * @author 
 */
class FriendlyDelegate extends Delegate
{

	public function new(chamber:DebateChamber, x:Float, y:Float) 
	{
		super(chamber, x, y, true);
		friendly = true;
	}
	
	override public function getSpriteSheet(random:Bool) {
		var bitmapData:BitmapData = Assets.getBitmapData("img/delegate_back.png");
		
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		randomizeAppearance(bitmapData);
		
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 13, 1, 32, 64);
	
		return spritesheet;
	}
	
	override public function getTarget():Delegate {
		var iteration:Int = 0;
		while (iteration < 10) {
			var index:Int = Math.floor(chamber.enemyDelegates.length * Math.random());
			var delegate:Delegate = chamber.enemyDelegates[index];
			if (delegate.isAlive()) {
				return delegate;
			}
			iteration += 1;
		}
		return null;
	}
	
	override public function createProjectile():Projectile {
		var projectile:Projectile = new Projectile(projectileDamage);
		projectile.friendly = true;
		projectile.generateSpeed();
		return projectile;
	}
	
	override public function stand() {
		if (crouched) {
			animatedSprite.showBehavior("idling");
			crouched = false;
		}
	}
	
	override public function crouch() {
		if (!crouched) {
			animatedSprite.showBehavior("crouch");
			crouched = true;
		}
	}
}