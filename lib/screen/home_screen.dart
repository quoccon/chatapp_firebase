import 'package:flutter/material.dart';
import 'package:chatapp_firebase/screen/chat_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Username"),
                      Text("username@gmail.com"),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(height: 1, color: Colors.black),
            ),
            ListTile(
              leading: const Icon(Icons.shield_moon),
              title: const Text("Light/Dark mode"),
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
                itemBuilder: (context) => [
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
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: const ChatBody(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
    );
  }
}
