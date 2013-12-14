package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.TargetCursor;
import flash.display.Sprite;
import com.bourbontank.oneworld.CollisionDetection;

import flash.ui.Mouse;
import flash.events.MouseEvent;

/**
 * ...
 * @author 
 */
class BaseTargetingScreen extends BaseAnimatedScreen
{

	var cursor:TargetCursor;
	var targets:Array<Sprite>;
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		targets = new Array<Sprite>();
		
		addEventListener (MouseEvent.MOUSE_MOVE, mouseMoveEvent);
		addEventListener (MouseEvent.MOUSE_DOWN, mouseDownEvent);
		
		addEventListener (MouseEvent.MOUSE_OVER, mouseOverEvent);
		addEventListener (MouseEvent.MOUSE_OUT, mouseOutEvent);
	}
	
	public function addCursor() {
		Mouse.hide();
		cursor = new TargetCursor();
		cursor.visible = true;
		addChild(cursor);
	}
	
	public function mouseOverEvent(event:MouseEvent) {
		cursor.x = event.stageX;
		cursor.y = event.stageY;
		cursor.visible = true;
	}
	
	public function mouseOutEvent(event:MouseEvent) {
		cursor.x = event.stageX;
		cursor.y = event.stageY;
		cursor.visible = false;
	}
	
	public function mouseMoveEvent(event:MouseEvent) {
		cursor.x = event.stageX;
		cursor.y = event.stageY;
		
	}
	
	public function mouseDownEvent(event:MouseEvent) {
		trace(event.stageX + ", " + event.stageY);
		trace(event.localX + ", " + event.localY);
	}
	
	public function addTarget(sprite:Sprite) {
		targets.push(sprite);
	}
	
}