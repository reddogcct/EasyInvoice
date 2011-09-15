package
{
	import com.ES.UI.StepOne;
	import com.drastudio.Utilities;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	
	import org.purepdf.Font;
	import org.purepdf.colors.RGBColor;
	import org.purepdf.elements.Element;
	import org.purepdf.elements.HeaderFooter;
	import org.purepdf.elements.Paragraph;
	import org.purepdf.elements.Phrase;
	import org.purepdf.elements.RectangleElement;
	import org.purepdf.pdf.PageSize;
	import org.purepdf.pdf.PdfDocument;
	import org.purepdf.pdf.PdfWriter;
	import org.purepdf.pdf.fonts.BaseFont;
	import org.purepdf.pdf.fonts.FontsResourceFactory;
	import org.purepdf.resources.BuiltinFonts;
	
[SWF(height="600", width="800")]
	public class EasyInvoice extends Sprite
	{
	//	private var _pdf:PDF;
		private var _header:TextField;
		private var _footer:TextField;
		private var _body:TextField;
		private var _sum:uint;
		private var _tfOuput:TextField;
		private var _document:PdfDocument;
		private var _writer:PdfWriter;
		private var _buffer:ByteArray;
		private var _headFont:Font;
		private var _footerFont:Font;
		private var _xPos:uint = 100;
		private var _step1:StepOne 

		
		public function EasyInvoice()
		{
			/*this.graphics.beginFill(0xcdcdcd,1)
			this.graphics.drawRoundRect(0,0, stage.stageWidth, stage.stageHeight, 15, 15);
			this.graphics.endFill()*/
			
			initChromeControls();
			initUI();
			
		}
		private function initChromeControls():void
		{
/*			var handle:Sprite = new Sprite();
			handle.graphics.beginFill(0x666666);
			handle.graphics.drawRoundRect(0,0,stage.stageWidth, 35, 15,15);
			handle.graphics.endFill();
			handle.x = 0;
			handle.y = 0;
	//		addChild(handle);
			
			var closeBtn:Sprite = Utilities.easyButton("Close");
			closeBtn.scaleX = closeBtn.scaleY = 0.5;
			closeBtn.x = stage.stageWidth - closeBtn.width - 5;
			closeBtn.y = 5;
	//		addChild(closeBtn);
			
			var minBtn:Sprite = Utilities.easyButton("Minimize");
			minBtn.scaleX = minBtn.scaleY = 0.5;
			minBtn.x = closeBtn.x - minBtn.width - 5;
			minBtn.y = 5;
	//		addChild(minBtn);
		*/
			
		}
		
		private function initUI():void
		{	
			_step1 = new StepOne();	
			_step1.nextButton.addEventListener(MouseEvent.CLICK, onMath);
			addChild(_step1)

			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			
			var tf1:TextField = new TextField();
			tf1.text = "Header: ";
			tf1.x = _xPos;
			tf1.y = 50;
			tf1.height = 20;
		//	addChild(tf1);	
			
			_header = new TextField()
			_header.x = _xPos;
			_header.y = tf1.y + tf1.height;
		//	_header.autoSize;
			_header.height = 20;
			_header.width = 200;
			_header.wordWrap = true;
			_header.border = true;
			_header.type = TextFieldType.INPUT;
	//		addChild(_header)
			
			var tf2:TextField = new TextField();
			tf2.x = _xPos;
			tf2.y = 110;
			tf2.height = 20;
			tf2.text = "Body: ";
	//		addChild(tf2);	
			
			_body = new TextField()
			_body.x = _xPos;
			_body.y = tf2.y + tf2.height;
			_body.height = 100;
			_body.width = 200;
			_body.wordWrap = true;
			_body.border = true;
			_body.type = TextFieldType.INPUT;
	//		addChild(_body)
			
			var tf3:TextField = new TextField();
			tf3.x = _xPos;
			tf3.y = 245;
			tf3.height = 20;
			tf3.text = "Footer: ";
	//		addChild(tf3);	
			
				
			_footer = new TextField()
			_footer.x = _xPos;
			_footer.y = tf3.y + tf3.height;
			_footer.autoSize;
			_footer.height = 20;
			_footer.width = 200;
			_footer.wordWrap = true;
			_footer.border = true;
			_footer.type = TextFieldType.INPUT;
	//		addChild(_footer)
			
			var pdfBtn:Sprite = Utilities.easyButton("Save PDF");
			pdfBtn.x = _xPos;
			pdfBtn.y = _footer.y + _footer.height + 10;
			pdfBtn.addEventListener(MouseEvent.CLICK, onMath);
	//		addChild(pdfBtn);
			
		}
		
		
		private function onMath(evt:MouseEvent):void
		{
			_sum = parseInt(_header.text) + parseInt(_footer.text)
			
			_tfOuput = new TextField();
			_tfOuput.text = _sum.toString();
			
			generatePDF()
			
			
				
		}
		
		private function generatePDF():void
		{
			_buffer = new ByteArray();
			_writer = PdfWriter.create(_buffer, PageSize.A4);
			_document = _writer.pdfDocument;
			
			
			// register 'Helvetica' font
			FontsResourceFactory.getInstance().registerFont( BaseFont.HELVETICA, new BuiltinFonts.HELVETICA());
			
			//Creates the font for the header and footer
			_headFont = new Font(Font.HELVETICA, 14, Font.NORMAL, RGBColor.BLACK);
			_footerFont = new Font(Font.HELVETICA, 14, Font.NORMAL, RGBColor.GRAY);
			
			//Creating the header
			var header:HeaderFooter = new HeaderFooter( new Phrase(_step1.userCompanyInput.inputField.tfInputFieldText.text, _headFont), null, false);
			
			header.alignment = Element.ALIGN_RIGHT;
			header.borderColor = new RGBColor( 100, 100, 100);
			header.border = RectangleElement.BOTTOM;
			header.borderWidth = 0.5;
			
			//Creating the footer	
		/*	var footer:HeaderFooter = new HeaderFooter( new Phrase( _footer.text+ " ", _footerFont), null, false);
			
			footer.alignment = Element.ALIGN_CENTER;
			footer.border = RectangleElement.NO_BORDER;
			footer.backgroundColor = new RGBColor(180, 180, 180);
		*/
			_document.setHeader(header);
	//		_document.setFooter(footer);	
			_document.open();
			
			// create a simple Paragraph using the default font
			_document.add( new Paragraph("Name" + _step1.userNameInput.inputField.tfInputFieldText.text));
			_document.add( new Paragraph("Company" + _step1.userCompanyInput.inputField.tfInputFieldText.text));
			_document.add( new Paragraph("Role" +_step1.userRoleInput.inputField.tfInputFieldText.text));
			_document.add( new Paragraph("Email" + _step1.userEmailInput.inputField.tfInputFieldText.text));
			_document.add( new Paragraph("Phone" + _step1.userPhoneInput.inputField.tfInputFieldText.text));
			
			// explicit declare the font
			var font:Font = new Font(Font.HELVETICA, 12, Font.NORMAL, RGBColor.BLACK);
			_document.add( new Paragraph(_body.text,font));
			
			//create a new font using a BaseFont as Source (changes font)
			var baseFont:BaseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI);
			font = new Font(Font.UNDEFINED, Font.UNDEFINED, Font.UNDEFINED, RGBColor.GREEN, baseFont);
			_document.add( new Paragraph(_body.text, font));
			
			_document.close();
			
			//Saves the pdf file
			var file:FileReference = new FileReference();
			file.save(_buffer, _step1.userCompanyInput.inputField.tfInputFieldText.text +" Invoice"+ ".pdf");
			
			
			/*_pdf = new PDF( Orientation.PORTRAIT, Unit.MM, Size.A4);
			_pdf.addPage();
			_pdf.setFontSize(18);
			_pdf.writeText(10, "The sum of: " + _num1.text);
			_pdf.writeText(20, "\n" + "and " + _num2.text);
			_pdf.setFontSize(50);
			_pdf.setY(100);
			_pdf.setX(100);
		//	_pdf.setTitle("hello")
			_pdf.writeText(30, "\n" + "Equals: " + _tfOuput.text);
			//_pdf.writeText(10, "\n" +"hello"); 
			
		//	_pdf.addImage(MovieClip:EasyInvoicePoC.jpg, null, 0,0,0,0,0,1,true,"jpg",100);
			
			var stream:FileStream = new FileStream();
			var file:File = File.desktopDirectory.resolvePath(_sum+".pdf");
			stream.open(file, FileMode.WRITE);
			
			var bytes:ByteArray = _pdf.save(Method.LOCAL);
			stream.writeBytes(bytes);
			stream.close()*/
			
		}
		
		private function onMouseDown(evt:MouseEvent):void
		{
			stage.nativeWindow.startMove()
		}	
	}
}