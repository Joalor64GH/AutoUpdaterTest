package;

class UpdateState extends FlxState {
	public static var mustUpdate:Bool = false;
	public static var daJson:Dynamic;

	override function create() {
		super.create();

		var text:FlxText = new FlxText(0, 0, FlxG.width,
			"Hey! You're running an outdated version!"
			+ '\nYour current version is v${Lib.application.meta.get('version')}, while the most recent version is v${daJson.version}!\n
			What\'s New:\n'
			+ daJson.description
			+ '\nPress ENTER to update the game. Otherwise, press ESCAPE to proceed anyways.\n
			Thanks for playing!', 40);
		text.screenCenter(XY);
		add(text);
	}

	public static function updateCheck() {
		trace('checking for updates...');
		var http = new Http('https://raw.githubusercontent.com/Joalor64GH/AutoUpdaterTest/main/version.json');
		http.onData = (data:String) -> {
			var daRawJson:Dynamic = Json.parse(data);
			if (daRawJson.version != Lib.application.meta.get('version')) {
				trace('oh noo outdated!!');
				daJson = daRawJson;
				mustUpdate = true;
			} else
				mustUpdate = false;
		}

		http.onError = (error) -> trace('error: $error');
		http.request();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) {
			FlxG.switchState(PlayState.new);
		}

        if (FlxG.keys.justPressed.ENTER) {
			AutoUpdater.downloadUpdate();
		}
	}
}