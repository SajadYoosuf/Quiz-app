import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'View/home_page.dart';
import 'ViewModel/quiz_page_functions.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setPreferredOrientations( 
    [DeviceOrientation.portraitUp]); 
  runApp( const  Myapp(),
  );
}

class Myapp extends StatelessWidget {

  const Myapp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => QuizPageFunctions(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
