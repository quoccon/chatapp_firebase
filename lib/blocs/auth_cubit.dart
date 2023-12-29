import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import '../model/userAuth.dart';


abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitIal extends AuthState {}

class AuthSuccess extends AuthState {
  final UserAuth user;
  AuthSuccess({required this.user});

  @override
  List<Object?> get props => [];
}

class AuthField extends AuthState {
  final String error;

  AuthField({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthCubit extends Cubit<AuthState> {
  final Dio dio = Dio();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitIal());

  Future<void> register(String usernameController, String passwordController,
      String confirmPassword, Function() callback) async {
    final username = usernameController;
    final pass = passwordController;

    if (username.isEmpty || pass.isEmpty || confirmPassword.isEmpty) {
      emit(AuthField(error: "Vui lòng nhập đầy đủ thông tin"));
      return;
    }
    if (pass != confirmPassword) {
      emit(AuthField(error: "Mật khẩu nhập không trùng khớp"));
      return;
    }
    try {
      final response = await dio.post(
        'http://10.0.2.2:8000/reg-api',
        data: {
          'username': username,
          'password': pass,
          'confirmpassword': confirmPassword
        },
      );
      // jsonEncode(response);
      print(response);

      if (response.statusCode == 200) {
        final userId = response.data['infoU']['_id'];
        UserAuth auth = UserAuth.fromJson(response.data);
        emit(AuthSuccess(user: auth));
        print('user == ${username.isEmpty}');
        print('pass == ${pass.isEmpty}');
        callback.call();
      } else {
        emit(AuthField(error: "Tài khoản đã tồn tại"));
      }
    } catch (e) {
      print('Lỗi : $e');
      emit(AuthField(error: "Đã có lỗi khi xử lí yêu cầu của bạn $e"));
    }
  }

  Future<void> login(String usernameController, String passwordController,
      Function(String) callback) async {
    final username = usernameController;
    final password = passwordController;

    if (username.isEmpty || password.isEmpty) {
      emit(AuthField(error: "Vui lòng nhập đầy đủ thông tin"));
      return;
    }

    try {
      final response = await dio.post(
        'http://10.0.2.2:8000/login-api',
        data: {'username': username, 'password': password},
      );
      print(response);

      if (response.statusCode == 200) {
        // final userId = response.data['infoU']['_id'];
        UserAuth userAuth = UserAuth.fromJson(response.data);
        emit(AuthSuccess(user: userAuth));
        // connectToSocket(userId);
        callback.call(userAuth as String);
      }
    } catch (e) {
      print('Lỗi đăng nhập $e');
    }

  }


  Future<void> getUbyId(String currentUId) async{
    try{
      final response = await dio.get('http://10.0.2.2:8000/getUbyId/$currentUId');
      if(response.statusCode == 200) {
        final userData = response.data;
        print('UserData : $userData');
      }else{
        emit(AuthField(error: "Không thể lấy thông tin người dùng"));
      }
    }catch(e){
      print('Lỗi lấy thông tin $e');
      emit(AuthField(error: "Có lỗi khi xử lí yêu cầu của bạn"));
    }
  }
}
