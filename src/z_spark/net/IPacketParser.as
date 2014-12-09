package z_spark.net
{
	import core.net.Socket;
	
	import z_spark.core.CustomByteArray;

	public interface IPacketParser
	{
		function decode(socket:Socket):void;
		function encode(systemId:int,moduleId:int,fnId:int,data:CustomByteArray):Boolean;
	}
}