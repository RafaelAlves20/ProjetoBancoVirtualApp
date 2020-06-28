import 'package:bancovirtualapp/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/transaction_auth_dialog.dart';

void main() {
  runApp(BancoVirtualApp());
  }

class BancoVirtualApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData(
    primaryColor: Colors.grey[700],
    accentColor: Colors.grey[600],
    buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent[700],
    textTheme: ButtonTextTheme.primary,
    )
    ),
    home: Dasdboard(),
    );
  }
}



