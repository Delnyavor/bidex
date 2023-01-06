import 'package:bidex/common/app_colors.dart';
import 'package:bidex/features/scaffolding/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final int position;
  const BottomNavButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.position})
      : super(key: key);

  @override
  State<BottomNavButton> createState() => _BottomNavButtonState();
}

class _BottomNavButtonState extends State<BottomNavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> expand;
  late Animation<double> paddingExpansion;
  late Animation<Color?> bgColorAnimation;
  late Animation<Color?> iconColorAnimation;
  bool active = false;

  late NavigationBloc bloc;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    expand = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    paddingExpansion = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    bgColorAnimation = ColorTween(
      begin: null,
      end: AppColors.buttonLightBlue,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.5),
      ),
    );

    iconColorAnimation = ColorTween(
      begin: Colors.black87,
      end: AppColors.darkBlue,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.1),
        reverseCurve: const Interval(0.3, 1),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<NavigationBloc>(context);
    activateRoute(bloc.state);
    deactivateRoute(bloc.state);
  }

  void setRoute() {
    bloc.add(PageChanged(page: widget.position));
  }

  void activateRoute(NavigationState state) {
    if (state.page == widget.position && active == false) {
      setState(() {
        active = true;
        controller.forward();
      });
    }
  }

  void deactivateRoute(NavigationState state) {
    if (state.page != widget.position && active == true) {
      setState(() {
        active = false;
        controller.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: listener(child: body()),
    );
  }

  Widget listener({required Widget child}) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        activateRoute(state);
        deactivateRoute(state);
      },
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: setRoute,
        child: child,
      ),
    );
  }

  Widget body() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: bgColorAnimation.value,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: iconColorAnimation.value,
              ),
              label(),
            ],
          ),
        );
      },
    );
  }

  Widget label() {
    return AnimatedBuilder(
      animation: expand,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: expand.value * 3,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 20 + expand.value * 70,
            ),
            child: labelText(),
          ),
        );
      },
    );
  }

  Widget labelText() {
    return Text(
      active ? widget.label : '',
      maxLines: 1,
      style: const TextStyle(
          fontSize: 10,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4),
    );
  }
}
