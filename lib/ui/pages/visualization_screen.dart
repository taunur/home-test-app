import 'package:flutter/material.dart';
import 'package:home_test_app/data/provider/data_visualitation.dart';
import 'package:fl_chart/fl_chart.dart';

class VisualizationScreen extends StatelessWidget {
  const VisualizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Visualization"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange[400],
      ),
      body: Center(
        child: FutureBuilder(
          future: loadAndProcessDataVisualization(context),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return VisualizationResultScreen(result: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class VisualizationResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> result;

  const VisualizationResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          /// Mendapatkan data untuk cabang tertentu dari hasil
          Map<String, dynamic> branchData = result[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Branch: ${branchData['branch']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// Menampilkan nilai-nilai data per tanggal
                    ...branchData.keys.map((key) {
                      if (key != 'branch') {
                        String formattedValue =
                            (branchData[key] as double).toStringAsFixed(2);
                        return Text('$key : $formattedValue');
                      }
                      return const SizedBox.shrink();
                    }),
                    const SizedBox(height: 8),
                    const Text(
                      'Graphic Visualization',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            /// Menampilkan data grafik sebagai garis
                            LineChartBarData(
                              spots: _generateSpots(branchData),
                              isCurved: true,
                              color: Colors.orange,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// menampilkan titik-titik data grafik
  List<FlSpot> _generateSpots(Map<String, dynamic> branchData) {
    List<FlSpot> spots = [];
    int index = 0;
    branchData.forEach((key, value) {
      if (key != 'branch' && value is num && value.isFinite) {
        /// Menambahkandata ke dalam daftar titik
        spots.add(FlSpot(index.toDouble(), value.toDouble()));
        index++;
      }
    });
    return spots;
  }
}
