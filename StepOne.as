package com.ES.UI
{
	import flash.events.FocusEvent;
	
	import libs.firstStep;
	
	public class StepOne extends firstStep
	{
		public function StepOne()
		{
			super();
			
			windowMinButton.buttonMode = true;
			windowMinButton.mouseChildren = false;
			windowCloseButton.buttonMode = true;
			windowCloseButton.mouseChildren = false;
			
			stepTabs.firstTab.tfTabLabel.text = "Step 1";
			stepTabs.secondTab.tfTabLabel.text = "Step 2";
			stepTabs.thirdTab.tfTabLabel.text = "Step 3";
			
			userNameInput.tfInputTitle.text = "Name:";
			userCompanyInput.tfInputTitle.text = "Company:";
			userRoleInput.tfInputTitle.text = "Role:";
			userEmailInput.tfInputTitle.text = "E-mail:";
			userPhoneInput.tfInputTitle.text = "Phone:";
			
			userNameInput.inputField.tfInputFieldText.text = "First and Last name";
			userCompanyInput.inputField.tfInputFieldText.text = "Company/Organization name";
			userRoleInput.inputField.tfInputFieldText.text = "i.e: Business Manager";
			userEmailInput.inputField.tfInputFieldText.text = "email@example.com";
			userPhoneInput.inputField.tfInputFieldText.text = "555-555-5555";

			
			logoUpload.uploadBtns.clearBtn.tfBtnLabel.text = "Clear";
			logoUpload.uploadBtns.uploadBtn.tfBtnLabel.text = "Upload";
			logoUpload.uploadBtns.clearBtn.buttonMode = true;
			logoUpload.uploadBtns.clearBtn.mouseChildren = false;
			logoUpload.uploadBtns.uploadBtn.buttonMode = true;
			logoUpload.uploadBtns.uploadBtn.mouseChildren = false;
			
			nextButton.buttonTF.text = "Save PDF";
			nextButton.mouseChildren = false;
			nextButton.buttonMode = true;
			
			windowMinButton.tfWindowControl.text = "-";
			
			
			/*userNameInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocus);
			userCompanyInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocus);
			userRoleInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocus);
			userEmailInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocus);
			userPhoneInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_IN,onTextFocus);*/

			/*userNameInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOut);
			userCompanyInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOut)
			userRoleInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOut)
			userEmailInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOut)
			userPhoneInput.inputField.tfInputFieldText.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOut)*/
		
			
			
			
			jobType.designProjectType.ProjectTypeRadioButton.stop()
			jobType.designProjectType.projectTypeTF.text = "Design Project";
			jobType.developProjectType.ProjectTypeRadioButton.stop()
		 	jobType.developProjectType.projectTypeTF.text = "Develop Project"; 
			
			
		}
		private function onTextFocus(evt:FocusEvent):void
		{
			if(userNameInput.inputField.tfInputFieldText.text == "first and last name")
			{
				userNameInput.inputField.tfInputFieldText.text = ' ';
			}

			else if(userCompanyInput.inputField.tfInputFieldText.text == "company/organization name")
			{
				userCompanyInput.inputField.tfInputFieldText.text = ' ';
			}
			else if(userRoleInput.inputField.tfInputFieldText.text == "i.e: business manager")
			{
				userRoleInput.inputField.tfInputFieldText.text = ' ';
			}
			else if(userEmailInput.inputField.tfInputFieldText.text == "email@example.com")
			{
				userEmailInput.inputField.tfInputFieldText.text = ' ';
			}
			else if(userPhoneInput.inputField.tfInputFieldText.text == "555-555-5555")
			{
				userPhoneInput.inputField.tfInputFieldText.text = ' ';
			}	
		}
		
		private function onTextFocusOut(evt:FocusEvent):void
		{
			if(userNameInput.inputField.tfInputFieldText.text == " ")
			{
				userNameInput.inputField.tfInputFieldText.text = 'first and last name';
			}

			else if(userCompanyInput.inputField.tfInputFieldText.text == " ")
			{
				userCompanyInput.inputField.tfInputFieldText.text = 'company/organization name';
			}
			else if(userRoleInput.inputField.tfInputFieldText.text == " ")
			{
				userRoleInput.inputField.tfInputFieldText.text = 'i.e: business manager';
			}
			else if(userEmailInput.inputField.tfInputFieldText.text == " ")
			{
				userEmailInput.inputField.tfInputFieldText.text = 'email@example.com';
			}
			else if(userPhoneInput.inputField.tfInputFieldText.text == " ")
			{
				userPhoneInput.inputField.tfInputFieldText.text = '555-555-5555';
			}	
			
		}
		
	}
}