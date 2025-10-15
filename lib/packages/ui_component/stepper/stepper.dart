import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class Stepper extends StatelessWidget {
  const Stepper({super.key, required this.stepColor});
final  Color stepColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.wPct(1.2),),
      height: context.hPct(0.5),
      decoration: BoxDecoration(
        color: stepColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class StepperRow extends StatelessWidget {
  final int currentStep ; 
  const StepperRow({super.key,required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:   List.generate(
      5,
      (index) => Expanded(
        child: Stepper(
          stepColor: index == currentStep
              ? AppColors.aquaTeal // active step
              : AppColors.pureWhite, // inactive step
        ),
      ),
    ),
  );
  }
}


