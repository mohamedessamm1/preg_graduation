import 'package:flutter/material.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/video_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  await launchUrl(
    url,
    mode: LaunchMode.externalApplication, // مهم جدًا لمقاطع يوتيوب
  );
}

class ListVideoTile extends StatelessWidget {
  List? videoOnTapList;
  List? videoTitleList;
   ListVideoTile({super.key,required this.videoTitleList,required this.videoOnTapList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
        itemBuilder:(context, index) {
          return VideoTile(
            title: videoTitleList?[index].toString(),
            onTap:(){
              _launchURL(videoOnTapList![index].toString());
              print(videoOnTapList?[index]);
            }
          );
        } ,
        separatorBuilder: (context, index) => SizedBox(),
        itemCount: videoTitleList!.length
    );
  }
}
