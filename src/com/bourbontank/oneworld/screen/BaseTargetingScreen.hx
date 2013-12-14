package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
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
class BaseTargetingScreen extends Screen
{

	public var cursor:TargetCursor;
	var targets:Array<Sprite>;
	
	public function new(display:Display, control:Control) 
	{
		super(display, control);
		
		targets = new Array<Sprite>();
		
		addEventListener (MouseEvent.MOUSE_MOVE, mouseMoveEvent);
		
		addEventListener (MouseEvent.MOUSE_DOWN, mouseDownEvent);
		addEventListener (MouseEvent.MOUSE_UP, mouseUpEvent);
		
		addEventListener (MouseEvent.MOUSE_OVER, mouseOverEvent);
		addEventListener (MouseEvent.MOUSE_OUT, mouseOutEvent);
		
	}
	
	
	public function addCursor() {
		Mouse.hide();
		cursor = new TargetCursor();
		cursor.visible = false;
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
		targetMouseDown(event);
	}
	
	public function mouseUpEvent(event:MouseEvent) {
		targetMouseUp(event);
	}
	
	dynamic public function targetMouseDown(event:MouseEvent) {
		
	}
	
	dynamic public function targetMouseUp(event:MouseEvent) {
		
	}
	
	public function addTarget(sprite:Sprite) {
		targets.push(sprite);
	}
	
}