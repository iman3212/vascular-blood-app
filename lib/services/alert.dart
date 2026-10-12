import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ExceptionAlert {
 

  CupertinoAlertDialog _cupertinoAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: TextButton(
            onPressed: () async {
              // await checkConnection();
            },
            child: const Text("Try again"),
          ),
        )
      ],
    );
  }

  

  void showAlert({
    required BuildContext context,
    required String title,
    required String content,
   
  }) async {
    // await checkConnection();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoAlertDialog(
          context: context,
          title: title,
          content: content,
        );
      },
    );
  }
}
