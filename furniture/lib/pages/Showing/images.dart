import 'package:flutter/material.dart';

class ImagesPages extends StatefulWidget {
  const ImagesPages({Key? key}) : super(key: key);

  @override
  State<ImagesPages> createState() => _ImagesPagesState();
}

class _ImagesPagesState extends State<ImagesPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('images'),
      ),
    );
  }
}
