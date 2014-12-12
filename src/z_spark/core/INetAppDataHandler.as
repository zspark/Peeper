package z_spark.core
{
	public interface INetAppDataHandler
	{
		function handle(fnId:uint,data:CustomByteArray):void;
		function send(fnId:uint,data:CustomByteArray):void;
		function get proxyName():String;
		function toString():String;
	}
}