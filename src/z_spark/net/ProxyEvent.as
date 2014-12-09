package z_spark.net
{
	import core.events.Event;
	
	public class ProxyEvent extends Event
	{
		
		public var value:*;
		public function ProxyEvent(type:String, vl:*=null)
		{
			super(type, false);
			value=vl;
		}
	}
}