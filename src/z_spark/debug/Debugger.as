package z_spark.debug
{
	import flash.utils.Dictionary;
	
	import core.filesystem.File;
	import core.utils.WeakDictionary;
	
	import z_spark.structure_internal;
	import z_spark.core.BaseProxy;
	import z_spark.net.ProtocolCodeController;

	use namespace structure_internal;
	public class Debugger
	{
		public static const COUT_INFO:int=2;
		public static const COUT_ERROR:int=4;
		public static const COUT_FAULT:int=6;
		
		private static var _coutMode:int;
		private static var _isTrace:Boolean;
		private static var _isWriteToDisk:Boolean;
		private static var _fileName:String;
		
		public function Debugger()
		{
		}
		
		public static function init(isTrace:Boolean=true,coutMode:int=COUT_INFO,isWriteToDisk:Boolean=false,fileName:String='structure_debug_info.txt'):void{
			_isTrace=isTrace;
			_coutMode=coutMode;
			_isWriteToDisk=isWriteToDisk;
			_fileName=fileName;
		}
		
		public static function error(...args):void{
			if(_coutMode>=COUT_ERROR)
				cout("[ERROR "+new Date().toString()+"] "+args.join(','));
		}
		
		public static function info(...args):void{
			if(_coutMode>=COUT_INFO)
				cout("[INFO "+new Date().toString()+"] "+args.join(','));
		}
		
		public static function fault(...args):void{
			if(_coutMode>=COUT_FAULT)
				cout("[FAULT "+new Date().toString()+"] "+args.join(','));
		}
		
		public static function print(...args):void{
			cout(args.join(','));
		}
		
		private static function cout(str:String):void{
			if(_isTrace)
				trace(str);
			if(_isWriteToDisk)
				File.write(_fileName,str);
		}
		
		public static function printPCCInfo():void{
			var result:String='[ProtocolCodeController debug info:]\n';
			var dic:Dictionary=ProtocolCodeController.instance.pccDataDic;
			for (var sysid:int in dic){
				result+="├ systemId: "+sysid+' :\n';
				var wdic:WeakDictionary=dic[sysid] as WeakDictionary;
				for (var moduleid:int in wdic){
					result+="│\t├ moduleId: "+moduleid+" ─> "+BaseProxy(wdic[moduleid]).toString()+"\n";
					var fnDic:Dictionary=BaseProxy(wdic[moduleid]).idToFnDic;
					for (var fnId:int in fnDic){
						result+="│\t│\t├ fnId: "+fnId+" ─> "+fnDic[fnId].toString()+"\n";
					}
				}
			}
			result+="├ end\n";
			cout(result);
		}
		
	}
}