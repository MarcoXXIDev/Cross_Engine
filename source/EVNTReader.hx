package;

import lime.utils.Assets;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

using StringTools;

class EVNTReader
{
    public static function readEVNTData(file:Array<String>, line:Int)
    {
        var temp:String = "";
        temp = StringTools.replace(file[line], "-sound(", "");
        temp = StringTools.replace(file[line], "-flash(", "");
        temp = StringTools.replace(file[line], "-switchChar(", "");
        
        temp = StringTools.replace(temp, ")", "");
        return temp;
    }
    public static function readEVNT(file:Array<String>, line:Int)
    {
        var absoluteBullShit:String = "";
		if (file[line].startsWith("-sound"))
            absoluteBullShit =  "sound";
        if (file[line].startsWith("-flash"))
            absoluteBullShit =  "flash";
        if (file[line].startsWith("-switchChar"))
            absoluteBullShit =  "switchChar";
        return absoluteBullShit;
    }
}