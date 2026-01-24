import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../App/AppColors.dart';
import '../../../../App/assets_path.dart';
import '../../../../App/routes.dart';
import '../../../Share/button_gradient.dart';
import '../../../Share/manifex_logo.dart';
import '../Controller/Controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class signup extends StatelessWidget {
  signup({super.key});
  final controller = Get.find<signup_controller>();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(assets_path.logo, width: 62, height: 62),
                logo_manifex(),
                Text(
                  "Welcome to MANIFEX! Let’s start your language learning journey today"
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(assets_path.splash_image),
                ),
                const SizedBox(height: 5),

                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "First Name".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }else{
                                return null;
                              }
                            }
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Last Name".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }else{
                                return null;
                              }
                            }
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select your age group".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DropdownButtonFormField<String>(
                  value: controller.selectedAgeGroup,
                  hint: const Text(
                    "Select your age group",
                    style: TextStyle(color: Colors.grey),
                  ),

                  dropdownColor: AppColors.primary,
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.primary), // dropdown icon color
                  isExpanded: true,

                  items: controller.ageGroups.map((age) {
                    return DropdownMenuItem<String>(
                      value: age,
                      child: Text(
                        age,
                        style: TextStyle(color: Colors.white), // item text color
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    controller.selectedAgeGroup = value;
                  },
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select hobbies and Interests".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DropdownButtonFormField<String>(
                  value: controller.selectedHobbies,
                  hint: const Text(
                    "Select hobbies and Interests",
                    style: TextStyle(color: Colors.grey),
                  ),

                  dropdownColor: AppColors.primary,
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.primary), // dropdown icon color
                  isExpanded: true,

                  items: controller.hobbies.map((age) {
                    return DropdownMenuItem<String>(
                      value: age,
                      child: Text(
                        age,
                        style: TextStyle(color: Colors.white), // item text color
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    controller.selectedHobbies = value;
                  },
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (GetUtils.isEmail(value) == false) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter your email".tr),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                      () => TextFormField(
                    obscureText: controller.password.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your password".tr,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.password.value =
                          !controller.password.value;
                        },
                        child: Icon(
                          controller.password.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm Password".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                      () => TextFormField(
                    obscureText: controller.confirm_password.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else if (value != controller.password.value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your password".tr,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.confirm_password.value =
                          !controller.confirm_password.value;
                        },
                        child: Icon(
                          controller.confirm_password.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ButtonGradient(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print("validated");
                    }
                  },
                  text: "Sign Up".tr,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New here? "),
                    GestureDetector(
                      onTap: () => Get.toNamed(routes.signup_screen),
                      child: Text(
                        "Create your account",
                        style: TextStyle(
                          color: AppColors.sky,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(" to get started"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
