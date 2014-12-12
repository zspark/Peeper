package z_spark.utils
{
	import core.display.DisplayObject;
	import core.display.DisplayObjectContainer;

	/**
	 * 工具类；不起名为Utils等等，免得与其他库中工具类名字重复或相近；
	 * Convenience：方便的事物；便利；厕所 
	 * 
	 * @author z_Spark
	 * 
	 */
	public class Convenience
	{
		/** 按钮 暗黄 */
		public static const COLOR_HTML_YELLOW_BUTTON:String = "#d9cc00";
		/** 普通文字 橙 */
		public static const COLOR_HTML_ORANGE:String = "#F59F9F";
		/** 普通文字 亮蓝 */
		public static const COLOR_HTML_BLUE_LIGHT:String = "#00e6ee";
		/** 普通文字 蓝 */
		public static const COLOR_HTML_BLUE:String = "#0099FF";
		/** 普通文字 金黄 */
		public static const COLOR_HTML_TEXT_YELLOW:String = "#ffff00";
		/** 普通文字 纯红 */
		public static const COLOR_HTML_RED:String = "#ff0000";
		/** 普通文字 白 */
		public static const COLOR_HTML_WHITE:String = "#FFFFFF";
		/** 普通文字 紫色 */
		public static const COLOR_HTML_PURPLE:String = "#f600ff";
		/** 普通文字 灰色 */
		public static const COLOR_HTML_GRAY:String = "#a0a0a0";
		/** 普通文字 亮绿色 */
		public static const COLOR_HTML_GREEN_LIGHT:String = "#00ff00";
		/** 普通文字 白 */
		public static const COLOR_WHITE:uint = 0xFFFFFF;
		/** 普通文字 暗黄 */
		public static const COLOR_YELLOW:uint = 0xf9faa3;//0xdcd181;
		/** 普通文字 金黄 */
		public static const COLOR_TEXT_YELLOW:uint = 0xffff00;
		/** 按钮 暗黄 */
		public static const COLOR_YELLOW_BUTTON:uint = 0xd9cc00;
		/** 提示文字 金黄 */
		public static const COLOR_YELLOW_ALERT:uint = 0xF6FF00;
		/** 普通文字 橙 */
		public static const COLOR_ORANGE:uint = 0xFF9c00;
		/** 普通文字 绿 */
		public static const COLOR_GREEN:uint = 0x00ff00;
		/** 普通文字 红 */
		public static const COLOR_RED:uint = 0xff0000;
		/** 普通文字 亮蓝 */
		public static const COLOR_BLUE_LIGHT:uint = 0x00e6ee;//0x5AD9FF;
		/** 普通文字 暗蓝 */
		public static const COLOR_BLUE_DARK:uint = 0xccfef6;
		/** 普通文字 灰暗*/
		public static const COLOR_GRAY:uint = 0x919191;
		/** 矩形黑色带透明*/
		public static const COLOR_BLACK_ALPHA:uint = 0x55000000;
		/** 普通文字 紫色 */
		public static const COLOR_PURPLE:uint = 0xf600ff;
		
		public static function removeAllChildren(ctn:DisplayObjectContainer):void{
			var numChildren:int=ctn.numChildren;
			for (var i:int=numChildren-1;i<0;i--){
				ctn.removeChildAt(i);
			}
		}
		
		public static function addToPos(child:DisplayObject,parent:DisplayObjectContainer,xx:int=0,yy:int=0):void{
			parent.addChild(child);
			child.x=xx;
			child.y=yy;
		}
		
	}
}