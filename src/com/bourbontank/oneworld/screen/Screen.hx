package com.bourbontank.oneworld.screen;
import com.bourbontank.oneworld.Control;
import com.bourbontank.oneworld.Display;
import com.bourbontank.oneworld.sprites.BriefSprite;
import com.bourbontank.oneworld.sprites.NarrateSprite;
import com.bourbontank.oneworld.sprites.SpeakerSprite;
import com.bourbontank.oneworld.sprites.TargetCursor;
import com.bourbontank.oneworld.Main;
import flash.display.Sprite;
import motion.Actuate;
import com.bourbontank.oneworld.ChatLine;

/**
 * ...
 * @author Riaan Swart
 */
class Screen extends Sprite
{
	public var display:Display;
	public var control:Control;
	
	private var narrateSprite:NarrateSprite;
	private var leftSpeakerBox:SpeakerSprite;
	private var rightSpeakerBox:SpeakerSprite;
	private var currentlyVisible:BriefSprite;
	public var conversation:Array<ChatLine> = null;
	public var conversing:Bool = false;
	
	private var showingHelp:Bool = false;
	
	private var helpSprite:Sprite = null;
	
	public function new(display:Display, control:Control) 
	{
		super();
		
		this.control = control;
		this.display = display;
	}
	
	public function nextScreen():Screen {
		throw "Not implemented.";
		return null;
	}
	
	public function addConversationBoxes() {
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
	}
	
	public function start() {
		
	}
	
	public function showSprite(sprite:BriefSprite) {
		Actuate.tween(sprite, 0.2, { alpha:1.0 } );
	}
	
	public function hideSprite(sprite:BriefSprite) {
		Actuate.tween(sprite, 0.2, { alpha:0.0 } );
	}
	
	public function narrate(line:String) {
		if (currentlyVisible != narrateSprite) {
			if (currentlyVisible != null) {
				hideSprite(currentlyVisible);
			}
			showSprite(narrateSprite);
			narrateSprite.setText(line);
			currentlyVisible = narrateSprite;
		}
	}
	
	public function speak(speakerBox:BriefSprite, assetString:String, line:String) {
		if (currentlyVisible != speakerBox) {
			if (currentlyVisible != null) {
				hideSprite(currentlyVisible);
			}
			showSprite(speakerBox);
			
			speakerBox.setAssetString(assetString);
			
			currentlyVisible = speakerBox;
		}
		
		
		speakerBox.setText(line);
	}
	
	public function showLine(line:ChatLine) {
		if (line.speakerName == "Narrator") {
			narrate(line.line);
		}
		else if (line.speakerName == "Scientist") {
			speak(leftSpeakerBox, "img/scientist.png", line.line);
		}
		else if (line.speakerName == "King") {
			speak(rightSpeakerBox, "img/king.png", line.line);
		}
		else if (line.speakerName == "Queen") {
			speak(leftSpeakerBox, "img/queen.png", line.line);
		}
	}
	
	public function continueConversation() {
		
		
		var nextLine:ChatLine = conversation[0];
		conversation.remove(nextLine);
		
		showLine(nextLine);
	}
	
}