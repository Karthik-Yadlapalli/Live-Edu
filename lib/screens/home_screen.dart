// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:live_edu/app_constants/edu_Icons.dart';
import 'package:live_edu/app_constants/edu_colors.dart';
import 'package:live_edu/widgets/home.dart';
import 'package:live_edu/widgets/profile.dart';
import 'package:live_edu/widgets/quiz_topics.dart';

import '../widgets/history.dart'; 

class HomeScreen extends StatefulWidget {
 const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   List<Widget> _pages =  [const HomePage(), const QuizPage(), HistoryPage(), const ProfilePage(),];

    int _selectedIndex = 0;

    void _selectedPage(int index){
      setState(() {
         _selectedIndex = index;
      });
    } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 150, 
          width: double.infinity, 
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
            gradient: EduColors.primaryGradient
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:80.0, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hi Karthik',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
                    SizedBox(
                      height: 5,
                    ),
                    Text('All your information')
                  ],
                ),
                const Spacer(),
                const Icon(EduIcons.coin,color: EduColors.optCoinColor, size: 30,),
                const SizedBox(width: 5), 
               const  Padding(padding: EdgeInsets.only(top: 5),child:Text('400'),),
                 const SizedBox(width: 16,), 
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: const Icon(EduIcons.notifaction))
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox(child: _pages[_selectedIndex],))
      ],),
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true, 
        showUnselectedLabels: false,
        onTap: _selectedPage,
        selectedItemColor: const Color(0xFFBFC3FC),
        unselectedItemColor: Colors.black,
        items: const [
        BottomNavigationBarItem(icon: Icon(EduIcons.home,),label: 'Home',),
        BottomNavigationBarItem(icon: Icon(Icons.checklist),label: 'Quizes',),
        BottomNavigationBarItem(icon: Icon(Icons.history),label: 'history',),
        BottomNavigationBarItem(icon: Icon(Icons.person_outlined),label: 'profile',),
      ]),
    );
  }
}
