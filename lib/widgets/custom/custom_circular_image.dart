import 'dart:io';

import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    this.imageURL,
    this.file,
    this.radius = 24,
    this.placeHolder,
    super.key,
  });
  final String? imageURL;
  final File? file;
  final String? placeHolder;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + 2,
      backgroundColor: Colors.grey.shade300,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: imageURL == null || (imageURL?.isEmpty ?? true)
            ? null
            : NetworkImage(imageURL ?? ''),
        child: file != null
            ? ClipOval(
                child: Image.file(
                  file!,
                  width: 2 * (radius),
                  height: 2 * (radius),
                  fit: BoxFit.cover,
                ),
              )
            : ClipOval(
                child: Image.asset(
                  AppImages.dummyProfile,
                  width: 2 * (radius),
                  height: 2 * (radius),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
