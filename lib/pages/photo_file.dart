import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_hike_flutter/utils/dimens.dart';
import 'package:m_hike_flutter/view_model/main_view_model.dart';
import 'package:provider/provider.dart';

class PhotoPage extends StatefulWidget {

  final int? id;
  const PhotoPage({Key? key, required this.id}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {

  @override
  void initState() {
    Provider.of<MainViewModel>(context, listen: false).queryAllImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery"),
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingX24),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () => pickImage(),
              child: Container(
                alignment: Alignment.center,
                height: 150,
                color: Colors.white,
                child: const Text(
                    "Add Photo", style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
            SizedBox(height: marginX16),
            Consumer<MainViewModel>(
              builder: (context, mainViewModel, child) {
                if (mainViewModel.imageData.isEmpty) {
                  return Center(
                    child: Container(
                        margin: EdgeInsets.only(top: marginX48),
                        child: const Text("No images available.")),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: mainViewModel.imageData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                          width: double.infinity,
                          padding: EdgeInsets.all(paddingX8),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: Image.memory(base64Decode(mainViewModel.imageData[index]["imageUrl"] ?? ""))
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  pickImage() async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      String imgString = base64Encode(await imgFile!.readAsBytes());
      var data = {
        "hikeId": widget.id,
        "imageUrl": imgString
      };
      Provider.of<MainViewModel>(context, listen: false).saveImage(data, context);
    });
  }

}