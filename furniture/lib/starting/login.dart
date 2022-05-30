import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture/modal/viewOrderModel.dart';
import 'package:furniture/pages/frontPage.dart';
import 'package:furniture/starting/signup.dart';
import "package:http/http.dart" as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    seePassword = true;
  }

  bool seePassword = true;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future login() async {
    try {
      final response = await http.post(
          Uri.parse("${ip}house/housedetail/login.php"),
          body: jsonEncode({
            "phone": phoneController.text,
            "password": passwordController.text
          }));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // if (data['status']! == 401) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        if (data['status'] == 401) {
          const snackBar = SnackBar(
            content: Text('Login Information Wrong'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          snackBar;
        }
        if (data['status'] == 200) {
          const snackBar = SnackBar(
            content: Text('Login Sucess'),
          );
          return Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const FrontPage();
          })));
        } else {}
      } else {}
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'field can\'t be empty ';
                          }
                          return null;
                          // if (!RegExp(
                          //         r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                          //     .hasMatch(value)) {
                          //   return 'Password requirement doesn\'t match';
                          // }
                          // return null;
                        }),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            label: Text('Phone Number'),
                            enabledBorder: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: seePassword ? true : false,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(),
                            label: const Text('password'),
                            suffixIcon: IconButton(
                              icon: Icon(seePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  seePassword = !seePassword;
                                });
                              },
                            ),
                            enabledBorder: const OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      login();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignupPage();
                        }));
                      },
                      child: Text(
                        ' signup',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
