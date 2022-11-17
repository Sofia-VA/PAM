import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:music_finder/home/home_page.dart';

import '../utils/secrets.dart';

class FormBodyFirebase extends StatelessWidget {
  FormBodyFirebase({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInScreen(
          headerBuilder: (context, constraints, shrinkOffset) {
            return Center(
                child: Text("Welcome to Music Finder",
                    style: TextStyle(fontSize: 20)));
          },
          providerConfigs: [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(clientId: GOOGLE_API_KEY)
          ],
          footerBuilder: (context, action) {
            return Column(
              children: [
                SizedBox(height: 20),
                Text('By signing in, you accept to our terms and conditions'),
              ],
            );
          },
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            })
          ]),
    );
  }
}
