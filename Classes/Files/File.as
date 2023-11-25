package Classes.Files {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class File extends MovieClip {
        private var fileName:String;
        private var fileExtension:String;
        private var nameTextField:TextField;
        private var targetFrame:String;
        private var customClass:Class;
        private var customString:String;

        public function File(name:String, extension:String, targetFrame:String = "PC", customClass:Class = null, customString:String = "") {
            this.fileName = name;
            this.fileExtension = extension;
            this.targetFrame = targetFrame;
            this.customClass = customClass;
            this.customString = customString;

            nameTextField = new TextField();
            nameTextField.text = name + "." + extension;
            nameTextField.autoSize = TextFieldAutoSize.CENTER;
            nameTextField.y = 70;
            nameTextField.x = this.width / 2 - nameTextField.width / 2;
            nameTextField.selectable = false; 

            var textFormat:TextFormat = new TextFormat();
            textFormat.color = 0xFFFFFF; 
            textFormat.font = "Arial"; 
            textFormat.size = 14;

            nameTextField.setTextFormat(textFormat);
            
            addChild(nameTextField);

            this.mouseEnabled = true;
            this.doubleClickEnabled = true;

            this.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
            this.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
            this.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);

            var hasExtensionFrame:Boolean = false;
            for each (var labelObject:Object in this.currentLabels) {
                if (labelObject.name == fileExtension) {
                    hasExtensionFrame = true;
                    gotoAndStop(fileExtension);
                    break;
                }
            }

            if (!hasExtensionFrame) {
                gotoAndStop(1);
            }
        }

        private function startDragging(event:MouseEvent):void {
            this.startDrag();
        }

        private function stopDragging(event:MouseEvent):void {
            this.stopDrag();
        }

        private function onDoubleClick(event:MouseEvent):void {
			if (targetFrame == "PC" && customClass != null) {
				if (customClass == App1) {
					var appObject:MovieClip = new App1(fileName, fileExtension, customString);
					appObject.x = this.x + 30;
					appObject.y = this.y + 30;
					MovieClip(root).addChild(appObject);
				} else {
					var customObject:MovieClip = new customClass();
					customObject.x = this.x + 30;
					customObject.y = this.y + 30;
					MovieClip(root).addChild(customObject);
				}
			} else {
				MovieClip(root)._removeAll(targetFrame);
			}
		}


        public function getFileName():String {
            return fileName;
        }

        public function getFileExtension():String {
            return fileExtension;
        }
		public function setCustomString(value:String):void {
    customString = value;
}
    }
}
