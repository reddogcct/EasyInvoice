package com.ES.UI
{
	import com.ES.Events.InvoiceEvent;
	import com.ES.vo.InvoiceVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
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
	
	
	public class Steps extends Sprite
	{
		private var _step1:StepOne;
		private var _step2:StepTwo;
		private var _step3:StepThree;
		private var _preview:InvoicePreview;
		private var _saveas:InvoiceSave;
		private var _VO:InvoiceVO;
		private var _document:PdfDocument;
		private var _writer:PdfWriter;
		private var _buffer:ByteArray;
		private var _headFont:Font;
		private var _footerFont:Font;

		
		public function Steps()
		{
			super();
			
			_step1 = new StepOne();
			_step1.windowCloseButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_step1.windowMinButton.addEventListener(MouseEvent.CLICK, onMinClick);	
			_step1.addEventListener(InvoiceEvent.SEND_VO, gotVO)
			addChild(_step1)
			
			_step2 = new StepTwo();
			_step2.windowCloseButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_step2.windowMinButton.addEventListener(MouseEvent.CLICK, onMinClick);	
			_step2.backButton.addEventListener(MouseEvent.CLICK, onBacktoFirst);
			_step2.addEventListener(InvoiceEvent.SEND_VO, gotVO)
				
			_step3 = new StepThree();
			_step3.windowCloseButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_step3.windowMinButton.addEventListener(MouseEvent.CLICK, onMinClick);
			_step3.backButton.addEventListener(MouseEvent.CLICK, onBacktoSecond);
			_step3.addEventListener(InvoiceEvent.SEND_VO, gotVO)
				
			_preview = new InvoicePreview();
			_preview.windowCloseButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_preview.windowMinButton.addEventListener(MouseEvent.CLICK, onMinClick);
			_preview.nextButton.addEventListener(MouseEvent.CLICK, onSave)	
			_preview.backButton.addEventListener(MouseEvent.CLICK, onBacktoThird);
		
			_saveas = new InvoiceSave();
			_saveas.savePrompt.iconPDF.addEventListener(MouseEvent.CLICK, onGeneratePDF)
	//		_saveas.savePrompt.iconPDF.addEventListener(MouseEvent.CLICK, onTrace)
			_saveas.savePrompt.goBackButton.addEventListener(MouseEvent.CLICK, onEdit)
			_saveas.savePrompt.previewPDFButton.addEventListener(MouseEvent.CLICK, onPreview) 
				
		}
		
		private function onGeneratePDF(evt:MouseEvent):void
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
			var header:HeaderFooter = new HeaderFooter( new Phrase(_VO.userCompany, _headFont), null, false);
			
			header.alignment = Element.ALIGN_RIGHT;
			header.borderColor = new RGBColor( 100, 100, 100);
			header.border = RectangleElement.BOTTOM;
			header.borderWidth = 0.5;
			
			//Creating the footer	
			var footer:HeaderFooter = new HeaderFooter( new Phrase( "THis is a footer" + " ", _footerFont), null, false);
			
			footer.alignment = Element.ALIGN_CENTER;
			footer.border = RectangleElement.NO_BORDER;
			footer.backgroundColor = new RGBColor(180, 180, 180);
			
			_document.setHeader(header);
			_document.setFooter(footer);	
			_document.open();
			
			var totalMins:int = new int();
			totalMins = (_VO.workHours * 60) + _VO.workMins
			
			var pricePerMin:Number = new Number();
			pricePerMin =	(_VO.projectPrice) / 60;
			
			var sum:Number = new Number();
			sum = (pricePerMin * totalMins);
			
			// create a simple Paragraph using the default font
			_document.add( new Paragraph("Name: " + _VO.userName));
			_document.add( new Paragraph("Company: " + _VO.userCompany));
			_document.add( new Paragraph("Role: " + _VO.userRole));
			_document.add( new Paragraph("Email: " + _VO.userEmail));
			_document.add( new Paragraph("Phone Number: " +_VO.userPhone));
			_document.add( new Paragraph("---------------------------"));
			_document.add( new Paragraph("Name: " + _VO.clientName));
			_document.add( new Paragraph("Company: " + _VO.clientCompany));
			_document.add( new Paragraph("Email: " + _VO.clientEmail));
			_document.add( new Paragraph("Phone Number: " +_VO.clientPhone));
			_document.add( new Paragraph("---------------------------"));
			_document.add( new Paragraph("Project Description:"));
			_document.add( new Paragraph(_VO.projectDescription));
			_document.add( new Paragraph(" "))
			_document.add( new Paragraph("Total Hours: "+_VO.workHours+" hours and "+ _VO.workMins+" minutes"));
			_document.add( new Paragraph("Total Cost: $"+sum));
			_document.close();
			
			//Saves the pdf file
			var file:FileReference = new FileReference();
			file.save(_buffer," Invoice"+ ".pdf");
			
		}
		private function gotVO(evt:InvoiceEvent):void
		{	
			_VO = evt.iVO
			
			if(evt.target is StepOne)
			{
				removeChild(_step1);
			
				_step2.invoiceVO = evt.iVO;
				addChild(_step2);	
			
			}
			else if(evt.target is StepTwo)
			{
				removeChild(_step2);
				
				_step3.invoiceVO = evt.iVO
				addChild(_step3);	
				
			}
			else if(evt.target is StepThree)
			{
				removeChild(_step3)
				_preview.invoiceVO = evt.iVO
				addChild(_preview)
			}
			
			
		}
		private function onTrace(evt:MouseEvent):void
		{
			
			trace("User: " + _VO.userName);
			trace("Company: " + _VO.userCompany);
			trace("Role: " + _VO.userRole);
			trace("Email: " + _VO.userEmail);
			trace("Phone: " + _VO.userPhone);
			trace(" ");
			trace("Client: " + _VO.clientName);
			trace("Company: " + _VO.clientCompany);
			trace("Email: " + _VO.clientEmail);
			trace("Phone: " + _VO.clientPhone);
			trace(" ");
			trace("Project Description:");
			trace(_VO.projectDescription);
			trace(" ");
			trace("WorkLoad:");
			trace(_VO.workLoad);
			
			
			
				
			var totalMins:int = new int();
			totalMins = (_VO.workHours * 60) + _VO.workMins
				
			var pricePerMin:Number = new Number();
			pricePerMin =	(_VO.projectPrice) / 60;
			
			var sum:Number = new Number();
			sum = (pricePerMin * totalMins); 
			
			trace("Total: " +"$"+sum)
			
		}
		
		
		private function onBacktoFirst(evt:MouseEvent):void
		{
			removeChild(_step2);
			addChild(_step1);
		}
		private function onBacktoSecond(evt:MouseEvent):void
		{
			removeChild(_step3);
			addChild(_step2);
		}
		private function onBacktoThird(evt:MouseEvent):void
		{
			removeChild(_preview);
			addChild(_step3);
		}
		
		private function onCloseClick(evt:MouseEvent):void
		{
			stage.nativeWindow.close();
		}
		private function onMinClick(evt:MouseEvent):void
		{
			stage.nativeWindow.minimize();
		}
		private function onSave(evt:MouseEvent):void
		{
			removeChild(_preview)
			addChild(_saveas)
		}
		private function onEdit(evt:MouseEvent):void
		{
			removeChild(_saveas)
			addChild(_step1)
		}
		private function onPreview(evt:MouseEvent):void
		{
			removeChild(_saveas)
			addChild(_preview)
		}
		
		
	}
}