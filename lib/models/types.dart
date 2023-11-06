import 'package:flutter/src/material/dropdown.dart';
import 'package:json_annotation/json_annotation.dart';

import "type.dart";

part 'types.g.dart';

@JsonSerializable()
class Types {
  Types();

  late List<Type> types;

  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);
  Map<String, dynamic> toJson() => _$TypesToJson(this);

  map(DropdownMenuItem<Object> Function(dynamic val) param0) {}
}
