import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class ScreenLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset("images/summit-tracks-live-2.png",width: 500, height: 500,),
          ),
          Expanded(
            flex: 1,
              child: Container(
                padding: EdgeInsets.all(100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      child: Text('ENTER'),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Constants.Screen.tracksList);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                      ),
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
