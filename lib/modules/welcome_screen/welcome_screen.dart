import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/sign_up_screen/sign_up_screen.dart';
import 'package:shop_app/shared/components.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                  child: Image(
              image: AssetImage('assets/images/login.png'),
            ),
                )),
            Text(
              'Welcome to our shop app',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: MaterialButton(
                onPressed: () {
                  navigateAndFinish(context, LoginScreen());
                },
                child: Text('LOGIN'),
                height: 50,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: MaterialButton(
                onPressed: () {
                  navigateAndFinish(context, SignUpScreen());
                },
                child: Text('SIGN UP'),
                height: 50,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
