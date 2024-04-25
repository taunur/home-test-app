import 'package:json_annotation/json_annotation.dart';

part 'data_group_model.g.dart';

@JsonSerializable()
class DataGroupV {
  final String branch;

  DataGroupV({
    required this.branch,
  });

  factory DataGroupV.fromJson(Map<String, dynamic> json) => _$DataGroupVFromJson(json);

  Map<String, dynamic> toJson() => _$DataGroupVToJson(this);
}