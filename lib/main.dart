import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introvel_1/location.dart';
import 'package:introvel_1/provider/user_provider.dart';
import 'package:introvel_1/screens/login.dart';
import 'package:introvel_1/screens/test.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xFFEDF2F6)),
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
