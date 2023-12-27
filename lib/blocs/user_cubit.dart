import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

class User{
  final String username;
  final String image;

  User(this.username, this.image);

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      json['username'],
      json['image'],
    );
  }
}

abstract class UserEvent extends Equatable{
  const UserEvent();
}

class LoadUser extends UserEvent{
  @override
  List<Object?> get props => [];
}

class UserState extends Equatable{
  final List<User> users;

  const UserState(this.users);

  @override
  List<Object?> get props => [users];
}

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(const UserState([]));
  final Dio dio = Dio();

  void loadUser(){
    List<User> users = [
      User("Nguyễn Văn Quốc", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXaova-4IVX3jj2DvzkGfkSzhrWWMyzxDwxw&usqp=CAU'),
      User("Dương Thị Huyền Trang", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXaova-4IVX3jj2DvzkGfkSzhrWWMyzxDwxw&usqp=CAU')
    ];
    emit(UserState(users));
  }

  void listU()async{
    try{
      final response = await dio.get('http://10.0.2.2:8000/getAllU');
      print(response.data);

      if(response.statusCode == 200){
        List<dynamic> dataU = response.data;
        List<User> users = dataU.map((userJson) => User.fromJson(userJson)).toList();
        emit(UserState(users));
      }else{
        emit(const UserState([]));
      }
    }catch(e){
      print('Lỗi lấy danh sách $e');
      emit(const UserState([]));
    }
  }
}