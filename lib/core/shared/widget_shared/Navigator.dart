import 'package:flutter/material.dart';

class Navigation {
  Future navigateTo({required BuildContext context, required screenName}) {
    return Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 900),
          pageBuilder: (context, animation, secondAnimation) => screenName,
          transitionsBuilder: (context, animation, secondAnimation, child) {
            var begin = Offset(-1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ));
  }

  Future navigateAndRemove(
      {required BuildContext context, required screenName}) {
    return Navigator.pushAndRemoveUntil(

        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 900),
          pageBuilder: (context, animation, secondAnimation) => screenName,
          transitionsBuilder: (context, animation, secondAnimation, child) {
            var begin = Offset(-1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
        (route) => false);
  }
}
