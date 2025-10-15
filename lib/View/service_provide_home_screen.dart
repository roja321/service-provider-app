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
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 8),
                Obx(() => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Completed', 'Pending', 'Hold']
                        .map((filter) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(filter),
                        selected: controller.selectedFilter.value == filter,
                        onSelected: (selected) {
                          if (selected) {
                            controller.changeFilter(filter);
                          }
                        },
                        selectedColor: Colors.teal[200],
                        checkmarkColor: Colors.teal[800],
                        labelStyle: TextStyle(
                          color: controller.selectedFilter.value == filter
                              ? Colors.teal[800]
                              : Colors.grey[600],
                          fontWeight: controller.selectedFilter.value == filter
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                )),
                // Show count of filtered results
                Obx(() => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Showing ${controller.filteredBookings.length} ${controller.selectedFilter.value.toLowerCase()} booking(s)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                )),
              ],
            ),
          ),

          // Bookings List
          Expanded(
            child: Obx(() {
              if (controller.bookings.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                );
              }

              if (controller.filteredBookings.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_alt_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No ${controller.selectedFilter.value.toLowerCase()} bookings found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                child: ListView.builder(
                  itemCount: controller.filteredBookings.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredBookings[index];
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(milliseconds: 500 + (index * 100)),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 50 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: InkWell(
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.teal[100],
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
                                  Colors.teal[50]!,
                                  Colors.teal[200]!,
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
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

                                  SizedBox(height: 10),

                                  Obx(() {
                                    final rawStatus = controller.statusMap[item['id']]?.value;
                                    final status = rawStatus ?? 'Pending';

                                    final dropdownItems = ['Completed', 'Hold', 'Pending'];

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
                                          prefixIcon: Icon(Icons.work_history,
                                              color: Colors.orange[600]),
                                          border: OutlineInputBorder(),
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
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
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body:
  //     Obx(() {
  //       if (controller.bookings.isEmpty) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
  //           ),
  //         );
  //       }
  //     return  Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
  //         child: ListView.builder(
  //             itemCount: controller.bookings.value.length,
  //             itemBuilder: (context, index) {
  //               final item = controller.bookings.value[index];
  //               return TweenAnimationBuilder<double>(
  //                 tween: Tween(begin: 0, end: 1),
  //                 duration: Duration(milliseconds: 500 + (index * 100)),
  //                 builder: (context, value, child) {
  //                   return Opacity(
  //                     opacity: value,
  //                     child: Transform.translate(
  //                       offset: Offset(0, 50 * (1 - value)),
  //                       // slide from bottom
  //                       child: child,
  //                     ),
  //                   );
  //                 },
  //                 child: InkWell(
  //                   // onTap: ()=> showServiceProviderDetails(context, item),
  //                     child: Card(
  //                       elevation: 8,
  //                       shadowColor: Colors.teal[100],
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(16),
  //                       ),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(16),
  //                           gradient: LinearGradient(
  //                             begin: Alignment.topLeft,
  //                             end: Alignment.bottomRight,
  //                             colors: [
  //                               Colors.teal[50]!,
  //                               Colors.teal[200]!,
  //                             ],
  //                           ),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(20),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               // Header with avatar
  //                               Row(
  //                                 children: [
  //                                   CircleAvatar(
  //                                     radius: 20,
  //                                     backgroundColor: Colors.teal[300],
  //                                     child: Icon(
  //                                       Icons.person,
  //                                       color: Colors.white,
  //                                       size: 18,
  //                                     ),
  //                                   ),
  //                                   SizedBox(width: 15),
  //                                   Expanded(
  //                                     child: Column(
  //                                       crossAxisAlignment: CrossAxisAlignment
  //                                           .start,
  //                                       children: [
  //                                         Text(
  //                                           item['serviceProviderName'],
  //                                           style: TextStyle(
  //                                             fontSize: 16,
  //                                             fontWeight: FontWeight.bold,
  //                                             color: Colors.teal[800],
  //                                           ),
  //                                         ),
  //                                         SizedBox(height: 4),
  //                                         Container(
  //                                           padding: EdgeInsets.symmetric(
  //                                               horizontal: 8, vertical: 4),
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.teal[200],
  //                                             borderRadius: BorderRadius
  //                                                 .circular(12),
  //                                           ),
  //                                           child: Text(
  //                                             item['service'],
  //                                             style: TextStyle(
  //                                               fontSize: 12,
  //                                               color: Colors.teal[800],
  //                                               fontWeight: FontWeight.w600,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //
  //                               SizedBox(height: 8),
  //
  //                               // Contact Information
  //                               CustomWidgets.buildInfoRow(
  //                                 icon: Icons.phone,
  //                                 label: 'Customer Address',
  //                                 value: item['address'],
  //                                 iconColor: Colors.green[600]!,
  //                               ),
  //
  //                               SizedBox(height: 8),
  //
  //
  //                               CustomWidgets.buildInfoRow(
  //                                 icon: Icons.work_history,
  //                                 label: 'Instruction',
  //                                 value: item['instruction'],
  //                                 iconColor: Colors.orange[600]!,
  //                               ),
  //                               // CustomWidgets.buildInfoRow(
  //                               //   icon: Icons.work_history,
  //                               //   label: 'Status',
  //                               //   value: item['status'],
  //                               //   iconColor: Colors.orange[600]!,
  //                               // ),
  //                               SizedBox(height: 10,),
  //                               Obx(() {
  //                                 final rawStatus = controller
  //                                     .statusMap[item['id']]?.value;
  //                                 final status = rawStatus ??
  //                                     'Pending'; // Prevents _TypeError
  //
  //                                 final dropdownItems = [
  //                                   'Completed',
  //                                   'Hold',
  //                                   'Pending'
  //                                 ];
  //
  //                                 // Add status to dropdown list if it came from DB and isn't in the default list
  //                                 if (!dropdownItems.contains(status)) {
  //                                   dropdownItems.add(status);
  //                                 }
  //
  //                                 return SizedBox(
  //                                   height: 35,
  //                                   width: 200,
  //                                   child: DropdownButtonFormField<String>(
  //                                     value: status,
  //                                     decoration: InputDecoration(
  //                                       labelText: 'Status',
  //                                       prefixIcon: Icon(Icons.work_history,
  //                                           color: Colors.orange[600]),
  //                                       border: OutlineInputBorder(),
  //                                       contentPadding: const EdgeInsets
  //                                           .symmetric(
  //                                           horizontal: 12, vertical: 8),
  //                                     ),
  //                                     items: dropdownItems
  //                                         .map((s) =>
  //                                         DropdownMenuItem(
  //                                           value: s,
  //                                           child: Text(s),
  //                                         ))
  //                                         .toList(),
  //                                     onChanged: (newValue) {
  //                                       if (newValue != null &&
  //                                           newValue != status) {
  //                                         controller.updateStatus(
  //                                             item['id'], newValue);
  //                                       }
  //                                     },
  //                                   ),
  //                                 );
  //                               }),
  //
  //
  //                               Align(
  //                                 alignment: Alignment.bottomRight,
  //                                 child: Container(
  //                                   padding: EdgeInsets.symmetric(
  //                                       horizontal: 8, vertical: 4),
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.teal[200],
  //                                     borderRadius: BorderRadius.circular(12),
  //                                   ),
  //                                   child: Text(
  //                                     item['bookingTime'],
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                       color: Colors.teal[800],
  //                                       fontWeight: FontWeight.w600,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //
  //                               // Action Buttons
  //
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                 ),
  //               );
  //             }
  //         ),
  //       );
  //     }  )
  //   );
  // }

}