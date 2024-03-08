import 'dart:io';

import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/image_picker_list.dart';
import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:bidex/features/giftings/data/models/gift_item_model.dart';
import 'package:bidex/features/giftings/domain/entities/gift_item.dart';
import 'package:bidex/features/giftings/presentation/bloc/giftings_bloc.dart';
import 'package:bidex/features/giftings/presentation/pages/gift_page.dart';
import 'package:bidex/features/profile/domain/entities/user_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';
import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../../scaffolding/scaffold.dart';
import '../widgets/post_type_selector.dart';

class CreateGiftPage extends StatefulWidget {
  final Gift? gift;
  //first initialises the post type selector to this particular page

  const CreateGiftPage({
    super.key,
    this.gift,
  });

  @override
  createState() => _CreateGiftPage();
}

class _CreateGiftPage extends State<CreateGiftPage>
    with TickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController criteria = TextEditingController();
  TextEditingController location = TextEditingController();
  List<ApiImage> images = [];

  late GiftingsBloc bloc;

  late Gift gift;

  bool isEditing = false;
  bool shouldClearImages = false;

  @override
  void initState() {
    super.initState();
    if (widget.gift != null) {
      isEditing = true;
      populateFields();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<GiftingsBloc>(context);
  }

  @override
  void dispose() {
    name.dispose();
    category.dispose();
    description.dispose();
    location.dispose();
    criteria.dispose();
    super.dispose();
  }

  void populateFields() {
    name.text = widget.gift!.name;
    category.text = widget.gift!.categoryId;
    description.text = widget.gift!.description;
    location.text = widget.gift!.location;
    criteria.text = widget.gift!.recipientCriteria;
  }

  void clear() {
    images.clear();
    name.clear();
    category.clear();
    description.clear();
    location.clear();
    criteria.clear();
    FocusScope.of(context).unfocus();
  }

  void viewEditedPost() {
    // Navigator.pushReplacement(context, slideInRoute(route));
  }

  void listener(GiftingsState state) {
    if (state.createGiftStatus == CreateGiftStatus.creationSuccess) {
      setState(() {
        gift = state.result!;
      });
    } else if (state.createGiftStatus == CreateGiftStatus.creationError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: const GlobalAppBar(),
      body: BlocListener<GiftingsBloc, GiftingsState>(
        bloc: bloc,
        listener: (BuildContext context, state) {
          listener(state);
        },
        child: body(),
      ),
      bottomNavbar: bottom(),
      resizeToAvoidInsets: true,
    );
  }

  Widget body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 35),
      children: [
        const PostTypeSelector(type: PostType.gift),
        const SizedBox(height: 20),
        ImagePickerList(
          clear: shouldClearImages,
          onRetrieved: (s) {
            images.add(ApiImage.fromFile(File(s)));
          },
          onRemoved: (s) {
            images.removeWhere(
              (image) => s.contains(image.name!),
            );
          },
        ),
        InputField(label: 'Name', controller: name),
        InputField(label: 'Category', controller: category),
        InputField(
          label: 'Recipient Criteria',
          controller: criteria,
        ),
        InputField(label: 'Description', controller: description, maxLines: 6),
        InputField(label: 'Location', controller: location),
      ],
    );
  }

  void createGift() {
    bloc.add(
      CreateGiftEvent(
        item: GiftModel(
          id: '1',
          userId: "",
          location: location.text,
          images: images,
          name: name.text,
          description: description.text,
          categoryId: category.text,
          createdAt: '',
          updatedAt: '',
          barters: const [],
          startingPrice: 0,
          priceCurrency: '',
          recipientCriteria: criteria.text,
          type: '',
          status: '',
          likeCount: 0,
          viewerCount: 0,
        ),
      ),
    );
  }

  Widget bottom() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CancelButton(text: 'CANCEL'),
          ProceedButton(
            text: 'ADD',
            onPressed: () {
              createGift();

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) {
                    return BlocListener<GiftingsBloc, GiftingsState>(
                        bloc: bloc,
                        listener: (BuildContext context, state) {
                          uploadListener(state);
                        },
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ));
                  });
            },
          )
        ],
      ),
    );
  }

  void uploadListener(GiftingsState state) {
    Navigator.pop(context);
    if (state.createGiftStatus == CreateGiftStatus.creationError) {
    } else if (state.createGiftStatus == CreateGiftStatus.creationSuccess) {
      Navigator.pushReplacement(
          context,
          slideInRoute(GiftPage(
            item: state.result!,
          )));
    }
  }
}
