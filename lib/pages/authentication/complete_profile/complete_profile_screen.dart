import 'package:flutter/material.dart';

import 'package:smile_engage/pages/authentication/complete_profile/profile_body.dart';
import 'package:smile_engage/pages/models/register_model.dart';



class CompleteProfileScreen extends StatelessWidget {
  final RegisterModel newUser;

  const CompleteProfileScreen({Key? key, required this.newUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ProfileBody(newUser),
    );
  }
}