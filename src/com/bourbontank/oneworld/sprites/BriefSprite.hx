package com.bourbontank.oneworld.sprites;

import flash.display.Sprite;
import flash.text.TextField;

/**
 * ...
 * @author ...
 */
class BriefSprite extends Sprite
{
	var textField:TextField;
	var assetString:String;
	
	public function new() 
	{
		super();
	}
	
	public function setText(text:String) {
		throw "Not implemented";
	}
	
	public function setAssetString(assetString:String) {
		this.assetString = assetString;
	}
	
}