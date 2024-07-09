import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/Utils/AppDataHelpher.dart';

import 'Bloc/splashbloc.dart';
import 'Screen/Home/home.dart';
import 'Screen/SplashScreen/SplashScreen.dart';




MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Template  Project',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppDataHelper.navKey,
      theme: ThemeData(
        primaryColor: buildMaterialColor(Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SplashBloc _splashBloc = SplashBloc();

  @override
  void dispose() {
    _splashBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Sizer(builder: (context, orientation, deviceType) {
      return
        Scaffold(
          body: SafeArea(
            top: true,
            child: StreamBuilder<bool>(
              stream: _splashBloc.splashStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return const home();
                } else {
                  return const Splashscreen();
                }
              },
            ),
          ),
        );
    }

    );

    }

  }

