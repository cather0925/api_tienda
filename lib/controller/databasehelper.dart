// ignore: unused_import
import 'package:api_tienda/views/editpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataBaseHelper {
  Future<http.Response> addUser(
      String name, String email, String address) async {
    var url = Uri.parse('192.168.1.5:8080/addUser');
    Map<String, String> data = {
      'name': name,
      'email': email,
      'address': address,
    };

    var body = json.encode(data);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response;
  }

  Future<http.Response> editUser(
      String id, String name, String email, String address) async {
    var url = Uri.parse('http://192.168.1.5:8080/updater');
    Map<String, String> data = {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
    };

    var body = json.encode(data);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response;
  }

  Future<http.Response> removeRegister(String id) async {
    var url = Uri.parse('http:192.168.1.5:8080/delete/$id');

    var response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }
}
