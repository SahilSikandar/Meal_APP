import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String? img;

  const Category({
    required this.id,
    required this.title,
    this.img,
  });
}
