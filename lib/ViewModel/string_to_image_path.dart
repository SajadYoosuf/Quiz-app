import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class StringToImagePath {
  static Future<String?> stringToImagePath(String imageD) async {
    final response = await http.get(Uri.parse(imageD));
    if (response.statusCode == 200) {
      imageD = response.bodyBytes.toString();
      final directory = await getExternalStorageDirectory();
      return imageD =
          '${directory!.path}/temp_image.png'; // Choose a suitable extension
    }
    return null;
  }
}
