package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
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


/**
 * ...
 * @author 
 */
class SplashScreen extends BaseClickingScreen
{

	private var fader:Sprite;
	private var lastTime:Int;
	
	private var space:Sprite;
	private var globe:AnimatedSprite;
	private var text:Sprite;
	
	private var startText:TextField;
	private var slideText:TextField;
	private var worldText:TextField;
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		var font:Font = Utils.getFont();
		
		addSpace();
		addGlobe();
		addText();
		
		
		fader = new Sprite();
		fader.graphics.beginFill(0x000000, 1.0);
		fader.graphics.drawRect(0, 0, Main.screenWidth, Main.screenHeight);
		addChild(fader);
		
		
		Actuate.tween (fader, 3.0, { alpha: 0 } ).onComplete(removeChild, [fader]);
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
		addCursor();
		
		targetMouseDown = clicked;
	}
	
	public function addText() {
		text = new Sprite();
		//text.width = Main.screenWidth;
		//text.height = Main.screenHeight;
		
		var textField = Utils.createTextSprite("Made in 48 hours for Ludum dare 28 by Supremefist", 0xFFFFFF, 12);
		textField.x = x + 450;
		textField.y = y + 460;
		textField.width = 800;
		textField.height = 400;
		text.addChild(textField);
		
		slideText = Utils.createTextSprite("You only get one...", 0xFF4F63, 40);
		slideText.x = -500;
		slideText.y = 100;
		slideText.width = 800;
		slideText.height = 400;
		text.addChild(slideText);
		
		worldText = Utils.createTextSprite("WORLD", 0xFFED4F, 80);
		worldText.x = 250;
		worldText.y = 150;
		worldText.alpha = 0.0;
		worldText.width = 800;
		worldText.height = 400;
		text.addChild(worldText);
		
		startText = Utils.createTextSprite("click to start...", 0xFFFFFF, 16);
		startText.x = 340;
		startText.y = 280;
		startText.width = 800;
		startText.height = 400;
		text.addChild(startText);
		
		startText.alpha = 0.0;
		
		addChild(text);
	}
	
	override public function start() {
		Actuate.tween(slideText, 2.0, { x:200 } ).ease(Linear.easeNone);
		
		Actuate.timer(3.0).onComplete(function() {
			Actuate.tween(worldText, 2.0, { alpha:1.0 } ).ease(Linear.easeNone);
		});
		
		Actuate.timer(5.0).onComplete(function() {
			fadeTextIn();
		});
		
	}
	
	public function fadeTextIn() {
		Actuate.tween(startText, 0.5, { alpha:1.0 } ).ease(Linear.easeNone).onComplete(fadeTextOut);
	}
	
	public function fadeTextOut() {
		Actuate.tween(startText, 0.5, { alpha:0.0 } ).ease(Linear.easeNone).onComplete(fadeTextIn);
	}
	
	public function addSpace() {
		space = new Sprite();
		
		var data:BitmapData = Assets.getBitmapData ("img/space.png");
		data = Utils.resizeBitmapData(data, Main.screenWidth, Main.screenHeight);
		
		space.addChild(new Bitmap (data));
		
		addChild(space);
	}
	
	public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		if (globe != null) {
			globe.update(delta);
		}
		
		//updateBorder(delta);
		lastTime = Lib.getTimer();
		
		
	}
	
	public function addGlobe() {
		var bitmapData:BitmapData = Assets.getBitmapData("img/globe.png");
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 3, 1, 500, 480);
		var spinBehaviour:BehaviorData = new BehaviorData("spin", [0, 1, 2], true, 5);
		spritesheet.addBehavior(spinBehaviour);
		
		globe = new AnimatedSprite(spritesheet, false);
		globe.x = 150;
		globe.y = 0;
		
		addChild(globe);
		
		globe.showBehavior("spin");
	}
	
	dynamic public function clicked(e:MouseEvent) {
		control.worldPhase();
	}
}