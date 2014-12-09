package custom
{
	import core.net.Socket;
	
	import z_spark.core.CustomByteArray;
	import z_spark.net.IPacketParser;
	import z_spark.net.ProtocolCodeController;
	
	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};
	
	public class XXXGamePacketParser implements IPacketParser
	{
		
		private static const HEAD_LEN:int=56;
		private static const HEAD_LEN_IN_BYTES:int=HEAD_LEN/8;
		
		private var _dataLen:int;
		private var _systemId:int;
		private var _moduleId:int;
		private var _functionId:int;
		private var _pcc:ProtocolCodeController;
		
		/**
		 * 当从底层收到一个包后，
		 * 这个包里面可能有好多个消息（message），
		 * 也可能只有半个消息，
		 * 甚至协议第一个字段（数据长度）都有可能被截断；
		 * 
		 *这里定义数据报基本协议格式；
		 * 
		 * 
		 * 4个字节（32位）的数据长度字段，仅仅是数据字段的长度；
		 * 1个字节（8位）的系统编号字段；
		 * 1个字节（8位）的模块编号字段；
		 * 1个字节（8位）的函数编号字段；
		 * n字节的数据字段； 
		 * 
		 * 其中前4个字段这里称作‘首部字段’；
		 * 其他所有字段称作‘数据字段’；
		 */
		public function XXXGamePacketParser(protocolCodeCtrolloer:ProtocolCodeController)
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("XXXGamePacketParser::XXXGamePacketParser()");
			};
			
			_pcc=protocolCodeCtrolloer;
		}
		
		public function decode(socket:Socket):void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("XXXGamePacketParser::decode(Socket)");
			};
			
			while(socket.bytesAvailable>=HEAD_LEN_IN_BYTES || _dataLen>0){
				if (_dataLen <= 0 )
				{
					_dataLen = socket.readUnsignedInt();
					_systemId=socket.readUnsignedByte();
					_moduleId=socket.readUnsignedByte();
					_functionId=socket.readUnsignedByte();
					
					CONFIG::STRUCTURE_DEBUG{
						Debugger.info("XXXGamePacketParser::decode(Socket),得到新的数据报，(len,sysId,moduleId,fnId)=",(_dataLen,_systemId,_moduleId,_functionId));
					};
				}
				
				if(socket.bytesAvailable>=_dataLen){
					var fullData:CustomByteArray=new CustomByteArray();
					socket.readBytes(fullData,0,_dataLen);
					_pcc.dispatch(_systemId,_moduleId,_functionId,fullData);
					_dataLen=0;
					continue;
				}
				break;
				
			}
		}
		
		public function encode(systemId:int,moduleId:int,fnId:int,data:CustomByteArray):Boolean{
			var netPacketBa:CustomByteArray=new CustomByteArray();
			netPacketBa.writeUnsignedInt(data.length);
			netPacketBa.writeByte(systemId);
			netPacketBa.writeByte(moduleId);
			netPacketBa.writeByte(fnId);
			netPacketBa.writeBytes(data,0,data.length);
			return true;
		}
		
	}
}


