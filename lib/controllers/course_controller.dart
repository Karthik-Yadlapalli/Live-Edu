import 'package:flutter/material.dart';
import '../modals/course.dart';

class CourseManager extends ChangeNotifier{

  final List<Course> _courses = [
    Course(name: 'Elementry', descreption: "This is a begineers course", price: 400, imgThumbnail: "asstes/illustrations/svgviewer-output (1) copy.png", id: DateTime.now().toString(), rating: 4.2),
    Course(name: "Advanced", descreption: "This is an advanced course", price: 500, imgThumbnail: "asstes/illustrations/svgviewer-output copy.png", id: DateTime.now().toString(), rating:3.8),
      Course(name: "Pro", descreption: "This is an por level course", price: 600, imgThumbnail: "asstes/illustrations/svgviewer-output (1) copy.png", id: DateTime.now().toString(), rating: 4.1),
    Course(name: "Elite", descreption: "This is an elite course", price: 700, imgThumbnail: "asstes/illustrations/svgviewer-output copy.png", id: DateTime.now().toString(), rating: 3.7),
  ];

  List<Course> get courses => _courses;

 //*Add new courses
  void addCourse(){}

//*Deleteing existing courses
  void deleteCourse(){} 

//*Updateing existing course
  void updateCourse(){}

}