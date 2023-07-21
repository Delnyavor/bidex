import 'package:flutter/material.dart';

import '../../../../common/widgets/modal_form/bottom_modal.dart';
import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';
import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../../profile/presentation/widgets/edit_feedback_dialog.dart';
import '../../../scaffolding/scaffold.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  createState() => _AddPostPage();
}

class _AddPostPage extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: GlobalAppBar(),
      body: ListView(),
      bottomNavbar: bottom(),
    );
  }

  Widget bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CancelButton(text: 'CANCEL'),
          ProceedButton(
              text: 'CHANGE',
              onPressed: () {
                showNormalDialog(context, const FeedbackDialog());
              })
        ],
      ),
    );
  }
}
