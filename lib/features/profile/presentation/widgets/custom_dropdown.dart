import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';

class CustomDropdown<T> extends StatefulWidget {
  /// the child widget for the button, this will be ignored if text is supplied

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(T, int) onChange;

  /// list of DropdownItems
  final List<DropdownItem<T>> items;
  final DropdownStyle dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle dropdownButtonStyle;

  /// dropdown button icon defaults to caret
  final Icon icon;

  final GlobalKey parentKey;

  final int? position;

  final bool showSelectors;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.dropdownStyle,
    required this.dropdownButtonStyle,
    required this.icon,
    required this.onChange,
    required this.parentKey,
    this.showSelectors = false,
    this.position,
  }) : super(key: key);

  @override
  createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int currentIndex = -1;
  late AnimationController _animationController;
  late Animation<Offset> slideAnimation;
  late double overlayHeight;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.position ?? -1;

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    final overlayInsets = widget.dropdownStyle.padding;

    overlayHeight = (widget.dropdownButtonStyle.height! +
            overlayInsets!.top +
            overlayInsets.bottom) *
        widget.items.length;

    slideAnimation = Tween(
      begin: Offset(0, overlayHeight),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (_overlayEntry != null) {
      if (_overlayEntry!.mounted) {
        _overlayEntry!.remove();
      }
      _overlayEntry!.dispose();
    }
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    RenderBox? parentBox =
        widget.parentKey.currentContext!.findRenderObject() as RenderBox?;

    var offset = renderBox.localToGlobal(Offset.zero);
    var parentOffset = parentBox!.localToGlobal(Offset.zero);

    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy,
                width: 250,
                child: CompositedTransformFollower(
                  offset: Offset(
                      parentOffset.dx - offset.dx, -(overlayHeight + 10)),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: ClipRRect(
                    borderRadius: widget.dropdownStyle.borderRadius,
                    child: AnimatedBuilder(
                      animation: slideAnimation,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.translate(
                          offset: slideAnimation.value,
                          child: child,
                        );
                      },
                      child: overlayWidget(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    // link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: SizedBox(
        width: style.width,
        height: style.height,
        child: IconButton(
          onPressed: _toggleDropdown,
          icon: widget.icon,
        ),
      ),
    );
  }

  Widget overlayWidget() {
    return ClipRRect(
      borderRadius: widget.dropdownStyle.borderRadius,
      child: Material(
        color: widget.dropdownStyle.color ?? AppColors.buttonLightBlue,
        child: ConstrainedBox(
          constraints: widget.dropdownStyle.constraints ??
              BoxConstraints(
                maxHeight: overlayHeight,
              ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) => overlayItem(
              widget.items[index],
              index,
            ),
            itemCount: widget.items.length,
          ),
        ),
      ),
    );
  }

  Widget overlayItem(DropdownItem<T> item, index) {
    return InkWell(
      onTap: () {
        setState(() => currentIndex = index);
        widget.onChange(item.value, currentIndex);
        _toggleDropdown();
      },
      child: Container(
        height: widget.dropdownButtonStyle.height,
        margin: widget.dropdownStyle.padding,
        alignment: item.center ? Alignment.center : Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: item.isAddend
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            item,
            (widget.showSelectors && !item.isAddend)
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: Radio<int>(
                      value: index,
                      groupValue: currentIndex,
                      onChanged: (val) {
                        setState(() => currentIndex = index);
                        widget.onChange(item.value, currentIndex);
                        _toggleDropdown();
                      },
                      activeColor: Colors.black.withOpacity(0.7),
                    ),
                  )
                : const SizedBox.shrink()
          ],
          // 0558852549
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      this._overlayEntry!.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry!);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final bool center;
  final bool isAddend;

  const DropdownItem(
      {Key? key,
      required this.value,
      required this.child,
      this.center = false,
      this.isAddend = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final OutlinedBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;
  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius,
  });
}
