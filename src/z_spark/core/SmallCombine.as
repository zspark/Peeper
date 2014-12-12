package z_spark.core
{
	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};
	import core.display.DisplayObjectContainer;
	
	import z_spark.debug.Debugger;

	/**
	 * 最小联合对象，用来创建小组件‘窗口’，
	 * 省去创建对应Logic、view两个类； 
	 * proxy具有异步性，不方便结合进来；
	 * 不过像系统提示这样的简单对话框可能根本不需要proxy；
	 * 
	 * @author z_Spark
	 * @since 20141211_1646
	 */
	public class SmallCombine extends DisplayObjectContainer
	{
		public var combineName:String;
		protected var _baseProxy:BaseProxy;
		public function SmallCombine(baseProxy:BaseProxy)
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("SmallCombine::SmallCombine()");
			};
			_baseProxy=baseProxy;
		}
		
		public function destruct():void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("SmallCombine::SmallCombine()");
			};
			_baseProxy=null;
		}
	}
}