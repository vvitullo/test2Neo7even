package robotlegs.test.events
{
	import flash.events.Event;
	
	public class DeleteFrameEvent extends Event
	{
		
		public static const CLICK_TO_DELETE_FRAME:String = "CLICK_TO_DELETE_FRAME";
		
		public function DeleteFrameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new DeleteFrameEvent(type);
		}
	}
}