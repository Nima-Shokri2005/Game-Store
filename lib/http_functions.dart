import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

String toHash(String str) {
  // First Encode To UTF-8 Format
  List<int> bytes = utf8.encode(str);
  // After Converting To UTF-8 Format It Will Convert To SHA-256 Format:
  Digest hash = sha256.convert(bytes);
  return hash.toString();
}


//template_azeusee for email confirmation
//template_cziytcp for reset password
Future sendEmail({
  required String email,
  required String template,
  required String name,
  required String code,
}) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(
      {
        'service_id': 'service_u9y1rse',
        'template_id': template,
        'user_id': 'WilfVudVGcrV_E0vv',
        'template_params': {
          'email': email,
          'name': name,
          'code': code,
        },
      },
    ),
  );
  print(response.body);
}

Future<String> executeQuery(String query) async {
// URL of your PHP script
  String url = 'https://devnima.ir/main.php';

  // Data to be sent in the HTTP POST request
  Map<String, String> data = {
    'query': query,
  };

  try {
    print("trying...");
    // Send POST request
    var response = await http.post(Uri.parse(url), body: data);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // If you expect some response from the PHP script, you can handle it here
      print("!");
      print(response.body);
      print("!");
      return response.body;
    } else {
      // Handle error if request fails
      print(' > > > > >Error: ${response.body}');
      return response.body;
    }
  } catch (e) {
    // Handle other types of errors
    print('Error (executeQuery): $e');
    return "ERR";
  }
}

Future<String> uploadImage(File imageFile) async {
  var uri = Uri.parse('http://dl.devnima.ir/main.php');
  var request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  var response = await request.send();
  if (response.statusCode == 200) {
    // Read the response stream and convert it to a string
    String responseString = await response.stream.bytesToString();
    return responseString;
  } else {
    throw Exception('Failed to upload image');
  }
}