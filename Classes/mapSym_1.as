package Classes {

	import flash.display.MovieClip;

	public class mapSym_1 extends MovieClip {

		private var dungeonMap: Array;
		private const MAP_WIDTH: int = 10;
		private const MAP_HEIGHT: int = 10;

		public function mapSym_1() {
			generateDungeon(30);
			printMapValues();
		}

		private function generateDungeon(totalRooms: int): void {
			dungeonMap = new Array(MAP_HEIGHT);
			for (var i: int = 0; i < MAP_HEIGHT; i++) {
				dungeonMap[i] = new Array(MAP_WIDTH);
				for (var j: int = 0; j < MAP_WIDTH; j++) {
					dungeonMap[i][j] = 0;
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
		}

		private function generateRandomPaths(x: int, y: int, totalRooms: int, dx: int, dy: int): void {
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

		private function placeRoom(roomType: int): void {
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

		private function printMapValues(): void {
			for (var i: int = 0; i < MAP_HEIGHT; i++) {
				var rowValues: String = "";
				for (var j: int = 0; j < MAP_WIDTH; j++) {
					rowValues += dungeonMap[i][j] + " ";
				}
				trace(rowValues);
			}
		}
	}
}