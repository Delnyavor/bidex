// import 'package:bidex/common/widgets/image_picker_list.dart';
// import 'package:bidex/common/widgets/input_field.dart';
// import 'package:bidex/features/add_post/presentation/bloc/create_post_bloc.dart';
// import 'package:bidex/features/giftings/domain/entities/gift_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../giftings/data/models/gift_item_model.dart';
// import '../../../../giftings/presentation/bloc/giftings_bloc.dart';

// class AddGiftSection extends StatefulWidget {
//   final Gift? item;
//   const AddGiftSection({super.key, this.item});

//   @override
//   State<AddGiftSection> createState() => _AddGiftSectionState();
// }

// class _AddGiftSectionState extends State<AddGiftSection> {
//   TextEditingController name = TextEditingController();
//   TextEditingController category = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController criteria = TextEditingController();
//   TextEditingController location = TextEditingController();
//   List<String> images = [];

//   late CreatePostBloc createPostBloc;
//   late GiftingsBloc bloc;

//   ScrollController scrollController = ScrollController();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     createPostBloc = BlocProvider.of<CreatePostBloc>(context);
//     bloc = BlocProvider.of<GiftingsBloc>(context);
//   }

//   @override
//   void dispose() {
//     name.dispose();
//     category.dispose();
//     description.dispose();
//     location.dispose();
//     criteria.dispose();
//     super.dispose();
//   }

//   void clear() {
//     images.clear();
//     name.clear();
//     category.clear();
//     description.clear();
//     location.clear();
//     criteria.clear();
//     FocusScope.of(context).unfocus();
//   }

//   void populateFields() {
//     name.text = widget.item!.name;
//     category.text = widget.item!.category;
//     description.text = widget.item!.description;
//     location.text = widget.item!.location;
//     criteria.text = widget.item!.criteria;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<GiftingsBloc, GiftingsState>(
//       bloc: bloc,
//       listener: (BuildContext context, state) {
//         if (state.createGiftStatus == CreateGiftStatus.creationSuccess) {
//           createPostBloc.add(const PostSubmitted(didSucceed: true));
//           bloc.add(const InitGiftCreation());
//           clear();
//         } else if (state.createGiftStatus == CreateGiftStatus.creationError) {
//           bloc.add(const InitGiftCreation());
//           createPostBloc.add(const PostSubmitted(didSucceed: false));
//         }
//       },
//       child: BlocBuilder<CreatePostBloc, CreatePostState>(
//         bloc: createPostBloc,
//         buildWhen: (previous, current) =>
//             previous.pageStatus != current.pageStatus,
//         builder: (BuildContext context, state) {
//           if (state.pageStatus == CreatePostPageStatus.loading &&
//               state.page == 0) {
//             bloc.add(
//               CreateGiftEvent(
//                 item: GiftModel(
//                   id: '1',
//                   userId: "userId",
//                   username: "username",
//                   location: "location",
//                   userProfileImg: "userProfileImg",
//                   images: images,
//                   name: name.text,
//                   description: description.text,
//                   criteria: criteria.text,
//                   category: category.text,
//                 ),
//               ),
//             );
//           }
//           return body();
//         },
//       ),
//     );
//   }

//   Widget body() {
//     return Column(
//       children: [
//         const SizedBox(height: 35),
//         ImagePickerList(
//           onRetrieved: (s) {
//             images.add(s);
//           },
//           onRemoved: (s) {
//             images.remove(s);
//           },
//         ),
//         InputField(label: 'Name', controller: name),
//         InputField(label: 'Category', controller: category),
//         InputField(
//           label: 'Recipient Criteria',
//           controller: criteria,
//         ),
//         InputField(label: 'Description', controller: description, maxLines: 6),
//         InputField(label: 'Location', controller: location),
//       ],
//     );
//   }
// }
