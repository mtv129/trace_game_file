package Classes {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class gadjetHit extends MovieClip {
		private var player: MovieClip;
		private var distance: Number = 30;
		private var bulletTimer: Timer;

		public function gadjetHit() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			player = MovieClip(root).player;

			addEventListener(Event.ENTER_FRAME, updatePosition);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, startShooting);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopShooting);

			bulletTimer = new Timer(300);
			bulletTimer.addEventListener(TimerEvent.TIMER, onBulletTimer);
		}

		private function updatePosition(event: Event): void {
			var dx: Number = parent.mouseX - player.x;
			var dy: Number = parent.mouseY - player.y;
			var angleDegrees: Number = Math.atan2(dy, dx) * 180 / Math.PI;

			rotation = angleDegrees;

			x = player.x + 50 * Math.cos(rotation * Math.PI / 180);
			y = player.y + 30 * Math.sin(rotation * Math.PI / 180);
		}

		private function startShooting(event: MouseEvent): void {
			MovieClip(root).bulletCreate();
			bulletTimer.start();
		}

		private function stopShooting(event: MouseEvent): void {
			bulletTimer.stop();
		}

		private function onBulletTimer(event: TimerEvent): void {
			MovieClip(root).bulletCreate();
		}

		public function removeEnt(): void {
			removeEventListener(Event.ENTER_FRAME, updatePosition);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, startShooting);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopShooting);

			bulletTimer.stop();
			bulletTimer.removeEventListener(TimerEvent.TIMER, onBulletTimer);
		}
	}
}