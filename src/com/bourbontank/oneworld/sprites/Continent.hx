package com.bourbontank.oneworld.sprites;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.Control;
import flash.geom.ColorTransform;
import flash.geom.Transform;

import com.bourbontank.oneworld.Utils;
import com.bourbontank.oneworld.Main;
import openfl.Assets;

import com.bourbontank.oneworld.ChatLine;

/**
 * ...
 * @author ...
 */
class Continent extends Sprite
{

	var currentBitmap:Bitmap = null;
	var enemyBitmap:Bitmap;
	var friendlyBitmap:Bitmap;
	
	public var friendly:Bool = true;
	public var highlighted:Bool = false;
	
	var highlightedMultiplier:Float = 0.9;
	var unhighlightedMultiplier:Float = 0.5;
	public var continentName:String = "";
	public var difficulty:Int = 0;
	public var specialty:Int = 0;
	
	public var victoryConversation:Array<ChatLine> = null;
	public var defeatConversation:Array<ChatLine> = null;
	
	public function new(display:Display, control:Control, continentName:String, bitmapString:String) 
	{
		super();
		
		this.continentName = continentName;
		
		defeatConversation = [new ChatLine("Scientist", "Good try, my liege.  There is always next time!")];
		
		var friendlyBitmapData = Assets.getBitmapData (bitmapString);
		friendlyBitmapData = Utils.resizeBitmapData(friendlyBitmapData, friendlyBitmapData.width * 2, friendlyBitmapData.height * 2);
		friendlyBitmap = new Bitmap(friendlyBitmapData);
		friendlyBitmap.transform.colorTransform = new ColorTransform(0, unhighlightedMultiplier, 0);
		
		var enemyBitmapData = Assets.getBitmapData (bitmapString);
		enemyBitmapData = Utils.resizeBitmapData(enemyBitmapData, enemyBitmapData.width * 2, enemyBitmapData.height * 2);
		enemyBitmap = new Bitmap(enemyBitmapData);
		enemyBitmap.transform.colorTransform = new ColorTransform(unhighlightedMultiplier, 0, 0);
		
		setFriendly(false);
	}
	
	public function setHighlighted(highlighted:Bool) {
		if (highlighted != this.highlighted) {
			this.highlighted = highlighted;
			
			if (highlighted) {
				if (friendly) {
					friendlyBitmap.transform.colorTransform = new ColorTransform(0, highlightedMultiplier, 0);
				}
				else {
					enemyBitmap.transform.colorTransform = new ColorTransform(highlightedMultiplier, 0, 0);
				}
			}
			else {
				if (friendly) {
					friendlyBitmap.transform.colorTransform = new ColorTransform(0, unhighlightedMultiplier, 0);
				}
				else {
					enemyBitmap.transform.colorTransform = new ColorTransform(unhighlightedMultiplier, 0, 0);
				}
			}
		}
		
	}
	
	public function setFriendly(friendly:Bool) {
		if (this.friendly != friendly) {
		
			this.friendly = friendly;
			if (currentBitmap != null) {
				removeChild(currentBitmap);
			}
			
			if (friendly) {
				currentBitmap = friendlyBitmap;
				addChild(currentBitmap);
			}
			else {
				currentBitmap = enemyBitmap;
				addChild(currentBitmap);
			}
		}
	}
	
	public function getVictoryConversation():Array<ChatLine> {
		return victoryConversation;
	}
	public function getDefeatConversation():Array<ChatLine> {
		return defeatConversation;
	}
	
}