import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class Stepper extends StatelessWidget {
  const Stepper({super.key, required this.stepColor});

  final Color stepColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.wPct(1.2)),
      height: context.hPct(0.5),
      decoration: BoxDecoration(
        color: stepColor,
        borderRadius: BorderRadius.circular(context.wPct(3)),
      ),
    );
  }
}

class StepperRow extends StatelessWidget {
  final int currentStep;

  const StepperRow({
    super.key,
    required this.currentStep,
    required this.stepPercentage,
  });

  final String stepPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) => Expanded(
              child: Stepper(
                stepColor: index + 1 <= currentStep
                    ? AppColors
                          .aquaTeal // active step
                    : AppColors.pureWhite, // inactive step
              ),
            ),
          ),
        ),
        context.hBox(.7),
        Padding(
          padding: EdgeInsetsDirectional.only(end: context.wPct(1)),
          // 16 pixels from the end
          child: Align(
            alignment: AlignmentGeometry.bottomRight,
            child: Text(stepPercentage),
          ),
        ),
      ],
    );
  }
}
