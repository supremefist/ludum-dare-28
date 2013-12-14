package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.TargetCursor;
import com.bourbontank.oneworld.Main;
import flash.display.Sprite;

/**
 * ...
 * @author Riaan Swart
 */
class Screen extends Sprite
{
	public var display:Display;
	public var control:Control;
	
	public function new(display:Display, control:Control) 
	{
		super();
		
		this.control = control;
		this.display = display;
	}
	
	public function nextScreen():Screen {
		throw "Not implemented.";
		return null;
	}
	
}