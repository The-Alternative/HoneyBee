import '../Welcome/HomeWelcom.dart';
import '../main.dart';
import '../services/sign_in.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return Column(
      children: [
        OutlineButton(
          splashColor: Colors.grey,
          onPressed: () {
            signInWithGoogle().whenComplete(() async {
              // String x = await signInWithGoogle();
              // if(!(x == "false")){

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeWelcom(true);
                  },
                ),
              );
              // }else{
              //   _showMaterialDialog();
              // }

            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 15)),
        OutlineButton(
          splashColor: Colors.grey,
          onPressed: () {

              // String x = await signInWithGoogle();
              // if(!(x == "false")){

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeWelcom(false);
                  },
                ),
              );
              // }else{
              //   _showMaterialDialog();
              // }


          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'المتابعة بدون تسجيل دخول',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("الرجاء اختيار حساب غوغل لتسجيل الدخول"),
          content: new Text(""),
          actions: <Widget>[
            FlatButton(
              child: Text('حسنا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
}


