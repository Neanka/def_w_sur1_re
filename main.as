package
{
	import Shared.GlobalFunc;
	import Shared.IMenu;
	import debug.Log;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	public class main extends IMenu
	{
		
		public var BGSCodeObj:Object;
		
		var tempCTF:ColorTransform;
		var ct_temp:ColorTransform;
		var UI_ct:ColorTransform;
		
		public var food_bar:def_bar;
		public var drink_bar:def_bar;
		public var fatigue_bar:def_bar;
		
		public var isHMO:int = 0;
		
		public var iFoodPoolStarvingAmount:int = -256;
		
		public var iDrinkPoolSeverelyDehydratedAmount:int = -180;
		
		public var iSleepPoolIncapacitatedAmount:int = -6;
		
		public var iFoodPool:int = 0;
		public var iDrinkPool:int = 0;
		public var iFoodStatus:int = 0;
		public var iDrinkStatus:int = 0;
		public var iSleepPool:int = 0;
		public var iSleepStatus:int = 0;
		
		public var iShowIcon:int = 1;
		public var iShowPercents:int = 1;
		public var iShowBar:int = 1;
		public var iShowTextStatus:int = 1;
		
		public var iColored = 1;
		
		public var fFoodBarX:Number = 37.5;
		public var fFoodBarY:Number = 9.05;
		public var fFoodBarScaleX:Number = 1.0;
		public var fFoodBarScaleY:Number = 1.0;
		public var fFoodBarRotation:Number = 0.0;
		public var iFoodBarVisible:int = 1;
		
		public var fDrinkBarX:Number = 37.5;
		public var fDrinkBarY:Number = 47;
		public var fDrinkBarScaleX:Number = 1.0;
		public var fDrinkBarScaleY:Number = 1.0;
		public var fDrinkBarRotation:Number = 0.0;
		public var iDrinkBarVisible:int = 1;
		
		public var fSleepBarX:Number = 37.5;
		public var fSleepBarY:Number = 84.95;
		public var fSleepBarScaleX:Number = 1.0;
		public var fSleepBarScaleY:Number = 1.0;
		public var fSleepBarRotation:Number = 0.0;
		public var iSleepBarVisible:int = 1;
		
		public var trans_food:Array = new Array();
		public var trans_drink:Array = new Array();
		public var trans_sleep:Array = new Array();
		
		public var trans_food_orig:Array = new Array();
		public var trans_drink_orig:Array = new Array();
		public var trans_sleep_orig:Array = new Array();
		
		public var trans_food_HMO:Array = new Array();
		public var trans_drink_HMO:Array = new Array();
		public var trans_sleep_HMO:Array = new Array();
		
		public function main()
		{
			Log.info("ctor");
			super();
			this.BGSCodeObj = new Object();
			trans_food_orig = ["$Fed", "$Peckish", "$Hungry", "$Famished", "$Ravenous", "$Starving"];
			trans_drink_orig = ["$Hydrated", "$Parched", "$Thirsty", "$Mildly Dehydrated", "$Dehydrated", "$Severely Dehydrated"];
			trans_sleep_orig = ["$Well Rested", "$Rested", "$Tired", "$Overtired", "$Weary", "$Exhausted", "$Incapacitated"];
			trans_food_HMO = ["$Fed", "$Minor Starvation", "$Advanced Starvation", "$Critical Starvation", "$Lethal Starvation"];
			trans_drink_HMO = ["$Hydrated", "$Minor Dehydration", "$Advanced Dehydration", "$Critical Dehydration", "$Lethal Dehydration"];
			trans_sleep_HMO = ["$Well Rested", "$Minor Sleep Deprivation", "$Advanced Sleep Deprivation", "$Critical Sleep Deprivation", "$Lethal Sleep Deprivation"];
			trans_food = trans_food_orig;
			trans_drink = trans_drink_orig;
			trans_sleep = trans_sleep_orig;
			food_bar.bg_for_mcm_mc.visible = false;
			drink_bar.bg_for_mcm_mc.visible = false;
			fatigue_bar.bg_for_mcm_mc.visible = false;
			food_bar.k_Type = 0;
			drink_bar.k_Type = 1;
			fatigue_bar.k_Type = 2;
		}
		
		public function setValuesForMCM()
		{
			food_bar.min_value = -256;
			food_bar.max_value = 0;
			set_food(-200, 3);
			drink_bar.min_value = -180;
			drink_bar.max_value = 0;
			set_drink(-100, 4);
			fatigue_bar.min_value = -6;
			fatigue_bar.max_value = 0;
			set_fatigue(-3, 3);
			
			food_bar.setmode(iShowIcon, iShowPercents, iShowBar, iShowTextStatus);
			drink_bar.setmode(iShowIcon, iShowPercents, iShowBar, iShowTextStatus);
			fatigue_bar.setmode(iShowIcon, iShowPercents, iShowBar, iShowTextStatus);
		}
		
		public function UpdateAmounts()
		{
			Log.info("UpdateAmounts");
			food_bar.min_value = iFoodPoolStarvingAmount;
			food_bar.max_value = 0;
			drink_bar.min_value = iDrinkPoolSeverelyDehydratedAmount;
			drink_bar.max_value = 0;
			fatigue_bar.min_value = iSleepPoolIncapacitatedAmount;
			fatigue_bar.max_value = 0;
		}
		
		public function UpdateValues()
		{
			Log.info("UpdateValues");
			
			set_food(iFoodPool, iFoodStatus);
			
			set_drink(iDrinkPool, iDrinkStatus);
			
			set_fatigue(iSleepPool, iSleepStatus);
		}
		
		public function UpdateModSettings()
		{
			Log.info("UpdateModSettings");
			food_bar.setmode(iShowIcon, iShowPercents, iShowBar, iShowTextStatus);
			drink_bar.setmode(iShowIcon, iShowPercents, iShowBar, iShowTextStatus);
			fatigue_bar.setmode(iShowIcon, iShowPercents, iShowBar, iShowTextStatus);
			
			food_bar.x = fFoodBarX;
			food_bar.y = fFoodBarY;
			food_bar.scaleX = fFoodBarScaleX;
			food_bar.scaleY = fFoodBarScaleY;
			food_bar.rotation = fFoodBarRotation;
			food_bar.visible = iFoodBarVisible == 1;
			
			drink_bar.x = fDrinkBarX;
			drink_bar.y = fDrinkBarY;
			drink_bar.scaleX = fDrinkBarScaleX;
			drink_bar.scaleY = fDrinkBarScaleY;
			drink_bar.rotation = fDrinkBarRotation;
			drink_bar.visible = iDrinkBarVisible == 1;
			
			fatigue_bar.x = fSleepBarX;
			fatigue_bar.y = fSleepBarY;
			fatigue_bar.scaleX = fSleepBarScaleX;
			fatigue_bar.scaleY = fSleepBarScaleY;
			fatigue_bar.rotation = fSleepBarRotation;
			fatigue_bar.visible = iSleepBarVisible == 1;
			
			UpdateValues();
		}
		
		public function set_food(val:int, status:int)
		{
			var perc:Number = val * 100 / iFoodPoolStarvingAmount;
			food_bar.pre_tf.text = String(int(100 - perc)) + "%";
			food_bar.set_value(val);
			if (isHMO)
			{
				food_bar.status_tf.text = trans_food[GetStatus(perc)];
			}
			else
			{
				food_bar.status_tf.text = trans_food[status];
			}
			if (iColored)
			{
				ct_temp = getCTF(int(100 - perc));
				setcolor(food_bar, ct_temp);
			}
			else
			{
				setcolor(food_bar, UI_ct);
			}
		}
		
		public function set_drink(val:int, status:int)
		{
			var perc:Number = val * 100 / iDrinkPoolSeverelyDehydratedAmount;
			drink_bar.pre_tf.text = String(int(100 - perc)) + "%";
			drink_bar.set_value(val);
			if (isHMO)
			{
				drink_bar.status_tf.text = trans_drink[GetStatus(perc)];
			}
			else
			{
				drink_bar.status_tf.text = trans_drink[status];
			}
			if (iColored)
			{
				ct_temp = getCTF(int(100 - perc));
				setcolor(drink_bar, ct_temp);
			}
			else
			{
				setcolor(drink_bar, UI_ct);
			}
		}
		
		public function set_fatigue(val:int, status:int)
		{
			var perc:Number = val * 100 / iSleepPoolIncapacitatedAmount;
			fatigue_bar.pre_tf.text = String(int(100 - perc)) + "%";
			fatigue_bar.set_value(val);
			if (isHMO)
			{
				fatigue_bar.status_tf.text = trans_sleep[GetStatus(perc)];
			}
			else
			{
				fatigue_bar.status_tf.text = trans_sleep[status];
			}
			if (iColored)
			{
				ct_temp = getCTF(int(100 - perc));
				setcolor(fatigue_bar, ct_temp);
			}
			else
			{
				setcolor(fatigue_bar, UI_ct);
			}
		}
		
		public function GetStatus(perc:Number):int
		{
			var status:int;
			if (perc < 11.5000)
			{
				status = 0;
			}
			else if (perc < 23.5000)
			{
				status = 1;
			}
			else if (perc < 47.0000)
			{
				status = 2;
			}
			else if (perc < 70.0000)
			{
				status = 3;
			}
			else
			{
				status = 4;
			}
			return status;
		}
		
		public function setcolor(mc:MovieClip, ct:ColorTransform)
		{
			mc.transform.colorTransform = ct;
		}
		
		public function getCTF(aiValue:int):ColorTransform
		{
			if (aiValue == 0)
			{
				tempCTF = new ColorTransform(0, 0, 0, 1, 255, 0, 0, 0);
			}
			else if (aiValue < 50)
			{
				tempCTF = new ColorTransform(0, 0, 0, 1, 255, 32 + aiValue * 4.46, 32, 0);
			}
			else if (aiValue == 50)
			{
				tempCTF = new ColorTransform(0, 0, 0, 1, 255, 255, 32, 0);
			}
			else
			{
				tempCTF = new ColorTransform(0, 0, 0, 1, 32 + (100 - aiValue) * 4.46, 255, 32, 0);
			}
			return tempCTF;
		}
		
		public function onApplyColorChange(r, g, b, multiplier):Array
		{
			Log.info("onApplyColorChange");
			var rint:uint = r * 255;
			var gint:uint = g * 255;
			var bint:uint = b * 255;
			var mint:uint = multiplier * 255;
			
			UI_ct = new ColorTransform(0.0, 0.0, 0.0, 1.0, rint, gint, bint, 0);
			
			//return [255, 255, 255, 1];
			return [];
		}
		
		public function onCodeObjCreate():*
		{
			Log.info("onCodeObjCreate");
			//	root.f4se.AllowTextInput(true);
		}
		
		public function onCodeObjDestruction():*
		{
			Log.info("onCodeObjDestruction");
			//	root.f4se.AllowTextInput(false);
			this.BGSCodeObj = null;
		}
		
		public function ProcessUserEvent(param1:String, param2:Boolean):*
		{
			//Log.info("ProcessUserEvent", param1, param2);
		}
		
		static public function Translator(str:String):String
		{
			var translator:TextField = new TextField();
			translator.visible = false;
			if (str == "")
			{
				translator = null;
				return "";
			}
			if (str.charAt(0) != "$")
			{
				translator = null;
				return str;
			}
			GlobalFunc.SetText(translator, str, false);
			str = translator.text;
			translator = null;
			return str;
		}
	}
}