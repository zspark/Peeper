package z_spark
{
	import z_spark.core.BaseProxy;
	import z_spark.core.INetAppDataHandler;
	import z_spark.mgr.LayerManager;
	import z_spark.mgr.LogicManager;
	import z_spark.mgr.ProxiesManager;
	import z_spark.net.Connetion;
	import z_spark.net.IPacketParser;
	import z_spark.net.ProtocolCodeController;
	
	use namespace structure_internal;
	public class Face
	{
		protected var _proxyManager:ProxiesManager;
		protected var _logicManager:LogicManager;
		protected var _layerManager:LayerManager;
		/**
		 * 链接； 
		 */
		private var _conn:Connetion;
		
		/**
		 * 协议编号表； 
		 */
		protected var _PCC:ProtocolCodeController;
		
		public function Face()
		{
			_layerManager=new LayerManager();
			_logicManager=new LogicManager();
			_proxyManager=new ProxiesManager();
			
			_PCC=new ProtocolCodeController();
			_conn=new Connetion();
		}
		
		public function get conn():Connetion
		{
			return _conn;
		}

		public function set packetParser(value:IPacketParser):void{
			_conn.packetParser=value;
			_proxyManager.updatePacketParser(value);
		}
		
		public function registProxy(systemId:int,moduleId:int,proxy:INetAppDataHandler):void{
			_proxyManager.registProxy(proxy as BaseProxy);
			_PCC.registNetAppDataHandler(systemId,moduleId,proxy);
		}
		
		public function get layerManager():LayerManager
		{
			return _layerManager;
		}

		public function get logicManager():LogicManager
		{
			return _logicManager;
		}

		public function get proxyManager():ProxiesManager
		{
			return _proxyManager;
		}
		
	}
}