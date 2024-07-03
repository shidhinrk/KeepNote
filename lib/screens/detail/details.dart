import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keepnote/screens/detail/site_url.dart';

import 'Post.dart';
import 'detail.dart';

class Details extends StatefulWidget {
   Details({super.key, required this.post});
  @override
  final Post post;

  @override
  State<Details> createState() => _DetailsState(post);

}

class _DetailsState extends State<Details> {
  _DetailsState(this.post);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Delete?"),
                  content: const Text("Are you sure to delete."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        deleteData(post.id);

                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: const Text("Delete",style: TextStyle(color: Colors.red),),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: const Text("Cancel"),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.delete_outline_sharp,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${getText(post.title)}",
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${getText(post.details)}",
                    style: const TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteData(String? id) async{
    var url = Uri.parse(site_url().delete_msg_url+id.toString());
    final response = await http.get(url);
  //final response = await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201||response.statusCode == 200) {
      print(response.body.toString());
      Route route = MaterialPageRoute(builder: (context) => Detail());
      Navigator.pushAndRemoveUntil(context, route,(Route<dynamic> route) => false);
    } else {
      print(response.body.toString());
      final snackBar = const SnackBar(content: const Text('Data Delete Failed'),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Route route = MaterialPageRoute(builder: (context) => Detail());
      Navigator.pushAndRemoveUntil(context, route,(Route<dynamic> route) => false);

    }
  }

  String getText(String? titleEnc){
   // Codec<String, String> stringToBase64 = utf8.fuse(base64);
   // return stringToBase64.decode(titleEnc.toString());
    return titleEnc.toString();
  }
}
