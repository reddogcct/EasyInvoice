package com.ES.UI
{
	import com.ES.Events.InvoiceEvent;
	import com.ES.vo.InvoiceVO;
	
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import libs.firstStep;
	
	public class StepOne extends firstStep
	{
		private var _namePrompt:String = "First and Last name";
		private var _companyPrompt:String = "Company/Organization name";
		private var _rolePrompt:String = "i.e: Business Manager";
		private var _emailPrompt:String = "email@example.com";
		private var _phonePrompt:String = "555-555-5555";
		private var _pricePrompt:String = "$00.00";
		private var _type:Boolean = true;
		
		
		public function StepOne()
		{
			super();
			
			windowMinButton.buttonMode = true;
			windowMinButton.mouseChildren = false;
			windowCloseButton.buttonMode = true;
			windowCloseButton.mouseChildren = false;
			
			stepTabs.firstTab.tfTabLabel.text = "Step 1";
			stepTabs.secondTab.tfTabLabel.text = "Step 2";
			stepTabs.secondTab.alpha = .5;
			stepTabs.thirdTab.tfTabLabel.text = "Step 3";
			stepTabs.thirdTab.alpha = .5;
			
			userNameInput.tfInputTitle.text = "Name: *";
			userCompanyInput.tfInputTitle.text = "Company:";
			userRoleInput.tfInputTitle.text = "Role:";
			userEmailInput.tfInputTitle.text = "E-mail: *";
			userPhoneInput.tfInputTitle.text = "Phone Number: *";
			
			userNameInput.inputField.tfInputFieldText.text = _namePrompt;
			userCompanyInput.inputField.tfInputFieldText.text = _companyPrompt;
			userRoleInput.inputField.tfInputFieldText.text = _rolePrompt;
			userEmailInput.inputField.tfInputFieldText.text = _emailPrompt;
			userPhoneInput.inputField.tfInputFieldText.text = _phonePrompt;

			
			logoUpload.uploadBtns.clearBtn.tfBtnLabel.text = "Clear";
			logoUpload.uploadBtns.uploadBtn.tfBtnLabel.text = "Upload";
			logoUpload.uploadBtns.clearBtn.buttonMode = true;
			logoUpload.uploadBtns.clearBtn.mouseChildren = false;
			logoUpload.uploadBtns.uploadBtn.buttonMode = true;
			logoUpload.uploadBtns.uploadBtn.mouseChildren = false;
			
			nextButton.tfButton.text = "Step 2";
			nextButton.mouseChildren = false;
			nextButton.buttonMode = true;
			nextButton.addEventListener(MouseEvent.CLICK, onClick)
			
			backButton.tfButton.text = "Back";
			backButton.mouseChildren = false;
			backButton.buttonMode = true;
			backButton.alpha = .5;
			
			windowMinButton.tfWindowControl.text = "-";
			
			jobType.designProjectType.ProjectTypeRadioButton.stop()
			jobType.designProjectType.projectTypeTF.text = "Design Project";
			jobType.designProjectType.priceInput.tfPriceText.text = "$00.00";
			jobType.developProjectType.ProjectTypeRadioButton.stop()
		 	jobType.developProjectType.projectTypeTF.text = "Develop Project"; 
			jobType.developProjectType.priceInput.tfPriceText.text = "$00.00";

			
			
			
			userNameInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInName);
			userCompanyInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInCompany);
			userRoleInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInRole);
			userEmailInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInEmail);
			userPhoneInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInPhone);
			jobType.designProjectType.priceInput.tfPriceText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInDesign)
			jobType.developProjectType.priceInput.tfPriceText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInDevelop)
			
			jobType.developProjectType.ProjectTypeRadioButton.gotoAndStop(1)
			jobType.developProjectType.ProjectTypeRadioButton.buttonMode = true;
			jobType.developProjectType.ProjectTypeRadioButton.mouseChildren = false
			jobType.developProjectType.addEventListener(MouseEvent.CLICK, onDevelopClick);
			
			jobType.designProjectType.ProjectTypeRadioButton.gotoAndStop(1)
			jobType.designProjectType.ProjectTypeRadioButton.buttonMode = true;
			jobType.designProjectType.ProjectTypeRadioButton.mouseChildren = false;
			jobType.designProjectType.addEventListener(MouseEvent.CLICK, onDesignClick);

			/*userNameInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOutName);
			userCompanyInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOutCompany)
			userRoleInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOutRole)
			userEmailInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOutEmail)
			userPhoneInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOutPhone)
			jobType.designProjectType.priceInput.tfPriceText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusOutDesign)
			jobType.developProjectType.priceInput.tfPriceText.addEventListener(FocusEvent.FOCUS_IN,onTextFocusOutDevelop)
			*/
			
			
		}
		private function onClick(evt:MouseEvent):void
		{
			
			var iVO:InvoiceVO = new InvoiceVO();
			iVO.userName = userNameInput.inputField.tfInputFieldText.text;
			iVO.userCompany = userCompanyInput.inputField.tfInputFieldText.text;
			iVO.userRole =  userRoleInput.inputField.tfInputFieldText.text;
			iVO.userEmail = userEmailInput.inputField.tfInputFieldText.text;
			iVO.userPhone = userPhoneInput.inputField.tfInputFieldText.text
			
			if(_type)
			{
				iVO.projectType = "Design"
				iVO.projectPrice = parseInt(jobType.designProjectType.priceInput.tfPriceText.text);
			}
			else
			{
				iVO.projectType = "Develop"	
				iVO.projectPrice = parseInt(jobType.developProjectType.priceInput.tfPriceText.text);
			}
			
		//	iVO.developPrice = jobType.developProjectType.priceInput.tfPriceText.text;
			
			var iEvent:InvoiceEvent = new InvoiceEvent(InvoiceEvent.SEND_VO)
			iEvent.iVO = iVO;
			dispatchEvent(iEvent)
		}
		
		private function onDesignClick(evt:MouseEvent):void
		{
			
			if(evt.currentTarget == jobType.designProjectType )
			{
				jobType.designProjectType.ProjectTypeRadioButton.gotoAndStop(2)
				jobType.developProjectType.ProjectTypeRadioButton.gotoAndStop(1)
				_type = true;	
			}
			
		}	
	
		
		
		private function onDevelopClick(evt:MouseEvent):void
		{
			
			if(evt.currentTarget == jobType.developProjectType)
			{
				jobType.developProjectType.ProjectTypeRadioButton.gotoAndStop(2)
				jobType.designProjectType.ProjectTypeRadioButton.gotoAndStop(1)
				_type = false;	
					
			}
			
			
			
		}
		//Focus In Events
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
		private function onTextFocusInRole(evt:FocusEvent):void
		{
			if(userRoleInput.inputField.tfInputFieldText.text == _rolePrompt)
			{
				userRoleInput.inputField.tfInputFieldText.text = '';
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
		private function onTextFocusInDesign(evt:FocusEvent):void
		{
			if(jobType.designProjectType.priceInput.tfPriceText.text == _pricePrompt)
			{
				jobType.designProjectType.priceInput.tfPriceText.text = '';
			}
		}	
		private function onTextFocusInDevelop(evt:FocusEvent):void
		{
			 if(jobType.developProjectType.priceInput.tfPriceText.text == _pricePrompt)
			 {
				jobType.developProjectType.priceInput.tfPriceText.text = '';
			 }
		}
		
		//Focus Out Events
		/*private function onTextFocusOutName(evt:FocusEvent):void
		{
			if(userNameInput.inputField.tfInputFieldText.text == " ")
			{
				userNameInput.inputField.tfInputFieldText.text = _namePrompt;
			}
		}
		private function onTextFocusOutCompany(evt:FocusEvent):void
		{
			if(userCompanyInput.inputField.tfInputFieldText.text == " ")
			{
				userCompanyInput.inputField.tfInputFieldText.text = _companyPrompt;
			}
		}	
		private function onTextFocusOutRole(evt:FocusEvent):void
		{
			if(userRoleInput.inputField.tfInputFieldText.text == " ")
			{
				userRoleInput.inputField.tfInputFieldText.text = _rolePrompt;
			}
		}
		private function onTextFocusOutEmail(evt:FocusEvent):void
		{
			if(userEmailInput.inputField.tfInputFieldText.text == " ")
			{
				userEmailInput.inputField.tfInputFieldText.text = _emailPrompt;
			}
		}	
		private function onTextFocusOutPhone(evt:FocusEvent):void
		{
			if(userPhoneInput.inputField.tfInputFieldText.text == " ")
			{
				userPhoneInput.inputField.tfInputFieldText.text = _phonePrompt;
			}	
		}	
		private function onTextFocusOutDesign(evt:FocusEvent):void
		{
			if(jobType.designProjectType.priceInput.tfPriceText.text == "" )
			{
				jobType.designProjectType.priceInput.tfPriceText.text = _pricePrompt;
			}
		}
		private function onTextFocusOutDevelop(evt:FocusEvent):void
		{
			if(jobType.developProjectType.priceInput.tfPriceText.text == "")
			{
				jobType.developProjectType.priceInput.tfPriceText.text = _pricePrompt;
			}	
		}*/
		
	}
}