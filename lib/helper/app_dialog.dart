import 'package:flutter/cupertino.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class AppDialog {

  BuildContext context;
  String title, content;
  List<Widget> actions;

  AppDialog({
    required this.context,
    required this.title,
    required this.content,
    required this.actions
  }){
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text(title),
        content: Text(content),
        actions: actions,
      )
    );
  }

}