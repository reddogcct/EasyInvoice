package com.ES.UI
{
	import com.ES.Events.InvoiceEvent;
	import com.ES.vo.InvoiceVO;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import libs.thirdStep;
	
	public class StepThree extends thirdStep
	{
		
		private var _workloadPrompt:String = "What did you work on?";
		private var _invoiceVO:InvoiceVO;
		
		public function StepThree()
		{
			super();
			windowMinButton.buttonMode = true;
			windowMinButton.mouseChildren = false;
			windowMinButton.tfWindowControl.text = "~";
			windowCloseButton.buttonMode = true;
			windowCloseButton.mouseChildren = false;
			
			stepTabs.mouseChildren = false;
			stepTabs.firstTab.tfTabLabel.text = "Step 1";
			stepTabs.secondTab.tfTabLabel.text = "Step 2";
			stepTabs.thirdTab.tfTabLabel.text = "Step 3";
			
			workLoadSection.tfWorkLoadItem.text = "Workload:"
			workLoadSection.tfWorkLoadText.text = _workloadPrompt;
			workLoadSection.hoursInputField.tfHoursInput.text = "00";
			workLoadSection.hoursInputField.tfMinuteHours.text = "00";
			workLoadSection.addEventListener(FocusEvent.FOCUS_IN, onTextFocusInWorkload);
			workLoadSection.hoursInputField.tfHoursInput.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInHours); 
		    workLoadSection.hoursInputField.tfMinuteHours.addEventListener(FocusEvent.FOCUS_IN,onTextFocusInMins); 
			
			nextButton.tfButton.text = "Preview";
			nextButton.mouseChildren = false;
			nextButton.buttonMode = true;
			nextButton.addEventListener(MouseEvent.CLICK, onClick);
			
			backButton.tfButton.text = "Back";
			backButton.mouseChildren = false;
			backButton.buttonMode = true;
		}
		
		
		public function get invoiceVO():InvoiceVO
		{
			return _invoiceVO;
		}

		public function set invoiceVO(value:InvoiceVO):void
		{
			_invoiceVO = value;

		}
		
		private function onClick(evt:MouseEvent):void
		{
			
			_invoiceVO.workLoad = workLoadSection.tfWorkLoadText.text
			_invoiceVO.workHours = parseInt(workLoadSection.hoursInputField.tfHoursInput.text) 
			_invoiceVO.workMins = parseInt(workLoadSection.hoursInputField.tfMinuteHours.text) 
			
			var iEvent:InvoiceEvent = new InvoiceEvent(InvoiceEvent.SEND_VO)
			iEvent.iVO = _invoiceVO;
			dispatchEvent(iEvent)
		}

		private function onTextFocusInHours(evt:FocusEvent):void
		{
			
			if(workLoadSection.hoursInputField.tfHoursInput.text == "00")
			{
				workLoadSection.hoursInputField.tfHoursInput.text = "";
			}
		}
		
		private function onTextFocusInMins(evt:FocusEvent):void
		{
			 if(workLoadSection.hoursInputField.tfMinuteHours.text == "00")
			{
				workLoadSection.hoursInputField.tfMinuteHours.text = "";	
			}
		}
		
		private function onTextFocusInWorkload(evt:FocusEvent):void
		{
			if(workLoadSection.tfWorkLoadText.text == _workloadPrompt)
			{
				workLoadSection.tfWorkLoadText.text = "";
			}
		}
			
		private function onTextFocusOut(evt:FocusEvent):void
		{
			if(workLoadSection.tfWorkLoadText.text == "")
			{
				workLoadSection.tfWorkLoadText.text = "What did you work on?";
			}
		}
	}
}