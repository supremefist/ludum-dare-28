package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.Utils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.Font;
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


/**
 * ...
 * @author 
 */
class MenuScreen extends Screen
{

	private var fader:Sprite;
	private var lastTime:Int;
	private var dude:AnimatedSprite;
	private var staticDude:Sprite;
	private var border:Sprite;
	private var direction:Int = 0;
	
	private var cursor:Sprite;
	
	private var minX:Int = 0;
	private var maxX:Int = 100;
	private var minY:Int = 0;
	private var maxY:Int = 100;
	
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		var font:Font = Utils.getFont();
		
		//addBorder();
		
		var firstTextField = Utils.createTextSprite("Ludum dare 28", 0xFF6633, 80);
		firstTextField.x = x + 50;
		firstTextField.y = y + 100;
		firstTextField.width = 800;
		firstTextField.height = 400;
		addChild(firstTextField);
		
		fader = new Sprite();
		fader.graphics.beginFill(0x000000, 1.0);
		fader.graphics.drawRect(0, 0, Main.screenWidth, Main.screenHeight);
		addChild(fader);
		
		
		Actuate.tween (fader, 3.0, { alpha: 0 } ).onComplete(removeChild, [fader]);
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
		addStaticDude();
		addDude();
		
		Mouse.hide();
		
		cursor = new Sprite();
		cursor.x = 100;
		cursor.y = 100;
		cursor.graphics.beginFill(0xFFFFFF, 1.0);
		cursor.graphics.drawRect(0, 0, 5, 5);
		addChild(cursor);
		
		addEventListener (MouseEvent.MOUSE_MOVE, mouseMoveEvent);
		addEventListener (MouseEvent.MOUSE_DOWN, mouseDownEvent);
		
	}
	
	public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		if (dude != null) {
			dude.update(delta);
		}
		
		//updateBorder(delta);
		lastTime = Lib.getTimer();
		
		
	}
	
	public function mouseMoveEvent(event:MouseEvent) {
		cursor.x = event.stageX - 64;
		cursor.y = event.stageY - 64;
		
		if (CollisionDetection.isColliding(cursor, staticDude, this, true)) {
			dude.visible = false;
		}
		else {
			dude.visible = true;
		}
	}
	
	public function mouseDownEvent(event:MouseEvent) {
		trace(event.stageX + ", " + event.stageY);
	}
	
	public function addStaticDude() {
		var data:BitmapData = Assets.getBitmapData ("img/dude.png");
		data = Utils.resizeBitmapData(data, 96, 96);
		staticDude = new Sprite();
		staticDude.addChild(new Bitmap (data));
		staticDude.x = 200;
		staticDude.y = 230;
		
		
		addChild(staticDude);
		
		staticDude.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);
		
	}
	
	public function addDude() {
		var dudeBitmapData:BitmapData = Assets.getBitmapData("img/dudeanim.png");
		dudeBitmapData = Utils.resizeBitmapData(dudeBitmapData, dudeBitmapData.width * 4, dudeBitmapData.height * 4);
		var spritesheet:Spritesheet = BitmapImporter.create(dudeBitmapData, 4, 1, 128, 128);
		var jumpBehaviour:BehaviorData = new BehaviorData("jump", [0, 1, 2], true, 5);
		spritesheet.addBehavior(jumpBehaviour);
		
		dude = new AnimatedSprite(spritesheet, false);
		dude.x = 300;
		dude.y = 250;
		
		addChild(dude);
		
		dude.showBehavior("jump");
	}
	
	public function updateBorder(delta:Int) {
		border.graphics.clear();
		border.graphics.lineStyle(2, 0xffc553, .2, false, LineScaleMode.NONE);
		border.graphics.beginFill(0xffc553, .1);
		border.graphics.moveTo(delta*4, 0);
		border.graphics.lineTo(100, 100 + delta*4);
		border.graphics.endFill();
	}
	
	public function addBorder() {
		border = new Sprite();
		
		addChild(border);
	}
	
}