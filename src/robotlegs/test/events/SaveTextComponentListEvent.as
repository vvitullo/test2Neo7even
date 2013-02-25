package robotlegs.test.events
{
	import flash.events.Event;
	
	public class SaveTextComponentListEvent extends Event
	{
		
		public static const SAVE_TEXT_COMPONENT_LIST:String = "SAVE_TEXT_COMPONENT_LIST";
		
		public function SaveTextComponentListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new SaveTextComponentListEvent(type);
		}
	}
}