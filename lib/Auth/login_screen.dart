import 'package:chatapp_firebase/Auth/register_screen.dart';
import 'package:chatapp_firebase/blocs/auth_cubit.dart';
import 'package:chatapp_firebase/model/userAuth.dart';
import 'package:chatapp_firebase/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const LoginFrom(),
    );
  }
}

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showError = false;
  late AuthCubit authCubit;
  late UserAuth userAuth;

  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "images/conversation.png",
            width: 150,
            height: 150,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Enter your username',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Enter your password',
                ),
              ),
            ),
          ),
          Visibility(
            visible: showError &&
                (usernameController.text.isEmpty ||
                    passwordController.text.isEmpty),
            child: Text(
              (authCubit.state is AuthField)
                  ? (authCubit.state as AuthField).error
                  : "",
              style: const TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SizedBox(
              width: 400,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    showError = true;
                  });
                  authCubit
                      .login(usernameController.text, passwordController.text,
                          (userAuth) async {
                    if(!(authCubit.state is AuthField)){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  HomeScreen(userAuth: userAuth,)));
                    }
                  });
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              children: [
                const Text(
                  "Do you haven't account?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            // Sử dụng Expanded để đảm bảo container chiếm phần còn lại của màn hình
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // Đặt mainAxisAlignment để các container xuống dưới cùng
              children: [
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "images/facebook.png",
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Text(
                        "Login with facebook",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "images/google.png",
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Text(
                        "Login with google",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
