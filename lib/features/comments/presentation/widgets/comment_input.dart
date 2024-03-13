import 'package:bidex/features/comments/presentation/bloc/comment_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_colors.dart';
import 'package:flutter/material.dart';

class CommentInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? errorText;
  final bool preventFocus;
  final Function? onSubmit;

  const CommentInput(
      {super.key,
      required this.controller,
      this.onChanged,
      this.errorText,
      this.preventFocus = false,
      this.onSubmit});

  @override
  State<CommentInput> createState() => CommentInputState();
}

class CommentInputState extends State<CommentInput>
    with SingleTickerProviderStateMixin {
  bool invisible = true;
  late AnimationController controller;
  late Animation<double> zoomInOut;
  bool showMic = true;

  late CommentBloc bloc;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    zoomInOut = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    addTextListener();

    bloc = BlocProvider.of<CommentBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void addTextListener() {
    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty) {
        if (showMic) {
          runAnimation();
          Future.delayed(const Duration(milliseconds: 55), () {
            setState(() {
              showMic = false;
            });
          });
        }
      }
      if (widget.controller.text.isEmpty) {
        if (!showMic) {
          runAnimation();
          Future.delayed(const Duration(milliseconds: 55), () {
            setState(() {
              showMic = true;
            });
          });
        }
      }
    });
  }

  void runAnimation() async {
    await controller.forward().whenComplete(() => controller.reverse());
  }

  handleFocus() {
    if (widget.preventFocus && FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  final GlobalKey textboxKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    handleFocus();

    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Flexible(child: textField()),
            const SizedBox(width: 5),
            const Icon(
              CupertinoIcons.photo,
              color: Colors.black87,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return TextField(
      key: textboxKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,

      controller: widget.controller,
      style: const TextStyle(fontSize: 12, color: AppColors.darkBlue),
      maxLines: 1,
      decoration: InputDecoration(
          hintText: 'Message...',
          hintStyle: const TextStyle(color: Colors.black38),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          errorText: widget.errorText,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          prefixIcon: const Icon(
            CupertinoIcons.camera_fill,
            color: Colors.black87,
          ),
          suffixIcon: swapper()),
      onChanged: widget.onChanged,
    );
  }

  Widget swapper() {
    return AnimatedBuilder(
      animation: zoomInOut,
      builder: (context, child) {
        return ScaleTransition(
          scale: zoomInOut,
          child: showMic ? micIcon() : sendIcon(),
        );
      },
    );
  }

  Widget micIcon() {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {},
      icon: const Icon(
        CupertinoIcons.mic,
        color: Colors.black87,
      ),
    );
  }

  Widget sendIcon() {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        // bloc.add(CreateComment(Chat(
        //     text: widget.controller.text,
        //     created: DateTime.now(),
        //     user: '0000')));

        widget.controller.clear();
      },
      icon: const Icon(
        Icons.send_rounded,
        color: Colors.black87,
      ),
    );
  }
}
