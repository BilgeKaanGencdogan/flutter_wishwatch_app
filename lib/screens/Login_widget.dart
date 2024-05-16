import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider; // new
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
          title: const Text(
            'Wish Watch',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurple,
                    Colors.purple,
                    Colors.pinkAccent,
                  ],
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.deepPurple,
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'May 19',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Icon(
                              Icons.location_city,
                              color: Colors.deepPurple,
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Ankara',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const Divider(
                              height: 40,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Consumer<ApplicationState>(
                              builder: (context, appState, _) => AuthFunc(
                                loggedIn: appState.loggedIn,
                                signOut: () {
                                  FirebaseAuth.instance.signOut();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Header("What we'll be watching today"),
                    const Paragraph(
                      'Join us for a day full of movies and fun!',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
