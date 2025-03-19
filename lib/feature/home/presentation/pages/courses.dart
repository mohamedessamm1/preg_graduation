import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pregnant_care/core/shared/Colors/colors.dart';
import 'package:pregnant_care/feature/home/presentation/manager/home_cubit.dart';
import 'package:pregnant_care/feature/home/presentation/widgets/grid_view_courses.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      var courses = HomeCubit.get(context).courses['groupedPosts'];
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Courses', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.brown,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Color(0xFFD2A482),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 8),
              GridViewCourses(course: courses['Childhood'],courseName: 'Childhood',),
              Divider(color: Colors.white,),
              GridViewCourses(course: courses['Motherhood'],courseName: 'Motherhood',),
              Divider(color: Colors.white,),

              GridViewCourses(course: courses['Foods'],courseName: 'Foods',),
              Divider(color: Colors.white,),

              GridViewCourses(course: courses['Exercises'],courseName: 'Exercises',),
              SizedBox(height: 20),
            ],
          ),
        ),


      );
    },);
  }
}
