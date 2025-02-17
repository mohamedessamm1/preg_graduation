import 'package:flutter/material.dart';
import 'package:pregnant_care/core/shared/Cache/local_cache.dart';

import '../../../auth/login/presentation/pages/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('ProfileScreen'),
          TextButton(onPressed: (){
            CacheHelper.removedata(key: 'token');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

          }, child: Text('logout'))
        ],
      ),
    );
  }
}
