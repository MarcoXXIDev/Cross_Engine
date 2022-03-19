package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

	private var vocals:FlxSound;

	var scoreText:FlxText;
	var modText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var curRead:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var weekSelected:Int = 0;

	var songNameFP:String = "";
	var weekFP:Int = 0;

	var difficultySelectors:FlxGroup;

	var sprDifficulty:FlxSprite;

	override function create()
	{
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		addWeek(['Tutorial'], 0, ['gf']);

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		if(StoryMenuState.weekUnlocked[2] || isDebug)
			addWeek(['Bopeebo', 'Fresh', 'Dadbattle'], 1, ['dad']);
		if(StoryMenuState.weekUnlocked[3] || isDebug)
			addWeek(['Spookeez', 'South', 'Monster'], 2, ['spooky']);
		if(StoryMenuState.weekUnlocked[4] || isDebug)
			addWeek(['Pico', 'Philly', 'Blammed'], 3, ['pico']);
		if(StoryMenuState.weekUnlocked[5] || isDebug)
			addWeek(['Satin-Panties', 'High', 'Milf'], 4, ['mom']);
		if(StoryMenuState.weekUnlocked[6] || isDebug)
			addWeek(['Cocoa', 'Eggnog', 'Winter-Horrorland'], 5, ['parents-christmas', 'parents-christmas', 'monster-christmas']);
		if(StoryMenuState.weekUnlocked[7] || isDebug)
			addWeek(['Senpai', 'Roses', 'Thorns'], 6, ['senpai', 'senpai', 'spirit']);
		// LOAD MUSIC

		for (i in 0...initSonglist.length)
		{
			if (initSonglist[i] != "")
			{
				switch (curRead)
				{
					case 0:
						songNameFP = initSonglist[i];
					case 1:
						weekFP = Std.parseInt(initSonglist[i]);
					case 2:
					{
						songs.push(new SongMetadata(songNameFP, weekFP, initSonglist[i], "Basegame"));
					}	
				}
				if (curRead == 2)
				{
					curRead = 0;
				}
				else
				{
					curRead += 1;
				}
			}
		}

		var modList = CoolUtil.coolTextFile(Paths.txt('modList'));
		for (i in 0...modList.length)
		{
			if (modList[i] != "Basegame")
			{
				var curModSL = CoolUtil.coolTextFile(Paths.txt('mods/' + modList[i] + '/songlist'));
				var curMod:String = modList[i];
				for (i in 0...curModSL.length)
				{
					switch (curRead)
					{
						case 0:
							songNameFP = curModSL[i];
						case 1:
							weekFP = Std.parseInt(curModSL[i]);
						case 2:
						{
							songs.push(new SongMetadata(songNameFP, weekFP, curModSL[i], curMod));
						}	
					}
					if (curRead == 2)
					{
						curRead = 0;
					}
					else
					{
						curRead += 1;
					}
				}
			}
		}
		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('funkin'));
		bg.width = FlxG.width;
		bg.height = FlxG.height;
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;
		modText = new FlxText(FlxG.width * 0.7, scoreText.y + 36, 0, "", 32);
		modText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 80, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		sprDifficulty = new FlxSprite(FlxG.width * 0.45, 0);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		
		var difficultyBG:FlxSprite = new FlxSprite(FlxG.width * 0.35, 0).makeGraphic(Std.int((FlxG.width * 0.666)-(FlxG.width * 0.35)), 66, 0xFF000000);
		difficultyBG.alpha = 0.6;
		add(difficultyBG);

		diffText = new FlxText(scoreText.x, modText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);
		add(modText);
		add(sprDifficulty);

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, mod:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, mod));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num], "Basegame");

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST: " + lerpScore;
		modText.text = songs[curSelected].mod;
		if (lerpScore == 0)
		{
			scoreText.text = "PERSONAL BEST: N/A";
		}
		difficultySelectors.visible = true;

		switch(curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 20;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);
		if (FlxG.keys.justPressed.Q)
		{
			changeSelection(-3);
		}
		if (FlxG.keys.justPressed.E)
		{
			changeSelection(3);
		}
		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);

			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			PlayState.storyWeek = songs[curSelected].week;
			trace('CUR WEEK' + PlayState.storyWeek);
			LoadingState.loadAndSwitchState(new PlayState());
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		#end
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		// lerpScore = 0;
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var mod:String = "";

	public function new(song:String, week:Int, songCharacter:String, mod:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.mod = mod;
	}
}
