import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog (String title, String body, BuildContext context) {
  bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      if (isIOS) {
        return CupertinoAlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context, 'OK'),
            )
          ],
        );
      } else {
        return AlertDialog(
          title: new Text(title),
            content: new Text(body),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('Close'),
              ),
            ],
        );
      }
    },
  );
}

String numWords (int value) {
  List words = ['time', 'times', 'times']; 
  value = value.abs() % 100; 
  int num = value % 10;
  if(value > 10 && value < 20) return words[2]; 
  if(num > 1 && num < 5) return words[1];
  if(num == 1) return words[0]; 
  return words[2];
}