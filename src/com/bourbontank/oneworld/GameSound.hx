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
	
	var music:Sound;
	private var musicTransform:SoundTransform;
	
	public function new(control:Control) 
	{
		this.control = control;
	
		music = Assets.getSound("sfx/music.mp3");
		musicTransform = new SoundTransform();
	}
	
	public function playMusic()
	{
		currentChannel = music.play (0, 99999, musicTransform);
	}
}