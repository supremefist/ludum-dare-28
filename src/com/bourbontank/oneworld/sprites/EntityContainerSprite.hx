package com.bourbontank.oneworld.sprites;
import flash.display.Sprite;
import com.bourbontank.oneworld.Main;
/**
 * ...
 * @author 
 */
class EntityContainerSprite extends Sprite
{

	var entities:Array<EntitySprite>;
	
	public function new() 
	{
		super();
		
		entities = new Array<EntitySprite>();
	}
	
	function offScreen(entity:EntitySprite) {
		var buffer:Int = 100;
		if (entity.x > Main.screenWidth + buffer) {
			return true;
		}
		else if (entity.x < -buffer) {
			return true;
		}
		else if (entity.y > Main.screenHeight + buffer) {
			return true;
		}
		else if (entity.y < -buffer) {
			return true;
		}
		return false;
	}
	
	public function updateEntities(delta:Int) {
		for (entity in entities) {
			entity.update(delta);
		}
	}
}