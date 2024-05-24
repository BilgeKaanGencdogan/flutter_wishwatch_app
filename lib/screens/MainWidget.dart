import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_470project/app_state.dart';
import 'package:flutter_470project/screens/movie_library.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Constants/ProjectStrings.dart';
import '../model/movie.dart';
import '../widgets/ListView_Widget.dart';
import '../widgets/listViewforBest_Widget.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<Movie>? favoriteMovies;
  static String appBarTitle = ProjectStrings.mainWidgetAppbarString;

  static int selectedIndex = 0;
  final widgetOptions = [
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recommended",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 400,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const ListViewWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Best Of 2024",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 400,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const ListViewWidgetForBest(),
          ),
        ],
      ),
    ),
    const MovieLibraryWidget(),
    // Add a placeholder for the search widget
    Container(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(child: Text(appBarTitle)),
      ),
      drawer: Drawer(
        child: Consumer<ApplicationState>(
          builder: (context, appState, _) => ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Profile'),
              ),
              Visibility(
                visible: true,
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Profile'),
                  onTap: () {
                    context.push('/profile');
                  },
                ),
              ),
              Visibility(
                visible: true,
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    context.go('/sign-in');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: ProjectStrings.bottomNavigationBarMain,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: ProjectStrings.bottomNavigationBarLibrary,
          ),    
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // Check the selected index and update the title accordingly
      switch (index) {
        case 0:
          // Set the title to the default value when the search icon is selected
          appBarTitle = ProjectStrings.mainWidgetAppbarString;
          break;
        case 1:
          // Set the title to 'Library' when the library icon is selected
          appBarTitle = ProjectStrings.libraryWidgetAppbarString;
          break;
        case 2:
          // Set the title to the default value when the menu icon is selected
          appBarTitle = ProjectStrings.searchWidgetAppbarString;
          break;
      }
    });
  }
}
