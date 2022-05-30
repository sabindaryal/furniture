import 'package:flutter/material.dart';
import 'package:furniture/modal/viewOrderModel.dart';
import 'package:furniture/pages/Showing/customer.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List orderData;
  CustomSearchDelegate(
    this.orderData,
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ShowOrder> matchQuery = [];
    var a = query.isEmpty
        ? orderData
        : orderData.where((element) =>
            element.fullname.toLowerCase().contains(query.toLowerCase()));

    matchQuery = a.cast<ShowOrder>().toList();

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return CustomerPage(
                    id: result.id,
                    fullname: result.fullname,
                    phone: result.phone,
                    addresh: result.addresh,
                    date: result.date,
                    image: result.image,
                    message: result.message);
              })));
            },
            child: ListTile(
              title: Text(result.fullname),
              subtitle: Text(result.addresh),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ShowOrder>? matchQuery = [];
    var a = query.isEmpty
        ? orderData
        : orderData.where((element) =>
            element.fullname.toLowerCase().contains(query.toLowerCase()));
    matchQuery = a.cast<ShowOrder>().toList();
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery![index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return CustomerPage(
                    id: result.id,
                    fullname: result.fullname,
                    phone: result.phone,
                    addresh: result.addresh,
                    date: result.date,
                    image: result.image,
                    message: result.message);
              })));
            },
            child: ListTile(
              title: Text(result.fullname),
              subtitle: Text(result.addresh),
            ),
          );
        });
  }
}
