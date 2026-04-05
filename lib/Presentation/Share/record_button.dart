import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../App/AppColors.dart';
import '../../Core/responsive.dart';

class RecordButton extends StatefulWidget {
  final String title;
  final RxBool isRecording;
  final RxString audioFile;
  final VoidCallback onTap;
  final String recordedText;
  final RxInt recordDuration;
  final String Function(int) formatDuration;

  const RecordButton({
    super.key,
    required this.title,
    required this.isRecording,
    required this.audioFile,
    required this.onTap,
    required this.recordedText,
    required this.recordDuration,
    required this.formatDuration,
  });

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 160,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Obx(() {
              final active = widget.isRecording.value;
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (active)
                    _buildRippleAnimation(),
                  Container(
                    height: ScreenResponsive.h(context, 75),
                    width: ScreenResponsive.w(context, 75),
                    decoration: BoxDecoration(
                      color: active ? Colors.red : null,
                      gradient: active
                          ? null
                          : LinearGradient(
                              colors: [
                                AppColors.yellow,
                                AppColors.pink,
                                AppColors.sky,
                              ],
                            ),
                      shape: BoxShape.circle,
                      boxShadow: active ? [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 2,
                        )
                      ] : null,
                    ),
                    child: Icon(
                      active ? Icons.mic_off : Icons.mic,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }),
          ),
          Obx(() => Text(
            widget.isRecording.value
                ? "Recording... ${widget.formatDuration(widget.recordDuration.value)}"
                : widget.title,
            style: TextStyle(
              color: widget.isRecording.value ? Colors.red : Colors.white,
              fontWeight: widget.isRecording.value ? FontWeight.bold : FontWeight.normal,
            ),
          )),
          Obx(
            () => widget.audioFile.value.isNotEmpty && !widget.isRecording.value
                ? Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 18,
                      ),
                      Text(
                        widget.recordedText,
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildRippleAnimation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: ScreenResponsive.w(context, 75) + (30 * _animationController.value),
          height: ScreenResponsive.h(context, 75) + (30 * _animationController.value),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.withOpacity(1 - _animationController.value),
          ),
        );
      },
    );
  }
}
