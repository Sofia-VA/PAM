import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentRadio;
  bool roundUp = false;
  var radioGroup = {0: 'Amazing (20%)', 1: 'Good (18%)', 2: 'Okay (15%)'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.store),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Cost of Service"),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Text("How was the service?"),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
            child: Column(
              children: radioGroupGenerator(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.north_east),
            title: Text("Round up tip"),
            trailing: Switch(
                value: roundUp,
                onChanged: (bool selected) {
                  roundUp = selected;
                  setState(() {});
                }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MaterialButton(
                  child: Text("CALCULATE"),
                  onPressed: () {},
                  color: Colors.green,
                  textColor: Colors.white,
                ),
                Text(
                  "Tip amount: \$20.00",
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _tipCalculation() {
    // TODO: completar
  }

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => ListTile(
            leading: Radio(
              value: radioElement.key,
              groupValue: currentRadio,
              onChanged: (int? selected) {
                currentRadio = selected;
                setState(() {});
              },
            ),
            title: Text("${radioElement.value}"),
          ),
        )
        .toList();
  }
}
