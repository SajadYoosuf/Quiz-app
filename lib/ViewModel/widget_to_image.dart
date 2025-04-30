import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io' show File, Platform;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class WidgetToImage {
  String? mediaPath;
  Future<String> capturePng(BuildContext context, GlobalKey globalKey) async {
    try {
      final RenderRepaintBoundary boundary = globalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData?.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes!);
      // _mediaPath = bs64;
      final directory = await getExternalStorageDirectory();
      final filePath =
          '${directory?.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(filePath);
      await imageFile.writeAsBytes(pngBytes);
      return mediaPath = imageFile.path;

      // return pngBytes;
    } catch (e) {
      print(e);

      throw Exception(e.toString());
    }
  }
}
