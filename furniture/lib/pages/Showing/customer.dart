import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture/pages/Showing/CustomerImageshow.dart';
import 'package:furniture/pages/frontPage.dart';
import 'package:http/http.dart' as http;

class CustomerPage extends StatefulWidget {
  String id;
  String fullname;
  String phone;
  String addresh;
  String date;
  String image;
  String message;

  CustomerPage(
      {Key? key,
      required this.id,
      required this.fullname,
      required this.phone,
      required this.addresh,
      required this.date,
      required this.image,
      required this.message})
      : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  String? id;
  Future deleteHouse() async {
    try {
      String url =
          "http://192.168.1.177/house/housedetail/deletehouserecord.php";

      // "http://192.168.100.12/house/housedetail/deletehouserecord.php";
      var body = {
        "id": id,
      };
      var headers = {
        'content-type': 'application/json',
      };

      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      print(response.statusCode);
      if (response.statusCode == 200) {
      } else {}
    } catch (error) {
      print(error);
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Do you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                id = widget.id;
                deleteHouse();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const FrontPage()),
                    (Route<dynamic> route) => false);
              },
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Customer')),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomerImageShow(
                            image:
                                "http://192.168.1.177/house/housedetail/images/${widget.image}");

                        //  Column(
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //       },
                        //       child: const Icon(
                        //         Icons.cancel,
                        //         color: Colors.white,
                        //         size: 30,
                        //       ),
                        //     ),
                        //     Image(
                        //         image: NetworkImage(
                        //             "http://192.168.1.177/house/housedetail/images/${widget.image}")),
                        //   ],
                        // );
                      });
                },
                child: Card(
                    child: Image(
                        image: NetworkImage(
                            "http://192.168.1.177/house/housedetail/images/${widget.image}"))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.fullname,
                  style: const TextStyle(fontSize: 25),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: InkWell(
                      onTap: () {
                        _showDialog(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Addresh:${widget.addresh}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Phone number:${widget.phone}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Register Date:${widget.date}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
                decoration: const BoxDecoration(), child: Text(widget.message)),
          ],
        ),
      )),
    );
  }
}
