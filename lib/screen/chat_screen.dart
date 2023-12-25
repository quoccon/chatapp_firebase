import 'package:flutter/material.dart';
import 'package:chatapp_firebase/blocs/user_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("jbdfkabjdkb"),
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
                MessageWidget(isMe: false,message: "Oke đmm!",)
              ],
            ),
          ),
          const InputField()
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
        child: Text(
          message,style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController messController = TextEditingController();
  bool isTextNotEmpty = false;


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
              // print('Message sent ${messController.text}');
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
