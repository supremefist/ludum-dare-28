package com.bourbontank.oneworld.sprites;
import flash.display.BitmapData;
import spritesheet.AnimatedSprite;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;

import openfl.Assets;

/**
 * ...
 * @author ...
 */
class SpeakerSprite extends BriefSprite
{
	var background:TextBackgroundSprite;
	var speakerAnimation:AnimatedSprite = null;
	var speakerX:Float = 0;
	
	public function new(textBoxX:Float, speakerX:Float) 
	{
		super();
		
		var textFieldWidth:Float = 300;
		var textFieldHeight:Float = 150;
		
		this.speakerX = speakerX;
		
		background = new TextBackgroundSprite(textFieldWidth, textFieldHeight);
		background.x = textBoxX;
		addChild(background);
		
		textField = Utils.createTextSprite("", 0x000000);
		var borderBuffer = background.borderOffset + background.borderLineWidth;
		textField.wordWrap = true;
		textField.x = borderBuffer + textBoxX;
		textField.y = borderBuffer;
		textField.width = textFieldWidth - borderBuffer * 2;
		textField.height = textFieldHeight - borderBuffer * 2;
		addChild(textField);
	}
	
	override public function setText(text:String) {
		textField.text = text;
	}
	
	override public function setAssetString(assetString:String) {
		super.setAssetString(assetString);
		
		var bitmapData:BitmapData = Assets.getBitmapData(assetString);
		bitmapData = Utils.resizeBitmapData(bitmapData, bitmapData.width * 2, bitmapData.height * 2);
		var spritesheet:Spritesheet = BitmapImporter.create(bitmapData, 2, 1, 64, 96);
		var talkBehaviour:BehaviorData = new BehaviorData("talk", [0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1], true, 10);
		spritesheet.addBehavior(talkBehaviour);
		
		if (speakerAnimation != null) {
			removeChild(speakerAnimation);
		}
		
		speakerAnimation = new AnimatedSprite(spritesheet, false);
		speakerAnimation.x = speakerX;
		speakerAnimation.y = 134;
		
		addChild(speakerAnimation);
		
		speakerAnimation.showBehavior("talk");
	}
	
	public function animate(delta:Int) {
		if (speakerAnimation != null) {
			speakerAnimation.update(delta);
		}
	}
	
}