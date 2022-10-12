import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class ImageResource {
  final String resource;
  ImageResource({required this.resource});

  Future<Image> getImage();
}

class AssetImageResource extends ImageResource {
  AssetImageResource({required super.resource});

  @override
  Future<Image> getImage() async {
    return Image.asset(resource);
  }
}
