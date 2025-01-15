import 'package:flutter/material.dart';

import 'category_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f1147),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 50, left: 5),
              width: 360,
              height: 400,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 44, 23, 96),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(130),
                  bottomRight: Radius.circular(130),
                ),
              ),
              child: Image.asset(
                'assets/images/final_logo.png',
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 80,
          ),
          const Text(
            "Let's Play!",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Play now and Level up",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 120,
          ),
          SizedBox(
              width: 280,
              height: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 48, 3, 250),
                    side: const BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 51, 7, 247),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                       
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                  },
                  child: const Text(
                    'Play Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
