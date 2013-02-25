package robotlegs.test.model
{
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	import robotlegs.test.model.vo.TextComponent;
	
	public class TextComponentListModel extends Actor
	{
		private var _textComponentList:ArrayCollection = new ArrayCollection();
		
		public function TextComponentListModel()
		{
			super();
		}
		
		public function get textComponentList():ArrayCollection
		{
			return _textComponentList ||= new ArrayCollection();
		}
		
		public function updateTextComponent(textComponentUpdated:TextComponent):TextComponent
		{
			for each(var textComponent:TextComponent in _textComponentList)
			{
				if (textComponent.id == textComponentUpdated.id)
					return textComponent.update(textComponentUpdated);
			}
			
			addTextComponent(textComponentUpdated);
			
			return textComponentUpdated;
		}
		
		
		public function deleteTextComponent(textId:int):void
		{
			for(var i:int=0; i<_textComponentList.length; i++){
				if (_textComponentList[i].id == textId)
					_textComponentList.removeItemAt(i);
			}
		}
		
		public function getTextComponentById(id:int):TextComponent
		{
			for each(var textComponent:TextComponent in _textComponentList)
			{
				if (textComponent.id == id)
					return textComponent;
			}
			return null;
		}
		
		
		public function addTextComponent(newTextComponent:TextComponent):void
		{
			if (!_textComponentList.contains(newTextComponent))
				_textComponentList.addItem(newTextComponent);
		}
		
		public function reset():void
		{
			_textComponentList.removeAll();
		}
	}
}