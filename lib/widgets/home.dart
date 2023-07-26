// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_edu/app_constants/edu_Icons.dart';
import 'package:live_edu/app_constants/edu_colors.dart';
import '../providers/course_provider.dart'; 

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
     final courseManager =  ref.watch(courseProvider);
     final topicsManager = ref.watch(courseTopicProvider);
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height-150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 5, 
              fit: FlexFit.tight,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left:16.0 , top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Padding(
                      padding:  EdgeInsets.symmetric(vertical:10.0, horizontal:8.0),
                      child: Text("Courses",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: courseManager.courses.length,
                        itemBuilder: (ctx , index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Image.asset(courseManager.courses[index].imgThumbnail,height:180, width: 180,),
                                Positioned(
                                  top: 10, 
                                  left: 10,
                                  child: Container(
                                  height: 20, 
                                  width: 43,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.white),
                                  child: Center(child: Row(
                                    children: [
                                       Padding(
                                        padding:  const EdgeInsets.only(right:3.0),
                                        child: Icon(Icons.star,size:15,color: Colors.grey[400],),
                                      ),
                                      Text(courseManager.courses[index].rating.toString(),style: TextStyle(color: Colors.grey[500])),
                                    ],
                                  )),
                                  
                                  ))
                            
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(courseManager.courses[index].name, style: const TextStyle(fontSize: 18),),
                                      Row(
                                        children: [
                                          const Icon(EduIcons.coin,size: 15,color: EduColors.optCoinColor,),
                                          const SizedBox(width: 3,),
                                          Text(courseManager.courses[index].price.toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(courseManager.courses[index].descreption)
                              ],
                            ),
                          )
                        ],);
                      }),
                    )
                
                  ]),
                ),
                
              ),
            ),
            Flexible(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:  EdgeInsets.symmetric(horizontal:8.0,vertical: 16),
                      child: Text("Topics to study",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height-540,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: topicsManager.courseTopics.length,
                        itemBuilder: (ctx, index){return Padding(
                          padding: const EdgeInsets.only(bottom:10.0 , right: 10.0),
                          child: Container(
                          height: 70, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), 
                            color: const Color(0xFFBFC3FC).withOpacity(0.2)
                          ),
                          child: ListTile(
                            leading: Image.asset(topicsManager.courseTopics[index].videoThumbnail),
                            title: Text(topicsManager.courseTopics[index].title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                            subtitle: Text(topicsManager.courseTopics[index].subTitle),
                            trailing: Text('${topicsManager.courseTopics[index].duration} min',style: const TextStyle(color: Color(0xFFBFC3FC)),),
                          ),
                                          ),
                        );}),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
