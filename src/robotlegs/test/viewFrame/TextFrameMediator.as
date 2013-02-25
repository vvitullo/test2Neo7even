package robotlegs.test.viewFrame
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextLineMetrics;
	
	import org.robotlegs.mvcs.Mediator;
	
	import robotlegs.test.events.*;
	import robotlegs.test.model.*;
	
	public class TextFrameMediator extends Mediator
	{
		
		[Inject]
		public var view:TextFrame;
		
		[Inject]
		public var testModel:TestModel;
		
		[Inject]
		public var textComponentListModel:TextComponentListModel;
		
		//public var checkClickedOnFrame:Boolean = false;
		
		private var startPoint:Point;
		
		public function TextFrameMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, MouseEvent.MOUSE_DOWN, mouseDownOnFrameHandler);
			eventMap.mapListener(view, MouseEvent.MOUSE_UP, mouseUpOnFrameHandler);
			
			eventMap.mapListener(view.ui_resize_circle, MouseEvent.MOUSE_DOWN, mouseDownOnResizeCircleHandler);
			eventMap.mapListener(view.parent, MouseEvent.MOUSE_UP, mouseUpOnResizeCircleHandler);
			
			eventMap.mapListener(view, MouseEvent.DOUBLE_CLICK, mouseDoubleClickOnFrameHandler);
			//eventMap.mapListener(view, MouseEvent.CLICK, mouseClickOnFrameHandler);
			eventMap.mapListener(view.parent, MouseEvent.CLICK, mouseClickOnParentHandler);
			
			addContextListener(ViewFrameEvent.CLICK_ON_FRAME, clickOnViewFrameHandler); 
			addContextListener(DeleteFrameEvent.CLICK_TO_DELETE_FRAME, deleteFrameHandler);
		}

		
		//RESIZE HANDLER FUNCTIONS
		private function mouseDownOnResizeCircleHandler(event:MouseEvent):void
		{
			trace("mouseDownOnResizeCircleHandler = "+view.currentState);
			eventMap.unmapListener(view, MouseEvent.MOUSE_DOWN, mouseDownOnFrameHandler);
			
			startPoint = new Point(event.stageX, event.stageY);
			//startPoint = view.globalToLocal(startPoint);
			eventMap.mapListener(view.parent, MouseEvent.MOUSE_MOVE, mouseMoveOnResizeCircleHandler);
		}
		
		private function mouseUpOnResizeCircleHandler(event:MouseEvent):void
		{
			trace("mouseUpOnResizeCircleHandler = "+view.currentState);
			//MAP moove handler
			eventMap.mapListener(view, MouseEvent.MOUSE_DOWN, mouseDownOnFrameHandler);

			startPoint=null;
			//UPDETE MODEL object in the list
			textComponentListModel.updateTextComponent(view.textComponent);
			
			//UnMAP resize handler
			eventMap.unmapListener(view.parent, MouseEvent.MOUSE_MOVE, mouseMoveOnResizeCircleHandler);
		}
		
		
		private var oldStageX:int = 0;
		private var oldStageY:int = 0;
		
		private function mouseMoveOnResizeCircleHandler(event:MouseEvent):void
		{
			if(startPoint!=null){
				view.textComponent.hValue += event.stageY - startPoint.y - oldStageY;  
				view.textComponent.wValue += event.stageX - startPoint.x - oldStageX;
				
				oldStageX = (event.stageX - startPoint.x);
				oldStageY = (event.stageY - startPoint.y);
				
				view.textComponent.hValue = (view.textComponent.hValue <= 28) ? 28 : view.textComponent.hValue;
				//view.textComponent.wValue = (view.textComponent.wValue <= 100) ? 100 : view.textComponent.wValue;
			
				var textMetrics:TextLineMetrics = view.lbl_text_frame.measureText( view.lbl_text_frame.text );  
				var wLimit:int = textMetrics.width + 24;
				view.textComponent.wValue = wLimit;

			}
		}
		
		private function mouseDownOnFrameHandler(event:MouseEvent):void
		{
			trace("mouseDowOnFrame = "+view.currentState);
	
			if(view.currentState != "editable")
			{
				testModel.checkClickedOnFrame = true;
				testModel.currentFrameId = view.textComponent.id;
				dispatch(new ViewFrameEvent(ViewFrameEvent.CLICK_ON_FRAME));
				
				view.parentDocument.setElementIndex(view, view.parentDocument.numElements-1);
	
				
				if(testModel.statusMenuButtons == "resize"){
					
					startPoint = new Point(event.stageX, event.stageY);
					startPoint = view.globalToLocal(startPoint);
					
					eventMap.mapListener(view.parent, MouseEvent.MOUSE_MOVE, mouseMoveOnParentHandler);
				}
			}

		}
		
		private function mouseUpOnFrameHandler(event:MouseEvent):void
		{
			trace("(+)mouseUpOnFrame = "+event.currentTarget);
			
			startPoint=null;
			//UPDETE MODEL object in the list
			textComponentListModel.updateTextComponent(view.textComponent);
			
			//UNMAP moove handler
			eventMap.unmapListener(view.parent, MouseEvent.MOUSE_MOVE, mouseMoveOnParentHandler);
		}
		
		private function mouseMoveOnParentHandler(event:MouseEvent):void
		{
			if(startPoint!=null){
				view.textComponent.xValue += view.mouseX - startPoint.x;
				view.textComponent.yValue += view.mouseY - startPoint.y;
				
				view.textComponent.xValue = (view.textComponent.xValue <= 0) ? 1 : view.textComponent.xValue ;
				view.textComponent.yValue = (view.textComponent.yValue <= 0) ? 1 : view.textComponent.yValue;

			}
		}
		
		
		private function mouseDoubleClickOnFrameHandler(event:MouseEvent):void
		{
			trace("mouseDoubleClickOnFrame");
			if(testModel.statusMenuButtons != "resize"){
				view.currentState = "editable";
			}
			
		}

