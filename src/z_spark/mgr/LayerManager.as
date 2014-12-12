package z_spark.mgr
{
	import core.display.DisplayObject;
	import core.display.DisplayObjectContainer;
	import core.display.Stage;
	import core.events.Event;
	
	import z_spark.StringDef;
	import z_spark.structure_internal;
	import z_spark.debug.SError;

	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};
	
	use namespace structure_internal;
	
	public class LayerManager
	{
		/**
		 * 用于在框架内部方便对象处理； 
		 * 任何时候只引用该类最新实例；
		 */
		structure_internal static var instance:LayerManager;
		
		public static const LAYER_TOP:int=0;
		public static const LAYER_UI:int=1;
		public static const LAYER_FIGHT:int=2;
		public static const LAYER_BOTTOM:int=3;
		
		CONFIG::STRUCTURE_DEBUG{
			public static const LAYER_DEBUG:int=100;
		};
		
		private var _topLayer:DisplayObjectContainer=new DisplayObjectContainer();
		private var _uiLayer:DisplayObjectContainer=new DisplayObjectContainer();
		private var _fightLayer:DisplayObjectContainer=new DisplayObjectContainer();
		private var _bottomLayer:DisplayObjectContainer=new DisplayObjectContainer();
		
		CONFIG::STRUCTURE_DEBUG{
			private var _debugLayer:DisplayObjectContainer=new DisplayObjectContainer();
		};
		
		public function LayerManager()
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LayerManager::LayerManager()");
			};
			
			var stage:Stage=Stage.getStage();
			stage.addChild(_bottomLayer);
			stage.addChild(_fightLayer);
			stage.addChild(_uiLayer);
			stage.addChild(_topLayer);
			
			CONFIG::STRUCTURE_DEBUG{
				stage.addChild(_debugLayer);
			};
			
			instance=this;
		}
		
		CONFIG::STRUCTURE_DEBUG{
			public function getCtn(layerId:int):DisplayObjectContainer{
				switch(layerId)
				{
					case LAYER_TOP:
					{
						return _topLayer;
						break;
					}
					case LAYER_UI:
					{
						return _uiLayer;
						break;
					}
					case LAYER_FIGHT:
					{
						return _fightLayer;
						break;
					}
					case LAYER_BOTTOM:
					{
						return _bottomLayer;
						break;
					}
					case LAYER_DEBUG:
					{
						return _debugLayer;
						break;
					}
					default:
					{
						return null;
						
					}
				}
			}
		};
		
		
		public function removeFromLayer(obj:DisplayObject):void{
			if(obj && obj.parent){
				if( obj.parent==_topLayer || obj.parent==_uiLayer || obj.parent==_fightLayer || obj.parent==_bottomLayer){
					obj.parent.removeChild(obj);
				}
			}
		}
		
		public function addToLayer(obj:DisplayObject,layerId:int,xx:int=0,yy:int=0):void{
			obj.x=xx;
			obj.y=yy;
			switch(layerId)
			{
				case LAYER_TOP:
				{
					_topLayer.addChild(obj);
					break;
				}
				case LAYER_UI:
				{
					_uiLayer.addChild(obj);
					break;
				}
				case LAYER_FIGHT:
				{
					_fightLayer.addChild(obj);
					break;
				}
				case LAYER_BOTTOM:
				{
					_bottomLayer.addChild(obj);
					break;
				}
				case LAYER_DEBUG:
				{
					_debugLayer.addChild(obj);
					break;
				}
				default:
				{
					CONFIG::STRUCTURE_DEBUG{
						Debugger.info("LayerManager::addToLayer(DisplayObject,int,int,int),不存在指定的图层！也不允许在这里额外多加图层！");
					};
					
					throw new Error("::addToLayer(DisplayObject,int,int,int),不存在指定的图层！也不允许在这里额外多加图层！");
					break;
					
				}
			}
		}
		
		private var _enterframeMap:Array;
		public function startGlobalEnterFrame():void{
			if(_bottomLayer.hasEventListener(Event.ENTER_FRAME)){
				CONFIG::STRICT_DEBUG{
					throw SError(StringDef.ERROR_GLOBAL_ALREADY_START);
				};
				return;
			}
			_enterframeMap=[];
			_bottomLayer.addEventListener(Event.ENTER_FRAME,onGlobalEnterHandler);
		}
		
		public function stopGlobalEnterFrame():void{
			if(_bottomLayer.hasEventListener(Event.ENTER_FRAME)){
				_bottomLayer.removeEventListener(Event.ENTER_FRAME,onGlobalEnterHandler);
				return;
			}
			CONFIG::STRICT_DEBUG{
				throw SError(StringDef.ERROR_GLOBAL_ALREADY_STOP);
			};
		}
		
		public function destoryGlobalEnterFrame():void{
			_enterframeMap=null;
			_bottomLayer.removeEventListener(Event.ENTER_FRAME,onGlobalEnterHandler);
		}
		
		public function addEnterframeCall(fn:Function,space:uint=1):void{
			
		}
		
		private function onGlobalEnterHandler(evt:Event):void
		{
			
		}
		
		
	}
}

class EnterframeSeed{
	public var space:uint=1;
	public var fn:Function ;
	public function EnterframeSeed(fn:Function ,space:uint=1){
		
	}
}