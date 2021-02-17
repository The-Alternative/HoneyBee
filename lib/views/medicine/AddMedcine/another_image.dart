import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(ImageSave());

class ImageSave extends StatefulWidget {
  @override
  _ImageSaveState createState() => _ImageSaveState();
}

class _ImageSaveState extends State<ImageSave> {
  File _image1;
  File _image2;
  File _image3;
  File _savedImage;
  File _saved1Image;

  final picker = ImagePicker();
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Times');

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter ImagePicker - Save Image Example',
      home:Directionality(textDirection: TextDirection.rtl,child:
      Scaffold(
        appBar: AppBar(
          title: Text('Flutter ImagePicker - Save Image Example'),
        ),
        body:get_body()
      ),
    ) ) ;
  }
  Widget get_body() {
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 25.0,top:25),
            child: ListTile(
              title: Text('المرفقات', style: style1),
              trailing: Image.asset("assets/Path105.png" ,
                  width: 120, height: 120),
            )),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(onTap: _getImageCamera, child: Image.asset("assets/ic_add_a_photo_24px.png" ,
                  width: 50, height: 50)),
            ),SizedBox(height: 25,width: 25,),
            GestureDetector(onTap: _getImageGallery, child: Icon(Icons.image_search,size: 50,color: Colors.lightBlue,)),
          ],
        ),Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:    CircleAvatar(
                  backgroundImage: _image1 == null ? null : FileImage(_image1),
                  radius: 50,
                  foregroundColor: Colors.amber,
                  backgroundColor: Colors.white,
                ),
                flex: 1,
              ),   Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child:CircleAvatar(

                  backgroundImage: _image2 == null ? null : FileImage(_image2),
                  radius: 50,
                  foregroundColor: Colors.amber,
                  backgroundColor: Colors.white,
                ),),
                flex: 1,
              ),   Expanded(
                child:    CircleAvatar(
                  backgroundImage: _image3 == null ? null : FileImage(_image3),
                  radius: 50,
                  foregroundColor: Colors.amber,
                  backgroundColor: Colors.white,
                ),
                flex: 1,
              ),

            ],
          ),
        )
,SizedBox(height: 25,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  child: Text(
                    'حفظ',
                    style: style2,
                  ),
                  onPressed: () {
                  }),
              flex: 1,
            ),
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.only(),
                child: Text(
                  'الغاء الأمر',
                  style: style2,
                ),
                onPressed: () {
                 // clear_tdata();
                 // fail_moveToLastScreen(context);
                },
              ),
              flex:1,
            ),
          ],
        )
      ],
    );
  }
  _getImageCamera() async {

      PickedFile imageFile = await picker.getImage(source: ImageSource.camera);
    if (imageFile == null) return;
    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);

    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
    print('${appDir.path}');
    setState(() {
      if(_image1==null){
      _image1 = tmpFile;
      return;}
      else if(_image2==null){
      _image2= tmpFile;return;}

      else if(_image3==null){
        _image3= tmpFile;return;}
      else _image1 =tmpFile;
      //  _savedImage=_saved1Image;
    });  }
  _getImageGallery() async {
    PickedFile imageFile = await picker.getImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
    print('${appDir.path}/$fileName');
    setState(() {
      if(_image1==null){
        _image1 = tmpFile;
        return;}
      else if(_image2==null){
        _image2= tmpFile;return;}

      else if(_image3==null){
        _image3= tmpFile;return;}
      else
        _image3= tmpFile;
      //  _savedImage=_saved1Image;
    });
  }

}
