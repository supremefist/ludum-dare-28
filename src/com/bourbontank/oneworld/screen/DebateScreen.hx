package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.Continent;
import com.bourbontank.oneworld.sprites.DebateChamber;
import com.bourbontank.oneworld.sprites.Delegate;
import com.bourbontank.oneworld.sprites.EntityContainerSprite;
import com.bourbontank.oneworld.sprites.RewardSelection;
import com.bourbontank.oneworld.sprites.TargetCursor;
import com.bourbontank.oneworld.Utils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.Font;
import flash.text.TextField;
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
import com.bourbontank.oneworld.CollisionDetection;

/**
 * ...
 * @author 
 */
class DebateScreen extends BaseTargetingScreen
{

	public var continent:Continent = null;
	var chamber:DebateChamber;
	private var lastTime:Int;
	
	var finished:Bool = false;
	var finishedTimer:Int = 0;
	
	private var pauseDuration:Int = 500;
	
	private var victory:Bool = false;
	
	private var messageBox:TextField = null;
	
	private var selectReward:Bool = false;
	private var selectingReward:Bool = false;
	private var selectRewardSprite:RewardSelection = null;
	private var selectedReward:Bool = false;
	
	public function new(display:Display, control:Control, continent:Continent) 
	{
		super(display, control);
		
		this.continent = continent;
		
		lastTime = Lib.getTimer();
		
		
		var enemyDelegates:Int = 1;
		if (continent != null) {
			enemyDelegates = continent.difficulty * 2 + 2;
		}
		var friendlyDelegates:Int = 1 + control.friendlyDelegates;
		
		chamber = new DebateChamber(this, enemyDelegates, friendlyDelegates);
		addChild(chamber);
		
		messageBox = Utils.createTextSprite("", 0xffffff, 40);
		messageBox.width = 800;
		messageBox.height = 100;
		messageBox.x = 250;
		messageBox.y = 150;
		messageBox.alpha = 0.0;
		addChild(messageBox);
		
		selectRewardSprite = new RewardSelection();
		selectRewardSprite.x = 250;
		selectRewardSprite.y = 170;
		selectRewardSprite.alpha = 0;
		addChild(selectRewardSprite);
		
		addCursor();
		
		addEventListener (Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function setMessage(message:String) {
		messageBox.text = message;
		messageBox.alpha = 1.0;
	}
	
	public function hideMessage() {
		messageBox.alpha = 0.0;
	}
	
	override public function onEnterFrame(e:Event):Void {
		var delta = Lib.getTimer() - lastTime;
		
		if (!selectingReward) {
			chamber.updateEntities(delta);
		}
		
		if ((chamber.debateDone()) && (!finished)) {
			selectReward = true;
			
			victory = false;
			for (delegate in chamber.friendlyDelegates) {
				if (delegate.isAlive()) {
					victory = true;
				}
				
			}
			
			if (victory) {
				setMessage("Debate won!");
				if (continent != null) {
					continent.setFriendly(true);
				}
				
				var done:Bool = true;
				for (continent in control.continents) {
					if (!continent.friendly) {
						done = false;
					}
				}
				
				if (done) {
					selectReward = false;
					selectedReward = true;
					finished = true;
				}
			}
			else {
				setMessage("Debate lost...");
			}
		}
		
		if (selectedReward) {
			finishedTimer += delta;
			
			if (finishedTimer > pauseDuration) {
				selectedReward = false;
			}
		}
		else if (selectReward) {
			finishedTimer += delta;
			
			if (finishedTimer > pauseDuration) {
				if (victory) {
					selectRewardSprite.alpha = 1.0;
					hideMessage();
					selectingReward = true;
					targetMouseDown = selectClick;
				}
				else {
					selectReward = false;
					selectingReward = false;
				}
				
				finished = true;
			}
		}
		else if (finished) {
			var worldScreen:WorldScreen = new WorldScreen(display, control);
			
			if (continent != null) {
				
				var conversation:Array<ChatLine>;
				if (victory) {
					conversation = continent.getVictoryConversation();
				}
				else {
					conversation = continent.getDefeatConversation();
				}
				
				if (conversation != null) {
					worldScreen.conversing = true;
					worldScreen.conversation = conversation;
				}
			}
			
			display.setScreen(worldScreen);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		//updateBorder(delta);
		lastTime = Lib.getTimer();
		
		
	}
	
	dynamic public function selectClick(e:MouseEvent) {
		if ((cursor.x > selectRewardSprite.x) && (cursor.x < selectRewardSprite.x + selectRewardSprite.width) && (cursor.y > selectRewardSprite.y) && (cursor.y < selectRewardSprite.y + selectRewardSprite.height)) {
			selectRewardSprite.alpha = 0;
			if (!selectedReward) {
				messageBox.x -= 150;
			
				if (cursor.x < selectRewardSprite.x + selectRewardSprite.width / 2) {
					// Join your team
					control.friendlyDelegates += 1;
					
					setMessage("Debate team size increased!");
				}
				else {
					// Absorb their abilities
					if (continent != null) {
						if (continent.specialty == 0) {
							// 
							setMessage("Maximum morale increased!");
							control.playerMoraleBonus += 20;
						}
						else if (continent.specialty == 1) {
							setMessage("Quickness of wit increased!");
							control.playerThrowRateBonus -= 200;
						}
						else {
							setMessage("Argument potency increased!");
							control.playerPotencyBonus += 20;
						}
					}
				}
				
				selectedReward = true;
				selectReward = false;
				finishedTimer = 0;
			}
		}
	}
	
	
}