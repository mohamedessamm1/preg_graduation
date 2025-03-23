import 'package:flutter/material.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/video_tile.dart';
import 'package:url_launcher/url_launcher.dart';
void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ListVideoTile extends StatelessWidget {
  List? videoOnTapList;
  List? videoTitleList;
   ListVideoTile({super.key,required this.videoTitleList,required this.videoOnTapList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
