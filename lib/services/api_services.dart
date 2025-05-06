import 'dart:convert';
import 'package:quiz_app/Model/quiz_data_model.dart';
import 'package:http/http.dart' as http;

class TriviaApi {
  Future<QuizData> getQuizData(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        // print('success');
        // // If the server did return a 200 OK response,
        // // then parse the JSON.
        // print(response.body);
        return QuizData.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (parseError) {
      throw Exception(parseError.toString());
    }
  }
}
