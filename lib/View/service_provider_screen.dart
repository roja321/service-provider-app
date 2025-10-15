import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:interview_project/Controller/service_provider_screen_controller.dart';

import '../widget/custome_widget.dart';


class ServiceProviderScreen extends StatelessWidget{
  final controller = Get.put(ServiceProviderScreenController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
          child:  Icon(Icons.add, color: Colors.teal[100],),
          onPressed: (){
            addServiceProvBottomSheet(context);
      }),
      body:
      Obx(() => controller.isDataPresent.value
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: ListView.builder(
          itemCount: controller.serviceProviderData.length,
          itemBuilder: (context, index) {
            final item = controller.serviceProviderData[index];

            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 500 + (index * 100)),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 50 * (1 - value)), // slide from bottom
                    child: child,
                  ),
                );
              },
              child: InkWell(
                onTap: () => showServiceProviderDetails(context, item),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
     : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
        ),
      ))

    );

  }

  addServiceProvBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.teal[50],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal[150],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.person_add,
                        color: Colors.teal[600],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Service Provider",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Fill in the details to add a new service provider",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Personal Information Section
                      CustomWidgets.buildSectionHeader("Personal Information", Icons.person),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.nameController,
                        label: "Full Name",
                        hint: "Enter full name",
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.phoneNoController,
                        label: "Phone Number",
                        hint: "Enter 10-digit phone number",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.addressController,
                        label: "Address",
                        hint: "Enter complete address",
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.streetAddress,
                        maxLines: 2,
                      ),

                      const SizedBox(height: 24),

                      // Professional Information Section
                      CustomWidgets.buildSectionHeader("Professional Information", Icons.work),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.serviceController,
                        label: "Services",
                        hint: "e.g., Plumber, Electrician, etc.",
                        icon: Icons.build_outlined,
                      ),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.experianceController,
                        label: "Experience (Years)",
                        hint: "Enter years of experience",
                        icon: Icons.work_history_outlined,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.skillController,
                        label: "Skills",
                        hint: "Enter relevant skills",
                        icon: Icons.star_outline,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.descriptionController,
                        label: "Description",
                        hint: "Brief description about services",
                        icon: Icons.description_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      CustomWidgets.buildCustomTextField(
                        controller: controller.minChargeController,
                        label: "Minimum Charges (₹)",
                        hint: "Enter minimum service charge",
                        icon: Icons.currency_rupee_outlined,
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 32),

                      // Save Button
        CustomWidgets.buildButton(
        text: "Save Profile",
        icon: Icons.save,
        onPressed: () {
          CustomWidgets.showLoader(context);
        controller.saveProfile(
        name: controller.nameController.text,
        phone: controller.phoneNoController.text,
        service: controller.serviceController.text,
        experiance: controller.experianceController.text,
        address: controller.addressController.text,
        description: controller.descriptionController.text,
        minimumCharge: controller.minChargeController.text,
        skills: controller.skillController.text,
        );
        },
        ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
                      icon: Icons.email,
                      label: 'Added By',
                      value: providerData['email']?.toString() ?? 'N/A',
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
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                    child:  CustomWidgets.buildInfoRow(
                      iconColor: Colors.teal,
                      icon: Icons.badge,
                      label: 'Role',
                      value: providerData['role']?.toString() ?? 'N/A',
                    ),
                ),

                  ],
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Add edit functionality here
                      },
                      icon: Icon(Icons.edit),
                      label: Text('Edit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.blue[700],
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        CustomWidgets.showLoader(context);
                       controller.delete(providerData: providerData['id'],context: context);
                      },
                      icon: Icon(Icons.delete),
                      label: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red[700],
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue[600],
            size: 22,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
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

  // Helper method for info rows


// Helper method for action buttons

}