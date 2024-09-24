import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';
import 'dart:convert';

import 'package:spotify_sdk/spotify_sdk.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with AutomaticKeepAliveClientMixin {
  String _accessToken = '';
  List<dynamic> _tracks = [];
  Track? currentTrack;
  Uint8List? currentImageInt8List;
  Image? currentImage;
  Stream<PlayerState>? playerStateStream;
  bool authed = false;
  AnimationController? musicController;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _autoAuthSpotify();
  }

  Future<void> _autoAuthSpotify() async {
    try {
      prefs = await SharedPreferences.getInstance();
      _accessToken = prefs!.getString('spotify_access_token') ?? '';
      if (_accessToken.isNotEmpty) {
        authed = await SpotifySdk.connectToSpotifyRemote(
          clientId: "822736f744d745a28a960c7cef4c3ee8",
          redirectUrl: "spotify-ios-quick-start://spotify-login-callback",
          accessToken: _accessToken,
        );
        playerStateStream = SpotifySdk.subscribePlayerState();
        setState(() {});
      } else {
        setState(() {
          authed = false;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _authSpotify() async {
    try {
      final String _authToken = await SpotifySdk.getAccessToken(
        clientId: "822736f744d745a28a960c7cef4c3ee8",
        redirectUrl: "spotify-ios-quick-start://spotify-login-callback",
        scope:
            "app-remote-control, user-read-playback-state, user-modify-playback-state",
      );
      prefs = await SharedPreferences.getInstance();
      if (_authToken.isNotEmpty) {
        prefs?.setString('spotify_access_token', _authToken);
        authed = await SpotifySdk.connectToSpotifyRemote(
          clientId: "822736f744d745a28a960c7cef4c3ee8",
          redirectUrl: "spotify-ios-quick-start://spotify-login-callback",
          accessToken: _authToken,
        );
        playerStateStream = SpotifySdk.subscribePlayerState();
        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error connecting to Spotify'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return !authed
        ? UnauthMusicView(
            onConnect: () async {
              await _authSpotify();
            },
          )
        : PlayerView(
            playerStateStream: playerStateStream,
            musicController: musicController,
          );
  }

  @override
  bool get wantKeepAlive => true;
}

class PlayerView extends StatelessWidget {
  const PlayerView({
    super.key,
    required this.playerStateStream,
    required this.musicController,
  });

  final Stream<PlayerState>? playerStateStream;
  final AnimationController? musicController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: playerStateStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final PlayerState playerState = snapshot.data as PlayerState;
        log('PlayerState: ${playerState.track}');
        bool isPlaying = !playerState.isPaused;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            // title: const Text('Music'),
          ),
          body: Stack(
            children: [
              if (playerState.track?.imageUri != null)
                FutureBuilder(
                  future: SpotifySdk.getImage(
                      imageUri: playerState.track!.imageUri),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(snapshot.data as Uint8List),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                    );
                  },
                ),

              // Blur image
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Column(
                      children: [
                        if (playerState.track?.imageUri != null)
                          FutureBuilder(
                            future: SpotifySdk.getImage(
                                imageUri: playerState.track!.imageUri),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return const CircularProgressIndicator();
                              }
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 202,
                                    height: 202,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(400),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(400),
                                    child: Image.memory(
                                      snapshot.data as Uint8List,
                                      width: 200,
                                      height: 200,
                                    ),
                                  )
                                      .animate(
                                        controller: musicController,
                                        onPlay: (controller) =>
                                            controller.repeat(),
                                      )
                                      .rotate(
                                        duration: const Duration(seconds: 20),
                                      ),
                                ],
                              );
                            },
                          ),
                        const SizedBox(
                          height: 60,
                        ),
                        // Track name
                        StatefulBuilder(builder: (context, setState) {
                          ScrollController _scrollController =
                              ScrollController();

                          _scrollController = ScrollController();
                          // _scrollController.onAttach
                          _scrollController.addListener(() {
                            log('Scrolling');
                          });

                          return SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: ScrollController(),
                              child: Text(
                                playerState.track?.name ?? 'No track playing',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          );
                        }),
                        // Artist name
                        Text(
                          playerState.track?.artist.name ?? 'No artist',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        // Player slider
                        if (playerState.track != null)
                          Slider(
                            value: (playerState.playbackPosition).toDouble(),
                            thumbColor: Colors.white,
                            inactiveColor:
                                const Color.fromARGB(255, 38, 38, 38),
                            activeColor: Colors.grey,
                            onChanged: (value) => {},
                            onChangeEnd: (value) {
                              SpotifySdk.seekTo(
                                positionedMilliseconds: value.toInt(),
                              );
                            },
                            min: 0,
                            max: (playerState.track!.duration).toDouble(),
                          ),
                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Previous button
                            IconButton(
                              onPressed: () {
                                SpotifySdk.skipPrevious();
                              },
                              icon: const Icon(CupertinoIcons.backward_end),
                              iconSize: 38,
                            ),
                            // Play/Pause button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  if (isPlaying) {
                                    SpotifySdk.pause();
                                  } else {
                                    SpotifySdk.resume();
                                  }
                                  // setState(() {});
                                },
                                icon: Icon(
                                  isPlaying
                                      ? CupertinoIcons.pause
                                      : CupertinoIcons.play_arrow,
                                ),
                                iconSize: 50,
                              ),
                            ),
                            // Next button
                            IconButton(
                              onPressed: () {
                                SpotifySdk.skipNext();
                              },
                              icon: const Icon(CupertinoIcons.forward_end),
                              iconSize: 38,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UnauthMusicView extends StatelessWidget {
  const UnauthMusicView({
    super.key,
    required this.onConnect,
  });

  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Music'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Connect to Spotify
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              onConnect();
            },
            child: const Text('Connect to Spotify'),
          ),
        ],
      )),
    );
  }
}
