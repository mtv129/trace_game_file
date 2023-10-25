package Classes {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class depthY extends MovieClip {
		public function setDepth(mc: DisplayObject, depth: Number): void {
			depth = Math.floor(depth);

			if (depth >= mc.parent.numChildren) {
				depth = mc.parent.numChildren - 1;
			}

			mc.parent.setChildIndex(mc, depth);

			mc.parent.addChildAt(mc, depth);
		}
		public function init(): void {
			for (var i: int = 0; i < parent.numChildren; i++) {
				var obj: DisplayObject = parent.getChildAt(i);

				if (!(obj is cubeMap) &&  obj != this && obj.parent == parent) {
					setDepth(obj, Math.floor(obj.y));
				}
			}
		}


		public function depthY() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event: Event): void {
			init();
		}
		public function removeEv(){
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
	}
}