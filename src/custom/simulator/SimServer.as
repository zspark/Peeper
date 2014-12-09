package custom.simulator
{
	import flash.utils.ByteArray;
	
	import core.events.ProgressEvent;
	
	public class SimServer
	{
		private static var _simSocket:SimSocket=new SimSocket();
		
		public static function get simSocket():SimSocket
		{
			return _simSocket;
		}

		public static function ackBasicInfo():void{
			var name:String='顺风顺水冯';
			var level:uint=200;
			_simSocket.writeByte(name.length*3);
			_simSocket.writeUTFBytes(name);
			_simSocket.writeByte(level);
			_simSocket.writeByte(124);
			
//			dispatch();
		}
		
		
		
		public static function ackLogin():void
		{
			var ba:ByteArray=new ByteArray();
			ba.writeBoolean(true);
			ba=fixUpHead(1,1,1,ba);
			ba.position=0;
			_simSocket.writeBytes(ba,0,ba.length);
			dispatch();
		}
		
		private static function dispatch():void{
			_simSocket.position=0;
			_simSocket.dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA));   
		}
		
		private static function fixUpHead(systemId:uint,moduleId:uint,fnId:int,barr:ByteArray):ByteArray{
			var netPacketBa:ByteArray=new ByteArray();
			netPacketBa.writeUnsignedInt(barr.length);
			netPacketBa.writeByte(systemId);
			netPacketBa.writeByte(moduleId);
			netPacketBa.writeByte(fnId);
			netPacketBa.writeBytes(barr,0,barr.length);
			return netPacketBa;
		}
	}
}