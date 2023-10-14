package Classes {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class gadjetHit extends MovieClip {
		private var player: MovieClip;
		private var distance: Number = 30;

		public function gadjetHit() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			player = MovieClip(root).player;

			addEventListener(Event.ENTER_FRAME, updatePosition);
		}

		private function updatePosition(event: Event): void {
			var dx: Number = parent.mouseX - player.x;
			var dy: Number = parent.mouseY - player.y;
			var angleRadians: Number = Math.atan2(dy, dx);

			var angleDegrees: Number = angleRadians * 180 / Math.PI;

			rotation = angleDegrees;

			x = player.x + 50 * Math.cos(rotation * Math.PI / 180);
			y = player.y + 30 * Math.sin(rotation * Math.PI / 180);
		}
		public function removeEnt(){
			removeEventListener(Event.ENTER_FRAME, updatePosition);
		}
	}
}