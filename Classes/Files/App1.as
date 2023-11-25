package Classes.Files
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.*;
	import flash.utils.*;

	public class App1 extends MovieClip
	{
		private var fileName:String;
		private var fileExtension:String;
		private var customString:String;
		private var customStringTextField:TextField;

		public function App1(name:String, _extension:String, customString:String = "")
		{
			this.fileName = name;
			this.fileExtension = _extension;
			this.customString = customString;

			var graySquare:Sprite = createGraySquare();
			addChild(graySquare);

			graphics.lineStyle(2, 0xFFFFFF);
			graphics.drawRect(0, 0, 300, 250);

			var titleBar:TitleBar = new TitleBar(fileName,fileExtension,customString);
			addChild(titleBar);

			customStringTextField = createCustomStringTextField();
			customStringTextField.text = customString;
			addChild(customStringTextField);

			var closeButton:Sprite = createCloseButton();
			closeButton.x = width - closeButton.width - 2;
			closeButton.y = 0;
			addChild(closeButton);
		}

		private function createGraySquare():Sprite
		{
			var graySquare:Sprite = new Sprite();
			graySquare.graphics.beginFill(0xF4F4F4);
			graySquare.graphics.drawRect(0, 0, 300, 250);
			graySquare.graphics.endFill();

			return graySquare;
		}

		private function createNameTextField():TextField
		{
			var textField:TextField = new TextField();
			textField.text = fileName;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.y = 10;
			textField.x = 10;
			textField.selectable = false;

			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.font = "Arial";
			textFormat.size = 14;

			textField.setTextFormat(textFormat);

			return textField;
		}

		private function createCustomStringTextField():TextField
		{
			var textField:TextField = new TextField();
			textField.autoSize = TextFieldAutoSize.NONE;
			textField.width = 300;
			textField.height = 225;
			textField.multiline = true;
			textField.wordWrap = true;
			textField.y = 30;
			textField.x = 0;
			textField.type = TextFieldType.INPUT;

			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.font = "Arial";
			textFormat.size = 14;

			textField.setTextFormat(textFormat);

			return textField;
		}



		private function createCloseButton():Sprite
		{
			var closeButton:Sprite = new Sprite();
			closeButton.graphics.beginFill(0xFF0000);
			closeButton.graphics.drawRect(0, 0, 40, 30);
			closeButton.graphics.endFill();

			closeButton.graphics.lineStyle(2, 0xFFFFFF);
			closeButton.graphics.moveTo(15, 8);
			closeButton.graphics.lineTo(27, 19);
			closeButton.graphics.moveTo(27, 8);
			closeButton.graphics.lineTo(15, 19);

			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);

			return closeButton;
		}


		private function onCloseButtonClick(event:MouseEvent):void
		{
			if (parent)
			{
				var files:Array = [];
				var numChildren:int = MovieClip(root).numChildren;
				for (var i:int = 0; i < numChildren; i++)
				{
					var child:flash.display.DisplayObject = MovieClip(root).getChildAt(i) as flash.display.DisplayObject;
					if (child is File)
					{
						files.push(child);
					}
				}

				for each (var file:File in files)
				{
					if (file.getFileName() == fileName)
					{
						(file as File).setCustomString(customStringTextField.text);
						break;
					}
				}

				parent.removeChild(this);
			}
		}



	}
}