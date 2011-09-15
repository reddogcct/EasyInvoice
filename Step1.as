package com.ES.UI
{
	import flash.events.MouseEvent;
	
	import libs.firstStep;
	
	public class StepOne extends firstStep
	{
		public function StepOne()
		{
			super();
			
			windowMinButton.buttonMode = true;
			windowMinButton.mouseChildren = false;
			windowMinButton.addEventListener(MouseEvent.CLICK, minWindow);
			windowCloseButton.buttonMode = true;
			windowCloseButton.mouseChildren = false;
			windowCloseButton.addEventListener(MouseEvent.CLICK, closeWindow);
			
			stepTabs.firstTab.tfTabLabel.text = "Step 1"
			stepTabs.secondTab.tfTabLabel.text = "Step 2"
			stepTabs.thirdTab.tfTabLabel.text = "Step 3"
			
			userNameInput.tfInputTitle.text = "Name: *";
			userCompanyInput.tfInputTitle.text = "Company Name:";
			userRoleInput.tfInputTitle.text = "Role In Company:";
			userEmailInput.tfInputTitle.text = "E-mail: *";
			userPhoneInput.tfInputTitle.text = "Phone: *";
			
			userNameInput.inputField.tfInputFieldText.text = "First and Last Name ";
			userCompanyInput.inputField.tfInputFieldText.text = "Company/Organization Name";
			userRoleInput.inputField.tfInputFieldText.text = "Business Manager";
			userEmailInput.inputField.tfInputFieldText.text = "Example@example.com";
			userPhoneInput.inputField.tfInputFieldText.text = "555-555-555";
			
			ProjectType.designProjectType.tfProjectType.text = "Design Project";
			ProjectType.developProjectType.tfProjectType.text = "Develop Project";
			
			Upload.UploadControls.tfClear.text = "Clear";
			Upload.UploadControls.tfUpload.text = "Upload";
			
			nextButton.nextTF.text = "Save PDF";
			nextButton.mouseChildren = false;
			nextButton.buttonMode = true;	
		}
		
		private function closeWindow(evt:MouseEvent):void
		{
			stage.nativeWindow.close();
		}
		
		private function minWindow(evt:MouseEvent):void
		{
			stage.nativeWindow.minimize();
		}
	}
}