package robotlegs.test
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import robotlegs.test.model.*;
	
	import robotlegs.test.viewMenu.standard.*;
	import robotlegs.test.viewMenu.*;
	import robotlegs.test.viewFrame.TextFrameMediator;
	import robotlegs.test.viewFrame.TextFrame;
	import robotlegs.test.viewApp.Blackboard;
	import robotlegs.test.viewApp.BlackboardMediator;
	import robotlegs.test.viewControlBar.*;
	
	public class TestContext extends Context
	{
		public function TestContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			//super(contextView, autoStartup);
			super();
		}
		
		override public function startup():void
		{
			
			
			//model
			injector.mapSingleton(TestModel);
			injector.mapSingleton(TextComponentListModel);
			
			//viewMenu
			//mediatorMap.mapView(MenuButtonStandard, MenuButtonStandardMediator);
			mediatorMap.mapView(ResizeButton, ResizeButtonMediator);
			mediatorMap.mapView(TextButton, TextButtonMediator);
			mediatorMap.mapView(SelectButton, SelectButtonMediator);
			
			mediatorMap.mapView(TextFrame, TextFrameMediator);
			
			mediatorMap.mapView(Blackboard, BlackboardMediator);
			
			mediatorMap.mapView(DeleteButton, DeleteButtonMediator);
			mediatorMap.mapView(SaveButton, SaveButtonMediator);
			
			super.startup();
		}
	}
}