import 'package:flutter/material.dart';

import 'body_content_section.dart';
import 'image_Section.dart';
import 'list_video_tile.dart';

class AllBodyVideoTips extends StatelessWidget {
  String content;
  String imageUrl;
 List ?videoTileList;
 List? videoOnTapList;
  String title;
   AllBodyVideoTips({super.key,required this.videoOnTapList,   required  this.videoTileList, required this.content, required this.imageUrl, required this.title, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB08E72),
      ),
      backgroundColor: Color(0xFFB08E72),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB08E72), // Card background color
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageSection(imageUrl: imageUrl),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyContentSection(title:title, content: content),
                          Column(
                            children: [
                              SizedBox(
                                  height: 350,
                                  child: ListVideoTile(
                                    videoOnTapList:videoOnTapList ,
                                    videoTitleList: videoTileList,)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
