import 'package:fl_storage/components/header.dart';
import 'package:fl_storage/components/footer.dart';
import 'package:fl_storage/components/body.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Header('Storage management'),
          Body(),
          Footer('Settings'),
        ],
      )
    );
  }
}