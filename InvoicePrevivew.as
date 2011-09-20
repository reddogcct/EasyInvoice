package com.ES.UI
{
	import com.ES.vo.InvoiceVO;
	
	import flash.events.MouseEvent;
	
	import libs.fourthStep;
	
	public class InvoicePreview extends fourthStep
	{
		private var _invoiceVO:InvoiceVO;
		
		public function InvoicePreview()
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
			
			nextButton.tfButton.text = "Save";
			nextButton.mouseChildren = false;
			nextButton.buttonMode = true;
	//		nextButton.addEventListener(MouseEvent.CLICK, onClick);
			
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
			
			firstStepOverview.tfNameReviewText.text = _invoiceVO.userName;
			firstStepOverview.tfPhoneReviewText.text = _invoiceVO.userPhone;
			firstStepOverview.tfEmailReviewText.text = _invoiceVO.userEmail;
			firstStepOverview.tfRoleReviewText.text = _invoiceVO.userRole;
			firstStepOverview.tfCompanyReviewText.text = _invoiceVO.userCompany;
			firstStepOverview.tfJobPriceReviewText.text = "$ "+_invoiceVO.projectPrice;
			
			secondStepOverview.tfClientNameReview.text = _invoiceVO.clientName;
			secondStepOverview.tfClientPhoneReview.text = _invoiceVO.clientPhone;
			secondStepOverview.tfClientEmailReview.text = _invoiceVO.clientEmail;
			secondStepOverview.tfClientCompanyReview.text = _invoiceVO.clientCompany;
			
			thirdStepOverview.tfJobLogDescription.text = _invoiceVO.workLoad;
			
			var totalMins:int = new int();
			totalMins = (_invoiceVO.workHours * 60) + _invoiceVO.workMins;
			
			var pricePerMin:Number = new Number();
			pricePerMin =	(_invoiceVO.projectPrice) / 60;
			
			var sum:Number = new Number();
			sum = (pricePerMin * totalMins);
			
			priceCalculation.hoursTotal.tfTotalHours.text = _invoiceVO.workHours;
			priceCalculation.hoursTotal.tfTotalMin.text = _invoiceVO.workMins;
			priceCalculation.priceTotal.tfTotalHours.text = sum;
			
				
		}

	}
}