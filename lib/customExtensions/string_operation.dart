import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    if(this != null) {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
  }
}