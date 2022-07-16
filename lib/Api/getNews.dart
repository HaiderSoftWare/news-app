import 'dart:convert';

import 'package:http/http.dart' as http;

Future getData(String link) async {
  var data;
  http.Response respone = await http.get(
    Uri.parse(link),
  );

  if (respone.statusCode == 200) {
    data = jsonDecode(respone.body);
  } else {
    print('Error in ${respone.hashCode}');
  }

  return data;
}
