import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Center(
          child: TextButton(onPressed:(){

          }, child:const Text("Home",style:TextStyle(fontSize:30,fontWeight:FontWeight.bold,color:Colors.red),),),
        ),);
  }
}
