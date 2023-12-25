import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Information"),
      ),
      body:  Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXaova-4IVX3jj2DvzkGfkSzhrWWMyzxDwxw&usqp=CAU",width: 150,height: 150,),
            const SizedBox(height: 20,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Username : ",style: TextStyle(fontSize: 18),),
                Text("Nguyễn Văn Quốc",style: TextStyle(fontSize: 18),),
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Email : ",style: TextStyle(fontSize: 18),),
                Text("qn329218@gmail.com",style: TextStyle(fontSize: 18),),
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Phone : ",style: TextStyle(fontSize: 18),),
                Text("0999999999 ",style: TextStyle(fontSize: 18),),
              ],
            ),
          ],
        ),
      )
    );
  }
}
