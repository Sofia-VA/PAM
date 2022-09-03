import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mc Flutter'),
        ),
        body: Column(
          children: [
            Row(children: [
              Icon(Icons.account_circle, size: 42),
              Column(children: [
                Text("Flutter McFlutter", style: TextStyle(fontSize: 20)),
                Text("Experienced App Developer")
              ])
            ]),
            Row(children: [
              Text("123 Main Street"),
              Text("(415) 555-0198"),
            ]),
            Row(children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.accessibility_new)),
              IconButton(onPressed: () {}, icon: Icon(Icons.timer)),
              IconButton(onPressed: () {}, icon: Icon(Icons.phone_android)),
              IconButton(onPressed: () {}, icon: Icon(Icons.phone_iphone)),
            ])
          ],
        ));
  }
}
