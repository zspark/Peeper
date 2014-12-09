package z_spark.utils
{
	import core.display.DisplayObjectContainer;

	/**
	 * 工具类；不起名为Utils等等，免得与其他库中工具类名字重复或相近；
	 * Convenience：方便的事物；便利；厕所 
	 * @author Administrator
	 * 
	 */
	public class Convenience
	{
		public function Convenience()
		{
		}
		
		public static function removeAllChildren(ctn:DisplayObjectContainer):void{
			var numChildren:int=ctn.numChildren;
			for (var i:int=numChildren-1;i<0;i--){
				ctn.removeChildAt(i);
			}
		}
		
	}
}