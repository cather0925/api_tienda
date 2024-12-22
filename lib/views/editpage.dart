import 'package:api_tienda/controller/databasehelper.dart';
import 'package:api_tienda/views/listviewproduct.dart';
import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  final List list;
  final int index;

  const EditUserPage({super.key, required this.list, required this.index});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final DataBaseHelper dataBaseHelper = DataBaseHelper();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerAddress;
  late TextEditingController controllerId;

  @override
  void initState() {
    super.initState();
    controllerId = TextEditingController(
      text: widget.list[widget.index]['id'].toString(),
    );
    controllerName = TextEditingController(
      text: widget.list[widget.index]['name'].toString(),
    );
    controllerEmail = TextEditingController(
      text: widget.list[widget.index]['email'].toString(),
    );
    controllerAddress = TextEditingController(
      text: widget.list[widget.index]['address'].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                title: TextFormField(
                  controller: controllerId,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                title: TextFormField(
                  controller: controllerName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.black),
                title: TextFormField(
                  controller: controllerEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.black),
                title: TextFormField(
                  controller: controllerAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    dataBaseHelper.editUser(
                      controllerId.text.trim(),
                      controllerName.text.trim(),
                      controllerEmail.text.trim(),
                      controllerAddress.text.trim(),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListUser(),
                      ),
                    );
                  }
                },
                child: const Text('Edit User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
