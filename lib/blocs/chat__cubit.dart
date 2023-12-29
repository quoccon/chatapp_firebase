import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../blocs/chat__state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final Dio dio = Dio();

  Future<void> sendMessage(String message) async {
    try {
      final response = await dio.post('http://10.0.2.2:8000/api-postmessage',data: {'message': message});
      print(response.data);

      if(response.statusCode == 200){
        emit(ChatSuccess());
      }else{
        emit(ChatError("Không thể gửi tin nhắn"));
      }
    } catch (e) {
      print('Lỗi gửi tin nhắn $e');
    }
  }
}
