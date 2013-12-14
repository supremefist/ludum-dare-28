package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.TargetCursor;
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
import flash.ui.Mouse;
import com.bourbontank.oneworld.Main;


/**
 * ...
 * @author 
 */
class DebateScreen extends BaseTargetingScreen
{

	var background:Sprite;
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		addBackground();
		
		var box:Sprite = new Sprite();
		box.graphics.beginFill(0xFFFFFF, 1.0);
		box.graphics.drawRect(0, 0, 100, 50);
		box.x = 100;
		box.y = 200;
		addChild(box);
		
		addTarget(box);
		
		addCursor();
	}
	
	public function addBackground() {
		background = new Sprite();
		background.graphics.beginFill(0x000000, 1.0);
		background.graphics.drawRect(0, 0, Main.screenWidth, Main.screenHeight);
		addChild(background);
	}
	
}