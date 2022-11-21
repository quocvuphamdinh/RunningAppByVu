import 'package:flutter/material.dart';
import 'package:running_app_flutter/presentation/widgets.dart';

import '../utils/strings.dart';

class VuHomePage extends StatelessWidget {
  const VuHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              "assets/images/runner.png",
              height: 200,
              width: 200,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(RunningAppStrings.titleApp,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SecularOne")),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              RunningAppStrings.subTitleApp,
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SecularOne"),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 40),
              child: buttonPrimary(
                  context, RunningAppStrings.textCreateAccount, () {})),
          Container(
              margin: const EdgeInsets.only(top: 10),
              child:
                  buttonPrimary(context, RunningAppStrings.textSignIn, () {})),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  RunningAppStrings.subTitleApp2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontFamily: "SecularOne"),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
