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
        body: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.account_circle, size: 42),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Flutter McFlutter", style: TextStyle(fontSize: 20)),
                  Text("Experienced App Developer")
                ])
              ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("123 Main Street"),
                Text("(415) 555-0198"),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.accessibility_new)),
                IconButton(onPressed: () {}, icon: Icon(Icons.timer)),
                IconButton(onPressed: () {}, icon: Icon(Icons.phone_android)),
                IconButton(onPressed: () {}, icon: Icon(Icons.phone_iphone)),
              ]),
            ],
          ),
        ));
  }
}
