import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:interview_project/Controller/service_provider_screen_controller.dart';

class ServiceProviderScreen extends StatelessWidget{
  final controller = Get.put(ServiceProviderScreenController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
          child: const Icon(Icons.add, color: Colors.blue,),
          onPressed: (){
            addServiceProvBottomSheet();
      }),
      body:
      Obx(()=> controller.isDataPresent.value?
        Padding(
          padding: const EdgeInsets.all(16),
          child:ListView.builder(
          itemCount: controller.serviceProviderData.length,
            itemBuilder: (context, index) {
            final item = controller.serviceProviderData[index];
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
            ):Container(),
      ));
  }

  addServiceProvBottomSheet(){
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return
          SingleChildScrollView(
              child:
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder(),),
                      controller:controller.nameController,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Phone", border: OutlineInputBorder(),),
                      keyboardType: TextInputType.phone,
                      controller: controller.phoneNoController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Only allows digits
                        LengthLimitingTextInputFormatter(10),   // Limits to 10 digits
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        decoration: const InputDecoration(labelText: "Services", border: OutlineInputBorder(),),
                        controller: controller.serviceController
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Experiance", border: OutlineInputBorder(),),
                      controller: controller.experianceController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Only allows digits
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle( backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),),
                      onPressed:(){
                        controller.saveProfile(name:controller.nameController.text,
                            phone:controller.phoneNoController.text,
                            service:controller.serviceController.text,
                            experiance: controller.experianceController.text);
                      },
                      child: const Text("Save Profile",style: TextStyle(color: Colors.white),),
                    ),

                    // ElevatedButton(
                    //   style: ButtonStyle( backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),),
                    //   onPressed:(){
                    //     controller.getUserServiceProviderProfiles();
                    //   },
                    //   child: const Text("Load Profile",style: TextStyle(color: Colors.white),),
                    // ),
                  ],
                ),
              )

          );

      },
    );
  }
}