import 'package:chatapp_firebase/Auth/register_screen.dart';
import 'package:chatapp_firebase/screen/home_screen.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Enter your password',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
           padding: const EdgeInsets.only(left: 30,right: 30),
           child:  SizedBox(
             width: 400,
             child: TextButton(
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(Colors.black),
               ),
               onPressed: () {
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(builder: (context) => const HomeScreen()),
                 );
               },
               child: const Text(
                 "Login",
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
               ),
             ),
           ),
         ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Row(
              children: [
                const Text("Do you haven't account?",style:TextStyle(fontSize: 16),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text("SignUp",style:TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold),),
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
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white),
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
                            fontSize: 20,),
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
      ),
    );
  }
}
