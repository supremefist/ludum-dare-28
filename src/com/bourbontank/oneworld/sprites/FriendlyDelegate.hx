package com.bourbontank.oneworld.sprites;
import flash.display.BitmapData;
import flash.display.Sprite;
import openfl.Assets;
/**
 * ...
 * @author 
 */
class FriendlyDelegate extends Delegate
{

	public function new(chamber:DebateChamber, x:Float, y:Float) 
	{
		super(chamber, x, y);
		friendly = true;
	}
	
	override public function getBitmapData() {
		var bitmapData:BitmapData = Assets.getBitmapData("img/delegate_back.png");
		return bitmapData;
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
	
	override public function stand() {
		animatedSprite.showBehavior("idling");
		crouched = false;
	}
	
	override public function crouch() {
		animatedSprite.showBehavior("crouch");
		crouched = true;
	}
}