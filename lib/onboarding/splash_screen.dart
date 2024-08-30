import 'package:flutter/material.dart';
import 'package:minimal_social_app/auth/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthPage();
  }

  _navigateToAuthPage() async{
    await Future.delayed(const Duration(seconds: 5),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 122, 208),
      body: Container(
        child: Center(
          child: Image.asset(
            'assets/logo/Track it.png'
          ),
        ),
      ),
    );
  }
}