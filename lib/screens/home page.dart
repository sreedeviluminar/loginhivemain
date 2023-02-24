import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body: Center(
       child:  Text("Welcome $email"),
     ),
   );
  }
}
