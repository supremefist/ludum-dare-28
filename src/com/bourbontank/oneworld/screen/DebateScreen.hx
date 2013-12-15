package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.Continent;
import com.bourbontank.oneworld.sprites.DebateChamber;
import com.bourbontank.oneworld.sprites.Delegate;
import com.bourbontank.oneworld.sprites.EntityContainerSprite;
import com.bourbontank.oneworld.sprites.TargetCursor;
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
import flash.ui.Mouse;
import com.bourbontank.oneworld.Main;
import flash.Lib;
import com.bourbontank.oneworld.ChatLine;

/**
 * ...
 * @author 
 */
class DebateScreen extends BaseTargetingScreen
{

	public var continent:Continent = null;
	var chamber:DebateChamber;
	private var lastTime:Int;
	
	var finished:Bool = false;
	var finishedTimer:Int = 0;
	
	private var victory:Bool = false;
	
	private var messageBox:TextField = null;
	
	public function new(display:Display, control:Control, enemyDelegates:Int, friendlyDelegates:Int) 
	{
		super(display, control);
		
		lastTime = Lib.getTimer();
		
		chamber = new DebateChamber(this, enemyDelegates, friendlyDelegates);
		addChild(chamber);
		
		messageBox = Utils.createTextSprite("", 0xffffff, 60);
		messageBox.width = 400;
		messageBox.height = 100;
		messageBox.x = 200;
		messageBox.y = 150;
		messageBox.alpha = 0.0;
		addChild(messageBox);
		
		addCursor();
		
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function setMessage(message:String) {
		messageBox.text = message;
		messageBox.alpha = 1.0;
	}
	
	public function hideMessage() {
		messageBox.alpha = 0.0;
	}
	
	override public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		
		chamber.updateEntities(delta);
		
		if ((chamber.debateDone()) && (!finished)) {
			finished = true;
			
			victory = false;
			for (delegate in chamber.friendlyDelegates) {
				if (delegate.isAlive()) {
					victory = true;
				}
				
			}
			
			if (victory) {
				setMessage("Debate won!");
				continent.setFriendly(true);
			}
			else {
				setMessage("Debate lost...");
			}
		}
		
		if (finished) {
			if (finishedTimer > 2000) {
				var worldScreen:WorldScreen = new WorldScreen(display, control);
				
				if (continent != null) {
					
					var conversation:Array<ChatLine>;
					if (victory) {
						conversation = continent.getVictoryConversation();
					}
					else {
						conversation = continent.getDefeatConversation();
					}
					
					if (conversation != null) {
						worldScreen.conversing = true;
						worldScreen.conversation = conversation;
					}
				}
				
				display.setScreen(worldScreen);
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			
			finishedTimer += delta;
		}
		
		//updateBorder(delta);
		lastTime = Lib.getTimer();
		
		
	}
	
	
}