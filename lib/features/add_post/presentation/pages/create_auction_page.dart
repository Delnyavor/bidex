import 'package:bidex/common/widgets/image_picker_list.dart';
import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/features/auction/data/models/auction_item_model.dart';
import 'package:bidex/features/auction/domain/entities/auction_item.dart';
import 'package:bidex/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';
import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../../scaffolding/scaffold.dart';
import '../widgets/post_type_selector.dart';

class CreateAuctionPage extends StatefulWidget {
  final AuctionItem? auction;
  const CreateAuctionPage({
    super.key,
    this.auction,
  });

  @override
  createState() => _CreateAuctionPage();
}

class _CreateAuctionPage extends State<CreateAuctionPage>
    with TickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController starting = TextEditingController();
  List<String> images = [];
  late AuctionBloc bloc;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.auction != null) {
      isEditing = true;
      populateFields();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  void populateFields() {
    name.text = widget.auction!.name;
    category.text = widget.auction!.category;
    description.text = widget.auction!.description;
    location.text = widget.auction!.location;
    starting.text = widget.auction!.startingPrice;
  }

  void clear() {
    images.clear();
    name.clear();
    category.clear();
    description.clear();
    location.clear();
    starting.clear();
    FocusScope.of(context).unfocus();
  }

  void viewEditedPost() {
    // Navigator.pushReplacement(context, slideInRoute(route));
  }
  void listener(AuctionState state) {
    if (state.createAuctionStatus == CreateAuctionStatus.creationSuccess) {
      clear();
    } else if (state.createAuctionStatus ==
        CreateAuctionStatus.creationError) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: const GlobalAppBar(),
      body: BlocListener<AuctionBloc, AuctionState>(
        bloc: bloc,
        listener: (BuildContext context, state) {
          listener(state);
        },
        child: body(),
      ),
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
          label: 'Starting Price',
          controller: starting,
          inputType: TextInputType.number,
        ),
        InputField(label: 'Description', controller: description, maxLines: 6),
        InputField(label: 'Location', controller: location),
        const SizedBox(height: 35),
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
              // TODO: block interactivity duting submission
              // Overlay.of(context).insert(buildEntry()!);
              // controller.forward();
            },
          )
        ],
      ),
    );
  }
}
