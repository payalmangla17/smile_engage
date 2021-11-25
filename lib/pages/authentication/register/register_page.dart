import 'package:flutter/material.dart';
import 'package:smile_engage/config/size_config.dart';
import 'package:smile_engage/pages/authentication/register/sign_up_body.dart';

class RegisterPageArgs{
  final bool isAdmin;

  RegisterPageArgs(this.isAdmin);



}
class RegisterPage extends StatelessWidget {
  final int isAdmin;
  final String orgCode;
  const RegisterPage({Key? key, required this.isAdmin,  required this.orgCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // final routeArgs =
    // ModalRoute.of(context).settings.arguments as Map<String, int>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SignUpBody(isAdmin,orgCode),
    );
  }
}