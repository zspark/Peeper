package z_spark.core
{
	import core.display.DisplayObject;
	import core.display.DisplayObjectContainer;
	
	/**
	 * UI基类，根据需求应该会有UI逻辑的存在，可以接受，
	 * 但业务逻辑一定要用BaseLogic来处理，实现UI与逻辑分离； 
	 * 
	 * @author z_Spark
	 * @since 2014/12/03
	 * 
	 */
	public class BaseView extends DisplayObjectContainer
	{
		public function BaseView()
		{
			super();
		}
		
		/**
		 * 创建view中非数据驱动的显示对象；
		 * @example：
		 * 邮箱面板：有标题，有关闭按钮，还有邮件列表；
		 *  其中标题、关闭按钮是不需要网络数据就能立刻建立起来的，
		 * 这些UI需要在该方法中实现；
		 * 
		 */
		public function createStaticUI(data:Object=null):void{}
		
		/**
		 * 创建/刷新由异步数据（网络数据等）驱动的显示对象，比如上例中的邮件列表； 
		 * @param asyncData
		 * @param fnCb			用于将显示对象创建完毕后回调，因为该创建过程
		 * 						可能参与有UI特效的表现;
		 * 						e.g.参考《女神联盟》中打开英雄列表时的动画；
		 * 
		 */
		public function refreshDynamicUI(asyncData:Object,fnCb:Function=null):void{}
		
		/**
		 * 播放ui特效；
		 * 可以是序列帧的，也可以是程序动画； 
		 * 
		 */
		public function playEffect():void{}
		
		/**
		 * 停止UI特效播放； 
		 * 
		 */
		public function stopEffect():void{}
		
		/**
		 * 销毁UI，主要用来清除Image等对象的内存占用；
		 * 其他诸如removeChild、=null等操作就不要在该接口中实现了；
		 * 免得冗余/过度的内存释放造成性能的下降； 
		 * 
		 */
		public function destoryView():void{}
		
		protected function setPos(obj:DisplayObject,xx:int=0,yy:int=0):void{
			obj.x=xx;
			obj.y=yy;
		}
		
		protected function addSetPos(obj:DisplayObject,xx:int=0,yy:int=0):void{
			addChild(obj);
			obj.x=xx;
			obj.y=yy;
		}
		
		protected function removeAllChildren():void{
			for (var i:int=numChildren-1;i<0;i--){
				removeChildAt(i);
			}
		}
	}
}