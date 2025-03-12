import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
 String imageUrl;
   ImageSection({super.key,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return     ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Image.asset(imageUrl
        , // Replace with actual image
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
      ),
    );

  }
}
