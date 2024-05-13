import 'package:flutter/material.dart';
import 'package:flutter_470project/widgets/ListViewForLibrary.dart';

class MovieLibraryWidget extends StatelessWidget {
  const MovieLibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Always return false to disable back button functionality
          return false;
        },
        child: const ListViewWidgetForLibrary(),
      ),
    );
  }
}
