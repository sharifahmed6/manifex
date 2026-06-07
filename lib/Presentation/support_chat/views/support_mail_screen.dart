import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/button_gradient.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';
import 'package:manifex/Presentation/support_chat/controllers/support_mail_controller.dart';

class SupportMailScreen extends StatelessWidget {
  const SupportMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupportMailController());
    return scaffold_background(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: Get.back,
        ),
        title: Text(
          'Support Mail'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        titleSpacing: -8,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: controller.fullNameController,
                  labelText: 'Full Name'.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name'.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: controller.emailController,
                  labelText: 'Email'.tr,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email'.tr;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email'.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: controller.subjectController,
                  labelText: 'Subject'.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject'.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: controller.descriptionController,
                  labelText: 'Description'.tr,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description'.tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                ButtonGradient(
                  onTap: controller.sendSupportEmail,
                  text: 'Send'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
