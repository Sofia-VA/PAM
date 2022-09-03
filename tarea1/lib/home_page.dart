import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPersonSelected = false;
  bool isTimerSelected = false;
  bool isTel1Selected = false;
  bool isTel2Selected = false;

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
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content:
                                Text("Únete a un club con otras personas")));
                      isPersonSelected = !isPersonSelected;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.accessibility_new,
                      color: isPersonSelected ? Colors.indigo : Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text(
                                "Cuenta regresiva para el evento: 31 días")));
                      isTimerSelected = !isTimerSelected;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.timer,
                      color: isTimerSelected ? Colors.indigo : Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text("Llama al número 4155550198")));
                      isTel1Selected = !isTel1Selected;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.phone_android,
                      color: isTel1Selected ? Colors.indigo : Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text("Llama al celular 3317865113")));
                      isTel2Selected = !isTel2Selected;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.phone_iphone,
                      color: isTel2Selected ? Colors.indigo : Colors.black,
                    )),
              ]),
            ],
          ),
        ));
  }
}
