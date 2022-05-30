import 'package:flutter/material.dart';
import 'package:furniture/pages/adding/addOrders.dart';
import 'package:furniture/pages/Showing/images.dart';
import 'package:furniture/pages/Showing/viewOrder.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Welcome')),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ImagesPages();
                      }));
                    },
                    child: const Card(
                      child: Center(
                          child: Icon(
                        Icons.image,
                        size: 50,
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }));
                    },
                    child: const Card(
                      child: Center(
                          child: Icon(
                        Icons.add,
                        size: 50,
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const OrderShowPage();
                      }));
                    },
                    child: const Card(
                      child: Center(
                          child: Icon(
                        Icons.view_agenda,
                        size: 50,
                      )),
                    ),
                  ),
                  // Card(
                  //   child: Center(
                  //       child: Icon(
                  //     Icons.add,
                  //     size: 50,
                  //   )),
                  // ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
// pickimage() async {
//   try {
//     var pickedfiles = await imgpicker.pickMultiImage();
//     //you can use ImageCourse.camera for Camera capture
//     if (pickedfiles != null) {
//       setState(() {
//         imagefiles = pickedfiles;
//       });
//     } else {
//       print("No image is selected.");
//     }
//   } catch (e) {
//     print("error while picking file.");
//   }

// //    try {
// //     var pickedfiles = await imgpicker.pickMultiImage();
// //     //you can use ImageCourse.camera for Camera capture
// //     if(pickedfiles != null){
// //         imagefiles = pickedfiles;
// //         setState(() {
// //         });
// //     }else{
// //         print("No image is selected.");
// //     }
// // }catch (e) {
// //     print("error while picking file.");
// // }
//   // final XFile? pickedFile = await  ImagePicker().pickImage(
//   //   source: ImageSource.gallery,
//   // );
//   // if (pickedFile != null) {
//   // File file = File(pickedFile.path);
//   // File ima = file;

//   //   setState(() {
//   //     ima = file;
//   //   });
//   // }
// }
