package z_spark.net
{
	import flash.utils.Dictionary;
	
	import core.utils.WeakDictionary;
	
	import z_spark.structure_internal;
	import z_spark.core.CustomByteArray;
	import z_spark.core.INetAppDataHandler;
	import z_spark.debug.Debugger;

	use namespace structure_internal;
	/**
	 * 协议编号控制器（映射表）；
	 * 用来找到由‘系统编号’，‘模块编号’，‘函数编号’映射的具体接口地址；
	 * 并调用接口逻辑； 
	 * @author z_Spark
	 * @since 20141202
	 * 
	 */
	public class ProtocolCodeController
	{
		/**
		 * 用于在框架内部方便对象处理； 
		 */
		structure_internal static var instance:ProtocolCodeController;
		structure_internal function get pccDataDic():Dictionary{
			return _pccDataDic;
		}
		
		private var _pccDataDic:Dictionary=new Dictionary();
		
		public function ProtocolCodeController()
		{
			instance=this;
		}
		
		/**
		 * 用弱字典持有网络数据解析器（BaseProxy）的引用；
		 * {{[fn1,fn2,fn3]},{[fn4],[..]},{[fn5,fn6],[..],[]}} 
		 * @param systemId
		 * @param moduleId
		 * @param receiver
		 * 
		 */
		structure_internal function registNetAppDataHandler(systemId:int,moduleId:int,receiver:INetAppDataHandler):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("ProtocolCodeController::registNetAppDataHandler(int,int,int,INetDataReceiver),proxyName=",receiver.proxyName);
			};
			
			var moduleDic:WeakDictionary=_pccDataDic[systemId];
			if(moduleDic==null){
				moduleDic=new WeakDictionary();
				_pccDataDic[systemId]=moduleDic;
			}
			moduleDic[moduleId]=receiver;
		}
		
		public function dispatch(systemId:int,moduleId:int,fnId:int,data:CustomByteArray):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("ProtocolCodeController::dispatch(int,int,int,CustomByteArray)",systemId,moduleId,fnId,"data.length=",data.length);
			};
			var receiver:INetAppDataHandler=_pccDataDic[systemId][moduleId] as INetAppDataHandler;
			if(receiver==null)
				Debugger.error("ProtocolCodeController::dispatch(int,int,int,CustomByteArray),没有注册任何处理逻辑或该代理在运行时被移除，将数据包丢弃！");
			receiver.handle(fnId,data);
		}
	}
}