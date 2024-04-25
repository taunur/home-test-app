import 'package:json_annotation/json_annotation.dart';

part 'data_group_model.g.dart';

@JsonSerializable()
class DataGroupM {
  final String branch;
  @JsonKey(name: 'posting_date')
  final String postingDate;

  DataGroupM({
    required this.branch,
    required this.postingDate,
  });

  factory DataGroupM.fromJson(Map<String, dynamic> json) =>
      _$DataGroupMFromJson(json);

  Map<String, dynamic> toJson() => _$DataGroupMToJson(this);
}
