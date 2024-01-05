import 'package:chatapp_firebase/blocs/auth_cubit.dart';
import 'package:chatapp_firebase/blocs/chat__cubit.dart';
import 'package:flutter/material.dart';
import 'package:chatapp_firebase/blocs/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatCubit chatCubit;
  late AuthCubit authCubit;

  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.phone),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.video_camera_front_sharp),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: const [
                MessageWidget(isMe: true,message: "Hello!",),
                MessageWidget(isMe: false,message: "Oke đmm!",),
                MessageWidget(isMe: true,message: "Hello!",),
                MessageWidget(isMe: false,message: "Oke !",),
                MessageWidget(isMe: true,message: "Hello!",),
                MessageWidget(isMe: false,message: "Oke đmm!",),
                MessageWidget(isMe: true,message: "Hello!",),
                MessageWidget(isMe: false,message: "Oke đmm!",),
                MessageWidget(isMe: true,message: "Hello!",),
                MessageWidget(isMe: false,message: "Oke đmm!",),
                MessageWidget(isMe: true,message: "Hello!",),
                MessageWidget(isMe: false,message: "Oke đmm!",),
              ],
            ),
          ),
           InputField(user: widget.user),
        ],
      ),
    );

  }

}

class MessageWidget extends StatelessWidget {

  final bool isMe;
  final String message;

  const MessageWidget({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          child: Text(
            message,style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
        ),
      );
  }
}

class InputField extends StatefulWidget {

  final User user;
  const InputField({super.key, required this.user});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController messController = TextEditingController();
  bool isTextNotEmpty = false;
  // final String senderId = widget.user.id;


  @override
  void initState() {
    super.initState();
    messController.addListener(updateIsTextNotEmpty);
  }

  void updateIsTextNotEmpty(){
    setState(() {
      isTextNotEmpty = messController.text.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              minLines: 1,
              controller: messController,
              decoration: InputDecoration(
                  hintText: "Type a message...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0
                  )
              ),
            ),
          ),
          IconButton(
            onPressed:isTextNotEmpty ? (){
              print('User : ${widget.user.id}');

                    messController.clear();
            } : null,
            icon: const Icon(Icons.send),
            color: isTextNotEmpty? Colors.blue : Colors.grey,
          )
        ],
      ),
    );
  }
}
