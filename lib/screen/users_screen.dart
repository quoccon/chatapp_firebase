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
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        // ],
      ),
      body: BlocProvider(
          create: (context) => UserCubit(),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SearchUser(),
              ),
              Expanded(child: UserBody())
            ],
          )),
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

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  TextEditingController searchControll = TextEditingController();
  bool showIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchControll.addListener(() {
      setState(() {
       showIcon = searchControll.text.isNotEmpty;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: searchControll,
          decoration: InputDecoration(
            hintText: 'Search here...',
            contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            border: InputBorder.none,
            suffixIcon: showIcon ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: (){
                searchControll.clear();
              },
            ) : null,
          ),
          onChanged: (query) {
            // Xử lý khi giá trị tìm kiếm thay đổi
            context.read<UserCubit>().searchU(query);
          },
        ),
      ),
    );
  }
}



