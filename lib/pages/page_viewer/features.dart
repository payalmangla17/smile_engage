import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smile_engage/config/constants.dart';
import 'package:smile_engage/routes/ui_routes.dart';


import 'items.dart';

class Features extends StatefulWidget {
  @override
  _Features createState() => _Features();
}

class _Features extends State<Features> {
  List<Widget> indicator() =>
      List<Widget>.generate(
          slides.length,
              (index) =>
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                height: 10.0,
                width: 10.0,
                decoration: BoxDecoration(
                    color: currentPage.round() == index
                        ? const Color(0xFF2E7CF8)
                        : const Color(0xFF2E7CF8).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0)),

              )
      );

  double currentPage = 0.0;
  final _pageViewController = PageController();

  List<Widget> slides = items
      .map((item) =>
      Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item['description'],
                      style: TextStyle(
                          color: appBlueColor,
                          letterSpacing: 1.2,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                    
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.5),
              ),
              SvgPicture.asset(
                item['image'],
                fit: BoxFit.fitWidth,
                width: 220.0,
                alignment: Alignment.topCenter,
              ),

            ],

          )))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageViewController,
            itemCount: slides.length,
            itemBuilder: (BuildContext context, int index) {
              _pageViewController.addListener(() {
                setState(() {
                  currentPage = _pageViewController.page!;
                  if (index == slides.length - 1) {
                   // Navigator.pushNamed(context, Routes.features);
                    slides[index]=buildLastPage(items,index, MediaQuery.of(context).size);
                  }
                  //    _pageViewController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                );
              });
              return slides[index];
            },
          ),

          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 70.0),
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicator(),


                ),
              ))
        ],
      ),
    );
  }

  Widget buildLastPage(List items, int index, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  items[index]['description'],
                  style: TextStyle(
                      color: appBlueColor,
                      letterSpacing: 1.2,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.5),
          ),
          SvgPicture.asset(
            items[index]['image'],
            fit: BoxFit.fitWidth,
            width: 220.0,
            alignment: Alignment.topCenter,
          ),
          Container(
            height: size.height * 0.055,
            width: size.width * 0.5,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.features);
              },
              child: Text(
                "Next",
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

      ));

    
  }

}
