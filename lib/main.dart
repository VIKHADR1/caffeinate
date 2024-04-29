import 'package:caffeinate/firebase_options.dart';
import 'package:caffeinate/pages/admin.dart';
import 'package:caffeinate/pages/bottomnav.dart';
import 'package:caffeinate/pages/home.dart';
import 'package:caffeinate/pages/login.dart';
import 'package:caffeinate/pages/order.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/bottomnav': (context) => const BottomNav(),
        '/adminpanel': (context) => const AdminPage(),
      },
    );
  }
}
