package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.ClickCursor;
import com.bourbontank.oneworld.sprites.TargetCursor;
import flash.display.Sprite;
import com.bourbontank.oneworld.CollisionDetection;

import flash.ui.Mouse;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
/**
 * ...
 * @author 
 */
class BaseClickingScreen extends BaseTargetingScreen
{

	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
	}
	
	
	override public function addCursor() {
		Mouse.hide();
		cursor = new ClickCursor();
		cursor.visible = false;
		addChild(cursor);
	}
}