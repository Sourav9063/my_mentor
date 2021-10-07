import 'dart:convert';

import 'package:flutter/material.dart';

class Task {
  final String name;
  final String beginTime;
  final String endTime;
  Task({
    required this.name,
    required this.beginTime,
    required this.endTime,
  });
 

  Task copyWith({
    String? name,
    String? beginTime,
    String? endTime,
  }) {
    return Task(
      name: name ?? this.name,
      beginTime: beginTime ?? this.beginTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'beginTime': beginTime,
      'endTime': endTime,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'] ?? '',
      beginTime: map['beginTime'] ?? '',
      endTime: map['endTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() => 'Task(name: $name, beginTime: $beginTime, endTime: $endTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Task &&
      other.name == name &&
      other.beginTime == beginTime &&
      other.endTime == endTime;
  }

  @override
  int get hashCode => name.hashCode ^ beginTime.hashCode ^ endTime.hashCode;
}
