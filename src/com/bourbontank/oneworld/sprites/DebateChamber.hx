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
	static public var enemyDelegateXLocations:Array<Int> = [330, 130, 530];
	static public var enemyDelegateYLocations:Array<Int> = [50, 120];
	
	public function new(screen:DebateScreen) 
	{
		super();
		this.screen = screen;
		
		addBackground();
		
		addEnemyDelegates(6);
		
		
	}
	
	public function addEnemyDelegates(count:Int) {
		for (i in 0...count) {
			var xLocationIndex = i % 3;
			var yLocationIndex = Math.ceil((i + 1) / 3.0) - 1;
			var xLocation = enemyDelegateXLocations[xLocationIndex];
			var yLocation = enemyDelegateYLocations[yLocationIndex];
			
			var table = new MeetingTable();
			table.x = xLocation;
			table.y = yLocation + 33;
			
			var delegate = new Delegate(this);
			delegate.x = xLocation + (table.width - delegate.width) / 2;
			delegate.y = yLocation;
			
			addDelegate(delegate);
			addTable(table);
			
			delegate.setCurrentTarget(table);
		}
		
	}
	
	public function addBackground() {
		var data:BitmapData = Assets.getBitmapData ("img/chamber_background.png");
		data = Utils.resizeBitmapData(data, Main.screenWidth, Main.screenHeight);
		background = new Sprite();
		background.addChild(new Bitmap (data));
		
		addChild(background);
		
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