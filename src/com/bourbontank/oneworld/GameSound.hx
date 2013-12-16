package com.bourbontank.oneworld;
import openfl.Assets;
import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundTransform;

/**
 * ...
 * @author 
 */
class GameSound
{
	var control:Control;
	private var currentChannel:SoundChannel = null;
	
	var earthMusic:Sound;
	private var musicTransform:SoundTransform;
	
	public function new(control:Control) 
	{
		this.control = control;
	
		earthMusic = Assets.getSound("sfx/earth.mp3");
		
		musicTransform = new SoundTransform();
	}
	
	public function playFX(name:String) {
		var sound:Sound = Assets.getSound("sfx/" + name + ".wav");
		sound.play();
	}
	
	public function playEarthMusic()
	{
		if (currentChannel != null) {
			currentChannel.stop();
		}
		currentChannel = earthMusic.play (0, 99999, musicTransform);
	}
}