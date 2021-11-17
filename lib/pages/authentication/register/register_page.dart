import 'package:flutter/material.dart';
import 'package:smile_engage/pages/authentication/register/sign_up_body.dart';


class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SignUpBody(),
    );
  }
}