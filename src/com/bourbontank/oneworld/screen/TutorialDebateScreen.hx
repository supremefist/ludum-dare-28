package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.DebateChamber;
import com.bourbontank.oneworld.sprites.Delegate;
import com.bourbontank.oneworld.sprites.EntityContainerSprite;
import com.bourbontank.oneworld.sprites.NarrateSprite;
import com.bourbontank.oneworld.sprites.SpeakerSprite;
import com.bourbontank.oneworld.sprites.TargetCursor;
import com.bourbontank.oneworld.Utils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.Font;
import motion.Actuate;
import openfl.Assets;
import flash.events.Event;
import flash.display.LineScaleMode;

import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.AnimatedSprite;
import flash.ui.Mouse;
import com.bourbontank.oneworld.Main;
import flash.Lib;
import com.bourbontank.oneworld.ChatLine;

/**
 * ...
 * @author 
 */
class TutorialDebateScreen extends DebateScreen
{
	private var conversing:Bool = true;
	
	public function new(display:Display, control:Control) 
	{
		super(display, control, 0, 0);
		
		conversation = new Array<ChatLine>();
		conversation.push(new ChatLine("King", "You: Well, my queen, as you may have heard, our vast kingdom is under threat of destruction by..."));
		conversation.push(new ChatLine("Queen", "Queen: Silence!  We shall debate this in the modern way: honorable battle of crumpled-up paper!  Prepare to be annihilated!"));
		conversation.push(new ChatLine("King", "King: Very well.  I am nothing if not adaptable to change!"));
		conversation.push(new ChatLine("Narrator", "Debate using the keys shown.  Your current morale is visible in the lower right corner.  Once this is depleted, you have lost the debate!  Outwit all your opponents to win the debate!"));
		
		
		narrateSprite = new NarrateSprite();
		narrateSprite.alpha = 0.0;
		narrateSprite.x = 250;
		narrateSprite.y = 30;
		addChild(narrateSprite);
		
		leftSpeakerBox = new SpeakerSprite(40, -30);
		leftSpeakerBox.alpha = 0.0;
		leftSpeakerBox.x = 50;
		leftSpeakerBox.y = 250;
		addChild(leftSpeakerBox);
		
		rightSpeakerBox = new SpeakerSprite(0, 310);
		rightSpeakerBox.alpha = 0.0;
		rightSpeakerBox.x = 405;
		rightSpeakerBox.y = 250;
		addChild(rightSpeakerBox);
		
		continueConversation();
		
		targetMouseDown = clicked;
	}
	
	override public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		
		if (!conversing) {
			chamber.updateEntities(delta);
		}
		else {
			leftSpeakerBox.animate(delta);
			rightSpeakerBox.animate(delta);
		}
		
		//updateBorder(delta);
		lastTime = Lib.getTimer();
	}
	
	dynamic public function clicked(e:MouseEvent) {
		if ((conversation != null) && (conversation.length > 0)) {
			continueConversation();
		}
		else {
			// Conversation completed!
			conversing = false;
			
			if (currentlyVisible != null) {
				hideSprite(currentlyVisible);
			}
			
			chamber.addFriendlyDelegates(1);
			chamber.addEnemyDelegate(0, false);
		}
	}
	
	
}