import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker_example/views/instruction.dart';

import '../controllers/diarycontrollers.dart';
import '../models/diary.dart';
import '../utils/database.dart';
import '../views/addmemior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Diaries extends StatefulWidget {
  String appTitle;
  Diary diary;
  Diaries(this.diary, this.appTitle);

  @override
  _DiariesState createState() => _DiariesState(this.diary, this.appTitle);
}

class _DiariesState extends State<Diaries> {
  List<Asset> images = <Asset>[];
  bool v = true;

  Diary diary;
  String appTitle;
  DatabaseConfig dbs = new DatabaseConfig();
  _DiariesState(this.diary, this.appTitle);
  String _error = 'No Error Dectected';
  List <File> fileImageArray = [];

  File gallery;
  String _imagePath;
  File _image;
  final picker = ImagePicker();

  //VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  File videoFile;
  String _videoPath;
  String s='';

  DiaryController db = new DiaryController();

  DateTime now = DateTime.now();

  TextEditingController _addressController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image=null;
    _addressController = new TextEditingController(text: "");
    _descriptionController = new TextEditingController(text: "");
    _imagePath = "";
    _image = File(_imagePath);
    _videoPath = "";
    videoFile = File(_videoPath);
  }

  @override
  void dispose() {
    //_controller.play();
    super.dispose();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    _addressController.text = diary.address;
    _descriptionController.text = diary.description;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: diary.id == null
                            ? Text(
                                "انشاء منشور",
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                "تعديل المنشور",
                                style: TextStyle(color: Colors.black),
                              )),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                          child: diary.id == null
                              ? Text(
                                  'حفظ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : Text(
                                  "تعديل",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                          color: Colors.blue[300],
                          onPressed: ()  {
                              // getpath();

                            save();
                           Navigator.pop(context, true);
                          }),
                    )
                  ],
                ),
              ),
              body:
                  // Column(
                  //   children: <Widget>[
                  //     Visibility(
                  //       visible: _controller != null,
                  //       child: FutureBuilder(
                  //         future: _initializeVideoPlayerFuture,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState == ConnectionState.done) {
                  //             return AspectRatio(
                  //               aspectRatio: _controller.value.aspectRatio,
                  //               child: VideoPlayer(_controller),
                  //             );
                  //           } else {
                  //             return Center(child: CircularProgressIndicator());
                  //           }
                  //           },),),
                  //     RaisedButton(
                  //       child: Text("Video"),
                  //       onPressed: () {
                  //         getVideo();},),],
                  // ),
                  // floatingActionButton: _controller == null
                  //     ? null
                  //     : FloatingActionButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       if (_controller.value.isPlaying) {
                  //         _controller.pause();
                  //       } else {
                  //         _controller.play();
                  //       }
                  //     });
                  //     },
                  //   child: Icon(
                  //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  //   ),
                  // ), // This trailing comma makes auto-formatting nicer for build methods.

                  Padding(
                padding: EdgeInsets.all(0),
                child: ListView(
                  shrinkWrap: true, physics: ClampingScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.only(top: 20, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.amber,
                                  blurRadius: 2,
                                  spreadRadius: 1)
                            ],
                            // image: DecorationImage(
                            //   image: AssetImage(""),
                            //   scale: 2.0,
                            // ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20, right: 10),
                            child: Text(
                              "يوميات",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )),
                      ],
                    ),
                    Column(children: [
                      Form(
                          child: Column(children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                    child: TextFormField(
                                      cursorColor: Colors.green,
                                      controller: _addressController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        diary.address = value;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(right: 10),
                                        hintText: "العنوان",
                                        hintStyle: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 18),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                    child: TextFormField(
                                      maxLines: 5,
                                      cursorColor: Colors.green,
                                      controller: _descriptionController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        diary.description = value;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(right: 10),
                                        hintText: "أضف وصف... ",
                                        hintStyle: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ]))
                    ]),
                    Row(children: [
                      // Container(
                      //   height: 300,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: gallery == null
                      //     ?Center(child: new Text("sorry"),):
                      //       Center(child: new Image.file(gallery),),)
                      //   Visibility(
                      //           visible: _controller != null,
                      //           child: FutureBuilder(
                      //             future: _initializeVideoPlayerFuture,
                      //             builder: (context, snapshot) {
                      //               if (snapshot.connectionState == ConnectionState.done) {
                      //                 return AspectRatio(
                      //                   aspectRatio: _controller.value.aspectRatio,
                      //                   child: VideoPlayer(_controller),
                      //                 );
                      //               } else {
                      //                 return Center(child: CircularProgressIndicator());
                      //               }
                      //               },),),
                      // ),
                      v == true
                          ? ooo()
                          :     Container( height: 300,width: 310,
                            child: GridView.count(shrinkWrap: true, physics: ClampingScrollPhysics(),
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
                    ]),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(
                          top: 0, left: 0, right: 0, bottom: 0),
                      child: FlatButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue[300],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("التقاط صورة/فيديو"),
                          ],
                        ),
                        onPressed: () {
                          getImageFromCamera();
                          // getVideoFromCamera();
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(
                          top: 0, left: 0, right: 0, bottom: 0),
                      child: FlatButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              color: Colors.blue[300],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("تحميل صورة/فيديو"),
                          ],
                        ),
                        onPressed: pickImages,
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              // floatingActionButton: _controller == null
              //     ? null
              //     : FloatingActionButton(
              //   onPressed: () {
              //     setState(() {
              //       if (_controller.value.isPlaying) {
              //         _controller.pause();
              //       } else {
              //         _controller.play();
              //       }
              //     });
              //   },
              //   child: Icon(
              //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              //   ),
              // )
              // ,
              bottomNavigationBar: new Icon(
                Icons.home,
                color: Colors.black12,
                size: 50.2,
              ),
            )));
  }
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
      v = false;
      images = resultList;
    });
getpath();
  }
getpath(){
  _imagePath='';
  images.forEach((imageAsset) async {
    final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

    File tempFile = File(filePath);
    _imagePath=tempFile.path+':'+_imagePath;
    print('${_imagePath}');
    if (tempFile.existsSync()) {
      fileImageArray.add(tempFile);
    }
  });
}
  Future getVideoFromCamera() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        videoFile = File(pickedFile.path);
        _videoPath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        v = true;
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path +':';
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  Widget ooo() {

    return Container(
      // margin: const EdgeInsets.only(top:10),
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: _imagePath == ''
          ? Text('')
          : Container(
              child: Image.file(
                _image,
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  void save() async {
    int result;
    if (diary.id == null) {
      int a = await db.saveDiary(Diary(
        address: _addressController.text,
        description: _descriptionController.text,
        image: _imagePath,
        date: now.toString().substring(0, 16),
      ));
    } else {
      result = await db.updateDiary(diary);
    }

    if (result == 0) {
      showAllertDialog('', 'لم يتم الحفظ');
    } else {
      showAllertDialog('', 'تم الحفظ بنجاح');
    }
  }

  void showAllertDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
  // Future getVideo() async {
  //   Future<File> _videoFile =
  //   ImagePicker.pickVideo(source: ImageSource.gallery);
  //   _videoFile.then((file) async {
  //     setState(() {
  //       videoFile = file;
  //       _controller = VideoPlayerController.file(videoFile);
  //       _initializeVideoPlayerFuture = _controller.initialize();
  //       _controller.setLooping(true);
  //     });
  //   });
  // }
}
