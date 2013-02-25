package robotlegs.test.model.vo
{

	[Bindable]
	public class TextComponent
	{
		public function TextComponent(id:int, text:String, x:int, y:int, height:int, width:int)
		{
			this.id = id;
			this.textValue = text;
			this.xValue = x;
			this.yValue = y;
			this.hValue = height;
			this.wValue = width;
		}
		
		public var id:int;
		public var textValue:String;
		public var xValue:int;
		public var yValue:int;
		public var hValue:int;
		public var wValue:int;
		
		
		public function update(textComponent:TextComponent):TextComponent
		{
			this.id = textComponent.id;
			this.textValue = textComponent.textValue;
			this.xValue = textComponent.xValue;
			this.yValue = textComponent.yValue;
			this.hValue = textComponent.hValue;
			this.wValue = textComponent.wValue;
			
			return this;
		}
		
	}
}