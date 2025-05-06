import 'package:quiz_app/ViewModel/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Column buildNavigationColumn(BuildContext context, IconData icon,
    String screenName, int index, String screenRoute) {
  final navigation = Provider.of<Navigation>(context);
  return Column(
    children: [
      IconButton(
          onPressed: () {
            if (navigation.currentIndex != index) {
              navigation.navigation(index);
              Navigator.pushNamed(context, screenRoute);
            }
          },
          icon: Icon(
            icon,
            color: navigation.currentIndex == index
                ? Colors.white
                : Colors.greenAccent,
          )),
      Text(
        screenName,
        style: TextStyle(
            color: navigation.currentIndex == index
                ? Colors.greenAccent
                : Colors.white),
      )
    ],
  );
}
