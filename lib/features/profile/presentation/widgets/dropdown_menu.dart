import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source_impl.dart';
import 'package:bidex/features/payment/presentation/pages/payment_page.dart';
import 'package:bidex/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:bidex/features/profile/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMenuDropdown extends StatefulWidget {
  final GlobalKey parentKey;
  const ProfileMenuDropdown({super.key, required this.parentKey});

  @override
  State<ProfileMenuDropdown> createState() => _ProfileMenuDropdownState();
}

class _ProfileMenuDropdownState extends State<ProfileMenuDropdown> {
  void navigateToEditProfilePage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EditProfilePage()));
  }

  void navigateToPaymentsPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PaymentPage()));
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Function>(
        parentKey: widget.parentKey,
        icon: const Icon(Icons.menu),
        onChange: (Function value, int index) => value(),
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
        items: [
          DropdownItem<Function>(
            value: navigateToEditProfilePage,
            child: const Row(children: [
              Icon(Icons.edit_note_outlined),
              SizedBox(width: 10),
              Text('Edit Profile Details'),
            ]),
          ),
          DropdownItem<Function>(
            value: navigateToPaymentsPage,
            child: const Row(children: [
              Icon(CupertinoIcons.creditcard_fill),
              SizedBox(width: 10),
              Text('Manage Payments'),
            ]),
          ),
          DropdownItem<Function>(
            value: () async {
              await LocalAuthSourceImpl().logout();
// TODO: rewrite to include bloc
              Navigator.pop(context);
            },
            child: const Row(children: [
              Icon(Icons.logout),
              SizedBox(width: 10),
              Text('Sign Out'),
            ]),
          ),
        ]);
  }
}
