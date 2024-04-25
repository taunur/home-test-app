import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_test_app/data/models/visualization/data_group_model.dart';
import 'package:home_test_app/data/models/visualization/data_x_model.dart';
import 'package:home_test_app/data/models/visualization/data_y_model.dart';
import 'package:provider/provider.dart';

class DataVisualitationProvider extends ChangeNotifier {
  List<DataX> _dataX = [];
  List<DataY> _dataY = [];
  List<DataGroupV> _dataGroupV = [];

  List<DataX> get dataX => _dataX;
  List<DataY> get dataY => _dataY;
  List<DataGroupV> get dataGroupV => _dataGroupV;

  Future<void> loadDataX(String path) async {
    try {
      String jsonString = await rootBundle.loadString(path);
      Iterable data = json.decode(jsonString);
      _dataX = data.map((json) => DataX.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data X: $e');
    }
  }

  Future<void> loadDataY(String path) async {
    try {
      String jsonString = await rootBundle.loadString(path);
      Iterable data = json.decode(jsonString);
      _dataY = data.map((json) => DataY.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data Y: $e');
    }
  }

  Future<void> loadDataGroupV(String path) async {
    try {
      String jsonString = await rootBundle.loadString(path);
      Iterable data = json.decode(jsonString);
      _dataGroupV = data.map((json) => DataGroupV.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data Group: $e');
    }
  }
}

Future<List<Map<String, dynamic>>> loadAndProcessDataVisualization(
      BuildContext context) async {
    /// Load data local json visualisation
    await Provider.of<DataVisualitationProvider>(context, listen: false)
        .loadDataX('json/visualization/data_x.json');
    if (!context.mounted) return [];
    await Provider.of<DataVisualitationProvider>(context, listen: false)
        .loadDataY('json/visualization/data_y.json');
    if (!context.mounted) return [];
    await Provider.of<DataVisualitationProvider>(context, listen: false)
        .loadDataGroupV('json/visualization/data_group.json');

    /// Siapkan list provider untuk diproses perhitungan
    if (!context.mounted) return [];
    List<DataX> dataX =
        Provider.of<DataVisualitationProvider>(context, listen: false).dataX;
    List<DataY> dataY =
        Provider.of<DataVisualitationProvider>(context, listen: false).dataY;
    List<DataGroupV> dataGroupV =
        Provider.of<DataVisualitationProvider>(context, listen: false)
            .dataGroupV;

    return processData(dataX, dataY, dataGroupV);
  }

  List<Map<String, dynamic>> processData(
    List<DataX> dataX,
    List<DataY> dataY,
    List<DataGroupV> dataGroupV,
  ) {
    List<Map<String, dynamic>> result = [];

    for (var group in dataGroupV) {
      String branch = group.branch;
      Map<String, dynamic> branchData = {'branch': branch};

      Map<String, double> branchVisitors = {};
      Map<String, double> branchTransactions = {};

      /// Siapkan semua nilai branch visitor dan branch total transaksi menjadi 0
      for (var item in dataX) {
        branchVisitors[item.postingDate] = 0.0;
      }

      for (var item in dataY) {
        branchTransactions[item.postingDate] = 0.0;
      }

      /// Isi nilai visitor harian dari dataX
      for (var item in dataX) {
        if (item.branch == branch) {
          branchVisitors[item.postingDate] = item.visitors / 100;
        }
      }

      /// Isi nilai total transaksi harian dari dataY
      for (var item in dataY) {
        if (item.branch == branch) {
          branchTransactions[item.postingDate] = item.totalTransactions / 100;
        }
      }

      /// Gabungkan nilai visitor harian dan total transaksi harian
      for (var date in branchVisitors.keys) {
        double visitors = branchVisitors[date] ?? 0.0;
        double transactions = branchTransactions[date] ?? 0.0;
        branchData[date] = transactions / visitors;
      }

      result.add(branchData);
      debugPrint('Data Visualization $branchData');
    }

    return result;
  }