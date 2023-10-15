package Classes {

	import flash.display.MovieClip;

	public class mapSym_1 extends MovieClip {

		public var dungeonMap: Array;
		public var mapLock: Array;
		public var mapOne: Array; // Новый массив mapOne
		public var mapMain: Array; // Новый массив mapMain
		public const MAP_WIDTH: int = 10;
		public const MAP_HEIGHT: int = 10;

		public function mapSym_1() {
			generateDungeon(30);
			printMapValues(dungeonMap);
			trace("####################");
			printMapValues(mapLock);
			trace("####################");
			printMapValues(mapOne);
			trace("####################");
			printMapValues(mapMain);
		}

		public function generateDungeon(totalRooms: int): void {
			dungeonMap = new Array(MAP_HEIGHT);
			mapLock = new Array(MAP_HEIGHT);
			mapOne = new Array(MAP_HEIGHT); // Инициализация mapOne
			mapMain = new Array(MAP_HEIGHT); // Инициализация mapMain

			for (var i: int = 0; i < MAP_HEIGHT; i++) {
				dungeonMap[i] = new Array(MAP_WIDTH);
				mapLock[i] = new Array(MAP_WIDTH);
				mapOne[i] = new Array(MAP_WIDTH); // Инициализация mapOne
				mapMain[i] = new Array(MAP_WIDTH); // Инициализация mapMain

				for (var j: int = 0; j < MAP_WIDTH; j++) {
					dungeonMap[i][j] = 0;
					mapLock[i][j] = 0;
					mapOne[i][j] = 0; // Инициализация mapOne
					mapMain[i][j] = 0; // Инициализация mapMain
				}
			}

			var startX: int = Math.floor(MAP_WIDTH / 2);
			var startY: int = Math.floor(MAP_HEIGHT / 2);

			dungeonMap[startY][startX] = 6;

			generateRandomPaths(startX, startY, totalRooms / 2, 0, -1);
			generateRandomPaths(startX, startY, totalRooms / 2, 0, 1);

			placeRoom(2);
			placeRoom(3);
			placeRoom(4);
			placeRoom(5);

			// Заполним mapLock в соответствии с dungeonMap
			for (var row: int = 0; row < MAP_HEIGHT; row++) {
				for (var col: int = 0; col < MAP_WIDTH; col++) {
					if (dungeonMap[row][col] == 6) {
						mapLock[row][col] = 1;
						setAdjacentRoomsLock(row, col);
					}
				}
			}

			// Заполним mapOne в соответствии с dungeonMap
			for (row = 0; row < MAP_HEIGHT; row++) {
				for (col = 0; col < MAP_WIDTH; col++) {
					if (dungeonMap[row][col] == 1) {
						mapOne[row][col] = Math.floor(Math.random() * 5) + 1; // Случайное число от 1 до 5
					}
				}
			}

			// Заполним mapMain в соответствии с dungeonMap
			for (row = 0; row < MAP_HEIGHT; row++) {
				for (col = 0; col < MAP_WIDTH; col++) {
					if (dungeonMap[row][col] == 6) {
						mapMain[row][col] = 1;
					}
				}
			}
		}

		public function generateRandomPaths(x: int, y: int, totalRooms: int, dx: int, dy: int): void {
			var directions: Array = [{
				dx: 0,
				dy: -1
			}, {
				dx: 0,
				dy: 1
			}, {
				dx: -1,
				dy: 0
			}, {
				dx: 1,
				dy: 0
			}];

			for (var i: int = 0; i < totalRooms; i++) {
				var dir: Object = directions[Math.floor(Math.random() * directions.length)];

				if (dir.dx != -dx || dir.dy != -dy) {
					dx = dir.dx;
					dy = dir.dy;
				}
				else {
					dir = directions[Math.floor(Math.random() * directions.length)];
					dx = dir.dx;
					dy = dir.dy;
				}

				var newX: int = x + dx;
				var newY: int = y + dy;

				if (newX >= 0 && newX < MAP_WIDTH && newY >= 0 && newY < MAP_HEIGHT && dungeonMap[newY][newX] == 0) {
					x = newX;
					y = newY;
					dungeonMap[y][x] = 1;
				}
			}
		}

		public function placeRoom(roomType: int): void {
			var placed: Boolean = false;

			while (!placed) {
				var x: int = Math.floor(Math.random() * MAP_WIDTH);
				var y: int = Math.floor(Math.random() * MAP_HEIGHT);

				if (dungeonMap[y][x] == 1) {
					dungeonMap[y][x] = roomType;
					placed = true;
				}
			}
		}

		public function setAdjacentRoomsLock(row: int, col: int): void {
			// Устанавливаем 1 вокруг комнаты (row, col)
			for (var i: int = -1; i <= 1; i++) {
				for (var j: int = -1; j <= 1; j++) {
					var newRow: int = row + i;
					var newCol: int = col + j;

					if (newRow >= 0 && newRow < MAP_HEIGHT && newCol >= 0 && newCol < MAP_WIDTH && dungeonMap[newRow][newCol] != 0) {
						mapLock[newRow][newCol] = 1;
					}
				}
			}
		}

		public function printMapValues(currentMap: Array): void {
			for (var i: int = 0; i < MAP_HEIGHT; i++) {
				var rowValues: String = "";
				for (var j: int = 0; j < MAP_WIDTH; j++) {
					rowValues += currentMap[i][j] + " ";
				}
				trace(rowValues);
			}
		}
	}
}
