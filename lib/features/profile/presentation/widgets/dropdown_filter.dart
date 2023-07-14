import 'package:bidex/features/profile/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';

class FilterDropdown extends StatefulWidget {
  final GlobalKey parentKey;
  const FilterDropdown({super.key, required this.parentKey});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  late ProfileBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: bloc,
      // buildWhen: (previous, current) => previous.selected != current.selected,
      builder: (context, state) {
        print(state.selected);
        return CustomDropdown<ProfileEvent>(
          position: state.selected,
          showSelectors: true,
          parentKey: widget.parentKey,
          icon: const Icon(Icons.filter_alt),
          onChange: (ProfileEvent value, int index) {
            bloc.add(value);
            setState(() {});
          },
          dropdownButtonStyle: const DropdownButtonStyle(
            width: 50,
            height: 45,
            backgroundColor: Colors.white,
            primaryColor: Colors.black87,
          ),
          dropdownStyle: DropdownStyle(
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
          ),
          items: const [
            DropdownItem<ProfileEvent>(
              value: FilterBarters(0),
              child: Text('Barter'),
            ),
            DropdownItem<ProfileEvent>(
              value: FilterAuctions(1),
              child: Text('Auction'),
            ),
            DropdownItem<ProfileEvent>(
              value: FilterGifts(2),
              child: Text('Gifts'),
            ),
            DropdownItem<ProfileEvent>(
              value: FetchAllUserPosts(-1),
              center: true,
              isAddend: true,
              child: Text('Clear Filters'),
            ),
          ],
        );
      },
    );
  }
}
