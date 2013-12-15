package com.bourbontank.oneworld;

import flash.display.Sprite;

/**
 * ...
 * @author ...
 */
class ChatLine
{

	public var speakerName:String;
	public var line:String;
	public var showKeys:Bool = false;
	
	public function new(speakerName:String, line:String, ?showKeys:Bool=false) 
	{
		this.speakerName = speakerName;
		this.line = line;
		this.showKeys = showKeys;
	}
	
}