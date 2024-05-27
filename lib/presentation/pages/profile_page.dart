import 'package:apc/presentation/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Demo Data
  List<ConnectData> connectData = [
    ConnectData(
      icon: 'assets/icons/x_icon.png',
      url: 'https://twitter.com/essenceapps',
    ),
    ConnectData(
      icon: 'assets/icons/instagram_icon.png',
      url: 'https://www.instagram.com/aplayersclub/',
    ),
    ConnectData(
      icon: 'assets/icons/telegram_icon.png',
      url: 'https://telegram.me/jacquesschaeken',
    ),
  ];

  bool _isEditing = false;

  void _editProfile(BuildContext context) {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TODO: Get user profile from auth provider
  }

  _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              _editProfile(context);
            },
            icon: Icon(
              _isEditing
                  ? CupertinoIcons.check_mark_circled
                  : CupertinoIcons.pencil,
              color: _isEditing
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),

              // Profile Picture
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'profileAvatar',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundImage: const NetworkImage(
                        'https://i.ibb.co/P4m662W/ai-gen-me.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Jacques Schaeken',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                ],
              ),

              // Job and Location
              const SizedBox(
                width: double.infinity,
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.briefcase_fill,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    'Agency Owner',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.location_fill,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    'Valencia, Spain',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),

              // Connect Bar
              const SizedBox(
                width: double.infinity,
                height: 35,
              ),
              Row(
                children: [
                  Text(
                    'Connect',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 0.7,
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
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var data in connectData)
                      ConnectIcon(
                        path: data.icon,
                        onPressed: () {
                          _launchUrl(data.url);
                        },
                      ),
                  ],
                ),
              ),

              // Content Collage
              const SizedBox(
                width: double.infinity,
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    'Content',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              // Content Collage GridView
              GridView.builder(
                shrinkWrap: true,
                itemCount: 7,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 35,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 0.7,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://picsum.photos/600/600/?random=${index.toString()}',
                            ),
                            fit: BoxFit.cover,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(.7),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .moveY(
                        duration: const Duration(milliseconds: 500),
                        begin: 100 * ((index + 1) / 5).toDouble(),
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectData {
  final String icon;
  final String url;

  ConnectData({
    required this.icon,
    required this.url,
  });
}

class ConnectIcon extends StatelessWidget {
  final String path;
  final Function() onPressed;

  const ConnectIcon({
    required this.path,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        path,
        width: 30,
        height: 30,
      ),
    );
  }
}
