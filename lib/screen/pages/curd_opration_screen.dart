import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> storeUser = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      setState(() {
        storeUser = List<Map<String, dynamic>>.from(jsonDecode(userData));
      });
    }
  }

  // Save user data to SharedPreferences
  void _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(storeUser);
    print("encodeList===><====$encodedData");
    await prefs.setString('userData', encodedData);
  }

  // Add or update user data
  void _addOrUpdateUser({int? index}) {
    setState(() {
      if (index == null) {
        storeUser.add({
          "username": userNameController.text,
          "email": emailController.text,
          "number": phoneNumberController.text,
        });
      } else {
        storeUser[index] = {
          "username": userNameController.text,
          "email": emailController.text,
          "number": phoneNumberController.text,
        };
      }
      _saveUserData(); // Save to local storage
    });
    Navigator.pop(context);
  }

  // Delete user data
  void _deleteUser(int index) {
    setState(() {
      storeUser.removeAt(index);
      _saveUserData(); // Save to local storage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialog();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 4,
        title: Center(
            child: Text(
              "CRUD",
              style: GoogleFonts.abel(),
            )),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          _loadUserData();
        },
        child: ListView.builder(
          itemCount: storeUser.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text("${index + 1}"),
                title: Text(storeUser[index]['username']!),
                subtitle: Text(storeUser[index]['email']!),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        dialog(index: index);
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteUser(index);
                      },
                      icon: const Icon(CupertinoIcons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void dialog({int? index}) {
    if (index != null) {
      userNameController.text = storeUser[index]['username']!;
      emailController.text = storeUser[index]['email']!;
      phoneNumberController.text = storeUser[index]['number']!;
    } else {
      userNameController.clear();
      emailController.clear();
      phoneNumberController.clear();
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (c, setState) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "DIALOG",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                          hintText: "Username",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your name ';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone Number",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _addOrUpdateUser(index: index);
                          }
                        },
                        color: Colors.pink.withOpacity(.4),
                        elevation: 0,
                        child: Text(index == null ? "Submit" : "Update"),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
