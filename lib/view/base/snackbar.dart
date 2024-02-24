
import 'package:flutter/material.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(key: UniqueKey(), content: Text(message),
      behavior: SnackBarBehavior.floating ,
      dismissDirection: DismissDirection.down,
      backgroundColor: isError ? Colors.red : Colors.green)
  );
}