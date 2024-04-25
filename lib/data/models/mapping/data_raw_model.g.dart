// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_raw_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataRaw _$DataRawFromJson(Map<String, dynamic> json) => DataRaw(
      branch: json['branch'] as String,
      postingDate: json['posting_date'] as String,
      customer: json['customer'] as String,
      grandTotal: json['grand_total'] as int,
    );

Map<String, dynamic> _$DataRawToJson(DataRaw instance) => <String, dynamic>{
      'branch': instance.branch,
      'posting_date': instance.postingDate,
      'customer': instance.customer,
      'grand_total': instance.grandTotal,
    };
