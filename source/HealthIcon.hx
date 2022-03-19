package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var curCharPath:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		switch(char)
		{
			case 'bf':
				animation.add('bf', [0, 1], 0, false, isPlayer);
			case 'bf-car':
				animation.add('bf-car', [0, 1], 0, false, isPlayer);
			case 'bf-christmas':
				animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
			case 'bf-pixel':
				animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
			case 'spooky':
				animation.add('spooky', [2, 3], 0, false, isPlayer);
			case 'pico':
				animation.add('pico', [4, 5], 0, false, isPlayer);
			case 'mom':
				animation.add('mom', [6, 7], 0, false, isPlayer);
			case 'mom-car':
				animation.add('mom-car', [6, 7], 0, false, isPlayer);
			case 'tankman':
				animation.add('tankman', [8, 9], 0, false, isPlayer);
			case 'face':
				animation.add('face', [10, 11], 0, false, isPlayer);
			case 'dad':
				animation.add('dad', [12, 13], 0, false, isPlayer);
			case 'senpai':
				animation.add('senpai', [22, 22], 0, false, isPlayer);
			case 'senpai-angry':
				animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
			case 'spirit':
				animation.add('spirit', [23, 23], 0, false, isPlayer);
			case 'bf-old':
				animation.add('bf-old', [14, 15], 0, false, isPlayer);
			case 'gf':
				animation.add('gf', [16], 0, false, isPlayer);
			case 'parents-christmas':
				animation.add('parents-christmas', [17], 0, false, isPlayer);
			case 'monster':
				animation.add('monster', [19, 20], 0, false, isPlayer);
			case 'monster-christmas':
				animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
			default:
			{
				curCharPath = 'characters/' + char + '/icons';
				loadGraphic(Paths.image(curCharPath), true, 150, 150);
				animation.add(char, [0, 1], 0, false, isPlayer);
			}
		}
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
