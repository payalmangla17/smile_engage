import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smile_engage/pages/ui/background.dart';
import 'package:smile_engage/routes/ui_routes.dart';


import 'config/constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// size makes the app responsive to various screen sizes
    Size size = MediaQuery.of(context).size;
    var landscapeMode =
        MediaQuery.of(context).orientation == Orientation.landscape;
    Widget child;
    if (landscapeMode) {
      child = Stack(fit: StackFit.expand, children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.0),
              Container(
                  height: size.height * 0.1,
                  width: double.infinity,
                  color: appBlueColor,
                  margin: EdgeInsets.only(top: 10),
                 // alignment: Alignment.topCenter,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Welcome to Smile!",

                        style: TextStyle(

                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/page_viewer/i1.svg",
                height: size.height * 0.55,

                fit: BoxFit.contain,
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                height: size.height * 0.1,
                width: size.width * 0.25,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.features);
                  },
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: appBlueColor,
                      shape: const StadiumBorder()),
                ),
              ),
            ])
      ]);
      return Scaffold(
          body: Center(
        child: child,
      ));
    } else {
      child = Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome to Smile!",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: appBlueColor),
              ),
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
                "assets/icons/page_viewer/i1.svg",
                height: 200,
                width: 200,
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                height: size.height * 0.055,
                width: size.width * 0.5,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.intro);
                  },
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: appBlueColor,
                      shape: StadiumBorder()),
                ),
              ),
            ],
          ),
        ],
      );
      return Scaffold(
          body: Background(
        child: child,
      ));
    }
  }
}
