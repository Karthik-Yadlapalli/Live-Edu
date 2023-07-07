import 'package:flutter/material.dart';
import 'package:live_edu/widgets/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../app_constants/edu_colors.dart';
import '../utils/page_button.dart';


class GuideScreen extends StatelessWidget {
  GuideScreen({super.key});
  final _controller = PageController();


//*setting flag for first time user and storing in device once the user visits the GuideScreen
  void setFirstTimeUserFlag() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', true);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible( 
              flex: 4,
              // fit: FlexFit.tight,
              child: PageView(
                controller: _controller,
                children:  [guidPage1(context), guidPage2(context), guidPage3(context)],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            activeDotColor: const Color(0xFFA2C3FC),
                            dotColor: Colors.blue[100]!)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Center(
                      child: PageButton(buttonText: 'Next', buttonTap: () {
                        setFirstTimeUserFlag();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuthPage() ));
                      },),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget guidPage1(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.11,),
        Center(
          child: Image.asset("asstes/illustrations/svgviewer-output.png"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
        ),
        Padding(
          padding: const EdgeInsets.only(left:22.0),
          child: SizedBox(
            height: 75,
            width: 245,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Explore New Courses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                    "Study and watch all our new courses and their are many of them")
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget guidPage2(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.11,),
        Center(
          child: Image.asset("asstes/illustrations/svgviewer-output (1).png"),
        ),
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.16,
        ),
        Padding(
          padding: const EdgeInsets.only(left:22.0),
          child: SizedBox(
            height: 75,
            width: 245,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "See your Goals",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text("Learn new things everyday and earn rewards to be on top")
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget guidPage3(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.11,),
        Center(
          child: Image.asset("asstes/illustrations/svgviewer-output (2).png"),
        ),
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
        ),
        Padding(
          padding: const EdgeInsets.only(left:22.0),
          child: SizedBox(
            height: 75,
            width: 290,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Move on to the Next course",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                    "Don't stop at one, start learning new things and make progress"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
