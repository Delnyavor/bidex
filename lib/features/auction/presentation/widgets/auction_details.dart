import 'package:flutter/material.dart';

class AuctionDetailsWidget extends StatelessWidget {
  const AuctionDetailsWidget({super.key});
  final TextStyle s =
      const TextStyle(fontSize: 12, height: 1.45, wordSpacing: 0.5);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          detail('Item Name', Text('Apple MacBook Pro', style: s)),
          detail('Description', detailList()),
          detail('Condition', Text('Normal', style: s)),
        ],
      ),
    );
  }

  Widget detail(String a, Widget b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(a, style: s)),
          Expanded(flex: 8, child: b),
        ],
      ),
    );
  }

  Widget detailList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Height: 8.36" | 21.24 cm', style: s),
        Text('Width: 11.97" | 30.41 cm', style: s),
        Text('Depth: .61" | 1.56 cm', style: s),
        Text('Screen Size: 13.3"', style: s),
        Text('Resolution: 2560 * 1600, 227ppi"', style: s),
        Text('Weight: 2.75lb | 1.25 kg', style: s),
      ],
    );
  }
}
