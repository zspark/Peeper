package z_spark.core
{
	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};
	/**
	 * 游戏具体业务逻辑的承载者；
	 * @author z_Spark
	 * @since 2014/12/02
	 * 
	 */
	public class BaseLogic
	{
		public var logicName:String;
		protected var _baseProxy:BaseProxy;
		protected var _baseView:BaseView;
		public function BaseLogic(baseProxy:BaseProxy,baseView:BaseView)
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("BaseLogic::BaseLogic()");
			};
			_baseProxy=baseProxy;
			_baseView=baseView;
		}
		
		public function openView(eft:Boolean=false):void{
		}
		
		public function closeView(eft:Boolean=false):void{
		}
		
		public function destory():void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("BaseLogic::destory()");
			};
			_baseProxy=null;
			_baseView=null;
		}
	}
}