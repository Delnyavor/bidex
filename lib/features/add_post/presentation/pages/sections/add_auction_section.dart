import 'package:bidex/common/widgets/image_picker_list.dart';
import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/features/add_post/presentation/bloc/create_post_bloc.dart';
import 'package:bidex/features/auction/domain/entities/auction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auction/presentation/bloc/auction_bloc.dart';

class AddAuctionSection extends StatefulWidget {
  const AddAuctionSection({super.key});

  @override
  State<AddAuctionSection> createState() => _AddAuctionSectionState();
}

class _AddAuctionSectionState extends State<AddAuctionSection> {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController starting = TextEditingController();
  List<String> images = [];

  late CreatePostBloc createPostBloc;
  late AuctionBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createPostBloc = BlocProvider.of<CreatePostBloc>(context);
    bloc = BlocProvider.of<AuctionBloc>(context);
  }

  @override
  void dispose() {
    name.dispose();
    category.dispose();
    description.dispose();
    location.dispose();
    starting.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuctionBloc, AuctionState>(
      bloc: bloc,
      listener: (BuildContext context, state) {
        if (state.createAuctionStatus == CreateAuctionStatus.creationSuccess) {
          createPostBloc.add(const PostSubmitted());
        }
      },
      child: BlocListener<CreatePostBloc, CreatePostState>(
        bloc: createPostBloc,
        listener: (BuildContext context, state) {
          if (state.pageStatus == CreatePostPageStatus.loading &&
              state.page == 1) {
            bloc.add(
              CreateAuctionEvent(
                item: AuctionItem(
                  id: 1,
                  userId: "userId",
                  username: "username",
                  location: "location",
                  rating: 0,
                  userImg: "userImg",
                  imageUrls: images,
                  description: description.text,
                  tags: const [],
                  category: '',
                  startingPrice: starting.text,
                  name: name.text,
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
          label: 'Starting Price',
          controller: starting,
          inputType: TextInputType.number,
        ),
        InputField(label: 'Description', controller: description, maxLines: 6),
        InputField(label: 'Location', controller: location),
      ],
    );
  }
}
