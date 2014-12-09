package z_spark.net
{
	import core.events.Event;
	import core.events.EventDispatcher;
	import core.events.IOErrorEvent;
	import core.events.ProgressEvent;
	import core.net.Socket;
	
	import custom.simulator.SimServer;
	
	import z_spark.StringDef;
	
	
	CONFIG::STRUCTURE_DEBUG{
		import z_spark.debug.Debugger;
	};

	public class Connetion extends EventDispatcher
	{
		private var _maxTryTimes:int=3;
		private var _tryTimes:int;
		private var _serverHost:String;
		private var _serverPort:uint;
		private var _socket:Socket;
		
		private var _packetParser:IPacketParser;
		
		
		public function Connetion()
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::Connetion()");
			};
			_tryTimes=0;
			
			CONFIG::SIMULATOR{
				_socket=SimServer.simSocket;
				initSocket(_socket);
				return ;
			};
			_socket=new Socket();
			initSocket(_socket);
		}
		
		public function set maxTryTimes(value:int):void
		{
			_maxTryTimes = value;
		}

		public function set packetParser(value:IPacketParser):void{
			_packetParser=value;
		}
		
		public function get packetParser():IPacketParser{
			return _packetParser;
		}
		
		/**
		 * socket连接在线服务器 
		 * @param host
		 * @param port
		 * 
		 */
		public function connect(host:String, port:int):void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::connect(String,int)",host,port);
			};
			_serverHost = host;
			_serverPort = port;
			
			_socket.connect(host,port);
		}
		
		public function reConnect():void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::reConnect(),tryTimes=",_tryTimes);
			};
			
			_tryTimes++
			if(_tryTimes>=_maxTryTimes){
				CONFIG::STRUCTURE_DEBUG{
					Debugger.info("Connetion::reConnect(),"+StringDef.MAX_TIME_TRIED);
				};
			}else{
			
				if(_socket)destorySocket(_socket);
				_socket=new Socket();
				initSocket(_socket);
				_socket.connect(_serverHost,_serverPort);
			}
		}
		
		private function destorySocket(socket:Socket):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::destorySocket(Socket)");
			};
			socket.removeEventListener(Event.CONNECT, onConnetHandler);
			socket.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);   
			socket.removeEventListener(Event.CLOSE, onCloseHandler);
			socket=null;
		}
		
		private function initSocket(socket:Socket):void{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::initSocket(Socket)");
			};
			socket.addEventListener(Event.CONNECT, onConnetHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			socket.addEventListener(Event.CLOSE, onCloseHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);   
		}
		
		private function onSocketDataHandler(evt:ProgressEvent):void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::onSocketDataHandler(ProgressEvent)");
			};
			
			_packetParser.decode(_socket);
		}
		
		
		private function onIOErrorHandler(evt:IOErrorEvent):void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::onIOErrorHandler(IOErrorEvent)");
			};
			dispatchEvent(new ConnetionEvent(ConnetionEvent.ERROR));
		}
		
		private function onCloseHandler(evt:Event):void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::onCloseHandler(Event)");
			};
			dispatchEvent(new ConnetionEvent(ConnetionEvent.CLOSE));
		}
		
		
		private function onConnetHandler(evt:Event):void
		{
			CONFIG::STRUCTURE_DEBUG{
				Debugger.info("Connetion::onConnetHandler(Event)");
			};
			_tryTimes=0;
			dispatchEvent(new ConnetionEvent(ConnetionEvent.CONNED));
		}
	}
}