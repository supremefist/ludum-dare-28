package com.bourbontank.oneworld;
import com.bourbontank.oneworld.screen.Screen;
import flash.display.Sprite;

/**
 * ...
 * @author 
 */
class Display
{
	var control:Control;
	public var rootSprite:Sprite;
	private var currentScreen:Screen;
	
	public function new(control:Control, ?rootSprite:Sprite) {
		this.control = control;
		
		if (rootSprite != null) {
			this.rootSprite = rootSprite;
		}
	}
	
	public function setScreen(screen:Screen) {
		if (currentScreen != null) {
			rootSprite.removeChild(currentScreen);
		}
		rootSprite.addChildAt(screen, 0);
		currentScreen = screen;
	}
	
}