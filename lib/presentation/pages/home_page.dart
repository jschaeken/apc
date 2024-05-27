import 'package:apc/domain/models/space.dart';
import 'package:apc/presentation/widgets/constants.dart';
import 'package:apc/presentation/widgets/home/section_selection_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _spaceSelectionScrollController = ScrollController();

  List<Space> demoButtons = [
    const Space(name: 'Events', id: 'events'),
    const Space(name: 'Resources', id: 'resources'),
    const Space(name: 'Mentors', id: 'mentors'),
    const Space(name: 'Accountability', id: 'accountability'),
  ];

  int selectedTabIndex = 0;

  void _setSectionIndex(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _onSpaceSelection(int index) {
    _setSectionIndex(index);
    _spaceSelectionScrollController.animateTo(
      index * 100.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: CustomScrollView(
        slivers: [
          // Section Selector Bar
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 70,
            floating: true,
            pinned: true,
            snap: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: SizedBox(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _spaceSelectionScrollController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: demoButtons.length,
                  itemBuilder: (context, i) {
                    final isSelected = i == selectedTabIndex;
                    return GestureDetector(
                      onTap: () {
                        _onSpaceSelection(i);
                      },
                      child: Padding(
                        padding: WidgetConstants.horizontalPadding.copyWith(
                          right: i == demoButtons.length - 1 ? 10 : null,
                          left: i == 0 ? 0 : null,
                        ),
                        child: Text(
                          demoButtons[i].name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              titlePadding: WidgetConstants.horizontalPadding,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                10,
                (idx) {
                  return Padding(
                    padding: WidgetConstants.itemPadding,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: .7,
                        ),
                      ),
                      height: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          // fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://picsum.photos/1000/1000?random=$idx',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              // fadeIn
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child.animate().fadeIn();
                                }
                                return const SizedBox();
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(.6),
                                    Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 18,
                              left: 18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Event Name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  Text(
                                    'Event Date',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            // Arrow Icon
                            Positioned(
                              bottom: 18,
                              right: 18,
                              child: Icon(
                                CupertinoIcons.chevron_forward,
                                size: 30,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .moveY(
                        duration: const Duration(milliseconds: 500),
                        begin: 100 * ((idx + 1) / 5).toDouble(),
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
