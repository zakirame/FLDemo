import 'package:fl_chart/fl_chart.dart';
import 'package:fl_storage/constants.dart';
import 'package:fl_storage/samples.dart';
import 'package:flutter/material.dart';
import 'package:fl_storage/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:flutter/gestures.dart';

class Pie extends StatelessWidget {
  Widget build(BuildContext context){
    return Container(
      height: 360,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '67.5 GB',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: pieFont,
                          fontFamily: 'AvenirNextDemi',
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        int touchedIndex = -1;
                        final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent && pieTouchResponse.touchInput is! PointerUpEvent;
                        if (desiredTouch && pieTouchResponse.touchedSection != null) {
                          touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                        } else {
                          touchedIndex = -1;
                        }

                        if (touchedIndex != -1 ) {
                          showAlertDialog('Alert', graphData[touchedIndex]['label'], context);
                        }
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 15,
                      centerSpaceRadius: 66,
                      sections: generateSecions(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 44,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              itemCount: graphData.length,
              itemBuilder: (BuildContext context, int index) {
                Map item = graphData[index];
                Color itemColor = Color(int.parse("0xff${colors[item['type']]}"));

                return TouchableOpacity(
                  activeOpacity: 0.7,
                  onTap: () {
                    showAlertDialog('Alert', item['label'], context);
                  },
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(children: [
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            "assets/icons/roundedShape.svg",
                            color: itemColor,
                            width: 16,
                            height: 16,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                        child: Text(
                          item['label'],
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: catTitle,
                            height: 1.47,
                            fontFamily: 'AvenirNextMedium',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            color: fileDescColor,
                          ),
                        )
                      )
                    ],)
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

List<PieChartSectionData> generateSecions() {
  List<PieChartSectionData> sections = [];

  graphData.forEach((item) {
    sections.add(PieChartSectionData(
      color: new Color(int.parse("0xff${colors[item['type']]}")),//.withOpacity(0.15),
      value: item['value'],
      radius: 52.0,
      showTitle: false,
    ));
  });

  return sections;
}