// ignore_for_file: unused_import

import 'package:api_tienda/controller/databasehelper.dart';
import 'package:api_tienda/views/editpage.dart';
import 'package:api_tienda/views/listviewproduct.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;

  const Detail({super.key, required this.index, required this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  Future<void> _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListUser()),
    );

    if (result == true) {
      setState(() {});
    }
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure you want to delete this record?"),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            dataBaseHelper
                .removeRegister(widget.list[widget.index]['id'].toString());
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Text(
                  widget.list[widget.index]['name'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Text(
                  widget.list[widget.index]['email'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditUserPage(
                            list: widget.list,
                            index: widget.index,
                          ),
                        ),
                      ),
                      child: const Text("Edit"),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () => confirm(),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
