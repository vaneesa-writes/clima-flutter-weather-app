import 'dart:convert' as convert;

// import 'dart:developer';

import 'package:http/http.dart' as http;

const String apiKey = '96575d0739379fdfa371be9256510356';

class Networking {
  Networking({required this.url});

  var url;
  Future<Map<String, dynamic>> NetworkHelper() async {
    // log('${url.runtimeType}');
    try {
      var response = await http.get(url);
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } catch (e) {
        // log('Request failed with status: ${response.statusCode}');
        throw "";
      }
    } catch (e) {
      // log('no internet');
      throw 'no internet';
    }
  }
}
