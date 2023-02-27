import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

showFormDialog(BuildContext context, Widget child, bool isScrollControlled) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.lightBlue,
    isScrollControlled: isScrollControlled,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
    builder: (BuildContext context) {
      return child;
    },
  );
}

showPaymentOptionDialog(BuildContext context, Widget child) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (BuildContext context) {
      return child;
    },
  );
}
