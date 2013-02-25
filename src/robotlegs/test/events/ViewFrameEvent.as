package robotlegs.test.events
{
	import flash.events.Event;
	
	public class ViewFrameEvent extends Event
	{
		public static const CLICK_ON_FRAME:String = "CLICK_ON_FRAME";
		
		public function ViewFrameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new ViewFrameEvent(type);
		}
	}
}