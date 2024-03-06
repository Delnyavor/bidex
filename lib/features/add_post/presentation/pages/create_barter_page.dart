import 'dart:io';

import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/image_picker_list.dart';
import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/common/widgets/modal_form/button_cancel.dart';
import 'package:bidex/common/widgets/modal_form/button_proceed.dart';
import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:bidex/features/add_post/presentation/bloc/create_post_bloc.dart';
import 'package:bidex/features/add_post/presentation/widgets/post_type_selector.dart';
import 'package:bidex/features/barter/data/models/barter_item_model.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/features/barter/presentation/pages/barter_detail_page.dart';
import 'package:bidex/features/home/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/scaffolding/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../barter/presentation/bloc/barter_bloc.dart';

class CreateBarterPage extends StatefulWidget {
  final BarterItem? barterItem;
  const CreateBarterPage({super.key, this.barterItem});

  @override
  State<CreateBarterPage> createState() => _CreateBarterPageState();
}

class _CreateBarterPageState extends State<CreateBarterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController desiredItemCtrl = TextEditingController();
  List<ApiImage> images = [];
  List<String> barters = [];
  bool hasDesiredItem = false;

  late CreatePostBloc createPostBloc;
  late BarterBloc bloc;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.barterItem != null) {
      isEditing = true;
      populateFields();
    }
  }

  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    createPostBloc = BlocProvider.of<CreatePostBloc>(context);
    bloc = BlocProvider.of<BarterBloc>(context);

    desiredItemCtrl.addListener(() {
      bool check = barters.contains(desiredItemCtrl.text);

      if (check) {
        if (!hasDesiredItem) {
          setState(() {
            hasDesiredItem = check;
          });
        }
      } else {
        if (hasDesiredItem) {
          setState(() {
            hasDesiredItem = check;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    name.dispose();
    category.dispose();
    description.dispose();
    location.dispose();
    desiredItemCtrl.dispose();
    super.dispose();
  }

  void populateFields() {
    name.text = widget.barterItem!.name;
    category.text = widget.barterItem!.categoryId;
    description.text = widget.barterItem!.description;
    location.text = widget.barterItem!.location;
    barters = widget.barterItem!.barters;
  }

  void clear() {
    images.clear();
    barters.clear();
    name.clear();
    category.clear();
    description.clear();
    desiredItemCtrl.clear();
    location.clear();
    FocusScope.of(context).unfocus();
  }

  void viewEditedPost() {
    // Navigator.pushReplacement(context, slideInRoute(route));
  }
  void listener(BarterState state) {
    if (state.createBarterStatus == CreateBarterStatus.creationSuccess) {
      clear();
    } else if (state.createBarterStatus == CreateBarterStatus.creationError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: const GlobalAppBar(),
      body: BlocListener<BarterBloc, BarterState>(
        bloc: bloc,
        listener: (BuildContext context, state) {
          listener(state);
        },
        child: body(),
      ),
      resizeToAvoidInsets: true,
      bottomNavbar: bottom(),
    );
  }

  Widget body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 35),
      children: [
        const PostTypeSelector(),
        const SizedBox(height: 20),
        ImagePickerList(
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
          label: 'Desired Items',
          controller: desiredItemCtrl,
          suffix: addTobarters(),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: barters
              .map((e) => Padding(
                  padding: const EdgeInsets.only(right: 10, top: 6),
                  child: chip(e)))
              .toList(),
        ),
        InputField(label: 'Description', controller: description, maxLines: 6),
        InputField(label: 'Location', controller: location),
      ],
    );
  }

  Widget chip(String value) {
    return Chip(
      label: Text(value),
      labelStyle: const TextStyle(color: Colors.black54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: const BorderSide(width: 0, color: Colors.black54),
      deleteIcon: const Icon(
        Icons.close,
        color: Colors.black87,
        size: 18,
      ),
      onDeleted: () {
        setState(() {
          barters.remove(value);
        });
      },
    );
  }

  void createBarter() {
    bloc.add(
      CreateBarterEvent(
        item: BarterItemModel(
          id: '1',
          images: images,
          userId: '',
          name: name.text,
          location: location.text,
          categoryId: '',
          description: description.text,
          barters: barters,
          createdAt: '',
          updatedAt: '',
          startingPrice: 0,
          priceCurrency: '',
          recipientCriteria: '',
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
              createBarter();

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) {
                    return BlocListener<BarterBloc, BarterState>(
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

  void uploadListener(BarterState state) {
    Navigator.pop(context);
    if (state.createBarterStatus == CreateBarterStatus.creationError) {
    } else if (state.createBarterStatus == CreateBarterStatus.creationSuccess) {
      Navigator.pushReplacement(
          context, slideInRoute(BarterDetailPage(item: state.item!)));
      // Navigator.pop(context);
    }
  }

  Widget addTobarters() {
    return IconButton(
      onPressed: () {
        if (desiredItemCtrl.text.isNotEmpty) {
          if (hasDesiredItem) {
            barters.remove(desiredItemCtrl.text);
          } else {
            barters.add(desiredItemCtrl.text);
          }
          desiredItemCtrl.clear();
          setState(() {});
        }
      },
      icon: Icon(hasDesiredItem ? Icons.close : Icons.playlist_add),
    );
  }
}
