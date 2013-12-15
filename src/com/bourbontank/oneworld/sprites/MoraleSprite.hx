package com.bourbontank.oneworld.sprites;

import flash.display.Sprite;
import flash.text.TextField;
import com.bourbontank.oneworld.Utils;
/**
 * ...
 * @author ...
 */
class MoraleSprite extends Sprite
{

	var bar:Sprite;
	var delegate:Delegate;
	var maxMorale:Int;
	var barWidth:Int;
	var previousMorale:Int = 0;
	
	public function new(barWidth:Int, delegate:Delegate) 
	{
		super();
		this.barWidth = barWidth;
		this.delegate = delegate;
		this.maxMorale = delegate.morale;
		
		var label:TextField = Utils.createTextSprite("Morale: ", 0x000000, 12);
		label.x -= 55;
		addChild(label);
		
		
		update();
		
	}
	
	public function update() {
		var newMorale:Int = delegate.morale;
		if (newMorale != previousMorale) {
			if (bar != null) {
				removeChild(bar);
			}
			bar = new Sprite();
		
			previousMorale = newMorale;
			var percentage:Float = newMorale / maxMorale;
			
			var lineColor:UInt = 0x00FF00;
			if (percentage < 0.25) {
				lineColor = 0xFF0000;
			}
			else if (percentage < 0.5) {
				lineColor = 0xFF6600;
			}
			else if (percentage < 0.75) {
				lineColor = 0xFFFF00;
			}
			
			bar.graphics.clear();
			bar.graphics.lineStyle( 4, lineColor, 1 );
			bar.graphics.moveTo(0, 11);
			bar.graphics.lineTo(barWidth * percentage, 11);
			
			addChild(bar);
		}
	}
	
}