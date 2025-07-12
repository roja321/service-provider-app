import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:interview_project/Controller/service_provider_home_controller.dart';

import '../widget/custome_widget.dart';

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
      body:
      Obx(()=>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 10),
        child:ListView.builder(
            itemCount: controller.bookings.value.length,
            itemBuilder: (context, index) {
              final item = controller.bookings.value[index];
              return InkWell(
                  // onTap: ()=> showServiceProviderDetails(context, item),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.teal.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.teal[100]!,
                            Colors.teal[400]!,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with avatar
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.teal[300],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['serviceProviderName'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal[800],
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.teal[200],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          item['service'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.teal[800],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            // Contact Information
                            CustomWidgets.buildInfoRow(
                              icon: Icons.phone,
                              label: 'Customer Address',
                              value: item['address'],
                              iconColor: Colors.green[600]!,
                            ),

                            SizedBox(height: 8),


                            CustomWidgets.buildInfoRow(
                              icon: Icons.work_history,
                              label: 'Instruction',
                              value: item['instruction'],
                              iconColor: Colors.orange[600]!,
                            ),
                            // CustomWidgets.buildInfoRow(
                            //   icon: Icons.work_history,
                            //   label: 'Status',
                            //   value: item['status'],
                            //   iconColor: Colors.orange[600]!,
                            // ),
                            SizedBox(height: 10,),
                            Obx(() {
                              final rawStatus = controller.statusMap[item['id']]?.value;
                              final status = rawStatus ?? 'Pending'; // Prevents _TypeError

                              final dropdownItems = ['Completed', 'Hold', 'Pending'];

                              // Add status to dropdown list if it came from DB and isn't in the default list
                              if (!dropdownItems.contains(status)) {
                                dropdownItems.add(status);
                              }

                              return SizedBox(
                                height: 35,
                                width: 200,
                                child: DropdownButtonFormField<String>(
                                  value: status,
                                  decoration: InputDecoration(
                                    labelText: 'Status',
                                    prefixIcon: Icon(Icons.work_history, color: Colors.orange[600]),
                                    border: OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                  items: dropdownItems
                                      .map((s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null && newValue != status) {
                                      controller.updateStatus(item['id'], newValue);
                                    }
                                  },
                                ),
                              );
                            }),


                            Align(
                              alignment: Alignment.bottomRight ,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.teal[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item['bookingTime'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[800],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            // Action Buttons

                          ],
                        ),
                      ),
                    ),
                  )
              );
            }
        ),
      )
      )
    );
  }

}