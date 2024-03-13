import 'package:flutter/material.dart';

class BidCount extends StatefulWidget {
  const BidCount({super.key});

  @override
  State<BidCount> createState() => _BidCountState();
}

class _BidCountState extends State<BidCount> {
  final TextStyle s = const TextStyle(
      fontSize: 12, height: 1.4, wordSpacing: 0.5, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bid('User48752', 'GHC15,900'),
        bid('User78239', 'GHC15,650'),
        bid('User10328', 'GHC15,400'),
        bid('User90973', 'GHC15,250'),
      ],
    );
  }

  Widget bid(String a, String b) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(flex: 7, child: Center(child: Text(a, style: s))),
          const Expanded(
              flex: 1, child: Icon(Icons.swap_vert, color: Colors.blue)),
          Expanded(
            flex: 7,
            child: Text(
              b,
              style: s,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
