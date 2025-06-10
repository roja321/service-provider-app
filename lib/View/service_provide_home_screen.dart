import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:interview_project/Controller/service_provider_home_controller.dart';

class ServiceProviderHomeScreen extends StatelessWidget{
  final controller = Get.put(ServiceProviderHomeController());


  // final String providerId; // passed from login
  //
  // ProviderHomePage({required this.providerId}) {
  //   controller.fetchOrders(providerId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return Center(child: Text('No orders found.'));
        }

        return ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(order['customerName']),
                subtitle: Text('${order['service']} - ${order['status']}'),
                trailing: _buildActionButtons(order),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> order) {
    final status = order['status'];
    final orderId = order['id'];

    if (status == 'pending') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () => controller.updateOrderStatus(orderId, 'accepted')),
          IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () => controller.updateOrderStatus(orderId, 'declined')),
        ],
      );
    } else if (status == 'accepted') {
      return TextButton(
        child: Text('Complete', style: TextStyle(color: Colors.blue)),
        onPressed: () => controller.updateOrderStatus(orderId, 'completed'),
      );
    } else {
      return Text(status[0].toUpperCase() + status.substring(1));
    }
  }
}