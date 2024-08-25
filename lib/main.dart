import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_app/auth/auth.dart';
import 'package:minimal_social_app/auth/login_or_register.dart';
import 'package:minimal_social_app/components/my_drawer.dart';
import 'package:minimal_social_app/firebase_options.dart';
import 'package:minimal_social_app/models/shop.dart';
import 'package:minimal_social_app/onboarding/splash_screen.dart';
import 'package:minimal_social_app/pages/add_device_page.dart';
import 'package:minimal_social_app/pages/alert_page.dart';
import 'package:minimal_social_app/pages/cart_page.dart';
import 'package:minimal_social_app/pages/home_page.dart';
import 'package:minimal_social_app/pages/list_page.dart';
import 'package:minimal_social_app/pages/map_page.dart';
import 'package:minimal_social_app/pages/shop_page.dart';
import 'package:minimal_social_app/pages/users_page.dart';
import 'package:minimal_social_app/theme/dark_mode.dart';
import 'package:minimal_social_app/theme/ligth_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
     create: (context) => Shop(),
     child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page':(context) => const LoginOrRegister(),
        '/map_page':(context) => MapPage(),
        '/list_page':(context) => ListPage(),
        '/alert_page':(context) => AlertPage(),
        '/shop_page':(context) => ShopPage(),
        '/users_page':(context) => UsersPage(),
        '/cart_page':(context) => CartPage(),
        '/auth_page':(context) => AuthPage(),
        '/home_page':(context) => HomePage(),
        '/my_drawer':(context) => MyDrawer(),
        '/add_device_page':(context) => AddDevicePage(),
      },
    );
  }
}