/*
		private function mouseClickOnFrameHandler(event:MouseEvent):void
		{
			trace("mouseClickOnFrame");
		}
*/		
		private function clickOnViewFrameHandler(e:ViewFrameEvent):void{
			if(testModel.currentFrameId == view.textComponent.id){
				if(testModel.statusMenuButtons == "select"){
					view.currentState = "selected";
				}
				else if(testModel.statusMenuButtons == "resize"){
					view.currentState = "resizable";
				}
			}
			else{
				view.currentState = "normal";
			}
		}
		
		private function deleteFrameHandler(e:DeleteFrameEvent):void{
			if(testModel.currentFrameId == view.textComponent.id){
				textComponentListModel.deleteTextComponent(view.textComponent.id);
				view.parentDocument.removeElement(view);
			}
		}
		
		private function mouseClickOnParentHandler(event:MouseEvent):void
		{
			trace("[-]mouseClickOnParent checkClickedOnFrame="+testModel.checkClickedOnFrame+" view.currentState="+view.currentState+" testModel.currentFrameId="+testModel.currentFrameId+" == "+view.textComponent.id);
			if(!testModel.checkClickedOnFrame){   

				if(view.currentState == "editable" && testModel.currentFrameId == view.textComponent.id)
				{
					trace("ENTERED");
					view.textComponent.textValue = view.txt_text_frame.text;
					var textMetrics:TextLineMetrics = view.lbl_text_frame.measureText( view.lbl_text_frame.text );  
					view.textComponent.wValue = textMetrics.width + 24;
					textComponentListModel.updateTextComponent(view.textComponent);
					dispatch(new ViewFrameEvent(ViewFrameEvent.CLICK_ON_FRAME));
					
					trace(">> textMetrics.width="+ textMetrics.width);
				}

//				view.currentState = "normal";
			}
		}
		
	}
}