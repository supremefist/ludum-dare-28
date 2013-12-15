package com.bourbontank.oneworld.sprites;
import flash.display.Sprite;
import flash.text.TextField;

/**
 * ...
 * @author ...
 */
class DetailBox extends Sprite
{

	var background:TextBackgroundSprite;
	var continent:Continent = null;
	var nameBox:TextField = null;
	var difficultBox:TextField = null;
	var specialtyBox:TextField = null;
	var statusBox:TextField = null;
	
	public function new() 
	{
		super();
		
		var boxWidth:Int = 250;
		var boxHeight:Int = 100;
		
		background = new TextBackgroundSprite(boxWidth, boxHeight);
		addChild(background);
		
		nameBox = Utils.createTextSprite("", 0x000000, 16);
		var borderBuffer:Float = background.borderLineWidth + background.borderOffset;
		nameBox.x += borderBuffer;
		nameBox.y += borderBuffer;
		nameBox.width = boxWidth - borderBuffer * 2;
		addChild(nameBox);

		difficultBox = Utils.createTextSprite("", 0x000000, 12);
		difficultBox.x += nameBox.x;
		difficultBox.y += nameBox.y + 30;
		difficultBox.width = nameBox.width;
		addChild(difficultBox);
		
		specialtyBox = Utils.createTextSprite("", 0x000000, 12);
		specialtyBox.x += nameBox.x;
		specialtyBox.y += nameBox.y + 50;
		specialtyBox.width = nameBox.width;
		specialtyBox.wordWrap = true;
		addChild(specialtyBox);
		
		statusBox = Utils.createTextSprite("", 0x000000, 12);
		statusBox.x += nameBox.x;
		statusBox.y += nameBox.y + 70;
		statusBox.width = nameBox.width;
		statusBox.wordWrap = true;
		addChild(statusBox);
	}
	
	public function setContinent(continent:Continent) {
		this.continent = continent;
		
		nameBox.text = continent.continentName;
		
		var difficultString = "Weak";
		if (continent.difficulty == 1) {
			difficultString = "Average";
		}
		else if (continent.difficulty == 2) {
			difficultString = "Strong";
		}
		difficultBox.text = "Debating: " + difficultString;
		
		var specialtyString = "Strong morale";
		if (continent.difficulty == 1) {
			specialtyString = "Quickness of wit";
		}
		else if (continent.difficulty == 2) {
			specialtyString = "Argument potency";
		}
		specialtyBox.text = "Specialty: " + specialtyString;
		
		var statusString = "Status: Oblivious";
		if (continent.friendly) {
			statusString = "Status: Informed";
		}
		statusBox.text = statusString;
	}
	
}