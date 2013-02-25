package robotlegs.test.viewMenu
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import robotlegs.test.events.ViewMenuButtonEvent;
	import robotlegs.test.model.TestModel;
	
	public class ResizeButtonMediator extends Mediator
	{
		[Inject]
		public var view:ResizeButton;
		
		[Inject]
		public var model:TestModel;
		
		public function ResizeButtonMediator()
		{
			super();
		}
	
		override public function onRegister():void
		{
			addContextListener(ViewMenuButtonEvent.CLICK_BUTTON, changeButtonState); 
			
			//tutti gli eventi
			eventMap.mapListener(view, MouseEvent.CLICK, clickButtonEvent);
		}
		
		
		private function clickButtonEvent(event:MouseEvent):void
		{
			model.statusMenuButtons = view.nameButton;
			trace("click button resize");
			dispatch(new ViewMenuButtonEvent(ViewMenuButtonEvent.CLICK_BUTTON));
		}
		
		private function changeButtonState(e:Event):void{
			trace("model.statusMenuButtons="+model.statusMenuButtons);
			view.changeState(model.statusMenuButtons);
		}

	}
}