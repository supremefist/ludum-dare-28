package com.bourbontank.oneworld.sprites;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import openfl.Assets;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;
import com.bourbontank.oneworld.Utils;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.Lib;
/**
 * ...
 * @author 
 */
class PlayerDelegate extends FriendlyDelegate
{

	var leftDown = false;
	var rightDown = false;
	var downDown = false;
	var upDown = false;
	var attacking = false;
	var strafing = false;
	var idling = true;
	
	public function new(chamber:DebateChamber, x:Float, y:Float) 
	{
		super(chamber, x, y);
		
		morale = 100;
		
		Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDown);
		Lib.current.stage.addEventListener (KeyboardEvent.KEY_UP, keyUp);
		
		chamber.screen.targetMouseDown = targetMouseDown;
		chamber.screen.targetMouseUp = targetMouseUp;
	}
	
	public function keyDown(e:KeyboardEvent) {
		if ((e.keyCode == Keyboard.A) || (e.keyCode == Keyboard.LEFT)) {
			leftDown = true;
		}
		else if ((e.keyCode == Keyboard.D) || (e.keyCode == Keyboard.RIGHT)) {
			rightDown = true;
		}
		else if ((e.keyCode == Keyboard.S) || (e.keyCode == Keyboard.DOWN)) {
			downDown = true;
		}
		else if ((e.keyCode == Keyboard.W) || (e.keyCode == Keyboard.UP)) {
			upDown = true;
		}
	}
	
	public function keyUp(e:KeyboardEvent) {
		if ((e.keyCode == Keyboard.A) || (e.keyCode == Keyboard.LEFT)) {
			leftDown = false;
		}
		else if ((e.keyCode == Keyboard.D) || (e.keyCode == Keyboard.RIGHT)) {
			rightDown = false;
		}
		else if ((e.keyCode == Keyboard.S) || (e.keyCode == Keyboard.DOWN)) {
			downDown = false;
		}
		else if ((e.keyCode == Keyboard.W) || (e.keyCode == Keyboard.UP)) {
			upDown = false;
		}
	}
	
	override public function getSpriteSheet(random:Bool) {
		var bitmapData:BitmapData = Assets.getBitmapData("img/delegate_back.png");
		
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		Utils.replaceColor(bitmapData, 0x000000, 0xff0000);
		
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 13, 1, 32, 64);
	
		return spritesheet;
	}
	
	override public function generateThrowRate() {
		throwRate = baseThrowRate;
	}
	
	override public function takeAction(delta:Int) {
		if (downDown) {
			crouch();
		}
		else if (!downDown) {
			stand();
			
			if (!((leftDown) && (rightDown))) {
				if ((leftDown) && (x > minX)) {
					stand();
					x -= delta * Delegate.MOVEMENT_SPEED_MODIFIER;
					
					if (!strafing) {
						idling = false;
						animatedSprite.showBehavior("strafing");
						strafing = true;
					}
				}
				else if ((rightDown) && (x < maxX)) {
					stand();
					x += delta * Delegate.MOVEMENT_SPEED_MODIFIER;
					
					if (!strafing) {
						idling = false;
						animatedSprite.showBehavior("strafing");
						strafing = true;
					}
				}
				else {
					strafing = false;
					if (!idling) {
						animatedSprite.showBehavior("idling");
						idling = true;
					}
				}
			}
			else {
				animatedSprite.showBehavior("idling");
				strafing = false;
			}
		}
		
		
		if ((attacking) && (throwWait >= throwRate) && (!crouched) && (!chamber.debateDone())) {
			
			// Time to throw!
			throwProjectile(chamber.screen.cursor.x, chamber.screen.cursor.y);
			
			throwWait = 0;
		}
	}
	
	override public function createProjectile():Projectile {
		var projectile:Projectile = new Projectile();
		projectile.friendly = true;
		projectile.speed = projectile.baseSpeed;
		return projectile;
	}
	
	override public function crouch() {
		strafing = false;
		if (!crouched) {
			animatedSprite.showBehavior("crouching");
			crouched = true;
		}
	}
	
	public function targetMouseDown(e:MouseEvent) {
		attacking = true;
	}
	
	public function targetMouseUp(e:MouseEvent) {
		attacking = false;
	}
}