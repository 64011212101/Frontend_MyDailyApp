// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Types _$TypesFromJson(Map<String, dynamic> json) => Types()
  ..types = (json['types'] as List<dynamic>)
      .map((e) => Type.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TypesToJson(Types instance) => <String, dynamic>{
      'types': instance.types,
    };
