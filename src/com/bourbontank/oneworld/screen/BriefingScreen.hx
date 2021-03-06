package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.BriefSprite;
import com.bourbontank.oneworld.sprites.NarrateSprite;
import com.bourbontank.oneworld.sprites.SpeakerSprite;
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
import com.bourbontank.oneworld.ChatLine;

/**
 * ...
 * @author 
 */
class BriefingScreen extends BaseClickingScreen
{

	private var fader:Sprite;
	private var lastTime:Int;
	
	public function new(display:Display, control:Control)
	{
		super(display, control);
		
		var font:Font = Utils.getFont();
		this.conversation = control.introConversation;
		addBackground();
		
		addConversationBoxes();
		
		fader = new Sprite();
		fader.graphics.beginFill(0x000000, 1.0);
		fader.graphics.drawRect(0, 0, Main.screenWidth, Main.screenHeight);
		addChild(fader);
		
		addCursor();
		
		targetMouseDown = clicked;
	}
	
	override public function start() {
		Actuate.tween (fader, 3.0, { alpha: 0 } ).onComplete(removeChild, [fader]);
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
		continueConversation();
	}
	
	public function setConversation(conversation:Array<ChatLine>) {
		this.conversation = conversation;
	}
	
	public function addBackground() {
		var space = new Sprite();
		
		var data:BitmapData = Assets.getBitmapData ("img/space.png");
		data = Utils.resizeBitmapData(data, Main.screenWidth, Main.screenHeight);
		
		space.addChild(new Bitmap (data));
		
		addChild(space);
	}
	
	override public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		leftSpeakerBox.animate(delta);
		rightSpeakerBox.animate(delta);
		lastTime = Lib.getTimer();
		
	}
	
	dynamic public function clicked(e:MouseEvent) {
		if ((conversation != null) && (conversation.length > 0)) {
			continueConversation();
		}
		else {
			var screen:Screen = new TutorialDebateScreen(display, control);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			display.setScreen(screen);
		}
	}
}