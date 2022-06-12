import 'package:eventatt/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'scan.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Email'),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Password'),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                String? token = await Login()
                    .login(emailController.text, passwordController.text);
                if (token != null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Scanner()));
                }
              },
              child: Center(
                child: Container(
                  color: Colors.blue,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
