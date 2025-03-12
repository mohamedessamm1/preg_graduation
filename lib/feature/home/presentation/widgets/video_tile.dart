import 'package:flutter/material.dart';

class VideoTile extends  StatelessWidget {
  var title;
  VoidCallback  onTap;

   VideoTile({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF6D4C41),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(Icons.play_circle_fill, color: Color(0xFFFFFFFF)),
            title: Text(
              title,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
            ),

          ),
        ),
      ),
    );
  }
}
