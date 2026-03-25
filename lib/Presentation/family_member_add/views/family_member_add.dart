import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/App/assets_path.dart';
import 'package:manifex/Presentation/Features/Subcription/View/Subcription.dart';
import 'package:manifex/Presentation/Share/custom_circle_progress_indicator.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/Share/text_title_small.dart';
import 'package:manifex/Presentation/app_bar/views/custom_app_bar.dart';

import '../controller/family_member_add_controller.dart';

class FamilyMemberAdd extends StatelessWidget {
   FamilyMemberAdd({super.key});
  final controller = Get.find<FamilyMemberAddController>();
  @override
  Widget build(BuildContext context) {
    return scaffold_background(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                children: [
                  CustomText(
                    text: 'Family Members',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  const Spacer(),
                  Text(
                    controller.memberCountText,
                    style: TextStyle(color: Colors.white60, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // --- Row: email + add ---
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter email Address',
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                Obx(
                  () => Opacity(
                    opacity: controller.canAddMore ? 1 : 0.5,
                    child: IgnorePointer(
                      ignoring: !controller.canAddMore,
                      child: GestureDetector(
                        onTap: () {
                          controller.memberAdd();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff432DD7),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Obx(() {
                            if (controller.memberIsLoading.value) {
                              return CustomCircleProgressIndicator();
                            }
                            return CustomText(
                              text: 'Add',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // --- List: Row এর নিচে ---
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CustomCircleProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                }

                if (controller.members.isEmpty) {
                  return const Center(
                    child: Text(
                      'No members found',
                      style: TextStyle(color: Colors.white60),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.fetchData,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.members.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final m = controller.members[index];
                      final name =
                          '${m.user?.firstName ?? ''} ${m.user?.lastName ?? ''}'
                              .trim();
                      final email = m.user?.email ?? '';
                      return _MemberTile(
                        name: name.isEmpty ? 'Unknown' : name,
                        email: email,
                        onDelete: () {
                          controller.removeMember(id: m.userId, subscriptionId: m.subscriptionId);
                          Get.back();
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onDelete;

  const _MemberTile({
    required this.name,
    required this.email,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2140).withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/splash_icon.png'),
          ),
          SizedBox(width: 12.w),

          // Name + Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              showDialog(
                onTap: onDelete
              );
            },
            icon: Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showDialog({required VoidCallback onTap}) {
    return Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AssetsPath.splashImage),
            ),
            CustomText(text: 'Are you sure?',fontSize: 24,),
            Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: GradientButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: 'No',
                  ),
                ),
                Expanded(child: GradientButton(
                  onPressed: onTap,
                    text: 'Yes')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
