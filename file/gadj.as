_res.addEventListener(MouseEvent.CLICK, resClick);

function resClick(e: MouseEvent): void {
	if (root is MovieClip) {
		this.visible = false;
		MovieClip(root).pauseBool = false;
		MovieClip(root).stage.frameRate = 60;
	}
}

_exit.addEventListener(MouseEvent.CLICK, exitClick);

function exitClick(e: MouseEvent): void {
	MovieClip(root).pauseBool = false;
	stage.frameRate = 60;
	_exit.removeEventListener(MouseEvent.CLICK, exitClick);
	MovieClip(root).removeAndGoToFrame1();
}
