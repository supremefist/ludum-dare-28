package com.bourbontank.oneworld;
import com.bourbontank.oneworld.screen.BriefingScreen;
import com.bourbontank.oneworld.screen.DebateScreen;
import com.bourbontank.oneworld.screen.SplashScreen;
import com.bourbontank.oneworld.screen.WorldScreen;
import flash.display.Sprite;
import com.bourbontank.oneworld.sprites.Continent;
/**
 * ...
 * @author 
 */
class Control
{

	var display:Display;
	var sound:GameSound;
	private var worldStartX:Int = 0;
	private var worldStartY:Int = 0;
	private var introConversation:Array<ChatLine>;
	
	public var continents:Array<Continent>;
	
	public function buildConversations() {
		// Intro
		introConversation = new Array<ChatLine>();
		introConversation.push(new ChatLine("Narrator", "You are the king of the great kingdom of Monaco!  You have ruled it honorably for many years.  Unfortunately, the scientist in Monaco has determined that the world will be uninhabitable within one year due to global warming!  This is likely to affect us negatively.  You know what they say... You only get one world!"));
		
		
	}
	
	public function initData() {
		addContinents();
		
		buildConversations();
	}
	
	public function addContinents() {
		continents = new Array<Continent>();
		var continent;
		
		continent = new Continent(display, this, "img/continents/north_america.png");
		continent.x = worldStartX;
		continent.y = worldStartY;
		continents.push(continent);
		
		continent = new Continent(display, this, "img/continents/south_america.png");
		continent.x = worldStartX + 180;
		continent.y = worldStartY + 270;
		continents.push(continent);
		
		continent = new Continent(display, this, "img/continents/europe.png");
		continent.x = worldStartX + 320;
		continent.y = worldStartY;
		continents.push(continent);
		
		continent = new Continent(display, this, "img/continents/africa.png");
		continent.x = worldStartX + 330;
		continent.y = worldStartY + 200;
		continents.push(continent);
		
		continent = new Continent(display, this, "img/continents/asia.png");
		continent.x = worldStartX + 423;
		continent.y = worldStartY + 27;
		continents.push(continent);
		
		continent = new Continent(display, this, "img/continents/australia.png");
		continent.x = worldStartX + 608;
		continent.y = worldStartY + 305;
		continents.push(continent);
	}
	
	public function worldPhase() {
		var done:Bool = true;
		for (continent in continents) {
			if (!continent.friendly) {
				done = false;
			}
		}
		
		if (!done) {
			display.setScreen(new WorldScreen(display, this));
		}
		else {
			// Game finished!
		}
	}
	
	public function new(?rootSprite:Sprite) 
	{
		if (rootSprite != null) {
			this.display = new Display(this, rootSprite);
			this.sound = new GameSound(this);
		}
		
		initData();
	}
	
	public function start() {
		//display.setScreen(new SplashScreen(display, this));
		display.setScreen(new BriefingScreen(display, this, introConversation, new WorldScreen(display, this)));
		//sound.playMusic();
	}
	
}