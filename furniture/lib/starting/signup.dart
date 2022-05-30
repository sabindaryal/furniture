import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture/modal/viewOrderModel.dart';
import 'package:furniture/starting/login.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future signup() async {
    try {
      final response =
          await http.post(Uri.parse("${ip}house/housedetail/register.php"),
              body: jsonEncode({
                "fullname": nameController.text,
                "phone": phoneController.text,
                "password": passwordController.text
              }));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == 401) {
          const snackBar = SnackBar(
            content: Text('error'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          snackBar;
        }
        if (data['status'] == 200) {
          return Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const LoginPage();
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
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Signup',
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
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          label: Text('Full name'),
                          enabledBorder: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
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
                      obscureText: true,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          label: Text('password'),
                          enabledBorder: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    signup();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have Account? ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  },
                  child: Text(
                    'Login ',
                    style: TextStyle(
                        color: Colors.grey[800], fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
