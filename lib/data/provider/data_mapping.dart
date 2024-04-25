import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_test_app/data/models/mapping/data_group_model.dart';
import 'package:home_test_app/data/models/mapping/data_raw_model.dart';
import 'package:provider/provider.dart';

class DataMappingProvider extends ChangeNotifier {
  List<DataGroupM> _dataGroupM = [];
  List<DataRaw> _dataRaw = [];

  List<DataRaw> get dataRaw => _dataRaw;
  List<DataGroupM> get dataGroupM => _dataGroupM;

  Future<void> loadDataGroupM(String path) async {
    try {
      String jsonString = await rootBundle.loadString(path);
      Iterable data = json.decode(jsonString);
      _dataGroupM = data.map((json) => DataGroupM.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data Group: $e');
    }
  }
  
  Future<void> loadDataRaw(String path) async {
    try {
      String jsonString = await rootBundle.loadString(path);
      Iterable data = json.decode(jsonString);
      _dataRaw = data.map((json) => DataRaw.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data X: $e');
    }
  }
}

Future<List<Map<String, dynamic>>> loadAndProcessDataMapping(
    BuildContext context) async {
  /// Load data local json mapping
  await Provider.of<DataMappingProvider>(context, listen: false)
      .loadDataGroupM('json/mapping/data_group.json');
  if (!context.mounted) return [];
  await Provider.of<DataMappingProvider>(context, listen: false)
      .loadDataRaw('json/mapping/data_raw.json');

  /// Memproses data mapping perhitungan
  if (!context.mounted) return [];
  return processDataMapping(
    Provider.of<DataMappingProvider>(context, listen: false).dataRaw,
    Provider.of<DataMappingProvider>(context, listen: false).dataGroupM,
  );
}

List<Map<String, dynamic>> processDataMapping(
    List<DataRaw> dataRaw, List<DataGroupM> dataGroupM) {
  List<Map<String, dynamic>> result = [];
  Set<String> processedBranches = {};

  for (var group in dataGroupM) {
    if (!processedBranches.contains(group.branch)) {
      /// Hitung grand_total untuk branch tertentu
      var totalBranch = dataRaw
          .where((raw) => raw.branch == group.branch)
          .fold(0, (sum, raw) => sum + raw.grandTotal);

      /// Tambahkan entri untuk branch dengan indent 0
      result.add({
        "indent": 0,
        "branch": group.branch,
        "grand_total": totalBranch,
      });

      processedBranches.add(group.branch);

      /// Ambil semua posting date tiap branch
      var postingDates = dataRaw
          .where((raw) => raw.branch == group.branch)
          .map((raw) => raw.postingDate)
          .toSet();

      /// Perulangan melalui posting_date dan tambahkan dengan indent 1
      for (var date in postingDates) {
        var totalDate = dataRaw
            .where((raw) =>
                raw.branch == group.branch && raw.postingDate == date)
            .fold(0, (sum, raw) => sum + raw.grandTotal);

        result.add({
          "indent": 1,
          "posting_date": date,
          "grand_total": totalDate,
        });

        /// Perulangan melalui dataRaw dan tambahkan dengan indent 2
        for (var raw in dataRaw.where(
            (raw) => raw.branch == group.branch && raw.postingDate == date)) {
          result.add({
            "indent": 2,
            "branch": raw.branch,
            "posting_date": raw.postingDate,
            "customer": raw.customer,
            "grand_total": raw.grandTotal,
          });
        }
      }
    }
  }

  debugPrint('$result');
  return result;
}