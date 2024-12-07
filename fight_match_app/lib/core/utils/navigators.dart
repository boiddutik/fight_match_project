import 'package:flutter/material.dart';

void popNavigate(BuildContext context) {
  Navigator.of(context).pop();
}

void navigate(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndReplace(BuildContext context, Widget widget) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndRemoveUntil(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (_) => false,
  );
}
