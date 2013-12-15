package com.bourbontank.oneworld;
import com.bourbontank.oneworld.screen.DebateScreen;
import com.bourbontank.oneworld.screen.SplashScreen;
import flash.display.Sprite;

/**
 * ...
 * @author 
 */
class Control
{

	var display:Display;
	var sound:GameSound;
	
	public function new(?rootSprite:Sprite) 
	{
		if (rootSprite != null) {
			this.display = new Display(this, rootSprite);
			this.sound = new GameSound(this);
		}
	}
	
	public function start() {
		display.setScreen(new SplashScreen(display, this));
		//sound.playMusic();
	}
	
}