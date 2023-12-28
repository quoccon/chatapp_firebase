import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

void connectToSocket(String userId){
  socket = IO.io('http://10.0.2.2:8000',<String, dynamic>{
    'transports' : ['websocket'],
    'autoConnect':true,
  });

  socket!.onConnect((_) {
    print('Kết nối IO thành công');
    socket!.emit('user connect',userId);
  });

  socket!.on('new_message', (data) {
    print('Nhận tin nhắn mới $data');
  });

  socket!.onDisconnect((_) => {
  print('User disconnet'),
  });
}


void sendMessage(String message){
  if(socket != null && socket!.connected){
    socket!.emit("send_message",{'message':message});
  }else{
    print('Lỗi gửi tin nhắn');
  }
}
