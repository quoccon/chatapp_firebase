import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}

class AuthInitIal extends AuthState{}

class AuthSuccess extends AuthState{
  final User user;

  AuthSuccess({required this.user});
}

class AuthField extends AuthState{
  final String error;

  AuthField({required this.error});
}

class AuthCubit extends Cubit<AuthState>{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() :super(AuthInitIal());

  Future<void> register(String email,String password) async {
      try{
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        emit(AuthSuccess(user: userCredential.user!));
      }catch(e){
        print('Lỗi : $e');
        emit(AuthField(error: e.toString()));
    }
  }
}
