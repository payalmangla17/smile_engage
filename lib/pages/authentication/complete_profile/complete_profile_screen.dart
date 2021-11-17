import 'package:flutter/material.dart';

import 'package:smile_engage/pages/authentication/complete_profile/profile_body.dart';



class CompleteProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ProfileBody(),
    );
  }
}