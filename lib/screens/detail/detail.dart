import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:keepnote/screens/detail/site_url.dart';
import 'package:keepnote/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Post.dart';
import 'add_data.dart';
import 'details.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _MyAppState();
}

class _MyAppState extends State<Detail> {
  Future<List<Post>> postsFuture = getPosts();
  late SharedPreferences sp;

  // function to fetch data from api and return future list of posts
  static Future<List<Post>> getPosts() async {
    String uid;
    SharedPreferences sp= await SharedPreferences.getInstance();
    if(sp.getString("userid")==null){
      uid='';
    }else{
      uid=sp.getString("userid").toString();
    }
    print("userID"+uid);
    var url = Uri.parse(site_url().base_url + site_url().load_msg_url+uid);
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Post.fromJson(e)).toList();
  }

 /* @override
  Future<void> initState() async {
    sp= await SharedPreferences.getInstance();

    if(sp.getString("userid")==null){
      Route route = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushAndRemoveUntil(context, route,(Route<dynamic> route) => false);
    }else{
      uid=sp.getString("userid");
    }
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Center(
        // FutureBuilder
        child: FutureBuilder<List<Post>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              print(snapshot.data.toString());
              if (snapshot.data.toString() == "[]") {
                return build_design();
              } else {
                final posts = snapshot.data!;
                return buildPosts(posts);
              }
            } else {
              print(snapshot.error);
              return Padding(
                padding: const EdgeInsets.all(38.0),
                child: Image.asset("assets/noentry.png"),
              );
            }
          },
        ),
      );

  }

  Widget buildPosts(List<Post> posts) {
    // ListView Builder to show data in a list
    return Scaffold(
      appBar: AppBar(title: Text('KeepNote'),),
      body: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            const QuiltedGridTile(2, 2),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) =>
              //Tile(index: index),
          Container(

            child: Card(
              elevation: 10,
              margin: const EdgeInsets.all(5),
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(
                              post: posts[index],
                            ))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    getText(posts[index].title.toString()),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            //child: Text(posts[index].title.toString(),style: TextStyle(fontSize: 15),),
          ),
          childCount: posts.length,
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: FloatingActionButton(
          backgroundColor: const Color(0xfffff000),
          foregroundColor: Colors.black,
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddData()),
              ),

          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget build_design() {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/noentry.png",width: 300,height: 300,),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: FloatingActionButton(
          backgroundColor: const Color(0xfffff000),
          foregroundColor: Colors.black,
          onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddData()),
            ),

          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
  String getText(String? titleEnc){
   // Codec<String, String> stringToBase64 = utf8.fuse(base64);
   // return stringToBase64.decode(titleEnc.toString());
    return titleEnc.toString();
  }
}
