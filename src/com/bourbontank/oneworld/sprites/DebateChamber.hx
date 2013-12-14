package com.bourbontank.oneworld.sprites;

import com.bourbontank.oneworld.screen.DebateScreen;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import com.bourbontank.oneworld.Utils;
import com.bourbontank.oneworld.Main;
import openfl.Assets;
/**
 * ...
 * @author 
 */
class DebateChamber extends EntityContainerSprite
{

	var background:Sprite;
	public var screen:DebateScreen;
	
	public function new(screen:DebateScreen) 
	{
		super();
		this.screen = screen;
		
		addBackground();
	}
	
	public function addBackground() {
		var data:BitmapData = Assets.getBitmapData ("img/chamber_background.png");
		data = Utils.resizeBitmapData(data, Main.screenWidth, Main.screenHeight);
		background = new Sprite();
		background.addChild(new Bitmap (data));
		
		addChild(background);
		
		var delegate = new Delegate(this);
		delegate.x = 200;
		delegate.y = 100;
		addDelegate(delegate);
		
		var table = new MeetingTable();
		table.x = 400;
		table.y = 400;
		addTable(table);
		
		delegate.setCurrentTarget(table);
	}
	
	public function addDelegate(delegate:Delegate) {
		entities.push(delegate);
		addChild(delegate);
	}
	
	public function addProjectile(projectile:Projectile) {
		entities.push(projectile);
		addChild(projectile);
	}
	
	public function addTable(table:MeetingTable) {
		entities.push(table);
		addChild(table);
	}
	
}