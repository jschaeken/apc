import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApcRoute extends CupertinoPageRoute {
  ApcRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);
}
