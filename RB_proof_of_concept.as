package
{
	import com.drastudio.Utilities;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	
	import org.alivepdf.fonts.CoreFont;
	import org.alivepdf.fonts.FontFamily;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	
	public class EasyInvoice extends Sprite
	{
		private var _pdf:PDF;
		private var _text:String;
		private var _textfield:TextField;
		
		public function EasyInvoice()
		{
			this.graphics.beginFill(0xcdcdcd,1)
			this.graphics.drawRoundRect(0,0, stage.stageWidth, stage.stageHeight, 15, 15);
			this.graphics.endFill()
			initWindowControls()
			
			_textfield = new TextField()
			_textfield.x = 40;
			_textfield.y = 40;
			_textfield.autoSize;
			_textfield.wordWrap = true;
			_textfield.border = true;
			_textfield.type = TextFieldType.INPUT;
			addChild(_textfield)
			
			
		}
		
		private function initWindowControls():void
		{
			var closeButton:Sprite = Utilities.easyButton("GeneratePDF");
			closeButton.x = stage.stageWidth - closeButton.width - 5;
			closeButton.y = 5
			closeButton.addEventListener(MouseEvent.CLICK, generatePDF);
			addChild(closeButton);
		}
		
		private function generatePDF(evt:MouseEvent):void
		{
			_pdf = new PDF( Orientation.LANDSCAPE, Unit.POINT, Size.A4);
			_pdf.addPage();
			
			_pdf.addText(_textfield.text);
			_pdf.setFontSize ( 18 );
			_pdf.setXY( 10, 40 );
			_pdf.writeText(4,_textfield.text);
			
				
			var stream:FileStream = new FileStream();
			var file:File = File.desktopDirectory.resolvePath("Desktop/GeneratedPDF");
			stream.open(file, FileMode.WRITE);
			var bytes:ByteArray = _pdf.save(Method.LOCAL);
			stream.writeBytes(bytes);
			stream.close()
		}
	}
}