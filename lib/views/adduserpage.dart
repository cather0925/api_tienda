import 'package:api_tienda/controller/databasehelper.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final DataBaseHelper dataBaseHelper = DataBaseHelper();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: 'Name', icon: Icon(Icons.person)),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', icon: Icon(Icons.email)),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                  labelText: 'Address', icon: Icon(Icons.place)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    addressController.text.isNotEmpty) {
                  dataBaseHelper.addUser(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    addressController.text.trim(),
                  );
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are required!')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
