package z_spark.net
{
	import flash.utils.Dictionary;
	
	import z_spark.structure_internal;
	import z_spark.core.CustomByteArray;
	import z_spark.core.INetAppDataHandler;
	import z_spark.debug.Debugger;

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
		private var _registedFnArr:Dictionary=new Dictionary();
		public function ProtocolCodeController()
		{
		}
		
		/**
		 * {{[fn1,fn2,fn3]},{[fn4],[..]},{[fn5,fn6],[..],[]}} 
		 * @param systemId
		 * @param moduleId
		 * @param receiver
		 * 
		 */
		structure_internal function registNetAppDataHandler(systemId:int,moduleId:int,receiver:INetAppDataHandler):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("PacketParser::registProxy(int,int,int,INetDataReceiver),proxyName=",receiver.proxyName);
			};
			
			var moduleDic:Dictionary=_registedFnArr[systemId];
			if(moduleDic==null){
				moduleDic=new Dictionary();
				_registedFnArr[systemId]=moduleDic;
			}
			
			var fnArr:Array=moduleDic[moduleId];
			if(fnArr==null){
				fnArr=[];
				moduleDic[moduleId]=fnArr;
			}
			
			fnArr.push(receiver);
		}
		
		public function dispatch(systemId:int,moduleId:int,fnId:int,data:CustomByteArray):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("PacketParser::dispatch(int,int,int,CustomByteArray)",systemId,moduleId,fnId,"data.length=",data.length);
			};
			var fnArr:Array=_registedFnArr[systemId][moduleId] as Array;
			if(fnArr==null)
				Debugger.error("PacketParser::dispatch(int,int,int,CustomByteArray),没有注册任何处理逻辑，将数据包丢弃！");
			for each(var receiver:INetAppDataHandler in fnArr){
				if(receiver!=null){
					receiver.handle(fnId,data);
				}
			}
		}
	}
}