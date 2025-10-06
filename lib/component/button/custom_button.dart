import 'package:flutter/material.dart';
import 'package:tira_fe/utils/constant.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.margin,
    this.isLoading = false,
  });

  final String text;
  final Function() onPressed;
  final EdgeInsetsGeometry? margin;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: !isLoading
              ? ColorUI.PRIMARY
              : ColorUI.PRIMARY.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: !isLoading
            ? Text(
                text,
                style: WHITE_TEXT_STYLE.copyWith(
                  fontSize: 16,
                  fontWeight: FontUI.WEIGHT_NORMAL,
                  letterSpacing: 1.15,
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width * .06,
                height: MediaQuery.of(context).size.height * .03,
                child: const CircularProgressIndicator(
                  color: ColorUI.WHITE,
                  strokeWidth: 3,
                ),
              ),
      ),
    );
  }
}
