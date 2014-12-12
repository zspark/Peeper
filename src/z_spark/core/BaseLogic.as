package z_spark.core
{
	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};
	/**
	 * 游戏具体业务逻辑的承载者；
	 * 若要划分复杂的庞大的逻辑为几个不同的子逻辑的话，可以考虑让主逻辑持有所有
	 * 子逻辑的引用，采用委托设计模式处理下；如果这种需求庞大并且在具体实践中证明
	 * 比较合理且必要的话，框架会考虑支持；
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
		
		public function destruct():void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("BaseLogic::destory()");
			};
			_baseProxy=null;
			_baseView=null;
		}
	}
}