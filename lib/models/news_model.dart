import 'package:flutter/material.dart';

class News {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  News({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }
}

class Favouritemodel {
  String title;
  String url;

  Favouritemodel({required this.title, required this.url});
}

class TextControllerModel {
  TextEditingController titleTxt = TextEditingController();
  TextControllerModel({required this.titleTxt});
}
