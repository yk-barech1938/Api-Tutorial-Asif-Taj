import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = [];
  Future<List<Photos>> getAllPhotos() async {
    final response = await http
        .get(Uri.parse('test'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
    //  photosList.clear();
      for (Map i in data) {
        // matching or maping the fields
        Photos photo = Photos(title: i['title'], url: i['url'],id: i['id']);
        photosList.add(photo);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('API Asif Taj Example 2'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getAllPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),

                          title: Text('Posts Id: ${snapshot.data![index].id ?? "No ID"}'),
                          subtitle: Text(snapshot.data![index].title?.toString() ?? "No title"),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url,required this.id, });
}
