package robotlegs.test.viewFrame
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	public class GraphicsCircleResize extends UIComponent
	{
		//override public var x:int;
		//override public var y:int;
		public var radius:int;
		public var color:uint = 0x000000;
		
		public function GraphicsCircleResize()
		{
			super();
		}
		
       override protected function createChildren():void
	   { 
		   super.createChildren();
		   
		   var dropFill:DropShadowFilter = new DropShadowFilter(0, 45, 0xffffff, 1, 7, 7, 7, 1);
		   var dropShadow:DropShadowFilter = new DropShadowFilter(3, 45, 0x000000, 0.5);
		   
		   var myCircle:Sprite = new Sprite();
		   myCircle.filters = new Array(dropFill, dropShadow);
		   myCircle.graphics.beginFill(color);
		   myCircle.graphics.drawCircle(1, 1, radius);
		   myCircle.graphics.endFill();
		   
		   addChild(myCircle);
		   
	   }

	}
}