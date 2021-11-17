import 'package:flutter/material.dart';

import 'package:smile_engage/pages/authentication/components/sign_in_body.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: SignInBody(),
    );
  }
}