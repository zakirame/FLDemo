import 'package:fl_storage/constants.dart';
import 'package:fl_storage/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class Header extends StatelessWidget {
  final String _title;
  Header(this._title);

  Widget build(BuildContext context){
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: -2,
            width: 480,
            height: 62,
            child: SvgPicture.asset(
              "assets/icons/header.svg",
              alignment: Alignment.topLeft,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 44, 10, 0),
            child: Row(
              children: <Widget>[
                TouchableOpacity(
                  activeOpacity: 0.7,
                  onTap: () {
                    showAlertDialog('Alert', 'Back button pressed', context);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
		                child: Center(
                      child: Container(
                        width: 20,
                        height: 14,
                        child: SvgPicture.asset(
                          "assets/icons/backArrow.svg",
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      _title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: titleFont,
                        fontFamily: 'AvenirNextDemi',
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}