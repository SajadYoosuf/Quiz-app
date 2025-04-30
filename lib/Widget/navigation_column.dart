import 'package:quiz_app/ViewModel/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Column navigationColumn(BuildContext context, IconData icon, String screenName,
    int index, Widget screen) {
  final navigation = Provider.of<Navigation>(context);
  return Column(
    children: [
      IconButton(
          onPressed: () {
            if (navigation.currentIndex != index) {
              navigation.navigation(index);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen));
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
