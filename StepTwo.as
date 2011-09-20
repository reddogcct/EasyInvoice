package com.ES.UI
{
	import com.ES.Events.InvoiceEvent;
	import com.ES.vo.InvoiceVO;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import libs.secondStep;
	
	public class StepTwo extends secondStep
	{
		private var _invoiceVO:InvoiceVO
		private var _namePrompt:String = "First and Last name";
		private var _companyPrompt:String = "Company/Organization name";
		private var _emailPrompt:String = "email@example.com";
		private var _phonePrompt:String = "555-555-5555";
		private var _descriptionPrompt:String ="Your Project Description Here";
		
		public function StepTwo()
		{
			super();
			
			windowMinButton.buttonMode = true;
			windowMinButton.mouseChildren = false;
			windowMinButton.tfWindowControl.text = "-";
			windowCloseButton.buttonMode = true;
			windowCloseButton.mouseChildren = false;
			
			stepTabs.firstTab.tfTabLabel.text = "Step 1";
			stepTabs.secondTab.tfTabLabel.text = "Step 2";
			stepTabs.thirdTab.tfTabLabel.text = "Step 3";
			stepTabs.thirdTab.alpha = .5;
			
			userNameInput.tfInputTitle.text = "Name: *";
			userCompanyInput.tfInputTitle.text = "Company:";
			userEmailInput.tfInputTitle.text = "E-mail: *";
			userPhoneInput.tfInputTitle.text = "Phone Number: *";
			
			userNameInput.inputField.tfInputFieldText.text = _namePrompt;
			userCompanyInput.inputField.tfInputFieldText.text = _companyPrompt;
			userEmailInput.inputField.tfInputFieldText.text = _emailPrompt;
			userPhoneInput.inputField.tfInputFieldText.text = _phonePrompt;
			ProjectDescription.tfProjectDescription.text = _descriptionPrompt;
			
			userNameInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInName);
			userCompanyInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInCompany);
			userEmailInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInEmail);
			userPhoneInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInPhone);
			ProjectDescription.addEventListener(FocusEvent.FOCUS_IN, onTextFocusInDescription);
			
			nextButton.tfButton.text = "Step 3";
			nextButton.mouseChildren = false;
			nextButton.buttonMode = true;
			nextButton.addEventListener(MouseEvent.CLICK, onClick)
			
			backButton.tfButton.text = "Back";
			backButton.mouseChildren = false;
			backButton.buttonMode = true;
			
			firstStepOverview.tfNameReviewText.text = "NameReview";
			firstStepOverview.tfPhoneReviewText.text = "PhoneReview";
			firstStepOverview.tfEmailReviewText.text = "EmailReview";
			firstStepOverview.tfRoleReviewText.text = "RoleReview";
			firstStepOverview.tfCompanyReviewText.text = "CompanyReview";
		
					
		}	

		public function get invoiceVO():InvoiceVO
		{
			return _invoiceVO;
		}

		public function set invoiceVO(value:InvoiceVO):void
		{
			_invoiceVO = value;
			
			firstStepOverview.tfNameReviewText.text = _invoiceVO.userName;
			firstStepOverview.tfPhoneReviewText.text = _invoiceVO.userPhone;
			firstStepOverview.tfEmailReviewText.text = _invoiceVO.userEmail;
			firstStepOverview.tfRoleReviewText.text = _invoiceVO.userRole;
			firstStepOverview.tfCompanyReviewText.text = _invoiceVO.userCompany;
			firstStepOverview.tfJobTypeReviewText.text = _invoiceVO.projectType;
			firstStepOverview.tfJobPriceReviewText.text = "$ "+_invoiceVO.projectPrice;
			
		}

		private function onClick(evt:MouseEvent):void
		{
			
	/*		var iVO:InvoiceVO = new InvoiceVO();
			iVO.userName = firstStepOverview.tfNameReviewText.text;
			iVO.userCompany = firstStepOverview.tfCompanyReviewText.text;
			iVO.userRole =  firstStepOverview.tfRoleReviewText.text;
			iVO.userEmail = firstStepOverview.tfEmailReviewText.text ;
			iVO.userPhone = firstStepOverview.tfPhoneReviewText.text;
				_iVO.designPrice = jobType.designProjectType.priceInput.tfPriceText.text;
				_iVO.developPrice = jobType.developProjectType.priceInput.tfPriceText.text;*/
			
			_invoiceVO.clientName = userNameInput.inputField.tfInputFieldText.text;
			_invoiceVO.clientCompany = userCompanyInput.inputField.tfInputFieldText.text;
			_invoiceVO.clientEmail = userEmailInput.inputField.tfInputFieldText.text;
			_invoiceVO.clientPhone = userPhoneInput.inputField.tfInputFieldText.text
			_invoiceVO.projectDescription = ProjectDescription.tfProjectDescription.text;
			
			var iEvent:InvoiceEvent = new InvoiceEvent(InvoiceEvent.SEND_VO)
			iEvent.iVO = _invoiceVO;
			dispatchEvent(iEvent)
		}
		private function onTextFocusInName(evt:FocusEvent):void
		{
			if(userNameInput.inputField.tfInputFieldText.text == _namePrompt)
			{
				userNameInput.inputField.tfInputFieldText.text = '';
			}
		}
		
		private function onTextFocusInCompany(evt:FocusEvent):void
		{
			if(userCompanyInput.inputField.tfInputFieldText.text == _companyPrompt)
			{
				userCompanyInput.inputField.tfInputFieldText.text = '';
			}
		}
		
		private function onTextFocusInEmail(evt:FocusEvent):void
		{
			if(userEmailInput.inputField.tfInputFieldText.text == _emailPrompt)
			{
				userEmailInput.inputField.tfInputFieldText.text = '';
			}
		}
		
		private function onTextFocusInPhone(evt:FocusEvent):void
		{
			if(userPhoneInput.inputField.tfInputFieldText.text == _phonePrompt)
			{
				userPhoneInput.inputField.tfInputFieldText.text = '';
			}	
		}
		
		private function onTextFocusInDescription(evt:FocusEvent):void
		{
			if(ProjectDescription.tfProjectDescription.text == _descriptionPrompt)
			{
				ProjectDescription.tfProjectDescription.text = "";
			}
		}
	}
}