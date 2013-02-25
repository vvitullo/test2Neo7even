package robotlegs.test.viewApp
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import robotlegs.test.events.ViewMenuButtonEvent;
	import robotlegs.test.events.ViewFrameEvent;
	import robotlegs.test.model.*;
	import robotlegs.test.model.vo.TextComponent;
	import robotlegs.test.viewFrame.TextFrame;
	
	public class BlackboardMediator extends Mediator
	{
		
		[Inject]
		public var view:Blackboard;
		
		[Inject]
		public var testModel:TestModel;
		
		[Inject]
		public var textComponentListModel:TextComponentListModel;
		
		public function BlackboardMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, MouseEvent.CLICK, clickBlackboardboardEvent);
			addContextListener(ViewMenuButtonEvent.CLICK_BUTTON, setEmptySelectionFrameHandler); 
		}
		
		private function clickBlackboardboardEvent(event:MouseEvent):void
		{
			trace("blackboard->clickBlackboardboardEvent "+testModel.checkClickedOnFrame);
			if(!testModel.checkClickedOnFrame){   
				if(testModel.statusMenuButtons == "text"){
					
					//CREATE a new_frame_text
					var frameId:int = Number(event.currentTarget.numElements.toString() + event.localX.toString() + event.localY.toString());
					var new_textComp:TextComponent = new TextComponent(frameId,
						"Sample Text Fram",
						event.localX,
						event.localY,
						40,
						200
					);
					
					var new_textFrame:TextFrame = new TextFrame();
					new_textFrame.textComponent = new_textComp;
					view.addElement(new_textFrame);
					textComponentListModel.addTextComponent(new_textComp);
					//.

					//SELECT new_frame_text
					testModel.checkClickedOnFrame = true;
					testModel.currentFrameId = new_textFrame.textComponent.id;
					dispatch(new ViewFrameEvent(ViewFrameEvent.CLICK_ON_FRAME));
					//.
					
					//SWITCH to SELECT status button mode
					testModel.statusMenuButtons = "select";
					dispatch(new ViewMenuButtonEvent(ViewMenuButtonEvent.CLICK_BUTTON));
					//.
				}
			}
			else{
				testModel.checkClickedOnFrame = false; 
			}	
		}
		
		private function setEmptySelectionFrameHandler(event:ViewMenuButtonEvent):void
		{
			testModel.checkClickedOnFrame = false;
			testModel.currentFrameId = 0;
			dispatch(new MouseEvent(MouseEvent.CLICK));
			dispatch(new ViewFrameEvent(ViewFrameEvent.CLICK_ON_FRAME));
		}
	}
}