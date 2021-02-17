


import 'package:bassel/controllers/bmi/desccontroller.dart';
import 'package:bassel/models/bmi/bmimodels.dart';
import 'package:bassel/views/BMI/bmi2.dart';
import 'package:bassel/views/BMI/bmi3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_validator/form_validator.dart';



class Bmi1 extends StatefulWidget  {

  @override
  _Bmi1State createState() => _Bmi1State();

}
class _Bmi1State extends State<Bmi1> {

  var _formKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 // void validate(){
 //   if(_formKey.currentState.validate()){
 //     print("validate");
 //   }else{
 //     print("not validate");
 //   }
 // }
 // String validateheight(value){
 //     if(value.isEmpty){
 //       return "أدخل الطول";
 //     }else{
 //       return null;
 //     }
 // }
 // String validateweight(value){
 //   if(value.isEmpty){
 //     return "أدخل الوزن";
 //   }else{
 //     return null;
 //   }
 // }


  DescController db = new DescController();

  int count =0;
  String value;//weight
  String val;//height
  String sbmi='';

  double result = 0;
  BmiModel _bmiModel;
  double res = 0;
  double reso =0 ;

  TextEditingController _heightController;
  TextEditingController _weightController ;

  DateTime now = DateTime.now();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _heightController = new TextEditingController(text: "");
    _weightController = new TextEditingController(text: "");
  }


  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow[700],
              title: Row(
                children: [
                  Center(
                    child: Image.asset("assets/group.png",)),
                  SizedBox(width: 10,),
                  Expanded(child:  Text('BMI' ,style: TextStyle(
                    color: Colors.black,
                  ),
                  ),),

                ],
              ),

            ),

            body:    Container(
    // height: MediaQuery.of(context).size.height,
    color: Colors.grey[200],
            child:
            ListView(
              children: <Widget>[
              // Container(
              //  // height: MediaQuery.of(context).size.height,
              //   color: Colors.grey[200],


               Center(
                  child: Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,

                    child: Card(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Form(
                            key: _formKey,
                            child: Column(

                              children: [
                                Padding(padding: EdgeInsets.only(top: 30)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                 Padding(padding: EdgeInsets.all(10)),
                                  Expanded(flex:1,
                                      child: Text("أدخل الطول:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black87),)),
                                  SizedBox(width: 10,),
                                    Expanded(
                                    child: Padding(padding: EdgeInsets.only( left: 0, right: 0),
                                          child: TextFormField(
                                              controller:_heightController,
                                              keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'أدخل الطول';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(style: BorderStyle.solid)),
                                              contentPadding: EdgeInsets.only(right: 25,bottom: 10),
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
                                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber,
                                                  style:BorderStyle.solid)),
                                            ),
                                            ),
                                        ),
                                        ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  SizedBox(width: 10,),
                                  Expanded(flex:1,child: Text("سم",style: TextStyle(fontSize: 16),))
                                ],
                                ),


                                Padding(padding: EdgeInsets.only(top: 30)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.all(10)),
                                    Expanded(flex:1,child: Text(" أدخل الوزن:", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black87),)),
                                    SizedBox(width: 10,),

                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 0, right: 0),
                                              child: TextFormField(
                                                controller:_weightController,
                                                keyboardType: TextInputType.number,

                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'أدخل الوزن';
                                                  }
                                                  return null;
                                                },

                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(style: BorderStyle.solid)),
                                                  contentPadding: EdgeInsets.only(right: 25,bottom: 10),
                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
                                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber,
                                                      style:BorderStyle.solid)),
                                                ),

                                                ),
                                            )),
                                            // ),

                                    Padding(padding: EdgeInsets.all(10)),
                                    SizedBox(width: 10,),

                                    Expanded(flex:1,child: Text("كغ",style: TextStyle(fontSize: 16),))
                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(top:60,left: 60,right: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FlatButton(
                                          child: Text("احسب",style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.bold),),
                                          onPressed: () async {
                                            print("111");
                                            final isValid = _formKey.currentState.validate();
                                            print("222 $isValid");
                                            if (!isValid) {
                                              print("3333");
                                              return;
                                            }
                                            print("4444");
                                            _formKey.currentState.save();
                                            print("55555");
                                            calculateBMI();
                                            print("66666");
                                            result = await Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return Bmi2(bmiModel: _bmiModel);
                                                        })

                                                        );

                                          }
                                      ),
                                      SizedBox(width: 30,),
                                      FlatButton(
                                        child: Text("السجل",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                                        color: Colors.white,

                                        onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Bmi3(bmiModel: _bmiModel)));
                                          
                                        },
                                      ),


                                    ],
                                  ),
                                ),

                              ],
                            ),



                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],)),),
    ));
  }
  void calculateBMI() async {

    setState(()  {
      double height = double.parse(_heightController.text)/100 ;
      double weight = double.parse(_weightController.text);

      double heightSquare = height * height;
      double result = weight / heightSquare;

      double res = heightSquare * 18.5;
      double reso = heightSquare * 25 ;

      result = result ;
      res = res;
      reso = reso;

      if(result >= 18.5 && result <= 25 ){
        _bmiModel = BmiModel(result: result, isNormal: true, comment: "وزن صحي", res: res, reso: reso, wight:_weightController.text, length: _heightController.text );

      }else
      if(result < 18.5){
        _bmiModel = BmiModel(result: result, isNormal: true, comment: "نحيف", res: res, reso: reso, wight:_weightController.text, length: _heightController.text );

      }else
      if(result > 25 && result<= 30){
        _bmiModel = BmiModel(result: result, isNormal: true, comment: "وزن زائد", res: res, reso: reso, wight:_weightController.text, length: _heightController.text );        }
      else
      {
        _bmiModel = BmiModel(result: result, isNormal: true, comment: "سمنة مفرطة", res: res, reso: reso, wight:_weightController.text, length: _heightController.text );
      }
     sbmi = result.toStringAsFixed(2);
    });

    int a =await db.saveDesc(
        CardInfo(
          length:_bmiModel.length ,
          wight:_bmiModel.wight ,
          bmi:sbmi,
          datt:now.toString().substring(0,19),
          comment:_bmiModel.comment,
        ));
        print(a);
       }
}