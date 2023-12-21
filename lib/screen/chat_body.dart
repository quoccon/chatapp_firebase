import 'package:chatapp_firebase/blocs/chat_cubit.dart';
import 'package:chatapp_firebase/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import Cubit

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..loadUser(),
      child: Scaffold(
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            // Hiển thị danh sách người dùng
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                  ),
                  title: Text(user.username),

                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                    );
                  },

                );
              },
            );
          },
        ),
      ),
    );
  }
}
