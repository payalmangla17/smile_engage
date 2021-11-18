import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:smile_engage/routes/app_routes.dart';
import 'package:smile_engage/routes/ui_routes.dart';

import 'welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({Key? key}) : super(key: key);
  // uncomment it for splash screen
  // @override
  // _MyAppState createState() => _MyAppState();
  // comment it and make state to statefulwidget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Screen',
      onGenerateRoute: AppRoutes.generateRoute,

      //initialRoute: Routes.welcome_screen,
        initialRoute: Routes.intro,
      //home: WelcomeScreen(),
    );
  }
}

// class _MyAppState extends State<MyApp>
//     with SplashScreenStateMixin, TickerProviderStateMixin {
//   static final navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         if (animationCompleted) buildAnimation(),
//       ],
//     );
//   }
// }
