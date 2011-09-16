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
		
		// explicit declare the font
		/*var font:Font = new Font(Font.HELVETICA, 12, Font.NORMAL, RGBColor.BLACK);
		_document.add( new Paragraph(_body.text,font));
		
		//create a new font using a BaseFont as Source (changes font)
		var baseFont:BaseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI);
		font = new Font(Font.UNDEFINED, Font.UNDEFINED, Font.UNDEFINED, RGBColor.GREEN, baseFont);
		_document.add( new Paragraph(_body.text, font))*/;
		
		_document.close();
		
		//Saves the pdf file
		var file:FileReference = new FileReference();
		file.save(_buffer," Invoice"+ ".pdf");
		
	}
