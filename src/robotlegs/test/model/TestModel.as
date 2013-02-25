package robotlegs.test.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class TestModel extends Actor
	{
		
		private var _statusMenuButtons:String = "none";
		private var _checkClickedOnFrame:Boolean = false;
		private var _currentFrameId:int = 0;
		
		public function TestModel()
		{
			super();
		}
		
		
		//_statuMenuButtons
		public function get statusMenuButtons():String{
			return _statusMenuButtons;
		}
		
		public function set statusMenuButtons(value:String):void{
			_statusMenuButtons = value;
		}
		
		//_checkClickedOnFrame
		public function get checkClickedOnFrame():Boolean{
			return _checkClickedOnFrame;
		}
		
		public function set checkClickedOnFrame(value:Boolean):void{
			_checkClickedOnFrame = value;
		}
		
		//_currentFrameId
		public function get currentFrameId():int{
			return _currentFrameId;
		}
		
		public function set currentFrameId(value:int):void{
			_currentFrameId = value;
		}
	}
}