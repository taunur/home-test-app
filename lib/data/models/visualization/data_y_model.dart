import 'package:json_annotation/json_annotation.dart';

part 'data_y_model.g.dart';

@JsonSerializable()
class DataY {
  final String branch;
  @JsonKey(name: 'posting_date')
  final String postingDate;
  @JsonKey(name: 'total_transactions')
  final int totalTransactions;

  DataY({
    required this.branch,
    required this.postingDate,
    required this.totalTransactions,
  });

  factory DataY.fromJson(Map<String, dynamic> json) => _$DataYFromJson(json);

  Map<String, dynamic> toJson() => _$DataYToJson(this);
}