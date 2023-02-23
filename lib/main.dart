import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loginhivemain/models/user_model.dart';
import 'package:loginhivemain/screens/signup.dart';
import 'package:rive/rive.dart';

import 'screens/home page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<UserModel>('user');
  runApp(GetMaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatelessWidget {
  final email_controller = TextEditingController();
  final password_controler = TextEditingController();

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
                      controller: password_controler,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(onPressed: () {
                          Get.to(()=>HomeScreen());
                        }, child: const Text("Login Here"))),
                    TextButton(
                        onPressed: () {
                          Get.to(()=>SignUpScreen());
                        },
                        child: const Text("Not a user ? SignUp Here!!!")),
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
