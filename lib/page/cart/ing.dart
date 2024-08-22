import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
 
class ImageCacheManager {
  static final ImageCacheManager _instance = ImageCacheManager._internal();

  factory ImageCacheManager() {
    return _instance;
  }

  ImageCacheManager._internal();

  final Map<String, Uint8List> _imageCache = LinkedHashMap();

  void addToCache(String key, Uint8List imageBytes) {
    _imageCache[key] = imageBytes;
  }

  Uint8List? getFromCache(String key) {
    return _imageCache[key];
  }
}
