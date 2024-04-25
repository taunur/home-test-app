import 'package:flutter/material.dart';
import 'package:home_test_app/data/provider/data_mapping.dart';

class MappingScreen extends StatelessWidget {
  const MappingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: loadAndProcessDataMapping(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> processedData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Data Mapping"),
              centerTitle: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange[400],
            ),
            body: ListView.builder(
              itemCount: processedData.length,
              itemBuilder: (context, index) {
                final item = processedData[index];

                /// Menampilkan judul dengan informasi branch dan total jika indent = 0
                if (item['indent'] == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          'Indent ${item['indent']} > ${item['branch']} > Total: ${item['grand_total']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );

                /// Menampilkan judul dengan informasi posting date dan total jika indent = 1
                } else if (item['indent'] == 1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Indent ${item['indent']} > Posting Date: ${item['posting_date']} > Total: ${item['grand_total']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }
                /// Menampilkan data dalam card jika indent bukan 0 atau 1 
                else {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: ListTile(
                      title: Text("Branch: ${item['branch']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Posting Date: ${item['posting_date']}"),
                          Text("Customer: ${item['customer']}"),
                          Text("Grand Total: ${item['grand_total']}"),
                          Text("Indent: ${item['indent']} "),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
