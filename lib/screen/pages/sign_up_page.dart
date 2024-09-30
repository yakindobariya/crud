import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sign_up_page extends StatefulWidget {
  const Sign_up_page({super.key});

  @override
  State<Sign_up_page> createState() => _Sign_up_pageState();
}

class _Sign_up_pageState extends State<Sign_up_page> {
  TextEditingController emailCntroller = TextEditingController();
  TextEditingController passwordCntroller = TextEditingController();
  List storeUser = [];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white60, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "CRUD OPERATIONS",
                    style: GoogleFonts.aboreto(fontSize: 30),
                  ),
                ),
                Text(
                  "SIGN IN",
                  style: GoogleFonts.acme(fontSize: 20),
                ),
                Text(
                  "Enter your credentials to access your account",
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 100)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 100)),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                ElevatedButton(onPressed: () {
                  
                }, child: Text("Submit")),
                Text("Forgot your password?",)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
