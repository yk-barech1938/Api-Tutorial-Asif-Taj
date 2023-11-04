import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // extra work because we dont have array name in response
  // in response it is just returning objects in array
  List<PostsModel> postList = [];
  // response is future, because if we hit the api end url we wait
  // so we wait that's why we use future function
  // async use because of future function we wait
  Future<List<PostsModel>> getAllPostsApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    // every response is coming with the its status code
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {return postList;}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Asif Taj'),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
