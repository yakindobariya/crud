import 'package:crudopretion/screen/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Sign_up_page(),
      debugShowCheckedModeBanner: false,
    );
  }
}
