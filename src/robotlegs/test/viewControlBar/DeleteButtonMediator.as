package robotlegs.test.viewControlBar
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import robotlegs.test.events.*;
	import robotlegs.test.model.TestModel;
	import robotlegs.test.viewApp.Blackboard;
	
	public class DeleteButtonMediator extends Mediator
	{
		
		[Inject]
		public var view:DeleteButton;
		
		[Inject]
		public var testModel:TestModel;
		
		public function DeleteButtonMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, MouseEvent.CLICK, clickDeleteButtonEvent);
 
		}
		
		private function clickDeleteButtonEvent(event:MouseEvent):void{

			if(testModel.currentFrameId != 0){
				trace("testModel.currentFrameId");
				Alert.show("Do you really want to delete this text frame?", "Delete Operation",  Alert.YES|Alert.NO, view.parentApplication as Sprite, alertDeleteHandler);
			}
			else{
				Alert.show("Select a text frame to delete.", "Delete Operation");
			}
		}
		
		private function alertDeleteHandler(event:CloseEvent):void {
			if (event.detail == Alert.YES) {
				dispatch(new DeleteFrameEvent(DeleteFrameEvent.CLICK_TO_DELETE_FRAME));
			}
		}
		
	}
}