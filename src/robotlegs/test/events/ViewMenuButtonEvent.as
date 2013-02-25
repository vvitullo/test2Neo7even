package robotlegs.test.events
{
	import flash.events.Event;
	
	public class ViewMenuButtonEvent extends Event
	{
		public static const CLICK_BUTTON:String = "CLICK_BUTTON";
		
		public function ViewMenuButtonEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new ViewMenuButtonEvent(type);
		}
	}
}