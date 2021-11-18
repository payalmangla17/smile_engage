import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_engage/config/constants.dart';
import 'package:smile_engage/config/size_config.dart';
import 'package:smile_engage/pages/authentication/register/register_page.dart';
import 'package:smile_engage/pages/models/radio_group.dart';
import 'package:smile_engage/pages/ui/default_button.dart';
import 'package:smile_engage/routes/ui_routes.dart';

class UserType extends StatefulWidget{
  @override
  _userTypeState createState()=> _userTypeState();

}

class _userTypeState extends State<UserType>{
  int _radioVal=0;
  List<RadioItem> radioList=[
    RadioItem(id: 0, value: "Admin"),
    RadioItem(id: 1, value: "Member")
  ];
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop:_onWillPop,
        child: Column(

          children: <Widget>[
            Padding(
                padding : EdgeInsets.all(14.0),
                child: Text("Registering as: ", style: TextStyle(fontSize: 23))
            ),

            Expanded(
                child: Container(
                  height: 350.0,
                  child: Column(
                    children:
                    radioList.map((data) => RadioListTile(
                      title: Text("${data.value}"),
                      groupValue: _radioVal,
                      activeColor: appBlueColor,
                      value: data.id,
                      onChanged: (val) {
                        setState(() {
                         // radioItem = data.value ;
                          _radioVal = data.id;
                        });
                      },


                    )).toList(),
                  ),
                )),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              text: "Continue",
              press: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterPage(isAdmin: _radioVal)));//Navigator.pushNamed(context, MaterialPageRoute(builder: (context)=> RegisterPage(isAdmin: _radioVal)));
                  //  _formKey.currentState!.save();
                  // if all are valid then go to success screen
                  // Navigator.pushNamed(context, Routes.complete_profile_screen);
                }

            ),

          ],
        ));
  }

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
    )) ?? false;
  }
}