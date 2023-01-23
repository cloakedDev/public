import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:coffee_ui/coffee_ui.dart';

class CoffeeRepository {
  CoffeeRepository();

  /// grab image from the Coffee API
  Future<dynamic> grabImage() async {
    Coffee image;
    String? imageUrl;

    int timeout = 5;
    try {
      http.Response response = await http
          .get(Uri.parse('https://coffee.alexflipnote.dev/random.json'))
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(response.body.toString()) as Map<String, dynamic>;

        image = Coffee.fromJson(jsonResponse);

        imageUrl = image.file;
        return imageUrl!;
      } else {
        return null;
      }
    } on TimeoutException catch (e) {
    } on SocketException catch (e) {
    } on Error catch (e) {}
  }
}
