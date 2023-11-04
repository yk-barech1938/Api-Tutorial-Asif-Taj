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
  // extra work because we don't have array name in response
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
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Asif Taj'),
      ),
      body: Column(
        children: [
        // occupies the data in show data in scrolling
          Expanded(
            // showing the api data we use future builders
            child: FutureBuilder(
              future: getAllPostsApi(),
              builder: (context, snapshot) {
                // initially hitting api we don't have data, we use not ! data
                if (!snapshot.hasData) {
                  return const Text('Loading');
                } else {
                  // using ListView.builder now we are getting a Complete list in response
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Text(
                        index.toString(),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
