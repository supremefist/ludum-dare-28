package com.bourbontank.oneworld.sprites;
import flash.display.Sprite;
import flash.text.TextField;

import com.bourbontank.oneworld.Utils;

/**
 * ...
 * @author ...
 */
class NarrateSprite extends BriefSprite
{

	var background:TextBackgroundSprite;
	
	public function new() 
	{
		super();
		
		var textFieldWidth:Float = 300;
		var textFieldHeight:Float = 150;
		
		background = new TextBackgroundSprite(textFieldWidth, textFieldHeight);
		addChild(background);
		
		textField = Utils.createTextSprite("", 0x000000);
		var borderBuffer = background.borderOffset + background.borderLineWidth;
		textField.wordWrap = true;
		textField.x = borderBuffer;
		textField.y = borderBuffer;
		textField.width = textFieldWidth - borderBuffer * 2;
		textField.height = textFieldHeight - borderBuffer * 2;
		addChild(textField);
	}
	
	override public function setText(text:String) {
		textField.text = text;
	}
}