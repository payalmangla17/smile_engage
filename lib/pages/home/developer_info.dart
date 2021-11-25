import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_engage/config/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBlueColor,
          title: const Text(
            'Payal Mangla',
            style: TextStyle(
                fontWeight: FontWeight.bold,

                // color: StreamChatTheme.of(context).colorTheme.textHighEmphasis,
                fontSize: 16.0),
          ),
          //leading: const StreamBackButton(),
        ),
        body: Center(

            child:
                Padding(padding: EdgeInsets.all(10),
                child: Column(//mainAxisAlignment: MainAxisAlignment.start,
                   children: <
                    Widget>[
          //  Padding(padding: EdgeInsets.all(12.0)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.2,
              child: const Image(image: AssetImage("assets/images/payal.png")),
            ),
          ),
          Align(
            alignment: Alignment.center,

            child: const Text(
                "Hello,\nI am Payal Mangla. I love to develop mobile applications and work on backend services.\n",
              style: TextStyle(
                  fontSize: 20
              ),),
          ),
          Container(
              height:50,
              child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Connect me at: ",
                          style: TextStyle(
                          fontSize: 20
                          ),
                  ),
                  InkWell(
                    onTap: () => _launchURL("https://github.com/payalmangla17"),
                    child: Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Image.asset(
                        'assets/images/github.png',
                        fit: BoxFit.cover, // this is the solution for border
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        _launchURL("https://www.linkedin.com/in/payal-mangla/"),
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Image.asset(
                        'assets/images/linkedin.png',
                        fit: BoxFit.cover, // this is the solution for border
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                  ),
                ],
              )))
        ]))));
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
