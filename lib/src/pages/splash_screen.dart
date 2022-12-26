import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_notes/src/cubit/authentication/authentication_cubit.dart';

import 'launching_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LaunchingPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
  create: (context) => AuthenticationCubit(),
  child: Scaffold(
        body:
        Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: BoxDecoration(
                color: Colors.yellow.shade700
            ),
            child:Column(
              children: [
                Image(image: AssetImage('assets/logo.png')),
              ],
            )
        )
    ),
);
  }

  
}
