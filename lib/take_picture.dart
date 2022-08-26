import 'dart:convert';

import 'package:http/http.dart' as http;

void takePicture() async {
  Map<String, String> header = {
    'Content-Type': 'application/json; charset=utf-8'
  };
  Map<String, dynamic> body = {'name': 'camera.takePicture'};
  Uri url = Uri.parse('http://192.168.1.1/osc/commands/execute');
  var response = await http.post(url, headers: header, body: jsonEncode(body));
  print(response.body);
}
