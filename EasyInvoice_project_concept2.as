package
{
	//NOTE YOU NEED PUREPFD.SWC TO USE THIS EXAMPLE
		
	import com.drastudio.Utilities;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
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
	
	public class EasyInvoice2 extends Sprite
	{
		private var _document:PdfDocument;
		private var _writer:PdfWriter;
		private var _buffer:ByteArray;
		private var _textfield:TextField;
		private var _title:TextField;
		private var _header:Font;
		private var _footer:Font;
		
		public function EasyInvoice2()
		{
			this.graphics.beginFill(0xcdcdcd,1)
			this.graphics.drawRoundRect(0,0, stage.stageWidth, stage.stageHeight, 15, 15);
			this.graphics.endFill()
			initWindowControls();
		}
		
		private function initWindowControls():void
		{
			var upload:Sprite = Utilities.easyButton("Upload");
			upload.x = 200;
			upload.y = 105;
			upload.addEventListener(MouseEvent.CLICK, onUploadClick);
			addChild(upload);
			
			var closeButton:Sprite = Utilities.easyButton("Close")
			closeButton.x = stage.stageWidth - closeButton.width - 5;
			closeButton.y = 5
			closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			addChild(closeButton);
			
			var generateButton:Sprite = Utilities.easyButton("GeneratePDF");
			generateButton.x = closeButton.x - generateButton.width - 5;
			generateButton.y = 5
			generateButton.addEventListener(MouseEvent.CLICK, generatePDF);
			addChild(generateButton);
			
			_textfield = new TextField()
			_textfield.x = 40;
			_textfield.y = 60;
			_textfield.autoSize;
			_textfield.wordWrap = true;
			_textfield.border = true;
			_textfield.type = TextFieldType.INPUT;
			addChild(_textfield)
			
			_title = new TextField();
			_title.x = 40;
			_title.y = 20;
			_title.height = 30;
			_title.border = true;
			_title.type = TextFieldType.INPUT;
			addChild(_title);
		}
		
		private function generatePDF(evt:MouseEvent):void
		{
			_buffer = new ByteArray();
			_writer = PdfWriter.create(_buffer, PageSize.A4);
			_document = _writer.pdfDocument;
			
			
			// register 'Helvetica' font
			FontsResourceFactory.getInstance().registerFont( BaseFont.HELVETICA, new BuiltinFonts.HELVETICA());
			
			//Creates the font for the header and footer
			_header = new Font(Font.HELVETICA, 14, Font.NORMAL, RGBColor.BLACK);
			_footer = new Font(Font.HELVETICA, 14, Font.NORMAL, RGBColor.GRAY);
			
			//Creating the header
			var header:HeaderFooter = new HeaderFooter( new Phrase(_title.text, _header));
			
			header.alignment = Element.ALIGN_RIGHT;
			header.borderColor = new RGBColor( 100, 100, 100);
			header.border = RectangleElement.BOTTOM;
			header.borderWidth = 0.5;
			
			//Creating the footer	
			var footer:HeaderFooter = new HeaderFooter( new Phrase("Page Number", _footer));
			
			footer.alignment = Element.ALIGN_CENTER;
			footer.border = RectangleElement.NO_BORDER;
			footer.backgroundColor = new RGBColor(180, 180, 180);
			
			_document.setHeader(header);
			_document.setFooter(footer);
			
			_document.open();
			
			
		
			
			
			// create a simple Paragraph using the default font
			_document.add( new Paragraph(_title.text));
			
			// explicit declare the font
			
			var font:Font = new Font(Font.HELVETICA, 12, Font.NORMAL, RGBColor.BLACK);
			_document.add( new Paragraph(_textfield.text,font));
			
			//create a new font using a BaseFont as Source
			var baseFont:BaseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI);
			font = new Font(Font.UNDEFINED, Font.UNDEFINED, Font.UNDEFINED, RGBColor.GREEN, baseFont);
			_document.add( new Paragraph(_textfield.text, font));
			
			_document.close();
			
			//Create the pdf file
			
			var file:FileReference = new FileReference();
			file.save(_buffer, _title.text + ".pdf");
			
			/*_font = new CoreFont(FontFamily.HELVETICA_BOLD);
			var font2:IFont = new CoreFont(FontFamily.TIMES_ITALIC);
			
			_pdf = new PDF( Orientation.PORTRAIT, Unit.POINT, Size.A4);
			_pdf.addPage();
			
			_pdf.setFont(_font, 24);
			_pdf.addText(_title.text, 250, 20);
			_pdf.setTitle(_title.text);
			
			
			_pdf.setFont(font2, 12);
			_pdf.addText(_textfield.text, 20, 100);
			
			
			
			var stream:FileStream = new FileStream();
			var file:File = File.desktopDirectory.resolvePath("Desktop/" + _title.text);
			stream.open(file, FileMode.WRITE);
			var bytes:ByteArray = _pdf.save(Method.LOCAL);
			stream.writeBytes(bytes);
			stream.close()*/
		}
		
		private function onUploadClick(evt:MouseEvent):void
		{
			var fileref:FileReference = new FileReference();
			var file:File = new File();
			file.browse();
			
		}
		
		private function onCloseClick(evt:MouseEvent):void
		{
			stage.nativeWindow.close();
		}
	}
}