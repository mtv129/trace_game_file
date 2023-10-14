import flash.display.MovieClip;
import Classes.depthY;
import Classes.gadjetHit;
import Classes.mapSym_1;
import flash.events.MouseEvent;
import flash.events.Event;

stop();

const numRows: int = 9;
const numCols: int = 9;
const distanceCubes: int = 31;

const cubeX: int = 30;
const cubeY: int = 15;

var pauseBool: Boolean = false;

for (var row: int = 0; row < numRows; row++) {
	for (var col: int = 0; col < numCols; col++) {
		var cube: issomCube = new issomCube();

		cube.x = col * cubeX - row * distanceCubes + 400;
		cube.y = row * cubeY + col * distanceCubes * 0.5 + 300;

		addChild(cube);
	}
}

var player: hitBoxPlayer = new hitBoxPlayer();
player.x = 395;
player.y = 412;
addChild(player);

var blockHit: blockHitBox = new blockHitBox();
blockHit.x = 405;
blockHit.y = 319;
blockHit.visible = false;
addChild(blockHit);

var gadjet: gadjetHit = new gadjetHit();
gadjet.x = 100;
gadjet.y = 100;
addChild(gadjet);

var depY: depthY = new depthY();
addChild(depY);

var map: mapSym_1 = new mapSym_1();
map.visible = false;
addChild(map);

var menu: gadjetBig = new gadjetBig();
menu.x = 400;
menu.y = 300;
menu.frameRate = 30;
menu.visible = false;
addChild(menu);

var _pauseBut:pauseBut = new pauseBut();
_pauseBut.x = 700;
_pauseBut.y = 50;
addChild(_pauseBut);
_pauseBut.addEventListener(MouseEvent.CLICK, pauseClick);

function pauseClick(e: MouseEvent): void {
	if (!pauseBool) {
		menu.visible = true;
		pauseBool = true;
		stage.frameRate = 0;
	}
	else {
		menu.visible = false;
		pauseBool = false;
		menu.stage.frameRate = 60;
	}
}
function removeAndGoToFrame1() {
	gadjet.removeEnt();
	player.removeEnt();
	while (numChildren > 0) {
		trace(numChildren);
		removeChildAt(0);
	}
	gotoAndStop(1);
	return;
}