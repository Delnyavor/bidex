import 'package:bidex/common/widgets/image_picker_modal.dart';
import 'package:bidex/common/widgets/modal_form/bottom_modal.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        profileDisplay(),
        const SizedBox(height: 8),
        Text('Nii Kpakpo',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w600)),
        Text('Labone, Accra', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 45),
      ],
    );
  }

  void showImageSelector() {
    showFormDialog(context, ImagePickerModal(
      onRetrieved: (value) {
        //change local persistence
        //change state
        //send to remote
      },
    ), false);
  }

  Widget profileDisplay() {
    return GestureDetector(
      onTap: showImageSelector,
      child: const CircleAvatar(
        radius: 40,
        foregroundImage: AssetImage('assets/images/prof.jpg'),
      ),
    );
  }
}
