import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:flutter_470project/Constants/ProjectStrings.dart';
import 'package:flutter_470project/screens/Login_widget.dart';
import 'package:flutter_470project/screens/MainWidget.dart';
import 'package:flutter_470project/screens/movie_detail.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // new

import 'app_state.dart'; // new

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Card(
                  color: Colors.purple, // Set the card color to purple
                  margin:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Container(
                    width: 500,
                    height: 500, // Set the card width
                    padding: EdgeInsets.all(16.0),
                    child: SignInScreen(
                      actions: [
                        ForgotPasswordAction(((context, email) {
                          final uri = Uri(
                            path: '/sign-in/forgot-password',
                            queryParameters: <String, String?>{
                              'email': email,
                            },
                          );
                          context.push(uri.toString());
                        })),
                        AuthStateChangeAction(((context, state) {
                          final user = switch (state) {
                            SignedIn state => state.user,
                            UserCreated state => state.credential.user,
                            _ => null
                          };
                          if (user == null) {
                            return;
                          }
                          if (state is UserCreated) {
                            user.updateDisplayName(user.email!.split('@')[0]);
                          }
                          if (!user.emailVerified) {
                            user.sendEmailVerification();
                            const snackBar = SnackBar(
                                content: Text(
                                    'Please check your email to verify your email address'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          context.pushReplacement('/main');
                        })),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.uri.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/movieDetail',
      builder: (context, state) {
        final arguments = state.uri.queryParameters;
        return movieDetailsScreen(
          name: arguments['name'] ?? '',
          description: arguments['description'] ?? '',
          director: arguments['director'] ?? '',
          duration: arguments['duration'] ?? '',
          image: arguments['image'] ?? '',
          publishDate: arguments['publishDate'] ?? '',
          category: arguments['category'] ?? '',
          imdb: arguments['imdb'] ?? '',
          stars: arguments['stars'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainWidget(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: ProjectStrings.appTitleString,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routerConfig: _router, // new
    );
  }
}
