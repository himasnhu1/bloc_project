import 'package:flutter/material.dart';
import '../../services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SplashServices _splashServices = SplashServices();
  @override
  void initState() {
    _splashServices.isLogin(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: Center(
            child: Column(crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Center(
                  child: const Text("Splash Screen",style:TextStyle(fontSize:30,fontWeight:FontWeight.bold,color:Colors.red),),
                ),
              ],
            ),
          ),
        ),);
  }
}
