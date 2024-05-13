import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // new

import '../app_state.dart'; // new
import '../src/authentication.dart'; // new
import '../src/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wish Watch'),
        ),
        body: ListView(
          children: <Widget>[
            const SizedBox(height: 8),
            const IconAndDetail(Icons.calendar_today, 'May 19'),
            const IconAndDetail(Icons.location_city, 'Ankara'),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => AuthFunc(
                  loggedIn: appState.loggedIn,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ),
            const Divider(
              height: 8,
              thickness: 1,
              indent: 8,
              endIndent: 8,
              color: Colors.grey,
            ),
            const Header("What we'll be watching today"),
            const Paragraph(
              'Join us for a day full of movies and fun!',
            ),
          ],
        ),
      ),
    );
  }
}
