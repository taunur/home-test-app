import 'package:json_annotation/json_annotation.dart';

part 'data_raw_model.g.dart';

@JsonSerializable()
class DataRaw {
  final String branch;
  @JsonKey(name: 'posting_date')
  final String postingDate;
  final String customer;
  @JsonKey(name: 'grand_total')
  final int grandTotal;

  DataRaw({
    required this.branch,
    required this.postingDate,
    required this.customer,
    required this.grandTotal,
  });

  factory DataRaw.fromJson(Map<String, dynamic> json) =>
      _$DataRawFromJson(json);

  Map<String, dynamic> toJson() => _$DataRawToJson(this);
}
