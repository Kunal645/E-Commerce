import 'dart:io';

import 'package:ecom/constant/color_constant.dart';
import 'package:ecom/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenPhotoView extends StatelessWidget {
  final String? url;
  const FullScreenPhotoView({required this.url,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.kPrimaryBGColor,
        title: Text('Profile Picture',style: TextStyles.k16Bold()),
      ),
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered,
        imageProvider: Image.network(url.toString()).image,
      ),
    );
  }
}
