import 'package:bidex/common/widgets/image_picker_list.dart';
import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/features/add_post/presentation/bloc/create_post_bloc.dart';
import 'package:bidex/features/giftings/domain/entities/gift_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../giftings/presentation/bloc/giftings_bloc.dart';

class AddGiftSection extends StatefulWidget {
  const AddGiftSection({super.key});

  @override
  State<AddGiftSection> createState() => _AddGiftSectionState();
}

class _AddGiftSectionState extends State<AddGiftSection> {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController criteria = TextEditingController();
  TextEditingController location = TextEditingController();
  List<String> images = [];
  List<String> desiredItems = [];
  bool hasDesiredItem = false;

  late CreatePostBloc createPostBloc;
  late GiftingsBloc bloc;

  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    createPostBloc = BlocProvider.of<CreatePostBloc>(context);
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<GiftingsBloc, GiftingsState>(
      bloc: bloc,
      listener: (BuildContext context, state) {
        if (state.createGiftStatus == CreateGiftStatus.creationSuccess) {
          createPostBloc.add(const PostSubmitted());
          bloc.add(const InitGiftCreation());
        }
      },
      child: BlocListener<CreatePostBloc, CreatePostState>(
        bloc: createPostBloc,
        listener: (BuildContext context, state) {
          if (state.pageStatus == CreatePostPageStatus.loading &&
              state.page == 0) {
            bloc.add(
              CreateGiftEvent(
                item: Gift(
                  id: 1,
                  userId: "userId",
                  username: "username",
                  location: "location",
                  rating: 0.25,
                  userProfileImg: "userProfileImg",
                  imageUrls: images,
                  title: name.text,
                  description: description.text,
                  criteria: criteria.text,
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
          label: 'Recipient Criteria',
          controller: criteria,
        ),
        InputField(label: 'Description', controller: description, maxLines: 6),
        InputField(label: 'Location', controller: location),
      ],
    );
  }
}
