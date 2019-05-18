package  {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.display.MovieClip;
	import debug.Log;
	import flash.utils.getQualifiedClassName;
	import flash.geom.ColorTransform;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	//import Shared.AS3.BSButtonHintData;
	
	public class SSW_main extends MovieClip {
		
		public static const KEY_LSHIFT:int = 160;
		public static const KEY_RSHIFT:int = 161;
		public static const KEY_LCTRL:int = 162;
		public static const KEY_RCTRL:int = 163;
		public static const KEY_LALT:int = 164;
		public static const KEY_RALT:int = 165;
		
		public var Menu_mc:main;
		public var _mcmCodeObject: Object = new Object;
		public var _f4seCodeObject: Object = new Object;
		public var _noTintCT: ColorTransform;
		public var _tintCT: ColorTransform;
		private var _shift: Boolean;
		private var _alt: Boolean;
		private var _ctrl: Boolean;
		private var dragTarget: MovieClip;
		private var controlTarget: def_bar;
		
		//public var MenuButton1: Shared.AS3.BSButtonHintData;
		//public var MenuButton2: Shared.AS3.BSButtonHintData;
		//public var MenuButton3: Shared.AS3.BSButtonHintData;
		//public var MenuButton4: Shared.AS3.BSButtonHintData;
		//public var MenuButton5: Shared.AS3.BSButtonHintData;
		
		public function SSW_main() {
			// constructor code
		}
		
		public function onCustomClipLoaded(mcmCodeObject: Object, f4seCodeObject: Object, noTintCT: ColorTransform, tintCT: ColorTransform)
		{
			_shift = false;
			_alt = false;
			_ctrl = false;
			
			_f4seCodeObject = f4seCodeObject;
			_mcmCodeObject = mcmCodeObject;
			_noTintCT = noTintCT;
			_tintCT = tintCT;

			var SettingsObject: Object = _f4seCodeObject.plugins.SSW.RequestSettings();
			Menu_mc.iShowIcon = SettingsObject.iShowIcon;
			Menu_mc.iShowPercents = SettingsObject.iShowPercents;
			Menu_mc.iShowBar = SettingsObject.iShowBar;
			Menu_mc.iShowTextStatus = SettingsObject.iShowTextStatus;
			Menu_mc.iColored = SettingsObject.iColored;
			
			Menu_mc.fFoodBarX = SettingsObject.fFoodBarX;
			Menu_mc.fFoodBarY = SettingsObject.fFoodBarY;
			Menu_mc.fFoodBarScaleX = SettingsObject.fFoodBarScaleX;
			Menu_mc.fFoodBarScaleY = SettingsObject.fFoodBarScaleY;
			Menu_mc.fFoodBarRotation = SettingsObject.fFoodBarRotation;
			Menu_mc.iFoodBarVisible = SettingsObject.iFoodBarVisible;
			
			Menu_mc.fDrinkBarX = SettingsObject.fDrinkBarX;
			Menu_mc.fDrinkBarY = SettingsObject.fDrinkBarY;
			Menu_mc.fDrinkBarScaleX = SettingsObject.fDrinkBarScaleX;
			Menu_mc.fDrinkBarScaleY = SettingsObject.fDrinkBarScaleY;
			Menu_mc.fDrinkBarRotation = SettingsObject.fDrinkBarRotation;
			Menu_mc.iDrinkBarVisible = SettingsObject.iDrinkBarVisible;
			
			Menu_mc.fSleepBarX = SettingsObject.fSleepBarX;
			Menu_mc.fSleepBarY = SettingsObject.fSleepBarY;
			Menu_mc.fSleepBarScaleX = SettingsObject.fSleepBarScaleX;
			Menu_mc.fSleepBarScaleY = SettingsObject.fSleepBarScaleY;
			Menu_mc.fSleepBarRotation = SettingsObject.fSleepBarRotation;
			Menu_mc.iSleepBarVisible = SettingsObject.iSleepBarVisible;
			
			
			Menu_mc.UI_ct = tintCT;
			
			
			Menu_mc.UpdateModSettings();
			Menu_mc.setValuesForMCM();
			Log.info("onCustomClipLoaded");
			
			Menu_mc.food_bar.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			Menu_mc.drink_bar.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			Menu_mc.fatigue_bar.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			
			Menu_mc.food_bar.addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			Menu_mc.drink_bar.addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			Menu_mc.fatigue_bar.addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			
			Menu_mc.food_bar.addEventListener(MouseEvent.MOUSE_DOWN, _onThumbMouseDown);
			Menu_mc.drink_bar.addEventListener(MouseEvent.MOUSE_DOWN, _onThumbMouseDown);
			Menu_mc.fatigue_bar.addEventListener(MouseEvent.MOUSE_DOWN, _onThumbMouseDown);
		}

		public function _onMouseOver(e: MouseEvent)
		{
			controlTarget = e.currentTarget;
			controlTarget.bg_for_mcm_mc.visible = true;
			//trace(e.currentTarget);
		}
		
		public function _onMouseOut(e: MouseEvent)
		{
			controlTarget.bg_for_mcm_mc.visible = false;
			controlTarget = null;
			//trace(e.currentTarget);
		}
		
		public function _onThumbMouseDown(e: MouseEvent)
		{
			//trace(e.currentTarget);
			dragTarget = e.currentTarget;
			dragTarget.startDrag(false, new Rectangle(-1280, -720, 2560, 1440));
			stage.addEventListener(MouseEvent.MOUSE_UP, _onThumbMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _onThumbMouseMove);
		}
		
		private function _onThumbMouseMove(e:MouseEvent):void
		{

		}
		
		private function _onThumbMouseUp(e:MouseEvent):void
		{
			dragTarget.stopDrag();
			dragTarget = null;
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.onThumbMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onThumbMouseMove);
		}
		
		public function SetButtonsSimple(SetButtonHint: Function)
		{
			Log.info("SetButtonsSimple");
			/*SetButtonHint(aiButtonNumber: int, astrButtonText:String, 
			astrPCKey:String, astrPSNButton:String, astrXenonButton:String, auiJustification:uint, aFunction:Function, 
			astrSecondaryPCKey:String = "", astrSecondaryPSNButton:String = "", astrSecondaryXenonButton:String = "")*/

			SetButtonHint(1, "$MOVE", "LMouse", "s", "s", 1, null);
			SetButtonHint(2, "$SCALE", "Z", "G", "G", 1, null,"C", "L", "L");
			SetButtonHint(3, "$ROTATE", "Q", "PSN_L2_Alt", "Xenon_L2_Alt", 1, null, "E", "PSN_R2_Alt", "Xenon_R2_Alt");
			SetButtonHint(4, "$SAVE", "R", "PSN_X", "Xenon_X", 1, onAcceptPress);
			SetButtonHint(5, "$RESET", "T", "PSN_Y", "Xenon_Y", 1, onResetButtonClicked);
		}

		/*public function SetButtons(btn1: Shared.AS3.BSButtonHintData, btn2: Shared.AS3.BSButtonHintData, btn3: Shared.AS3.BSButtonHintData, btn4: Shared.AS3.BSButtonHintData, btn5: Shared.AS3.BSButtonHintData)
		{	
			MenuButton1 = btn1;
			MenuButton1.SetButtons("LMouse", "s", "s");
			MenuButton1.SetSecondaryButtons("", "", "");
			MenuButton1.ButtonVisible = true;
			MenuButton1.ButtonText = "$MOVE";
			MenuButton1["_uiJustification"] = 1;
			MenuButton1["_callbackFunction"] = null;

			Log.info("SetButtons");
		}*/
		
		public function onAcceptPress()
		{
			Log.info("onAcceptPress");
			saveSettings();
			dispatchEvent(new Event("closeRequest"));
		}
		
		public function onResetButtonClicked()
		{
			Log.info("onResetButtonClicked");
			Reset();
		}
		
		public function ProcessKeyEvent(keyCode:int, isDown:Boolean):void
		{
			if (!isDown)
			{
			//Log.info("Key event! keyCode: " + keyCode + " isDown: " + isDown);
				switch (keyCode)
				{
				case Keyboard.T: 
					onResetButtonClicked();
					break;
				case Keyboard.R: 
					onAcceptPress();
					break;
				case KEY_LSHIFT: 
				case KEY_RSHIFT: 
					_shift = false;
					break;
				case KEY_LCTRL: 
				case KEY_RCTRL: 
					_ctrl = false;
					break;
				case KEY_LALT: 
				case KEY_RALT: 
					_alt = false;
					break;
				case Keyboard.Q: 
					frot(_alt?-20:(_ctrl?-1:(_shift?-5:-10)));
					break;
				case Keyboard.E: 
					frot(_alt?20:(_ctrl?1:(_shift?5:10)));
					break;
				case Keyboard.W: 
					fposy(_alt?-100:(_ctrl?-1:(_shift?-5:-10)));
					break;
				case Keyboard.S: 
					fposy(_alt?100:(_ctrl?1:(_shift?5:10)));
					break;
				case Keyboard.A: 
					fposx(_alt?-100:(_ctrl?-1:(_shift?-5:-10)));
					break;
				case Keyboard.D: 
					fposx(_alt?100:(_ctrl?1:(_shift?5:10)));
					break;
				case Keyboard.Z: 
					fscalex(-1);
					fscaley(-1);
					break;
				case Keyboard.C: 
					fscalex(+1);
					fscaley(+1);
					break;					
				default: 
				}
			}
			else 
			{
				switch (keyCode)
				{
				case KEY_LSHIFT: 
				case KEY_RSHIFT: 
					_shift = true;
					break;
				case KEY_LCTRL: 
				case KEY_RCTRL: 
					_ctrl = true;
					break;
				case KEY_LALT: 
				case KEY_RALT: 
					_alt = true;
					break;
				default: 
				}
			}
		}
		
		public function ProcessUserEvent(controlName:String, isDown:Boolean, deviceType:int):void
		{
			//Log.info("ProcessUserEvent", controlName, isDown, deviceType);
			if (!isDown && deviceType == 2)
			{
				switch (controlName)
				{
				case "LShoulder": 
					LShoulderPressed();
					break;
				case "RShoulder": 
					RShoulderPressed();
					break;
				case "LTrigger": 
					LTriggerPressed();
					break;
				case "RTrigger": 
					RTriggerPressed();
					break;
				case "ResetToDefault": 
					onResetButtonClicked();
					break;
				case "Up": 
					ProcessKeyEvent(Keyboard.W, false)
					break;
				case "Down": 
					ProcessKeyEvent(Keyboard.S, false)
					break;
				case "Left": 
					ProcessKeyEvent(Keyboard.A, false)
					break;
				case "Right": 
					ProcessKeyEvent(Keyboard.D, false)
					break;
				case "Accept": 
					SwitchFocus();
					break;
				case "Cancel": 
					dispatchEvent(new Event("closeRequest"));
					break;
				case "DeleteSave": 
					ProcessKeyEvent(Keyboard.R, false)
					break;
				default: 
				}
				
			}
		}
		
		public function SwitchFocus():*
		{
			if (controlTarget == null)
			{
				controlTarget = Menu_mc.food_bar;
				controlTarget.bg_for_mcm_mc.visible = true;
			}
			else 
			{
				controlTarget.bg_for_mcm_mc.visible = false;
					if (controlTarget == Menu_mc.food_bar) 
					{				
						controlTarget = Menu_mc.drink_bar;
					}
					else if (controlTarget == Menu_mc.drink_bar) 
					{
						controlTarget = Menu_mc.fatigue_bar;
					} 
					else
					{
						controlTarget = Menu_mc.food_bar;
					} 
				controlTarget.bg_for_mcm_mc.visible = true;
			}
		}
		
		public function RTriggerPressed():void
		{
			ProcessKeyEvent(Keyboard.E, false)
		}
		
		public function LTriggerPressed():void
		{
			ProcessKeyEvent(Keyboard.Q, false)
		}
		
		private function LShoulderPressed()
		{
			fscalex(-1);
		}
		
		private function RShoulderPressed()
		{
			fscalex(1);
		}
		
		public function Reset():void 
		{
			Menu_mc.UpdateModSettings();
			Menu_mc.setValuesForMCM();
		}
		
		private function frot(val: Number):void 
		{
			controlTarget.rotation = ((controlTarget.rotation + val) % 360);
		}
		
		private function fposx(val: Number):void 
		{
			controlTarget.x += val;
		}
		
		private function fposy(val: Number):void 
		{
			controlTarget.y += val;
		}
		
		public function fscalex(val: Number):void 
		{
			if ((controlTarget.scaleX > 0.2 && val<0) || (val>0))
			{
				controlTarget.scaleX += val * 0.1;
			}
		}
		
		public function fscaley(val: Number):void 
		{
			if ((controlTarget.scaleY > 0.2 && val<0) || (val>0))
			{
				controlTarget.scaleY += val * 0.1;
			}
		}
		
		private function falpha(val: Number):void 
		{
			if ((controlTarget.alpha> 0.04 && val<0) || (controlTarget.alpha < 0.96 && val>0))
			{
				controlTarget.alpha += val * 0.05;
			}
		}
		
		private function saveSettings():*
		{
			_mcmCodeObject.SetModSettingFloat("SSW", "fFoodBarX:Main", Menu_mc.food_bar.x);
			_mcmCodeObject.SetModSettingFloat("SSW", "fFoodBarY:Main", Menu_mc.food_bar.y);
			_mcmCodeObject.SetModSettingFloat("SSW", "fFoodBarScaleX:Main", Menu_mc.food_bar.scaleX);
			_mcmCodeObject.SetModSettingFloat("SSW", "fFoodBarScaleY:Main", Menu_mc.food_bar.scaleY);
			_mcmCodeObject.SetModSettingFloat("SSW", "fFoodBarRotation:Main", Menu_mc.food_bar.rotation);

			_mcmCodeObject.SetModSettingFloat("SSW", "fDrinkBarX:Main", Menu_mc.drink_bar.x);
			_mcmCodeObject.SetModSettingFloat("SSW", "fDrinkBarY:Main", Menu_mc.drink_bar.y);
			_mcmCodeObject.SetModSettingFloat("SSW", "fDrinkBarScaleX:Main", Menu_mc.drink_bar.scaleX);
			_mcmCodeObject.SetModSettingFloat("SSW", "fDrinkBarScaleY:Main", Menu_mc.drink_bar.scaleY);
			_mcmCodeObject.SetModSettingFloat("SSW", "fDrinkBarRotation:Main", Menu_mc.drink_bar.rotation);
			
			_mcmCodeObject.SetModSettingFloat("SSW", "fSleepBarX:Main", Menu_mc.fatigue_bar.x);
			_mcmCodeObject.SetModSettingFloat("SSW", "fSleepBarY:Main", Menu_mc.fatigue_bar.y);
			_mcmCodeObject.SetModSettingFloat("SSW", "fSleepBarScaleX:Main", Menu_mc.fatigue_bar.scaleX);
			_mcmCodeObject.SetModSettingFloat("SSW", "fSleepBarScaleY:Main", Menu_mc.fatigue_bar.scaleY);
			_mcmCodeObject.SetModSettingFloat("SSW", "fSleepBarRotation:Main", Menu_mc.fatigue_bar.rotation);
			
			_f4seCodeObject.plugins.SSW.UpdateSettings();
		}
		
		// *********************************
		// =========== UTILITIES ===========
		// *********************************
		
		public static function traceObj(obj:Object):void
		{
			for (var id:String in obj)
			{
				var value:Object = obj[id];
				
				if (getQualifiedClassName(value) == "Object")
				{
					trace("-->");
					traceObj(value);
				}
				else
				{
					trace(id + " = " + value);
				}
			}
		}
	}
	
}
