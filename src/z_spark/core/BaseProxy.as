package z_spark.core
{
	import flash.utils.Dictionary;
	
	import core.events.EventDispatcher;
	
	import z_spark.structure_internal;
	import z_spark.net.IPacketParser;

	use namespace structure_internal;
	
	public class BaseProxy extends EventDispatcher implements INetAppDataHandler
	{
		private var _packetParser:IPacketParser;
		
		private var _systemId:uint;
		private var _moduleId:uint;
		private var _proxyName:String;
		private var _idToFnDic:Dictionary;
		
		public static const SYSTEM_SERVICE:uint=0x01;
		public static const SYSTEM_FIGHT:uint=0x02;
		public static const SYSTEM_yangcheng:uint=0x03;
		
		public function BaseProxy(name:String,systemId:uint,moduleId:uint)
		{
			_proxyName=name;
			_systemId=systemId;
			_moduleId=moduleId;
			
			_idToFnDic=new Dictionary();
		}
		
		structure_internal function get idToFnDic():Dictionary
		{
			return _idToFnDic;
		}

		structure_internal function set packetParser(value:IPacketParser):void{
			_packetParser=value;
		}
		
		protected function addHandleFnMap(fnId:int,fn:Function):void{
			_idToFnDic[fnId]=fn;
		}
		
		public function get proxyName():String
		{
			return _proxyName;
		}

		public function handle(fnId:uint, data:CustomByteArray):void
		{
			var fn:Function=_idToFnDic[fnId] as Function;
			if(fn){
				fn(data);
			}
		}
		
		public function send(fnId:uint,data:CustomByteArray):void{
			_packetParser.encode(_systemId,_moduleId,fnId,data);
		}
		
		public function toString():String
		{
			return "/null,printed from BaseProxy::toString()/";
		}
	}
}