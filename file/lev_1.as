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

var menu: gadjetBig = new gadjetBig();
menu.x = 400;
menu.y = 300;
menu.frameRate = 30;
menu.visible = false;
addChild(menu);

var _pauseBut: pauseBut = new pauseBut();
_pauseBut.x = 700;
_pauseBut.y = 50;
addChild(_pauseBut);
_pauseBut.addEventListener(MouseEvent.CLICK, pauseClick);


// Получаем координаты единицы в mapMain
var oneCoordinates:Object = findCoordinatesOfOne(map.mapMain);

if (oneCoordinates != null && oneCoordinates.col > 0) {
    // Получаем число слева от позиции единицы в dungeonMap
    var numberToLeft:int = map.dungeonMap[oneCoordinates.row][oneCoordinates.col - 1];
    
    // Выводим результат в консоль
    trace("Число слева от единицы: " + numberToLeft);
} else {
    trace("Единица не найдена или она находится на краю массива.");
}


if (oneCoordinates != null && oneCoordinates.col > 0 && map.dungeonMap[oneCoordinates.row][oneCoordinates.col - 1] != 0) {
	var _leftBut: leftBut = new leftBut;
	_leftBut.x = 192;
	_leftBut.y = 259;
	addChild(_leftBut);
	_leftBut.addEventListener(MouseEvent.CLICK, onLeftButtonClick);
	function onLeftButtonClick(event: MouseEvent): void {
		moveOneFromMapMain(map, "left");
		removeAndGoToFrame2();

	}
}

if (oneCoordinates != null && oneCoordinates.row > 0 && map.dungeonMap[oneCoordinates.row - 1][oneCoordinates.col] != 0) {
	var _upBut: upBut = new upBut;
	_upBut.x = 688;
	_upBut.y = 245;
	addChild(_upBut);
	_upBut.addEventListener(MouseEvent.CLICK, onUpButtonClick);
	function onUpButtonClick(event: MouseEvent): void {
		moveOneFromMapMain(map, "up");
		removeAndGoToFrame2();
	}

}
if (oneCoordinates != null && oneCoordinates.col < map.MAP_WIDTH - 1 && map.dungeonMap[oneCoordinates.row][oneCoordinates.col + 1] != 0) {
	var _rightBut: rightBut = new rightBut;
	_rightBut.x = 668, 8;
	_rightBut.y = 537, 2;
	addChild(_rightBut);
	_rightBut.addEventListener(MouseEvent.CLICK, onRightButtonClick);

	function onRightButtonClick(event: MouseEvent): void {
		moveOneFromMapMain(map, "right");
		removeAndGoToFrame2();
	}
}
if (oneCoordinates != null && oneCoordinates.row < map.MAP_HEIGHT - 1 && map.dungeonMap[oneCoordinates.row + 1][oneCoordinates.col] != 0) {
	var _downBut: downBut = new downBut;
	_downBut.x = 125;
	_downBut.y = 520;
	addChild(_downBut);
	_downBut.addEventListener(MouseEvent.CLICK, onDownButtonClick);

	function onDownButtonClick(event: MouseEvent): void {
		moveOneFromMapMain(map, "down");
		removeAndGoToFrame2();
	}
}

function removeAndGoToFrame2(): void {
	gadjet.removeEnt();
	player.removeEnt();


	while (numChildren > 0) {
		removeChildAt(0);
	}
	gotoAndStop(45);

}

function moveOneFromMapMain(map: mapSym_1, direction: String): void {
	var oneCoordinates: Object = findCoordinatesOfOne(map.mapMain);

	if (direction == "left") {
		if (oneCoordinates.col > 0) {
			map.mapMain[oneCoordinates.row][oneCoordinates.col] = 0;
			map.mapMain[oneCoordinates.row][oneCoordinates.col - 1] = 1;
		}
	}
	else if (direction == "up") {
		if (oneCoordinates.row > 0) {
			map.mapMain[oneCoordinates.row][oneCoordinates.col] = 0;
			map.mapMain[oneCoordinates.row - 1][oneCoordinates.col] = 1;
		}
	}
	else if (direction == "right") {
		if (oneCoordinates.col < map.MAP_WIDTH - 1) {
			map.mapMain[oneCoordinates.row][oneCoordinates.col] = 0;
			map.mapMain[oneCoordinates.row][oneCoordinates.col + 1] = 1;
		}
	}
	else if (direction == "down") {
		if (oneCoordinates.row < map.MAP_HEIGHT - 1) {
			map.mapMain[oneCoordinates.row][oneCoordinates.col] = 0;
			map.mapMain[oneCoordinates.row + 1][oneCoordinates.col] = 1;
		}
	}

	map.printMapValues(map.mapMain);
}

function findCoordinatesOfOne(arr: Array): Object {
	for (var i: int = 0; i < arr.length; i++) {
		for (var j: int = 0; j < arr[i].length; j++) {
			if (arr[i][j] == 1) {
				return {
					row: i,
					col: j
				};
			}
		}
	}
	return null;
}

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