// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_y_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataY _$DataYFromJson(Map<String, dynamic> json) => DataY(
      branch: json['branch'] as String,
      postingDate: json['posting_date'] as String,
      totalTransactions: json['total_transactions'] as int,
    );

Map<String, dynamic> _$DataYToJson(DataY instance) => <String, dynamic>{
      'branch': instance.branch,
      'posting_date': instance.postingDate,
      'total_transactions': instance.totalTransactions,
    };
