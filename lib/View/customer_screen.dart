import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/customer_screen_controller.dart';

class CustomerScreen extends StatelessWidget{
  final controller = Get.put(CustomerScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
          onChanged: (value) => controller.searchByService(value),
            decoration: InputDecoration(
            hintText: 'Search by service...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            ),
            ),),
        ),
        Expanded(
          child: Container(

            child: Obx(()=> controller.isDataPresent.value?
            Padding(
              padding: const EdgeInsets.all(16),
              child:Obx(()=>
                ListView.builder(
                    itemCount: controller.filteredData.value.length,
                    itemBuilder: (context, index) {
                      final item = controller.filteredData.value[index];
                      return Card(
                        color: Colors.blue[50],
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Name : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Text(item['name']),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Contact No : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Text(item['phone']),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Experiance : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Text(item['experiance']),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Service : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Text(item['services']),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            ):Container(),
            ),
          ),
        ),
      ],
    )
    );
  }
}