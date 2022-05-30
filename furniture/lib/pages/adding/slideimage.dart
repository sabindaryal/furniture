import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SlideImage extends StatefulWidget {
  List<XFile>? imageFileList;
  int selctedImage;

  SlideImage(
      {Key? key, required this.imageFileList, required this.selctedImage})
      : super(key: key);

  @override
  State<SlideImage> createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  int? change = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      change = widget.selctedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (change! < 1) {
                      change = 0;
                    } else {
                      change = change! - 1;
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Image.file(
                File(widget.imageFileList![change!].path),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (change! == widget.imageFileList!.length - 1) {
                      } else {
                        change = change! + 1;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
