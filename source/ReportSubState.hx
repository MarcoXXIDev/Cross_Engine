package;

import Discord.DiscordClient;

import Controls.Control;
import PlayState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;



class ReportSubState 
{
    var myOwnRatingShit:PlayState;
    var report:FlxText;

    var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    bg.alpha = 0;
    bg.scrollFactor.set();
    add(bg);

    report = new FlxText(healthBarBG.x + (healthBarBG.width / 2) - 1250, 0, 2500, "", 20);
    report.setFormat(Paths.font("ChunkFive-Regular.otf"), 40, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    report.scrollFactor.set();
    report.alignment = FlxTextAlign.CENTER;
    add(report);

    report.text = "Rank : " + myOwnRatingShit;

    if (FlxG.keys.justPressed.ENTER)
		{
			
		}
}

