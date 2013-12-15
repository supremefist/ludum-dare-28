package com.bourbontank.oneworld.sprites;

import com.bourbontank.oneworld.screen.DebateScreen;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import com.bourbontank.oneworld.Utils;
import com.bourbontank.oneworld.Main;
import openfl.Assets;
import com.bourbontank.oneworld.CollisionDetection;
import com.bourbontank.oneworld.sprites.PlayerDelegate;
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
	static public var friendlyDelegateYLocations:Array<Int> = [400, 330];
	
	public var friendlyDelegates:Array<FriendlyDelegate>;
	public var enemyDelegates:Array<Delegate>;
	
	public var friendlyProjectiles:Array<Projectile>;
	public var enemyProjectiles:Array<Projectile>;
	
	public var completed:Bool = false;
	
	public function new(screen:DebateScreen, enemyDelegateCount:Int, friendlyDelegateCount:Int) 
	{
		super();
		this.screen = screen;
		
		friendlyDelegates = new Array<FriendlyDelegate>();
		enemyDelegates = new Array<Delegate>();
		
		friendlyProjectiles = new Array<Projectile>();
		enemyProjectiles = new Array<Projectile>();
		
		addBackground();
		
		addEnemyDelegates(enemyDelegateCount);
		
		addFriendlyDelegates(friendlyDelegateCount);
	}
	
	public function addEnemyDelegate(index:Int, random:Bool=true, ?hairColor:UInt=0xffff7d, ?tieColor:UInt=0xff0000, ?male:Bool=false) {
		var xLocationIndex = index % 3;
		var yLocationIndex = Math.ceil((index + 1) / 3.0) - 1;
		var xLocation = enemyDelegateXLocations[xLocationIndex];
		var yLocation = enemyDelegateYLocations[yLocationIndex];
		
		var table = new MeetingTable();
		table.x = xLocation;
		table.y = yLocation + 33;
		
		var delegate = new Delegate(this, xLocation + (table.width - 32) / 2, yLocation, random, hairColor, tieColor, male);
		
		addDelegate(delegate);
		addTable(table);
		
		enemyDelegates.push(delegate);
	}

	
	public function addEnemyDelegates(count:Int) {
		for (i in 0...count) {
			addEnemyDelegate(i);
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
			
			var delegate:FriendlyDelegate;
			if (i == 0) {
				delegate = new PlayerDelegate(this, xLocation + (table.width - 32) / 2, yLocation);
			}
			else {
				delegate = new FriendlyDelegate(this, xLocation + (table.width - 32) / 2, yLocation);
			}
			
			
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
			for (projectile in enemyProjectiles) {
				projectile.collidable = false;
			}
			for (projectile in friendlyProjectiles) {
				projectile.collidable = false;
			}
			
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
		
		if (projectile.friendly) {
			friendlyProjectiles.push(projectile);
		}
		else {
			enemyProjectiles.push(projectile);
		}
	}
	
	public function addTable(table:MeetingTable) {
		entities.push(table);
		addChild(table);
	}
	
	public function removeProjectile(projectile:Projectile, list:Array<Projectile>) {
		projectile.parent.removeChild(projectile);
		list.remove(projectile);
	}
	
	public function clearDeadProjectiles(projectiles:Array<Projectile>) {
		// Remove offscreen projectiles
		for (projectile in projectiles) {
			if (offScreen(projectile)) {
				removeProjectile(projectile, projectiles);
			}
		}
	}
	
	override public function updateEntities(delta:Int) {
		super.updateEntities(delta);
		
		clearDeadProjectiles(friendlyProjectiles);
		clearDeadProjectiles(enemyProjectiles);
		
		
		for (projectile in friendlyProjectiles) {
			if ((projectile.mobile) && (projectile.collidable)) {
				for (enemy in enemyDelegates) {
					if ((!enemy.crouched) && (enemy.isAlive())) {
						if (CollisionDetection.isColliding(projectile, enemy, this, true)) {
							enemy.convince(projectile.potency);
							
							projectile.hit();
						}
					}
				}
			}
		}
		
		for (projectile in enemyProjectiles) {
			if ((projectile.mobile) && (projectile.collidable)) {
				for (friend in friendlyDelegates) {
					if ((!friend.crouched) && (friend.isAlive())) {
						if (CollisionDetection.isColliding(projectile, friend, this, true)) {
							friend.convince(projectile.potency);
							
							projectile.hit();
						}
					}
				}
			}
		}
	}
	
}