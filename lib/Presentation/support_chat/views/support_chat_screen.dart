import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifex/Presentation/Share/scafold_background.dart';
import 'package:manifex/Presentation/support_chat/controllers/support_chat_controller.dart';

class SupportChatScreen extends StatelessWidget {
  const SupportChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SupportChatController controller = Get.find<SupportChatController>();
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
          'Support Chat'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        titleSpacing: -8,
      ),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Align(
                    alignment:
                        message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Get.width * 0.75,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(8.w),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: message.isUser
                              ? Colors.blue
                              : Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          message.text,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(
            () => controller.isReplying.value
                ? _buildReplyingIndicator()
                : const SizedBox.shrink(),
          ),
          _buildMessageComposer(controller),
        ],
      ),
    );
  }

  Widget _buildReplyingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.75,
        ),
        child: Container(
          margin: EdgeInsets.all(8.w),
          padding: EdgeInsets.all(12.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Mercury replying...",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageComposer(SupportChatController controller) {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: controller.sendMessage,
          ),
        ],
      ),
    );
  }
}
