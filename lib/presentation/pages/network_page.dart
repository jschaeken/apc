import 'package:apc/domain/models/mentor.dart';
import 'package:apc/domain/models/player.dart';
import 'package:apc/domain/models/space.dart';
import 'package:apc/presentation/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  List<Player> topPlayers = [
    Player(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/701',
    ),
    Player(
      id: '2',
      firstName: 'Jane',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/702',
    ),
    Player(
      id: '3',
      firstName: 'John',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/703',
    ),
    Player(
      id: '4',
      firstName: 'Jane',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/704',
    ),
    Player(
      id: '5',
      firstName: 'John',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/705',
    ),
    Player(
      id: '6',
      firstName: 'Jane',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/706',
    ),
    Player(
      id: '7',
      firstName: 'John',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/707',
    ),
    Player(
      id: '8',
      firstName: 'Jane',
      lastName: 'Doe',
      imageUrl: 'https://i.pravatar.cc/708',
    ),
  ];

  void _navToPlayerProfile(Player player) {
    Navigator.pushNamed(context, '/profile', arguments: player.id);
  }

  List<Mentor> mentors = [
    Mentor(
      id: '1',
      name: 'Sheamie Parra',
      imageUrl:
          'https://scontent.cdninstagram.com/v/t39.30808-6/439959852_18435939313018442_7542552085840413609_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE2MjIuc2RyLmYzMDgwOCJ9&_nc_ht=scontent.cdninstagram.com&_nc_cat=102&_nc_ohc=AJzwWSVstY4Q7kNvgGF2tKo&edm=APs17CUAAAAA&ccb=7-5&ig_cache_key=MzM2NjE5MTk1MTYyOTg0NDkzNQ%3D%3D.2-ccb7-5&oh=00_AYA3VHWYHeNX1SLF4ZDB7ZpT359E-bdDIsfyXBdzjX2z_g&oe=6659E93D&_nc_sid=10d13b',
      title: 'Online Coach',
      location: 'Dubai, UAE',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Top Players this week
          // Title
          Padding(
            padding: WidgetConstants.horizontalPadding,
            child: Text(
              'Top Players this week',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          // Scrollview horizontal
          SizedBox(
            // color: Colors.red,
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topPlayers.length,
              // padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navToPlayerProfile(topPlayers[index]);
                  },
                  child: Hero(
                    tag: topPlayers[index].id,
                    child: CircleAvatar(
                      foregroundImage:
                          NetworkImage(topPlayers[index].imageUrl!),
                      radius: 50,
                    ),
                  ),
                );
              },
            ),
          ),

          // Divider
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 1,
            height: 80,
            indent: 8,
            endIndent: 8,
          ),

          // Spaces
          // Horizontal Scrollview

          Padding(
            padding: WidgetConstants.horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mentor Title
                Text(
                  'Mentors',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Mentor Cards
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mentors.length,
                  itemBuilder: (context, index) {
                    return MentorCard(
                      backgroundImageUrl: mentors[index].imageUrl!,
                      mentor: mentors[index],
                      onTap: () {},
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MentorCard extends StatelessWidget {
  final String backgroundImageUrl;
  final Mentor mentor;
  final Function onTap;

  const MentorCard({
    super.key,
    required this.backgroundImageUrl,
    required this.mentor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
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
                backgroundImageUrl,
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
                      Theme.of(context).colorScheme.primary.withOpacity(.4),
                      Theme.of(context).colorScheme.primary.withOpacity(.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: WidgetConstants.itemPadding,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          // foregroundImage: NetworkImage(backgroundImageUrl),
                          child: CircleAvatar(
                            radius: 48,
                            foregroundImage: NetworkImage(backgroundImageUrl),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mentor.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(CupertinoIcons.briefcase_fill),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                mentor.title ?? '',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(CupertinoIcons.location_fill),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                mentor.location ?? '',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
