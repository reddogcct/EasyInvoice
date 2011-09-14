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
		private var _num1:TextField;
		private var _num2:TextField;
		private var _sum:uint;
		private var _tfOuput:TextField;

		
		public function EasyInvoice()
		{
			this.graphics.beginFill(0xcdcdcd,1)
			this.graphics.drawRoundRect(0,0, stage.stageWidth, stage.stageHeight, 15, 15);
			this.graphics.endFill()
			
			initChromeControls();
			initUI();
			
			
			
		}
		private function initChromeControls():void
		{
			var handle:Sprite = new Sprite();
			handle.graphics.beginFill(0x666666);
			handle.graphics.drawRoundRect(0,0,stage.stageWidth, 35, 15,15);
			handle.graphics.endFill();
			handle.x = 0;
			handle.y = 0;
			addChild(handle);
			handle.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			var closeBtn:Sprite = Utilities.easyButton("Close");
			closeBtn.scaleX = closeBtn.scaleY = 0.5;
			closeBtn.x = stage.stageWidth - closeBtn.width - 5;
			closeBtn.y = 5;
			addChild(closeBtn);
			closeBtn.addEventListener(MouseEvent.CLICK, onCloseClick);
			
			var minBtn:Sprite = Utilities.easyButton("Minimize");
			minBtn.scaleX = minBtn.scaleY = 0.5;
			minBtn.x = closeBtn.x - minBtn.width - 5;
			minBtn.y = 5;
			addChild(minBtn);
			minBtn.addEventListener(MouseEvent.CLICK, onMinClick);	
		}
		
		private function initUI():void
		{
			_num1 = new TextField()
			_num1.x = 40;
			_num1.y = (stage.stageHeight/2) - 50;
			_num1.autoSize;
			_num1.height = 20;
			_num1.wordWrap = true;
			_num1.border = true;
			_num1.type = TextFieldType.INPUT;
			addChild(_num1)
			
			var tf1:TextField = new TextField();
			tf1.x = _num1.x + _num1.width + 20;
			tf1.y = _num1.y + 4;
			tf1.text = "+";
			addChild(tf1);	
			
			
			_num2 = new TextField()
			_num2.x = _num1.x + _num1.width + 50;
			_num2.y = _num1.y;
			_num2.autoSize;
			_num2.height = 20;
			_num2.wordWrap = true;
			_num2.border = true;
			_num2.type = TextFieldType.INPUT;
			addChild(_num2)
			
			var tf2:TextField = new TextField();
			tf2.x = _num2.x + _num2.width + 20;
			tf2.y = _num2.y + 4;
			tf2.text = "=";
			addChild(tf2);	
			
			var pdfBtn:Sprite = Utilities.easyButton("GET SUM");
			pdfBtn.x = _num2.x + _num2.width + 50;
			pdfBtn.y = _num2.y - 10;
			pdfBtn.addEventListener(MouseEvent.CLICK, onMath);
			addChild(pdfBtn);
			
		}
		
		
		private function onMath(evt:MouseEvent):void
		{
			_sum = parseInt(_num1.text) + parseInt(_num2.text)
			
			_tfOuput = new TextField();
			_tfOuput.text = _sum.toString();
			
			generatePDF()	
		}
		
		private function generatePDF():void
		{
			_pdf = new PDF( Orientation.LANDSCAPE, Unit.POINT, Size.A4);
			_pdf.addPage();
			
		//	_pdf.addText(_num1.text);
			_pdf.setFontSize ( 18 );
		//	_pdf.setXY( 10, 40 );
			_pdf.writeText(4,_tfOuput.text);
			
			var stream:FileStream = new FileStream();
			var file:File = File.desktopDirectory.resolvePath(_sum+".pdf");
			stream.open(file, FileMode.WRITE);
			var bytes:ByteArray = _pdf.save(Method.LOCAL);
			stream.writeBytes(bytes);
			stream.close()
			
		}
		
		private function onCloseClick(evt:MouseEvent):void
		{
			stage.nativeWindow.close();
		}
		
		private function onMinClick(evt:MouseEvent):void
		{
			stage.nativeWindow.minimize();
		}
		
		private function onMouseDown(evt:MouseEvent):void
		{
			stage.nativeWindow.startMove()
		}	
	}
}