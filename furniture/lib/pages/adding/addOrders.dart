// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:furniture/modal/viewOrderModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = false;
  NepaliDateTime? _selectedDateTime;
  // String? ima;
  String? imagePath;
  String? date;
  String? imagePat;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addreshController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  final snackBar = const SnackBar(
    content: Text(' Already Exist'),
  );
  final sucessmsg = const SnackBar(
    content: Text('sucessfully register'),
  );
  File? ima;
  void pickimage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        // File ima = file;

        Uint8List bytes = file.readAsBytesSync();

        imagePat = base64Encode(bytes);
        setState(() {
          ima = file;
          imagePath = imagePat;
        });
      } else {}
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  _selectDate(BuildContext context) async {
    NepaliDateTime? selectedDateTime = (await showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
    ));
    if (selectedDateTime != null) {
      setState(() {
        // var date = NepaliDateFormat("d/MM/yyyy").format(_selectedDateTime!);
        _selectedDateTime = selectedDateTime;
        date = NepaliDateFormat("d/MM/yyyy").format(_selectedDateTime!);
      });
    }
  }

  Future postData() async {
    setState(() {
      isloading = true;
    });
    try {
      String url = '${ip}house/housedetail/houseregister.php';
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'fullname': nameController.text,
            'phone': phoneController.text,
            'addresh': addreshController.text,
            'date': date.toString(),
            "image": imagePath,
            'message': msgController.text,
          }));

      var data = jsonDecode(response.body);

      if (data['status'] == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(sucessmsg);
      } else if (response.statusCode == 409) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // ignore: avoid_print
        print('wrong');
      }
    } catch (e) {
      // ignore: avoid_print
      print("this is catch $e");
    }
    setState(() {
      isloading = false;
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text(' Add Orders')),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                autofocus: false,
                // validator: ((value) {
                //   if (value!.isEmpty) {
                //     return 'field can\'t be empty ';
                //   }
                //   return null;
                // }),
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    label: Text('Full Name'),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'field can\'t be empty ';
                  }
                  return null;
                }),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    label: Text('Phone Number'),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'field can\'t be empty ';
                  }
                  return null;
                  // if (!RegExp(
                  //         r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                  //     .hasMatch(value)) {
                  //   return ' requirement doesn\'t match';
                  // }
                  // return null;
                }),
                controller: addreshController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    label: Text('Addresh'),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: const Text("Starting Date")),
                  const SizedBox(
                    width: 10,
                  ),
                  date != null
                      ? Text(
                          ' ${NepaliDateFormat("d/MM/yyyy").format(_selectedDateTime!)}',
                        )
                      : const Text(''),
                ],
              ),
              Row(children: [
                ElevatedButton(
                    onPressed: () {
                      pickimage();
                    },
                    child: const Text('Upload image')),
                const SizedBox(
                  width: 20,
                ),

                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(),
                  child: ima != null ? Image.file(ima!) : const Text(''),
                ),
                //   SizedBox(
                //     height: 100,
                //     child: Card(
                //       child: ima != null ? Image.file(ima) : const Text('image'),
                //     ),
                //   )
              ]),
              TextFormField(
                maxLines: 8,
                autofocus: false,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'field can\'t be empty ';
                  }
                  return null;
                }),
                controller: msgController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    label: Center(child: Text('Message')),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10)),
                  onPressed: () {
                    // if (formKey.currentState!.validate()) {
                    //   formKey.currentState!.save();
                    if (!isloading) {
                      postData();
                    }
                    // }
                  },
                  child: !isloading
                      ? const Text('Save order')
                      : const CircularProgressIndicator(
                          color: Colors.white,
                          value: 15,
                        ))
            ]),
          ),
        ))));
  }
}
