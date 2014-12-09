package z_spark.net
{
	import core.events.Event;
	
	public class ConnetionEvent extends Event
	{
		public static const CONNED:String='conned';
		public static const ERROR:String='error';
		public static const CLOSE:String='close';
		
		public function ConnetionEvent(type:String, bubbles:Boolean=false)
		{
			super(type, bubbles);
		}
	}
}