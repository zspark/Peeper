package z_spark.mgr
{
	import flash.utils.Dictionary;
	
	import z_spark.StringDef;
	import z_spark.structure_internal;
	import z_spark.core.BaseProxy;
	import z_spark.debug.SError;
	import z_spark.net.IPacketParser;

	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};

	use namespace structure_internal;
	
	public class ProxiesManager
	{
		/**
		 * 用于在框架内部方便对象处理； 
		 */
		structure_internal static var instance:ProxiesManager;
		private var _proxiesDic:Dictionary=new Dictionary();
	
		/**
		 * 更新每一个proxy的IpacketParser；
		 * 用在客户端更换协议解析类的时候由Face调用； 
		 * @param value
		 * 
		 */
		structure_internal function updatePacketParser(value:IPacketParser):void{
			for each(var proxy:BaseProxy in _proxiesDic){
				proxy.packetParser=value;
			}
		}
		
		/**
		 * 给指定的Proxy使用指定的IPacketParser； 
		 * @param obj
		 * @param parser
		 * 
		 */
		public function setParserTo(obj:*,parser:IPacketParser):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("ProxiesManager::setParserTo(*，IPacketParser)",obj);
			};
			var proxy:BaseProxy;
			if(obj is String){
				proxy=getProxy(obj);
			}else if(obj is BaseProxy)
				proxy=obj;
			
			if(proxy==null){
				CONFIG::STRICT_DEBUG{
					throw SError(StringDef.ERROR_NOT_EXIST);
				};
				CONFIG::STRUCTURE_DEBUG{
					Debugger.error("ProxiesManager::setParserTo(*，IPacketParser)",StringDef.ERROR_NOT_EXIST);
				};
				return;
			}else{
				proxy.packetParser=parser;
			}
		}
		
		public function ProxiesManager()
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("ProxiesManager::ProxiesManager()");
			};
			
			instance=this;
		}
		
		public function registProxy(proxy:BaseProxy):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("ProxiesManager::registProxy(INetDataReceiver),proxyName=",proxy.proxyName);
			};
			
			_proxiesDic[proxy.proxyName]=proxy;
		}
		
		public function getProxy(proxyName:String):BaseProxy{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("ProxiesManager::getProxy(String),proxyName=",proxyName);
			};
			if(proxyName==null)return null;
			CONFIG::STRICT_DEBUG{
				if(_proxiesDic[proxyName]==null){
					throw SError("ProxiesManager::getProxy(String),"+StringDef.ERROR_NOT_EXIST+"，proxyName="+proxyName);
				}
			};
			return _proxiesDic[proxyName] as BaseProxy;
		}
		
		public function toString():String{
			return '';
		}
	}
}