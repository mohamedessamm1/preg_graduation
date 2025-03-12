import 'package:flutter/material.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/video_tile.dart';

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
              print(videoOnTapList?[index]);
            }
          );
        } ,
        separatorBuilder: (context, index) => SizedBox(),
        itemCount: videoTitleList!.length
    );
  }
}
