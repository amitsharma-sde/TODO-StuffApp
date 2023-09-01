import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_stuff/pages/home_screen.dart';
import 'package:todo_stuff/utils/constant.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("mybox");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((value) => runApp(const ToDoStuffApp()));

  runApp(const ToDoStuffApp());
}

class ToDoStuffApp extends StatelessWidget {
  const ToDoStuffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          title: 'ToDo-Stuff',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: kBlack,
          width: 1.sw,
          height: 1.sh,
          child: Image.asset("assets/icon/logo.png"),
        ),
      ),
    );
  }
}
