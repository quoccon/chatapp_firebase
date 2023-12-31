import 'package:chatapp_firebase/Auth/login_screen.dart';
import 'package:chatapp_firebase/model/userAuth.dart';
import 'package:chatapp_firebase/screen/information_screen.dart';
import 'package:chatapp_firebase/screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp_firebase/screen/chat_body.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userAuth}) : super(key: key);
  final UserAuth userAuth;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkModeEnabled = false;
  String _selectedLanguage = "English"; // Default language

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkModeEnabled = value;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _openQrCode() {
    // String userId = widget.userAuth.infoU?.id ?? "";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QrCodeScreen(userAuth: widget.userAuth)
        )
    );
  }

  void _showLogout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  );

                  Future.delayed(const Duration(seconds: 2),(){
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen())
                    );
                  });
                },
                child: const Text("Logout"),
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text("Chat App"),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => _openDrawer(context),
          child: const Icon(Icons.settings),
        ),
        actions: [

          IconButton(onPressed: () {
            _openQrCode();
          }, icon: const Icon(Icons.qr_code))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXaova-4IVX3jj2DvzkGfkSzhrWWMyzxDwxw&usqp=CAU',
                    width: 100,
                    height: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.userAuth.infoU?.username ?? ""),
                      const Text("username@gmail.com"),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Information"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InformationScreen())
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(height: 1, color: Colors.black),
            ),
            ListTile(
              leading: const Icon(Icons.shield_moon),
              title: const Text("Dark mode"),
              trailing: Switch(
                value: _isDarkModeEnabled,
                onChanged: (value) {
                  _toggleDarkMode(value);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(height: 1, color: Colors.black),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Language"),
              onTap: () {},
              trailing: PopupMenuButton(
                onSelected: (value) {
                  _selectLanguage(value);
                },
                itemBuilder: (context) =>
                [
                  const PopupMenuItem(
                    value: "Vietnamese",
                    child: Text("Vietnamese"),
                  ),
                  const PopupMenuItem(
                    value: "English",
                    child: Text("English"),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(height: 1, color: Colors.black),
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Change password"),
              onTap: () {
                _showLogout(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(height: 1, color: Colors.black),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                _showLogout(context);
              },
            ),
          ],
        ),
      ),
      body: const ChatBody(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserScreen())
            );
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
    );
  }
}

class QrCodeScreen extends StatelessWidget {
  final UserAuth userAuth;

  const QrCodeScreen({Key?key, required this.userAuth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrCode = QrImageView(
      data: userAuth.infoU?.id ?? "",
      version: QrVersions.auto,
      size: 200.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("My QrCode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            qrCode,
            const SizedBox(height: 20.0,),
            Text(userAuth.infoU?.username ?? ""),
          ],
        ),
      ),
    );
  }
}

