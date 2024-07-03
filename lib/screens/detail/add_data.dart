import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keepnote/screens/detail/site_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _add_dataState();
}

class _add_dataState extends State<AddData> {
  final title_controller = TextEditingController();
  final details_controller = TextEditingController();
  late SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            
            child:Card(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [

                  SizedBox(
                    height: 20,
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextField(
                      controller: title_controller,
                      decoration: InputDecoration(hintText: "Title"),
          
                    ),
                  ),
                 // SizedBox(height: 10,),
          
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextField(
                      controller: details_controller,
                      maxLines: 16, //or null
                      decoration: InputDecoration.collapsed(hintText: "Description here..."),
                    ),
                  ),
                ],
              ),
            ),
          
            
          
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(16.0),
          child: FloatingActionButton(
            backgroundColor: const Color(0xfffff000),
              onPressed: (){
                print(title_controller.text);
                uploadData(title_controller.text, details_controller.text);


              },
              child: Icon(Icons.check),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }


  Future<void> uploadData(String title,String details) async {
    String title=title_controller.text.trim()==''?'No title':title_controller.text;
    String details=details_controller.text.trim()==''?'No Description':details_controller.text;

    if(details_controller.text.trim()==''){
      final snackBar = const SnackBar(content: const Text('Empty Data'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    String title_enc=Uri.encodeComponent(title);
    String details_enc=Uri.encodeComponent(details);

    //print(details_enc);

    //var encData=Uri.encodeFull();

    String uid;
    SharedPreferences sp= await SharedPreferences.getInstance();
    if(sp.getString("userid")==null){
      uid='';
    }else{
      uid=sp.getString("userid").toString();
    }
    print("userID"+uid);

    var url = Uri.parse('${site_url().add_msg_url}$uid/$title_enc/$details_enc/');
   // print(url.toString());
    var response = await http.get(url);

    if (response.statusCode == 201||response.statusCode == 200) {
      print("upload complete");
      Route route = MaterialPageRoute(builder: (context) => Detail());
      Navigator.pushAndRemoveUntil(context, route,(Route<dynamic> route) => false);
    } else {
      print(response.statusCode.toString());
      final snackBar = const SnackBar(content: const Text('Data Upload Failed'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Route route = MaterialPageRoute(builder: (context) => Detail());
      Navigator.pushAndRemoveUntil(context, route,(Route<dynamic> route) => false);

    }
  }

}
