package Classes.Files
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TitleBar extends Sprite
	{
		private var fileName:String;
		private var fileExtension:String;
		private var customString:String;

		public function TitleBar(_fileName:String, _fileExtension:String, _customString:String = "")
		{
			fileName = _fileName;
			fileExtension = _fileExtension;
			customString = _customString;

			this.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			this.addEventListener(MouseEvent.MOUSE_UP, stopDragging);

			var nameTextField:TextField = createNameTextField();
			addChild(nameTextField);
		}

		private function createNameTextField():TextField
		{
			var textField:TextField = new TextField();
			textField.text = fileName + "." + fileExtension;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.y = 5;
			textField.x = 10;
			textField.selectable = false;

			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.font = "Arial";
			textFormat.size = 14;

			textField.setTextFormat(textFormat);

			return textField;
		}



		private function startDragging(event:MouseEvent):void
		{
			if (parent is Sprite)
			{
				Sprite(parent).startDrag();
			}
		}

		private function stopDragging(event:MouseEvent):void
		{
			if (parent is Sprite)
			{
				Sprite(parent).stopDrag();
			}
		}


	}
}