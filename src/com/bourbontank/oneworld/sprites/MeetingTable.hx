package com.bourbontank.oneworld.sprites;

import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Sprite;
import spritesheet.AnimatedSprite;
import openfl.Assets;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;
/**
 * ...
 * @author 
 */
class MeetingTable extends EntitySprite
{
	public function new() 
	{
		super();
		
		animated = false;
		mobile = false;
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/table.png");
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		var bitmap:Bitmap = new Bitmap(bitmapData);
		addChild(bitmap);
	}
	
}
