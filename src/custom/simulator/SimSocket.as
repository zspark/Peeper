package custom.simulator
{
	import flash.utils.ByteArray;
	
	import core.events.Event;
	import core.net.Socket;
	
	public class SimSocket extends Socket
	{
		private var _byteArray:ByteArray=new ByteArray();
		public function SimSocket()
		{
			super();
		}
		
		override public function connect(ip:String,port:int):void{
			dispatchEvent(new Event(Event.CONNECT));
		}
		
		override public function get bytesAvailable():uint{
			return _byteArray.bytesAvailable;
		}
		
		override public function set endian(value:String):void{
			_byteArray.endian=value;
		}
		
		override public function get endian():String{
			return _byteArray.endian;
		}
		
		override public function readUnsignedShort():uint
		{
			return _byteArray.readUnsignedShort();
		}
		
		override public function readUnsignedByte():uint
		{
			return _byteArray.readUnsignedByte();
		}
		
		override public function readUnsignedInt():uint
		{
			return _byteArray.readUnsignedInt();
		}
		
		override public function readBytes(fullData:ByteArray, param1:uint=0, _dataLen:uint=0):void
		{
			_byteArray.readBytes(fullData,param1,_dataLen);
		}
		
		override public function writeBytes(fullData:ByteArray, param1:uint=0, _dataLen:uint=0):void
		{
			_byteArray.writeBytes(fullData,param1,_dataLen);
		}
		
		public function set position(value:uint):void{
			_byteArray.position=value;
		}
		
		public function get position():uint{
			return _byteArray.position;
		}
	}
}