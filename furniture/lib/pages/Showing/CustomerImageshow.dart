import 'package:flutter/material.dart';

class CustomerImageShow extends StatefulWidget {
  String? image;

  CustomerImageShow({Key? key, required this.image}) : super(key: key);

  @override
  State<CustomerImageShow> createState() => _CustomerImageShow();
}

class _CustomerImageShow extends State<CustomerImageShow> {
  // int? change = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // change = widget.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.image);
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
                  // setState(() {
                  //   if (change! < 1) {
                  //     change = 0;
                  //   } else {
                  //     change = change! - 1;
                  //   }
                  // });
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
                child: Image(image: NetworkImage(widget.image!))),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    // setState(() {
                    //   if (change! == widget.image - 1) {
                    //   } else {
                    //     change = change! + 1;
                    //   }
                    // });
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
