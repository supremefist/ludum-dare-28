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
	static public var friendlyDelegateXLocations:Array<Int> = [330, 130, 530];
	static public var friendlyDelegateYLocations:Array<Int> = [400];
	
	public var friendlyDelegates:Array<FriendlyDelegate>;
	public var enemyDelegates:Array<Delegate>;
	
	public function new(screen:DebateScreen) 
	{
		super();
		this.screen = screen;
		
		friendlyDelegates = new Array<FriendlyDelegate>();
		enemyDelegates = new Array<Delegate>();
		
		addBackground();
		
		addEnemyDelegates(6);
		
		addFriendlyDelegates(3);
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
			
			var delegate = new Delegate(this, xLocation + (table.width - 32) / 2, yLocation);
			
			addDelegate(delegate);
			addTable(table);
			
			enemyDelegates.push(delegate);
		}
		
	}
	
	public function addFriendlyDelegates(count:Int) {
		for (i in 0...count) {
			var xLocationIndex = i % 3;
			var yLocationIndex = Math.ceil((i + 1) / 3.0) - 1;
			var xLocation = friendlyDelegateXLocations[xLocationIndex];
			var yLocation = friendlyDelegateYLocations[yLocationIndex];
			
			var table = new MeetingTable();
			table.x = xLocation;
			table.y = yLocation - 10;
			
			var delegate = new FriendlyDelegate(this, xLocation + (table.width - 32) / 2, yLocation);
			
			addTable(table);
			addDelegate(delegate);
			
			friendlyDelegates.push(delegate);
		}
		
	}
	
	public function debateDone():Bool {
		var friendlyAlive = false;
		for (delegate in friendlyDelegates) {
			if (delegate.isAlive()) {
				friendlyAlive = true;
			}
		}
		
		var enemyAlive = false;
		for (delegate in enemyDelegates) {
			if (delegate.isAlive()) {
				enemyAlive = true;
			}
		}
		
		if ((friendlyAlive) && (enemyAlive)) {
			return false;
		}
		else {
			return true;
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