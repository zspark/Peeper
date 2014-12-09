package z_spark.mgr
{
	import flash.utils.Dictionary;
	
	import z_spark.StringDef;
	import z_spark.structure_internal;
	import z_spark.core.BaseLogic;

	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};
	
	use namespace structure_internal;
	public class LogicManager
	{
		/**
		 * 用于在框架内部方便对象处理； 
		 * 任何时候只引用该类最新实例；
		 */
		structure_internal static var instance:LogicManager;
		
		private var _logicDic:Dictionary=new Dictionary();
		private var _wndMap:Dictionary=new Dictionary();
		public function LogicManager()
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::LogicManager()");
			};
			
			instance=this;
		}
		
		public function registWnd(wndName:String,proxyName:String,logicName:String,logicClass:Class,viewClass:Class):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::registWnd(String,String,String,Class,Class),wndName=",wndName," proxyName=",proxyName," logicName=",logicName);
			};
			_wndMap[wndName]=new WndSeed(proxyName,logicName,logicClass,viewClass);
		}
		
		public function getWnd(wndName:String):BaseLogic{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::getWnd(String),wndName=",wndName);
			};
			var wndSeed:WndSeed=_wndMap[wndName] as WndSeed;
			if(wndSeed==null){
				CONFIG::STRUCTURE_DEBUG{
					Debugger.info(StringDef.ERROR_NOT_REGIST);
				};
				return null;
			}
			
			var result:BaseLogic;
			if(isLogicExist(wndSeed.logicName)){
				trace(wndName,'已存在');
				result=getLogic(wndSeed.logicName);
			}else{
				var clsLogic:Class=wndSeed.logic;
				var clsView:Class=wndSeed.view;
				result=new clsLogic(ProxiesManager.instance.getProxy(wndSeed.proxyName),new clsView());
				addLogic(result);
				wndSeed.wndExist=true;
			}
			
			return result;
		}
		
		/**
		 *  销毁窗口；
		 * 用于销毁逻辑实例与UI实例；
		 * @param wndName
		 * @return 			只有之前存在窗口实例，并且由于这次调用接口才销毁掉该
		 * 					窗口的情况下，才返回true；
		 * 
		 */
		public function removeWnd(wndName:String):Boolean{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::cleanWnd(String),wndName=",wndName);
			};
			var wndSeed:WndSeed=_wndMap[wndName] as WndSeed;
			if(wndSeed==null){
				CONFIG::STRUCTURE_DEBUG{
					Debugger.info(StringDef.ERROR_NOT_REGIST);
				};
				return false;
			}
			if(wndSeed.wndExist){
				var tmp:BaseLogic=removeLogic(wndSeed.logicName);
				tmp.destory();
				wndSeed.wndExist=false;
				return true;
			}
			return false;
		}
		
		public function addLogic(logic:BaseLogic):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::addLogic(BaseLogic),logicName=",logic.logicName);
			};
			
			_logicDic[logic.logicName]=logic;
		}
		
		public function getLogic(logicName:String):BaseLogic{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::getLogic(String),logicName=",logicName);
			};
			if(_logicDic[logicName]==null){
				throw new Error("LogicManager::getLogic(String) "+StringDef.ERROR_NOT_EXIST+" logicName="+logicName);
			}
			return _logicDic[logicName] as BaseLogic;
		}
		
		public function removeLogic(logicName:String):BaseLogic{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::removeLogic(String),logicName=",logicName);
			};
			
			var logic:BaseLogic=_logicDic[logicName];
			if(logic==null){
				throw new Error("LogicManager::removeLogic(String) "+StringDef.ERROR_NOT_EXIST+" logicName="+logicName);
			}
			delete _logicDic[logicName];
			return logic;
		}
		
		public function isLogicExist(logicName:String):Boolean{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("LogicManager::isLogicExist(String),logicName=",logicName);
			};
			return _logicDic[logicName]!=null;
		}
	}
}

class WndSeed{
	public var proxyName:String;
	public var logicName:String;
	public var logic:Class;
	public var view:Class;
	public var wndExist:Boolean=false;
	public function WndSeed(pName:String,lName:String,logic:Class,view:Class){
		proxyName=pName;
		logicName=lName;
		this.logic=logic;
		this.view=view;
	}
}