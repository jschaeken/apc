import 'package:apc/domain/models/space.dart';
import 'package:apc/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';

class SectionSelectorBar extends StatelessWidget {
  const SectionSelectorBar({
    super.key,
    required this.onSectionTapped,
    required this.buttons,
    required this.selectedTabIndex,
  });

  final Function(int) onSectionTapped;
  final List<Space> buttons;
  final int selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        child: SizedBox(
          height: 48,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                final text = buttons[index].name;
                bool isSelected = index == selectedTabIndex;
                return GestureDetector(
                  onTap: () {
                    onSectionTapped(index);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: WidgetConstants.horizontalPadding,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
