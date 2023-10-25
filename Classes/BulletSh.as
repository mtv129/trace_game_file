package Classes {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class BulletSh extends MovieClip {
		private var speedY: Number = 5;
		private var speedX: Number = 3;

		public function BulletSh() {
			addEventListener(Event.ENTER_FRAME, moveBullet);
		}

		private function moveBullet(event: Event): void {
			y += speedY * Math.sin(rotation * Math.PI / 180);
			x += speedY * Math.cos(rotation * Math.PI / 180);

			if (stage && (x < 0 || x > stage.stageWidth || y < 0 || y > stage.stageHeight)) {
				removeBullet();
			}
		}


		public function removeBullet(): void {
			removeEventListener(Event.ENTER_FRAME, moveBullet);
			if (parent) {
				parent.removeChild(this);
			}
		}
	}
}