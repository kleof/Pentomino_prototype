function finish_tweens(_tweens) {
	for (var i = 0; i < array_length(_tweens); ++i) {
		TweenFinish(_tweens[i]);
	}
}