import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class User{
  final String username;
  final String image;

  User(this.username, this.image);
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

  void loadUser(){
    List<User> users = [
      User("Nguyễn Văn Quốc", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXaova-4IVX3jj2DvzkGfkSzhrWWMyzxDwxw&usqp=CAU'),
      User("Dương Thị Huyền Trang", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXaova-4IVX3jj2DvzkGfkSzhrWWMyzxDwxw&usqp=CAU')
    ];
    emit(UserState(users));
  }
}