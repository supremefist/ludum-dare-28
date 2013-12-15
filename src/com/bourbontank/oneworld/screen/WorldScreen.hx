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
import com.bourbontank.oneworld.sprites.DetailBox;
import motion.easing.Linear;

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
	private var instructionBox:Sprite;
	
	private var detailBox:DetailBox;
	private var detailBoxFading:Bool = false;
	
	private var startText:TextField;
	
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		var font:Font = Utils.getFont();
		
		addOcean();
		addContinents();
		addInstructions();
		addDetailBox();
		addConversationBoxes();
		
		fader = new Sprite();
		fader.graphics.beginFill(0x000000, 1.0);
		fader.graphics.drawRect(0, 0, Main.screenWidth, Main.screenHeight);
		addChild(fader);
		
		addCursor();
	}
	
	override public function start() {
		Actuate.tween (fader, 3.0, { alpha: 0 } ).onComplete(removeChild, [fader]);
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
		if ((conversation != null) && (conversation.length > 0)) {
			continueConversation();
		}
	}
	
	public function addDetailBox() {
		detailBox = new DetailBox();
		detailBox.x = 550;
		detailBox.alpha = 0.0;
		addChild(detailBox);
	}
	
	public function addOcean() {
		space = new Sprite();
		
		var data:BitmapData = Assets.getBitmapData ("img/ocean.png");
		data = Utils.resizeBitmapData(data, Main.screenWidth, Main.screenHeight);
		
		space.addChild(new Bitmap (data));
		
		addChild(space);
	}
	
	public function addInstructions() {
		instructionBox = new Sprite();
		instructionBox.x = 5;
		//instructionBox.y = 455;
		instructionBox.y = 5;
		
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
		var highlighted:Continent = null;
		for (continent in control.continents) {
			if ((CollisionDetection.isColliding(cursor, continent, this, true)) && (highlighted == null)) {
				continent.setHighlighted(true);
				highlighted = continent;
				detailBox.setContinent(continent);
			}
			else {
				continent.setHighlighted(false);
			}
		}
		
		if (highlighted != null) {
			Actuate.apply(detailBox, { alpha: 1.0 } );
			detailBoxFading = false;
		}
		else if (!detailBoxFading) {
			Actuate.tween(detailBox, 1.0, { alpha: 0.01 } ).ease(Linear.easeNone);
			detailBoxFading = true;
			
		}
	}
	
	public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		
		if (conversing) {
			leftSpeakerBox.animate(delta);
			rightSpeakerBox.animate(delta);
			
			instructionBox.alpha = 0;
			targetMouseDown = clicked;
		}
		else {
			highlightContinents();
			instructionBox.alpha = 1.0;
			targetMouseDown = targetClicked;
		}
		
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
	
	dynamic public function clicked(e:MouseEvent) {
		if (conversing) {
			if ((conversation != null) && (conversation.length > 0)) {
				continueConversation();
			}
			else {
				conversing = false;
				// Conversation completed!
				if (currentlyVisible != null) {
					hideSprite(currentlyVisible);
				}
			}
		}
	}
}