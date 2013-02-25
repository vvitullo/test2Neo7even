package robotlegs.test.viewMenu.standard
{
	import org.robotlegs.mvcs.Mediator;
	
	import flash.events.MouseEvent;
	
	import robotlegs.test.model.TestModel;
	import robotlegs.test.events.ViewMenuButtonEvent;
	
	
	
	public class MenuButtonStandardMediator extends Mediator
	{
		
		[Inject]
		public var view:MenuButtonStandard;
		
		[Inject]
		public var model:TestModel;
		
		public function MenuButtonStandardMediator()
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
			trace("click standard button ");
		}
		
		private function changeButtonState():void{
			trace("model.statusMenuButtons="+model.statusMenuButtons);
			view.changeState(model.statusMenuButtons);
		}
	}
}