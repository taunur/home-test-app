// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_x_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataX _$DataXFromJson(Map<String, dynamic> json) => DataX(
      branch: json['branch'] as String,
      postingDate: json['posting_date'] as String,
      visitors: json['visitors'] as int,
    );

Map<String, dynamic> _$DataXToJson(DataX instance) => <String, dynamic>{
      'branch': instance.branch,
      'posting_date': instance.postingDate,
      'visitors': instance.visitors,
    };
