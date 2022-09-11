import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var serviceCostController = TextEditingController();
  double tip = 0.0;
  int? currentRadio;
  bool roundUp = false;
  var radioGroup = {0: 'Amazing (20%)', 1: 'Good (18%)', 2: 'Okay (15%)'};
  var radioMults = {0: 0.20, 1: 0.18, 2: 0.15};

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
                controller: serviceCostController,
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
            title: Text("Round up tip?"),
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
                  onPressed: () {
                    _tipCalculation();
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                ),
                Text(
                  "Tip amount: \$${tip}",
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  void _tipCalculation() {
    if (serviceCostController.text.isEmpty) _emptyServiceCost();
    if (currentRadio == null) _emptyRadio();
    double serviceCost = double.parse(serviceCostController.text);
    // Según el radio seleccionado, multiplicamos por el porcentaje
    tip = serviceCost * radioMults[currentRadio]!;
    // Checamos si se desea redondear, si no, redondeamos a 2 decimales
    tip =
        (roundUp) ? tip.ceilToDouble() : double.parse((tip).toStringAsFixed(2));
    setState(() {});
  }

  Future<dynamic> _emptyServiceCost() {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              title: Text("Error"),
              content: Text(
                  "Service cost empty!\nPlease type cost to calculate tip."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Got it"))
              ]);
        }));
  }

  Future<dynamic> _emptyRadio() {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              title: Text("Error"),
              content: Text(
                  "No tip percentage selected!\nPlease select to calculate tip."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Got it"))
              ]);
        }));
  }
}
