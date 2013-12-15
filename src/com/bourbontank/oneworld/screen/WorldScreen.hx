package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.Continent;
import com.bourbontank.oneworld.Utils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.Font;
import flash.text.TextField;
import motion.Actuate;
import openfl.Assets;
import flash.events.Event;
import flash.display.LineScaleMode;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;
import flash.Lib;
import flash.ui.Mouse;
import motion.easing.Linear;
import com.bourbontank.oneworld.CollisionDetection;

/**
 * ...
 * @author 
 */
class WorldScreen extends BaseClickingScreen
{

	private var fader:Sprite;
	private var lastTime:Int;
	
	private var space:Sprite;
	private var globe:AnimatedSprite;
	private var instructionBox:Sprite;
	
	private var startText:TextField;
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		var font:Font = Utils.getFont();
		
		addOcean();
		addContinents();
		addInstructions();
		
		fader = new Sprite();
		fader.graphics.beginFill(0x000000, 1.0);
		fader.graphics.drawRect(0, 0, Main.screenWidth, Main.screenHeight);
		addChild(fader);
		
		
		addCursor();
	}
	
	override public function start() {
		Actuate.tween (fader, 3.0, { alpha: 0 } ).onComplete(removeChild, [fader]);
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function addOcean() {
		space = new Sprite();
		
		var data:BitmapData = Assets.getBitmapData ("img/ocean.png");
		data = Utils.resizeBitmapData(data, Main.screenWidth, Main.screenHeight);
		
		space.addChild(new Bitmap (data));
		
		addChild(space);
		
		targetMouseDown = targetClicked;
	}
	
	public function addInstructions() {
		instructionBox = new Sprite();
		instructionBox.x = 5;
		instructionBox.y = 455;
		
		var text:TextField = Utils.createTextSprite("Select a continent to debate against...", 0xFFFFFF, 16);
		text.width = 500;
		text.height = 100;
		instructionBox.addChild(text);
		
		addChild(instructionBox);
	}
	
	public function addContinents() {
		for (continent in control.continents) {
			addChild(continent);
		}
	}
	
	public function highlightContinents() {
		var highlightFound:Bool = false;
		for (continent in control.continents) {
			if ((CollisionDetection.isColliding(cursor, continent, this, true)) && (!highlightFound)) {
				continent.setHighlighted(true);
				highlightFound = true;
			}
			else {
				continent.setHighlighted(false);
			}
		}
	}
	
	public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		if (globe != null) {
			globe.update(delta);
		}
		
		highlightContinents();
		
		lastTime = Lib.getTimer();
	}
	
	dynamic public function targetClicked(e:MouseEvent) {
		for (continent in control.continents) {
			if (continent.highlighted) {
				continent.setFriendly(true);
			}
		}
		
		highlightContinents();
	}
}