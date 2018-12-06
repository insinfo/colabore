//ModalProgressIndicator
import 'package:flutter/material.dart';

Widget modalProgressIndicator({color = Colors.black}) {
  return Stack(
    children: [
      Opacity(
        opacity: 0.3,
        child: ModalBarrier(dismissible: false, color: color),
      ),
      Center(
        child: CircularProgressIndicator(),
      ),
    ],
  );
}
