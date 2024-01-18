import 'package:bidex/common/widgets/image_picker_list.dart';
import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/common/widgets/modal_form/button_cancel.dart';
import 'package:bidex/common/widgets/modal_form/button_proceed.dart';
import 'package:bidex/features/add_post/presentation/bloc/create_post_bloc.dart';
import 'package:bidex/features/add_post/presentation/widgets/post_type_selector.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/features/home/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/profile/domain/entities/user_post.dart';
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
  List<String> images = [];
  List<String> desiredItems = [];
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
      bool check = desiredItems.contains(desiredItemCtrl.text);

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
    name.text = widget.barterItem!.itemName;
    category.text = widget.barterItem!.category;
    description.text = widget.barterItem!.description;
    location.text = widget.barterItem!.location;
    desiredItems = widget.barterItem!.desiredItems;
  }

  void clear() {
    images.clear();
    desiredItems.clear();
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
    } else if (state.createBarterStatus == CreateBarterStatus.creationError) {}
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 35),
        const PostTypeSelector(),
        const SizedBox(height: 20),
        ImagePickerList(
          onRetrieved: (s) {
            images.add(s);
          },
          onRemoved: (s) {
            images.remove(s);
          },
        ),
        InputField(label: 'Name', controller: name),
        InputField(label: 'Category', controller: category),
        InputField(
          label: 'Desired Items',
          controller: desiredItemCtrl,
          suffix: addToDesiredItems(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: desiredItems
                .map((e) => Padding(
                    padding: const EdgeInsets.only(right: 10, top: 6),
                    child: Text(e)))
                .toList(),
          ),
        ),
        InputField(label: 'Description', controller: description, maxLines: 6),
        InputField(label: 'Location', controller: location),
      ],
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
              bloc.add(
                CreateBarterEvent(
                  item: BarterItem(
                    id: 1,
                    imageUrls: images,
                    userId: '',
                    username: '',
                    itemName: name.text,
                    location: location.text,
                    rating: 0.0,
                    tags: const [],
                    category: '',
                    description: description.text,
                    desiredItems: desiredItems,
                  ),
                ),
              );
              // TODO: block interactivity duting submission
              // Overlay.of(context).insert(buildEntry()!);
              // controller.forward();
            },
          )
        ],
      ),
    );
  }

  Widget addToDesiredItems() {
    return IconButton(
      onPressed: () {
        if (desiredItemCtrl.text.isNotEmpty) {
          if (hasDesiredItem) {
            desiredItems.remove(desiredItemCtrl.text);
          } else {
            desiredItems.add(desiredItemCtrl.text);
          }
          desiredItemCtrl.clear();
          setState(() {});
        }
      },
      icon: Icon(hasDesiredItem ? Icons.close : Icons.playlist_add),
    );
  }
}
