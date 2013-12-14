package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
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


/**
 * ...
 * @author 
 */
class DebateScreen extends BaseTargetingScreen
{

	var chamber:EntityContainerSprite;
	private var lastTime:Int;
	
		
		
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		lastTime = Lib.getTimer();
		
		chamber = new DebateChamber(this);
		addChild(chamber);
		
		addCursor();
		
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
		
		
	}
	
	public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		
		chamber.updateEntities(delta);
		
		//updateBorder(delta);
		lastTime = Lib.getTimer();
		
		
	}
	
	
}