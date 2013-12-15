package com.bourbontank.oneworld.sprites;

import flash.display.Sprite;
import flash.text.TextField;

/**
 * ...
 * @author ...
 */
class RewardSelection extends Sprite
{
	var background:TextBackgroundSprite;
	public var joinReward:Sprite;
	public var absorbReward:Sprite;
	
	public function new() 
	{
		super();
		
		background = new TextBackgroundSprite(300, 180);
		background.y = -30;
		addChild(background);
		
		var instructionText:TextField = Utils.createTextSprite("Select an option:", 0x000000, 20);
		instructionText.x = 5;
		instructionText.y = -30;
		instructionText.width = 200;
		addChild(instructionText);
		
		joinReward = new Sprite();
		joinReward.addChild(new TextBackgroundSprite(150, 150));
		
		var joinText:TextField = Utils.createTextSprite("Invite", 0x000000, 20);
		joinText.x = 40;
		joinReward.addChild(joinText);
		
		var joinInfo:TextField = Utils.createTextSprite("Have them join your cause and debate with you, increasing your debate team size.", 0x000000, 12);
		joinInfo.x = 5;
		joinInfo.y = 30;
		joinInfo.wordWrap = true;
		joinInfo.width = 140;
		joinReward.addChild(joinInfo);
		
		addChild(joinReward);
		
		absorbReward = new Sprite();
		absorbReward.x = 150;
		absorbReward.addChild(new TextBackgroundSprite(150, 150));
		
		var absorbText:TextField = Utils.createTextSprite("Ridicule", 0x000000, 20);
		absorbText.x = 30;
		absorbReward.addChild(absorbText);
		
		var absorbInfo:TextField = Utils.createTextSprite("Embarass them into revealing their debating secrets, increasing your ability.", 0x000000, 12);
		absorbInfo.x = 5;
		absorbInfo.y = 30;
		absorbInfo.width = 140;
		absorbInfo.wordWrap = true;
		absorbReward.addChild(absorbInfo);
		
		addChild(absorbReward);
	}
	
}