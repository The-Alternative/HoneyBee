import 'dart:io';
import 'package:diary/controllers/diarycontrollers.dart';
import 'package:diary/models/diary.dart';
import 'package:diary/utils/database.dart';
import 'package:diary/views/addmemior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';


class Diaries extends StatefulWidget {
  String appTitle;
  Diary diary;
  Diaries(this.diary,this.appTitle);



  @override
  _DiariesState createState() => _DiariesState(this.diary,this.appTitle);
}

class _DiariesState extends State<Diaries> {
  Diary diary;
  String appTitle;
  DatabaseConfig dbs = new DatabaseConfig();
  _DiariesState(this.diary,this.appTitle);

  String _imagePath;
  File _image;
  final picker = ImagePicker();

  DiaryController db = new DiaryController();

  DateTime now = DateTime.now();

  TextEditingController _addressController;
  TextEditingController _descriptionController ;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _addressController = new TextEditingController(text: "");
    _descriptionController = new TextEditingController(text: "");
    _imagePath = "";
    _image = File(_imagePath);

  }

  @override
  Widget build(BuildContext context) {
    
    _addressController.text = diary.address;
    _descriptionController.text =diary.description;
    
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Directionality(textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(flex: 2,
                        child: diary.id ==null
                        ?Text("انشاء منشور",style: TextStyle(color: Colors.black),)
                        :Text("تعديل المنشور",style: TextStyle(color: Colors.black),)
                    ),

                    Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                    Expanded(flex: 1,child:
                    FlatButton(
                        child: diary.id== null
                            ?Text("انشاء",style: TextStyle(color: Colors.white,fontSize: 20),)
                            :Text("تعديل",style: TextStyle(color: Colors.white,fontSize: 20),),
                        color: Colors.blue[300],

                        onPressed: () async{
                          save();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstPage(Diary())));

                        }
                    ),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(0),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Container(
                          height:50,
                          width: 50,
                          margin: EdgeInsets.only(top: 20,right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [BoxShadow(color: Colors.amber,blurRadius: 2,spreadRadius: 1)],
                            // image: DecorationImage(
                            //   image: AssetImage(""),
                            //   scale: 2.0,
                            // ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                            margin: EdgeInsets.only(top: 20,right: 10),
                            child: Text("يوميات",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )),
                      ],
                    ),
               Column(
                children: [
                Form(
                child: Column(
                  children: [

                    Container(
                       margin: const EdgeInsets.only(left: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(10)),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Padding(padding: EdgeInsets.only( left: 0, right: 0),
                              child: TextFormField(
                                cursorColor: Colors.green,
                                controller:_addressController,
                                keyboardType: TextInputType.text,

                                onChanged:(value){
                                  diary.address = value;
                                } ,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 10),
                                  hintText: "العنوان",
                                  hintStyle: TextStyle(color: Colors.black45,fontSize: 18),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
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
                          SizedBox(width: 10,),
                          Expanded(
                            child: Padding(padding: EdgeInsets.only( left: 0, right: 0),
                                child: TextFormField(
                                  maxLines: 5,
                                  cursorColor: Colors.green,
                                  controller:_descriptionController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value){
                                    diary.description = value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 10),
                                    hintText: "أضف وصف... ",
                                    hintStyle: TextStyle(color: Colors.black45,fontSize: 15),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    ]))]),


                    Row(
                        children: [
                          Container(
                           // margin: const EdgeInsets.only(top:10),
                            height: 230,
                            width:MediaQuery.of(context).size.width,
                            child:_imagePath == ''
                                ? Text('')
                                : Container(
                              child:Image.file(_image,fit: BoxFit.cover,) ,
                            ),
                          )
                        ]
                    ),
                    //Padding(padding: EdgeInsets.only(top: 1,bottom: 1)),
                    Divider(color: Colors.grey,),
                    Container(height: 30,
                        margin:const EdgeInsets.only(top: 0,left: 0,right: 0,bottom: 0),
                     // padding: EdgeInsets.all(1),
                      child: FlatButton(
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined,color: Colors.blue[300],),
                            SizedBox(width: 20,),
                            Text("التقاط صورة"),
                          ],
                        ),
                        onPressed: (){
                          getImageFromCamera();
                        },
                      ),
                    ),
                    Divider(color: Colors.grey,),

                    Container(
                      height: 30,
                      margin:const EdgeInsets.only(top: 0,left: 0,right: 0,bottom: 0),
                      child: FlatButton(
                        child: Row(
                          children: [
                            Icon(Icons.photo_library_outlined,color: Colors.blue[300],),
                            SizedBox(width: 20,),
                            Text("تحميل صور"),
                          ],
                        ),
                        onPressed: (){
                          getImageFromGallery();
                        },
                      ),
                    ),
                    Divider(color: Colors.grey,),
                  ],
                ),
              ),
              bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),
            )
        )
    );

  }

  Future getImageFromCamera() async {

    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageFromGallery() async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  void save() async{
    int result;

    if(diary.id == null) {
      int a = await db.saveDiary(Diary(
        address:_addressController.text,
        description: _descriptionController.text,
        image:_imagePath,
        date:now.toString().substring(0,16),
      ));}else{
       result = await db.updateDiary(diary);
    }

    if(result == 0) {
      showAllertDialog('', 'لم يتم الحفظ');
    }else{
      showAllertDialog('','تم الحفظ بنجاح');
    }

  }
  void showAllertDialog(String title,String msg){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context,builder: (_) => alertDialog );
  }
}

