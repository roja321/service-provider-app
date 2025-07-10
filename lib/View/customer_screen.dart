import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/customer_screen_controller.dart';
import '../widget/custome_widget.dart';

class CustomerScreen extends StatelessWidget{
  final controller = Get.put(CustomerScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
    Container(
    margin: const EdgeInsets.only(top: 10,left: 8,right: 8,bottom: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => controller.searchByService(value),
        decoration: InputDecoration(
          hintText: 'Search for services...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.search,
              color: Colors.teal[600],
              size: 20,
            ),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(12),
            child: Icon(
              Icons.tune,
              color: Colors.grey[500],
              size: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.teal[300]!,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    ),

    // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextField(
        //   onChanged: (value) => controller.searchByService(value),
        //     decoration: InputDecoration(
        //     hintText: 'Search by service...',
        //     prefixIcon: Icon(Icons.search),
        //     border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12),
        //     ),
        //     ),),
        // ),


        Expanded(
          child: Container(

            child: Obx((){
              print("widget build");
              if (controller.isDataPresent.value==false) {
                return Center(child: CircularProgressIndicator());
              }
              if (!controller.isDataPresent.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.filteredData.isEmpty) {
                return Center(child: Text("No data found"));
              }
            return

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              child:
                  ListView.builder(
                      itemCount: controller.filteredData.value.length,
                      itemBuilder: (context, index) {
                        final item = controller.filteredData[index];

                        return InkWell(
                            onTap: ()=> showServiceProviderDetails(context, item),
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
                                                  item['name'],
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
                                                    item['services'],
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
                                        label: 'Contact',
                                        value: item['phone'],
                                        iconColor: Colors.green[600]!,
                                      ),

                                      SizedBox(height: 8),

                                      // Experience Information
                                      CustomWidgets.buildInfoRow(
                                        icon: Icons.work_history,
                                        label: 'Experience',
                                        value: item['experiance'],
                                        iconColor: Colors.orange[600]!,
                                      ),

                                      SizedBox(height: 8),
                                      item['bookingStatus'] !='pending'?
                                      CustomWidgets.buildButton(
                                        text: "Book Now",
                                        icon: Icons.save,
                                        onPressed: () {
                                          bookNowBtnClick(context, controller.filteredData[index]);
                                        },
                                      ): CustomWidgets.buildInfoRow(
                                        icon: Icons.pending_sharp,
                                        label: 'status',
                                        value: item['bookingStatus'],
                                        iconColor: Colors.orange[600]!,
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

            );
                  } ),
          ),
        ),
      ],
    )
    );
  }


  showServiceProviderDetails(BuildContext context, providerData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(

        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal[200],
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.teal[700],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          providerData['name'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                          ),
                        ),
                        Text(
                          providerData['services'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.teal[700]),
                  ),
                ],
              ),
            ),

            // Details List
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child:
                      CustomWidgets.buildInfoRow(
                        iconColor: Colors.teal,
                        icon: Icons.phone,
                        label: 'Phone',
                        value: providerData['phone']?.toString() ?? 'N/A',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child:
                      CustomWidgets.buildInfoRow(
                        iconColor: Colors.teal,
                        icon: Icons.work_history,
                        label: 'Experience',
                        value: providerData['experiance']?.toString() ?? 'N/A',
                      ),),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child:
                      CustomWidgets.buildInfoRow(
                        iconColor: Colors.teal,
                        icon: Icons.build,
                        label: 'Skills',
                        value: _formatSkills(providerData['skills']),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child:
                      CustomWidgets.buildInfoRow(
                        iconColor: Colors.teal,
                        icon: Icons.location_on,
                        label: 'Address',
                        value: providerData['address']?.toString() ?? 'N/A',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child:
                      CustomWidgets.buildInfoRow(
                        iconColor: Colors.teal,
                        icon: Icons.attach_money,
                        label: 'Minimum Charge',
                        value: providerData['minimumCharge']?.toString() ?? 'N/A',
                      ),),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  String _formatSkills(dynamic skills) {
    if (skills == null) return 'N/A';
    if (skills is List) {
      return skills.join(', ');
    }
    return skills.toString();
  }

  bookNowBtnClick(BuildContext context, var item) async{
    print("item--${item}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) => Container(

        height: MediaQuery.of(context).size.height * 0.8,
    decoration: BoxDecoration(
    color: Colors.teal[50],
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomWidgets.buildInfoRow(
          //   icon: Icons.work_history,
          //   label: 'Customer Id',
          //   value:prefs.getString('customerId')!,
          //   iconColor: Colors.orange[600]!,
          // ),
          //
          // CustomWidgets.buildInfoRow(
          //   icon: Icons.work_history,
          //   label: 'Provider Id',
          //   value: item['id'],
          //   iconColor: Colors.orange[600]!,
          // ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, color: Colors.teal[700]),
          ),
        
          CustomWidgets.buildCustomTextField(
            controller: controller.customerAdressController,
            label: "Customer Address",
            hint: "Customer Address",
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
        
          CustomWidgets.buildCustomTextField(
            controller: controller.instructionController,
            label: "Instructions",
            hint: "",
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 10,),
          CustomWidgets.buildInfoRow(
            icon: Icons.work_history,
            label: 'Service Type',
            value: item['services'],
            iconColor: Colors.orange[600]!,
          ),
          SizedBox(height: 50,),
          CustomWidgets.buildButton(
            text: "Save",
            icon: Icons.save,
              onPressed: () async {
                CustomWidgets.showLoader(context);
                if(controller.customerAdressController.text.isNotEmpty && controller.instructionController.text.isNotEmpty ) {
                  Map<String, dynamic> bookingData = {
                    'customerId': prefs.getString('customerId')!,
                    'serviceProviderId': item['id'],
                    // 'customerName': 'Customer',//
                    'serviceProviderName': item['name'],
                    'service': item['services'],
                    'bookingDate': DateTime.now().toIso8601String().split('T')[0],
                    'bookingTime': TimeOfDay.now().format(context),
                    'address': controller.customerAdressController.text,
                    // 'phone': item['Name'],//
                    'status': 'pending',
                    // 'price': 0.0,//
                    'instruction': controller.instructionController.text,
                  };
        
                  String? bookingId = await controller.createBooking(bookingData);
                  if (bookingId != null) {
                    // Booking success
                    await controller.getUserServiceProviderProfiles();
                    print("booking id--$bookingId");

                    Get.snackbar(
                      "Success",
                      "Booking done successfully",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                    await controller.getUserServiceProviderProfiles();
                    controller.customerAdressController.clear();
                    controller.instructionController.clear();
                    controller.filteredData.refresh();
                    Navigator.of(context).pop();
                    Navigator.of(Get.context!, rootNavigator: true).pop();
                  } else {
                    // Handle error

                    Navigator.of(Get.context!, rootNavigator: true).pop();
                    Get.snackbar(
                      "Unsuccessful",
                      "Something went wrong",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                }else{
                  Navigator.of(Get.context!, rootNavigator: true).pop();
        
                  Get.snackbar(
                    "Unsuccessful",
                    "All fields are required.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
        
                }
           }
                 ),
        ]),
      ),
    )));}
}