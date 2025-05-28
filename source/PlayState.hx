package;

class PlayState extends FlxState {
	override public function create() {
		super.create();

		UpdateState.updateCheck();

		if (UpdateState.mustUpdate)
			FlxG.switchState(UpdateState.new);

		var text:FlxText = new FlxText(0, 0, 0, "Hello World!\nNow Improved!", 64);
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}