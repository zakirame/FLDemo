import 'package:fl_storage/constants.dart';
import 'package:fl_storage/samples.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_storage/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class Footer extends StatelessWidget {
  final String _activeTab;
  Footer(this._activeTab);

  Widget build(BuildContext context){
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Container(
      height: isIOS ? 82 : 48,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: shadowColor,
          spreadRadius: 0,
          blurRadius: 14,
          offset: Offset(0, 4),
        )],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: navScreens.map((item) => Tab(item, _activeTab)).toList(),
      )
    );
  }
}

class Tab extends StatelessWidget {
  final Map _data;
  final String _activeTab;

  Tab(this._data, this._activeTab);

  Widget build(BuildContext context){
    bool isActive = _data['screen'] == _activeTab;

    return Expanded(
      child: TouchableOpacity(
        activeOpacity: isActive ? 1 : 0.7,
        onTap: () {
          showAlertDialog('Alert', _data['label'], context);
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: isActive ? Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: footIconShadow,
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: Offset(0, 12),
                      )],
                    ),
                  ) : null,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: isActive ? SvgPicture.asset(
                    "assets/icons/roundedShape.svg",
                    color: footIconBack,
                    alignment: Alignment.center,
                  ) : null,
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${_data['icon']}.svg",
                    color: isActive ? footIconActive : footIconNormal,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}