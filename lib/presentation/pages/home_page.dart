import 'package:apc/domain/models/space.dart';
import 'package:apc/presentation/widgets/constants.dart';
import 'package:apc/presentation/widgets/home/section_selection_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Space> demoButtons = [
    const Space(name: 'Events', id: 'events'),
    const Space(name: 'Resources', id: 'resources'),
    const Space(name: 'Mentors', id: 'mentors'),
    const Space(name: 'Accountability', id: 'accountability'),
  ];

  int selectedTabIndex = 0;

  int demoTileCount = 5;

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
    HapticFeedback.lightImpact();
    _setSectionIndex(index);
  }

  _showModalSpaceSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      anchorPoint: const Offset(0.5, 0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: .7,
            ),
          ),
          child: Padding(
            padding: WidgetConstants.horizontalPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: WidgetConstants.itemPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select a Section',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.clear,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: WidgetConstants.horizontalPadding,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: demoButtons.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        borderOnForeground: true,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: .7,
                            ),
                          ),
                          onTap: () {
                            _onSpaceSelection(index);
                            Navigator.pop(context);
                          },
                          splashColor: Theme.of(context).colorScheme.secondary,
                          title: Text(
                            demoButtons[index].name,
                          ),
                          trailing: selectedTabIndex == index
                              ? Icon(
                                  CupertinoIcons.circle_fill,
                                  size: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        );
      },
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      demoButtons[selectedTabIndex].name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    IconButton(
                      onPressed: _showModalSpaceSelection,
                      icon: Icon(
                        CupertinoIcons.line_horizontal_3_decrease_circle,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              titlePadding: WidgetConstants.horizontalPadding,
            ),
          ),
          Builder(builder: (context) {
            return SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  (demoTileCount / (selectedTabIndex + 1)).round(),
                  (idx) {
                    return SectionCard(
                      title: 'Title ${idx + 1}',
                      subtitle: 'Subtitle ${idx + 1}',
                      imageUrl: 'https://picsum.photos/600/600/?random=$idx',
                      onTap: () {},
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
            );
          })
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Function onTap;

  const SectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: WidgetConstants.itemPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: .7,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              blurRadius: 7.6,
              spreadRadius: -7,
              offset: const Offset(2, 9),
            ),
          ],
        ),
        height: 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            // fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                // fadeIn
                loadingBuilder: (context, child, loadingProgress) {
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
                      Theme.of(context).colorScheme.surface.withOpacity(.6),
                      Theme.of(context).colorScheme.surface.withOpacity(1),
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
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
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
    );
  }
}
