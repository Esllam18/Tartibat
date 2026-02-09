import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'core/services/seed_data_service.dart';

class DebugDataScreen extends StatelessWidget {
  const DebugDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final products = prefs.getString('products');
                final orders = prefs.getString('shared_orders');

                print('📦 PRODUCTS JSON:');
                print(products);
                print('\n📋 ORDERS JSON:');
                print(orders);

                if (products != null) {
                  final decoded = jsonDecode(products) as List;
                  print('\n✅ Products count: ${decoded.length}');
                }

                if (orders != null) {
                  final decoded = jsonDecode(orders) as List;
                  print('✅ Orders count: ${decoded.length}');
                }
              },
              child: const Text('Check Storage'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await SeedDataService.clearAllData();
                await SeedDataService.initialize();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('✅ Data re-seeded! Restart app.')),
                );
              },
              child: const Text('Force Re-Seed'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await SeedDataService.clearAllData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🗑️ All data cleared!')),
                );
              },
              child: const Text('Clear All Data'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
