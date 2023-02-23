import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginhivemain/main.dart';
import 'package:loginhivemain/models/user_model.dart';
import 'package:rive/rive.dart';

import '../db/db_function.dart';

class SignUpScreen extends StatelessWidget {
  final email_controller = TextEditingController();
  final password_controler = TextEditingController();
  final cpass_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          const RiveAnimation.asset(
            "assets/rive/spiral.riv",
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 200,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    TextField(
                      controller: email_controller,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextField(
                      controller: cpass_controller,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    TextField(
                      controller: password_controler,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration:
                          const InputDecoration(hintText: 'Confirm Password'),
                    ),
                    SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              validateSignUp();
                              Get.to(() => LoginScreen());
                            },
                            child: const Text("Login Here"))),
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        child: const Text(
                            'Already Have an Account ,Go To Login!!'))
                  ],
                ),
              ))
        ],
      )),
    );
  }

  void validateSignUp() async {
    final email = email_controller.text.trim();
    final pass = password_controler.text.trim();
    final cpass = cpass_controller.text.trim();

    final isEmailValidated = EmailValidator.validate(email);
    if (email != " " && pass != "" && cpass != "") {
      if (isEmailValidated == true) {
        final isPasswordValidated = checkPassword(pass, cpass);
        if(isPasswordValidated == true){
          final user = UserModel(email: email,password :pass);
          await DBFunctions.instance.userSignup(user);
        }
      }
    }
  }

  bool checkPassword(String pass, String cpass) {
    if (pass == cpass) {
      if (pass.length < 6) {
        Get.snackbar("Error", "Password must contains 6 characters or more",
            backgroundColor: Colors.white30, colorText: Colors.red);
        return false;
      }else{
        return true;
      }
    }else{
      Get.snackbar("Password Mismatch", "Password and Confirm Password must be same",
          backgroundColor: Colors.white30, colorText: Colors.red);
      return false;
    }
  }
}
