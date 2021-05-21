import 'package:fl_storage/components/fileList.dart';
import 'package:fl_storage/components/pie.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Pie(),
            FileList(),
          ],
        ),
      )
    );
  }
}