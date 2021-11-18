import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_engage/pages/authentication/register/user_type_screen.dart';

class UserTypePage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: UserType(),
    );
  }
}