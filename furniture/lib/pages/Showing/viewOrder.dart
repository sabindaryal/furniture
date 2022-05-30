import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture/modal/viewOrderModel.dart';
import 'package:furniture/pages/Showing/customer.dart';
import 'package:furniture/pages/searchbar.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class OrderShowPage extends StatefulWidget {
  const OrderShowPage({Key? key}) : super(key: key);

  @override
  State<OrderShowPage> createState() => _OrderShowPageState();
}

// ignore: camel_case_types
class _OrderShowPageState extends State<OrderShowPage> {
  @override
  void initState() {
    super.initState();
    getOrder();
  }

  @override
  List<ShowOrder> orderData = [];
  bool isloading = false;
  Future<List<ShowOrder>> getOrder() async {
    try {
      String url = '${ip}house/housedetail/fetchhousedetail.php';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        orderData.clear();
        var data = jsonDecode(response.body);

        for (var o in data) {
          orderData.add(ShowOrder.fromJson(o));
        }
      }
      return orderData;
    } catch (error) {}
    return getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Orders'),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(orderData),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          ],
        ),
        body: SafeArea(
            child: FutureBuilder<List<ShowOrder>>(
                future: getOrder(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                        itemCount: orderData.length,
                        itemBuilder: (context, index) {
                          var customer = orderData[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                var passOrder = orderData[index];
                                return CustomerPage(
                                    id: passOrder.id,
                                    fullname: passOrder.fullname,
                                    phone: passOrder.phone,
                                    addresh: passOrder.addresh,
                                    date: passOrder.date,
                                    image: passOrder.image.toString(),
                                    message: passOrder.message);
                              }));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  customer.fullname,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                Text(customer.addresh),
                                                Text(customer.phone),
                                                Text(customer.date),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }

                  return const Center(child: CircularProgressIndicator());
                })));
  }
}
