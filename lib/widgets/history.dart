
// ignore_for_file: use_key_in_widget_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_constants/edu_Icons.dart';
import '../app_constants/edu_colors.dart';
import '../modals/flowChart_modal.dart';
import '../providers/course_provider.dart';


class HistoryPage extends ConsumerWidget {
   HistoryPage({super.key});

 final List<BarData> timeSpentData = [
  BarData("Mon", 13, 1),
  BarData("Tue", 9, 2),
  BarData("Wed", 3, 3,),
  BarData("Thu", 13, 4),
  BarData("Fri", 12, 5),
  BarData("Sut", 4, 6),
  BarData("Sun", 12, 7),
 ];


 final List<BarData> pasedTestData = [BarData(1, 13,0),
  BarData("2", 9,1),
  BarData("3", 8,2),
  BarData("4", 14,3),
  BarData("5", 5,4),
  BarData("6", 11,5),
  BarData("7", 12,6),
  BarData("8", 4,7),
  BarData("9", 12,8)
  ];


  @override
  Widget build(BuildContext context ,WidgetRef ref) {
      final courseManager =  ref.watch(courseProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 18,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xFFBFC3FC).withOpacity(0.3),
            ),
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.bar_chart,color:  Color(0xFFBFC3FC)),
                    Padding(
                      padding: EdgeInsets.only(left:8.0),
                      child: Text('Time spent in app'),
                    )
                  ],
                ),
                const SizedBox(height: 18.0),
                SizedBox(
                  height: 170,
                  child: appTimeBarChart(context, timeSpentData, 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xFFBFC3FC).withOpacity(0.3),
            ),
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.bar_chart,color:  Color(0xFFBFC3FC)),
                    Padding(
                      padding: EdgeInsets.only(left:8.0),
                      child: Text('Passed Tests'),
                    )
                  ],
                ),
                const SizedBox(height: 18.0),
                SizedBox(
                  height: 170,
                  child: appTimeBarChart(context, pasedTestData , 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18,),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 18),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text("Recently Viewed",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
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
                          Image.asset(courseManager.courses[index].imgThumbnail,height: 180, width: 180,),
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
            )
        ],
      ),
    );
  }

   Widget getTitles(double value, TitleMeta meta) {
    // if (value == 0) {
    //   return SideTitleWidget(
    //       axisSide: meta.axisSide,
    //       child: const Text(
    //         "0",
    //       ));
    // } else {
      return SideTitleWidget(
        space: 1,
        axisSide: meta.axisSide,
        // angle: 45,
        child: Text(timeSpentData[value.toInt()].title),
      );
  }


  Widget appTimeBarChart(BuildContext context, var data, double maxY) {
    return  BarChart(
      BarChartData(
      // backgroundColor: const Color(0xFFBFC3FC).withOpacity(0.3),
      maxY: maxY,
      minY: 0,
      baselineY: 0,
      titlesData: FlTitlesData(topTitles: AxisTitles(), rightTitles: AxisTitles(), 
      // bottomTitles: AxisTitles(sideTitles: SideTitles(
      //   getTitlesWidget:getTitles        
      // ))
      ),
      gridData: FlGridData(
        show: false
      ),
        borderData: FlBorderData(
          show: false,
           ),
        barGroups: [
          for(BarData item in data)
              BarChartGroupData(x: item.x, 
            barRods: [
            BarChartRodData(fromY: 0, toY: item.y, width: 15, color: const Color(0xFFA2C3FC)),
          ]),
        ]));
        }
  }
  