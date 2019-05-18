package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class def_bar extends MovieClip
	{
		public var k_Type:int;
		public var nuka_mc:MovieClip;
		
		public var bg_for_mcm_mc:MovieClip;
		
		public var pre_tf:TextField;
		
		public var status_tf:TextField;
		
		public var bra_mc:MovieClip;
		
		public var bar_mc:MovieClip;
		
		public var adren_mc:MovieClip;
		
		public var food_mc:MovieClip;
		
		public var drink_mc:MovieClip;
		
		public var sleep_mc:MovieClip;
		
		public var min_value:int;
		
		public var max_value:int;
		
		var bar_width:int;
		
		public function def_bar()
		{
			super();
			this.bar_width = this.bar_mc.width;
			// pre_tf.x = 0;
		}
		
		public function set_visible(param1:Boolean):*
		{
			this.visible = param1;
		}
		
		public function set_value(param1:int):*
		{
			if (param1 > this.max_value)
			{
				param1 = this.max_value;
			}
			if (param1 < this.min_value)
			{
				param1 = this.min_value;
			}
			this.bar_mc.width = this.bar_width * (param1 - this.min_value) / (this.max_value - this.min_value);
		}
		
		public function setmode(aIcon:int, aPerc:int, aBar:int, aText:int):*
		{
			var wsum:int = -34;
			if (k_Type == 0)
			{
				food_mc.visible = aIcon == 1;
			}
			else if (k_Type == 1)
			{
				drink_mc.visible = aIcon == 1;
			}
			else if (k_Type == 2)
			{
				sleep_mc.visible = aIcon == 1;
			}
			if (aIcon)
			{
				wsum += 34;
			}
			bra_mc.visible = aBar == 1;
			bar_mc.visible = aBar == 1;
			if (aBar) 
			{
				bra_mc.x = wsum;
				bar_mc.x = wsum;
				wsum += 206;
			}
			pre_tf.visible = aPerc == 1;
			if (aPerc) 
			{
				pre_tf.x = wsum;
				wsum += 61;
			}
			status_tf.visible = aText == 1;
			if (aText) 
			{
				status_tf.x = wsum;
			}
		}
	
	}
}
