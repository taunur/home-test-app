import 'package:json_annotation/json_annotation.dart';

part 'data_x_model.g.dart';

@JsonSerializable()
class DataX {
  final String branch;
  @JsonKey(name: 'posting_date')
  final String postingDate;
  final int visitors;

  DataX({
    required this.branch,
    required this.postingDate,
    required this.visitors,
  });

  factory DataX.fromJson(Map<String, dynamic> json) => _$DataXFromJson(json);

  Map<String, dynamic> toJson() => _$DataXToJson(this);
}