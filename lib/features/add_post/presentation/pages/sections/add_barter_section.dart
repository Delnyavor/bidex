import 'package:bidex/common/widgets/image_picker_list.dart';
import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/features/add_post/presentation/bloc/create_post_bloc.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../barter/presentation/bloc/barter_bloc.dart';

class AddBarterSection extends StatefulWidget {
  const AddBarterSection({super.key});

  @override
  State<AddBarterSection> createState() => _AddBarterSectionState();
}

class _AddBarterSectionState extends State<AddBarterSection> {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarterBloc, BarterState>(
      bloc: bloc,
      listener: (BuildContext context, state) {
        if (state.createBarterStatus == CreateBarterStatus.creationSuccess) {
          createPostBloc.add(const PostSubmitted());
          bloc.add(const InitBarterCreation());
          clear();
        }
      },
      child: BlocListener<CreatePostBloc, CreatePostState>(
        bloc: createPostBloc,
        listener: (BuildContext context, state) {
          if (state.page == 2 &&
              state.pageStatus == CreatePostPageStatus.loading) {
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
          }
        },
        child: body(),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        const SizedBox(height: 35),
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
