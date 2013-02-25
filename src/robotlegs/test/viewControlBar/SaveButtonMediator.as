package robotlegs.test.viewControlBar
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import robotlegs.test.events.SaveTextComponentListEvent;
	import robotlegs.test.model.*;
	
	public class SaveButtonMediator extends Mediator
	{
		
		
		[Inject]
		public var view:DeleteButton;		
		
		[Inject]
		public var textComponentListModel:TextComponentListModel;
		
		public function SaveButtonMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, MouseEvent.CLICK, clickSaveButtonEvent);
		}
		
		private function clickSaveButtonEvent(event:MouseEvent):void{
			dispatch(new SaveTextComponentListEvent(SaveTextComponentListEvent.SAVE_TEXT_COMPONENT_LIST));
		}
		
	}
}