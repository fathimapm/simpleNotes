import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_notes/src/pages/launching_page.dart';
import 'package:my_simple_notes/src/pages/splash_screen.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

