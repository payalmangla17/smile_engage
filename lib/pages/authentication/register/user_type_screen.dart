import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:smile_engage/config/constants.dart';
import 'package:smile_engage/config/size_config.dart';
import 'package:smile_engage/pages/authentication/register/register_page.dart';
import 'package:smile_engage/pages/models/radio_group.dart';
import 'package:smile_engage/pages/ui/default_button.dart';
import 'package:smile_engage/routes/ui_routes.dart';
import 'package:uuid/uuid.dart';

class UserType extends StatefulWidget {
  @override
  _userTypeState createState() => _userTypeState();
}

class _userTypeState extends State<UserType> {
  int _radioVal = -1;
  final TextEditingController _controller = TextEditingController();
  List<RadioItem> radioList = [
    RadioItem(id: 0, value: "Admin"),
    RadioItem(id: 1, value: "Member")
  ];
  String code = "";
  createCode() {
    setState(() {
      code = randomCode(8);
    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(14.0),
                child:
                    Text("Registering as: ", style: TextStyle(fontSize: 23))),
            Expanded(
                child: Container(
              height: 250.0,
              child: Column(
                children: radioList
                    .map((data) => RadioListTile(
                          title: Text("${data.value}"),
                          groupValue: _radioVal,
                          activeColor: appBlueColor,
                          value: data.id,
                          onChanged: (val) {
                            setState(() {
                              // radioItem = data.value ;
                              _radioVal = data.id;
                              if (_radioVal == 0) createCode();
                            });
                          },
                        ))
                    .toList(),
              ),
            )),
            SizedBox(height: getProportionateScreenHeight(15)),
            //Padding(padding: EdgeInsets.all(10.0)),
            Visibility(
                visible: (_radioVal == 0),
                child: Container(
                    child: Column(children: [

                  Text("Your Organisation Code: ${code}",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2,),
                  const Text(
                    "Disclaimer: Please provide this code to all the members who want to register in your organisation.",
                    style: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                      SizedBox(height:15 )
                ]))),
            Visibility(
                visible: (_radioVal == 1),
                child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Container(
                          // decoration: new BoxDecoration(
                          //   shape: BoxShape.rectangle,
                          //   border: new Border.all(
                          //     color: Colors.black,
                          //     width: 2.0,
                          //   ),
                          // ),
                          child: PinCodeTextField(
                        controller: _controller,
                        autoDisposeControllers: false,
                        length: 8,
                        obscureText: true,
                        obscuringCharacter: '*',
                        // obscuringWidget: FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        validator: (v) {
                          if (v!.length < 8) {
                            return "Please enter correct code!";
                          } else {
                            return "";
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 40,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (String value) {
                          print(value);
                          setState(() {
                            code = value;
                          });
                        },
                        onCompleted: (v) {
                          print("Completed");
                        },
                        appContext: context,
                      )),
                    ))),
            DefaultButton(

                text: "Continue",
                press: ()  async {
                  print(_radioVal);
                  bool f=true;
                  if(_radioVal==1) {
                    print("code: $code");
                    // DatabaseReference ref=
                    DatabaseReference ref = await FirebaseDatabase.instance
                        .reference()
                        .child("organisation").child(code);
                    //if(ref.child(code).child("users").) print("success");
                         //.then((DataSnapshot snapshot){
                    ref.once().then((DataSnapshot snap){
                    print(snap.value);
                    f=snap.exists;
                    print(f);
                    if (!snap.exists) {

                       showDialog(
                        context: context,
                        builder: (context) =>
                        new AlertDialog(
                          title: new Text('Wrong Organisation Code.'),
                          content: new Text('Organisation doesn\'t exist'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                              child: new Text('OK'),
                            ),

                          ],
                        ),
                      );

                     // print("Item doesn't exist in the db");
                    }else{
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              RegisterPage(isAdmin: _radioVal, orgCode: code)));
                    }
                  }
    );}else

                 {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RegisterPage(isAdmin: _radioVal, orgCode: code)));
                  } //Navigator.pushNamed(context, MaterialPageRoute(builder: (context)=> RegisterPage(isAdmin: _radioVal)));
                   //  _formKey.currentState!.save();
                  // if all are valid then go to success screen
                  // Navigator.pushNamed(context, Routes.complete_profile_screen);
                }),
          ],
        ));
  }

  // String? get _errorText {
  //   // at any time, we can get the text from _controller.value.text
  //   final text = _controller.value.text;
  //   // Note: you can do your own custom validation here
  //   // Move this logic this outside the widget for more testable code
  //   if (text.isEmpty) {
  //     return 'Can\'t be empty';
  //   }
  //   if (text.length < 8) {
  //     return 'Too short';
  //   }
  //   // return null if the text is valid
  //   return null;
  // }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  String randomCode(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var random = Random.secure();

    String code = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(random.nextInt(_chars.length))));
    return code;
  }
}
