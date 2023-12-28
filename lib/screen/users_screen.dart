import 'package:chatapp_firebase/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import '../blocs/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Danh sách người dùng"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocProvider(
        create: (context) => UserCubit(),
        child: const UserBody(),
      ),
    );
  }
}

class UserBody extends StatelessWidget {
  const UserBody({Key? key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().listU();
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.users.isEmpty
            ? const Center(
                child: Text("Danh sách người dùng trống"),
              )
            : ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.image),
                        ),
                        title: Text(user.username),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                        user: user,
                                      )));
                        },
                      ),
                    ],
                  );
                },
              );
      },
    );
  }
}
