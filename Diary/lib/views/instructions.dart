import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


class Instruction extends StatefulWidget {
  @override
  _InstructionState createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  Future<void> pickImages() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
      print(images.length);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: new AppBar(
          title: const Text('Multi Image Picker - FlutterCorner.com'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Pick images"),
              onPressed: pickImages,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  return AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

}
class MultiImg{
  List<Asset> resultList ;
  String _error = 'No Error Dectected';
  MultiImg(List<Asset> images){
    resultList = <Asset>[];
    pickImages(images);
  }
  Future<void> pickImages(List<Asset> images) async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
      images=resultList;
    } on Exception catch (e) {
      print(e);
    }

  }
}