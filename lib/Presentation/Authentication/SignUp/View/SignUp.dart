import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Authentication/SignUp/Model/signup_model.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import '../../../../App/AppColors.dart';
import '../../../../App/assets_path.dart';
import '../../../../App/routes.dart';
import '../../../../Core/responsive.dart';
import '../../../../Core/snakbar.dart';
import '../../../Share/button_gradient.dart';
import '../../../Share/manifex_logo.dart';
import '../Controller/Controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void _showMultiSelectDialog(BuildContext context, signup_controller controller) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.primary,
        title: Text("Select Hobbies".tr, style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.hobbies.length,
            itemBuilder: (context, index) {
              final hobby = controller.hobbies[index];
              return Obx(() {
                final isSelected = controller.selectedHobbies.contains(hobby);
                return CheckboxListTile(
                  title: Text(hobby, style: TextStyle(color: Colors.white)),
                  value: isSelected,
                  activeColor: Colors.white,
                  checkColor: AppColors.primary,
                  side: BorderSide(color: Colors.white),
                  onChanged: (bool? checked) {
                    if (checked == true) {
                      if (!controller.selectedHobbies.contains(hobby)) {
                        if (controller.selectedHobbies.length >= 2) {
                          AppSnackbar.show(
                            "You can select maximum 2 hobbies".tr,
                            backgroundColor: Colors.red,
                          );
                        } else {
                          controller.selectedHobbies.add(hobby);
                        }
                      }
                    } else {
                      controller.selectedHobbies.remove(hobby);
                    }
                  },
                );
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Done".tr, style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

class signup extends StatelessWidget {
  signup({super.key});
  final controller = Get.find<signup_controller>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

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
                Image.asset(AssetsPath.logo, width: 62, height: 62),
                logo_manifex(),
                Text(
                  "Welcome to MANIFEX! Let’s start your language learning journey today"
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenResponsive.responsiveFont(context, 12),
                  ),
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(AssetsPath.splashImage),
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
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  14,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: firstName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text'.tr;
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(hintText: "Jhon".tr),
                          ),
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
                                fontSize: ScreenResponsive.responsiveFont(
                                  context,
                                  14,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: lastName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text'.tr;
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(hintText: "Doe".tr),
                          ),
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
                      fontSize: ScreenResponsive.responsiveFont(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedAgeGroup.value,
                  hint: Text(
                    "Select your age group".tr,
                    style: TextStyle(color: Colors.grey),
                  ),

                  dropdownColor: AppColors.primary,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ), // dropdown icon color
                  isExpanded: true,

                  items: controller.ageGroups.map((age) {
                    return DropdownMenuItem<String>(
                      value: age,
                      child: Text(
                        age,
                        style: TextStyle(
                          color: Colors.white,
                        ), // item text color
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    controller.updateAgeGroup(value!);
                  },
                )),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select hobbies and Interests".tr,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Obx(() => GestureDetector(
                  onTap: () {
                    if (controller.selectedAgeGroup.value == null) {
                      AppSnackbar.show(
                        "Please select your age group first".tr,
                        backgroundColor: Colors.red,
                      );
                    } else {
                      _showMultiSelectDialog(context, controller);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            controller.selectedHobbies.isEmpty
                                ? "Select hobbies and Interests".tr
                                : controller.selectedHobbies.join(", "),
                            style: TextStyle(
                              color: controller.selectedHobbies.isEmpty ? Colors.grey : Colors.white,
                              fontSize: ScreenResponsive.responsiveFont(context, 14),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "User Type".tr,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedUserType.value,
                  hint: Text(
                    "Select User Type".tr,
                    style: TextStyle(color: Colors.grey),
                  ),

                  dropdownColor: AppColors.primary,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ), // dropdown icon color
                  isExpanded: true,

                  items: controller.userTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: TextStyle(
                          color: Colors.white,
                        ), // item text color
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    controller.selectedUserType.value = value;
                  },
                )),

                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Email".tr,
                //     style: TextStyle(
                //       fontSize: ScreenResponsive.responsiveFont(context,14),
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // TextFormField(
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     } else if (GetUtils.isEmail(value) == false) {
                //       return 'Please enter a valid email address';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(hintText: "Enter your email".tr),
                // ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password".tr,
                    style: TextStyle(
                      fontSize: ScreenResponsive.responsiveFont(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => TextFormField(
                    controller: password,
                    obscureText: controller.password.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters'.tr;
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
                      fontSize: ScreenResponsive.responsiveFont(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => TextFormField(
                    controller: confirmPassword,
                    obscureText: controller.confirm_password.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters'.tr;
                      } else if (value != password.text) {
                        return 'Passwords do not match'.tr;
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
                      if (controller.selectedAgeGroup.value == null) {
                        AppSnackbar.show("Please select your age group".tr);
                        return;
                      } else if (controller.selectedHobbies.isEmpty) {
                        AppSnackbar.show("Please select your hobbies".tr);
                        return;
                      } else if (controller.selectedUserType.value == null) {
                        AppSnackbar.show("Please select your user type".tr);
                        return;
                      } else {
                        String joinedHobbies = controller.selectedHobbies.join(", ").toLowerCase();
                        String formattedHobbies = joinedHobbies.isEmpty 
                            ? "" 
                            : joinedHobbies[0].toUpperCase() + joinedHobbies.substring(1);

                        signupModel model = signupModel(
                          firstName: firstName.text,
                          lastName: lastName.text,
                          ageGroup: controller.selectedAgeGroup.value!,
                          hobbies: formattedHobbies,
                          userType: controller.selectedUserType.value!,
                          email: controller.emailAddress.value,
                          password: password.text,
                          confirmPassword: confirmPassword.text,
                        );
                        controller.tempSignupModel = model;
                        controller.sent_otp(controller.emailAddress.value);
                      }
                    }
                  },
                  text: "Sign Up".tr,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ".tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 14),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(routes.login_screen),
                      child: Text(
                        "Log in".tr,
                        style: TextStyle(
                          color: AppColors.sky,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenResponsive.responsiveFont(
                            context,
                            14,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "to your account".tr,
                      style: TextStyle(
                        fontSize: ScreenResponsive.responsiveFont(context, 14),
                      ),
                    ),
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
