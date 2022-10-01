import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 50),
          Center(
              child:
                  Text("Toque para escuchar", style: TextStyle(fontSize: 20))),
          SizedBox(height: 50),
          Expanded(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              AvatarGlow(
                glowColor: Colors.deepPurpleAccent,
                endRadius: 170,
                animate: true,
                child: Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        onTap: () {},
                        splashColor: Color.fromARGB(109, 54, 0, 96),
                        child: Ink.image(
                            fit: BoxFit.scaleDown,
                            height: 200,
                            image: AssetImage(
                                'assets/images/sound_waves_round.png')))), // image
                // circleAvatar
                // ClipRRect
                // Material
              ),
            ]),
          ), // avatarglow
          MaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            child: CircleAvatar(
              child: Icon(Icons.favorite, color: Colors.black),
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 230),
        ],
      )),
    );
  }
}
