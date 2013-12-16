package com.bourbontank.oneworld;
import com.bourbontank.oneworld.screen.BriefingScreen;
import com.bourbontank.oneworld.screen.DebateScreen;
import com.bourbontank.oneworld.screen.Screen;
import com.bourbontank.oneworld.screen.SplashScreen;
import com.bourbontank.oneworld.screen.TutorialDebateScreen;
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
	public var sound:GameSound;
	private var worldStartX:Int = 0;
	private var worldStartY:Int = 0;
	public var introConversation:Array<ChatLine>;
	
	public var continents:Array<Continent>;
	
	public var friendlyDelegates:Int = 0;
	public var playerThrowRateBonus:Int = 0;
	public var playerPotencyBonus:Int = 0;
	public var playerMoraleBonus:Int = 0;
	
	public function buildConversations() {
		// Intro
		introConversation = new Array<ChatLine>();
		introConversation.push(new ChatLine("Narrator", "You are the king of the great kingdom of Monaco!  You have ruled it honorably for many years.  Unfortunately, the scientist in Monaco has determined that the world will be uninhabitable within one year due to global warming!  This is likely to affect us negatively.  You know what they say... You only get one world!"));
		introConversation.push(new ChatLine("Scientist", "Scientist: Your Majesty, I do believe it's time for Monaco to step in and save the world! We shall do it by convincing all the nations of the world to abandon their selfish carbon emissions, continent by continent!  How hard could it be?  Your debating skills are unmatched."));
		introConversation.push(new ChatLine("King", "You: Aye, they are unmatched, but I swore I would never use them again!  Remember what happened last time when I debated that young man..."));
		introConversation.push(new ChatLine("Scientist", "Scientist: That was a child, your Majesty."));
		introConversation.push(new ChatLine("King", "You: Child, who cares.  The point is that I am forced to take up debating again!  Where do we begin?"));
		introConversation.push(new ChatLine("Scientist", "Scientist: It begins right here.  You must convince the queen that our cause is just!"));
		introConversation.push(new ChatLine("King", "You: The horror!  She is as ruthless in love as she is in debate!"));
	}
	
	public function initData() {
		addContinents();
		
		buildConversations();
	}
	
	public function restart() {
		friendlyDelegates = 0;
		playerMoraleBonus = 0;
		playerPotencyBonus = 0;
		playerThrowRateBonus = 0;
		
		initData();
		
		sound.playEarthMusic();
		
		var screen:Screen = new SplashScreen(display, this);
		display.setScreen(screen);
	}
	
	public function addContinents() {
		continents = new Array<Continent>();
		var continent;
		
		continent = new Continent(display, this, "North America", "img/continents/north_america.png");
		continent.victoryConversation = [new ChatLine("Scientist", "Excellent debating, sire!  The americans never saw it coming!")];
		
		continent.specialty = 2; // Argument potency
		continent.difficulty = 2;
		continent.x = worldStartX;
		continent.y = worldStartY;
		continents.push(continent);
		
		continent = new Continent(display, this, "South America", "img/continents/south_america.png");
		continent.victoryConversation = [new ChatLine("Scientist", "They're good at football, but they are no match for your debating skills, my liege!")];
		continent.specialty = 0; // Strong morale
		continent.difficulty = 0;
		continent.x = worldStartX + 180;
		continent.y = worldStartY + 270;
		continents.push(continent);
		
		continent = new Continent(display, this, "Europe", "img/continents/europe.png");
		continent.victoryConversation = [new ChatLine("Scientist", "With the help of all these first world countries, noone can stop us, sire!")];
		continent.specialty = 1; // Quickness of wit
		continent.difficulty = 2;
		continent.x = worldStartX + 320;
		continent.y = worldStartY;
		continents.push(continent);
		
		continent = new Continent(display, this, "Africa", "img/continents/africa.png");
		continent.victoryConversation = [new ChatLine("Scientist", "Against all odds, your debating skills are increasing even further, your Majesty!")];
		continent.specialty = 0; // Strong morale
		continent.difficulty = 0;
		continent.x = worldStartX + 330;
		continent.y = worldStartY + 200;
		continents.push(continent);
		
		continent = new Continent(display, this, "Asia", "img/continents/asia.png");
		continent.victoryConversation = [new ChatLine("Scientist", "More great nations now support us, sire!")];
		continent.specialty = 1; // Quickness of wit
		continent.difficulty = 1;
		continent.x = worldStartX + 423;
		continent.y = worldStartY + 27;
		continents.push(continent);
		
		continent = new Continent(display, this, "Australia", "img/continents/australia.png");
		continent.victoryConversation = [new ChatLine("Scientist", "Throw some shrimp on the barby, yourself!")];
		continent.specialty = 2; // Argument potency
		continent.difficulty = 1;
		continent.x = worldStartX + 608;
		continent.y = worldStartY + 305;
		continents.push(continent);
	}
	
	public function worldPhase() {
		var screen:Screen = new WorldScreen(display, this);
		screen.conversation = [];
		screen.conversation.push(new ChatLine("Scientist", "Scientist: Now that the queen is on our side, she is allowing is to leave the castle, again!  We can debate the rulers of any continent we like!  Select the continent we will debate next."));
		screen.conversation.push(new ChatLine("Scientist", "Scientist: The continents marked in red are not convinced that global warming is real, yet.  We have to convince them all!"));
		screen.conversing = true;
		
		display.setScreen(screen);
		
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
		//display.setScreen(new BriefingScreen(display, this, introConversation, new WorldScreen(display, this)));
		//display.setScreen(new TutorialDebateScreen(display, this));
		//display.setScreen(new DebateScreen(display, this, null));
		//sound.playMusic();
		
		restart();
		
		//worldPhase();
	}
	
}