import 'dart:convert';
// ignore: unused_import
import 'dart:math';
import 'package:api_tienda/views/detailpage.dart';
// ignore: unused_import
import 'package:api_tienda/views/adduserpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  late Future<List> data;

  Future<List> getData() async {
    final response = await http.get(Uri.parse('http:192.168.1.5:8080/user'));
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: FutureBuilder<List>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return snapshot.data == null
              ? const Center(child: Text('No data available'))
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index]['name']),
                      subtitle: Text(snapshot.data![index]['email']),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            list: snapshot.data!,
                            index: index,
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
