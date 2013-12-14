package com.bourbontank.oneworld;
import flash.geom.Rectangle;
import flash.text.Font;
import flash.utils.ByteArray;

import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.text.TextField;
/**
 * ...
 * @author 
 */
class Utils
{

	public function new() 
	{
	
	}
	
	public static function getFont():Font {
		var font = Assets.getFont ("font/uni0553-webfont.ttf"); 
		return font;
	}
	
	public static function resizeBitmap( source:Bitmap, width:Int, height:Int ) : Bitmap
	{
		var data:BitmapData = source.bitmapData;
		var newData:BitmapData = resizeBitmapData(data, width, height);
		var newBitmap:Bitmap = new Bitmap(newData);
		return newBitmap;
	}
	
	public static function generateRandom(baseValue:Float, variance:Float):Float {
		var result:Float = baseValue + (variance * Math.random() - variance / 2);
		return result;
	}
	
	public static function resizeBitmapData( data:BitmapData, width:Int, height:Int ) : BitmapData
	{
		var scaleX:Float = width / data.width;
		var scaleY:Float = height / data.height;
		
		var matrix:Matrix = new Matrix();
		matrix.scale(scaleX, scaleY);
		var newData:BitmapData = new BitmapData(width, height, true, 0x000000FF);
		newData.draw(data, matrix);
		return newData;
	}
	
	public static function createTextSprite(text:String, ?color:Int=0xffffff, ?size:Int=12):TextField {
		var font:Font = Utils.getFont();
		var format = new flash.text.TextFormat(font.fontName);
		format.color = color;
		format.size = size;
		format.leading = 0;
		
		var textGraphic:TextField = new TextField();
		textGraphic.embedFonts = true;
		textGraphic.defaultTextFormat = format; 
		textGraphic.selectable = false;
		textGraphic.text = text;
		
		return textGraphic;
	}
	
	public static function replaceColor(bitmapData:BitmapData, oldColor:UInt, newColor:UInt) {
		for (x in 0...bitmapData.width) {
			for (y in 0...bitmapData.height) {
				if (bitmapData.getPixel(x,y) == oldColor) {
					bitmapData.setPixel(x,y,newColor);
				}
			}
		}
	}
	
	
}