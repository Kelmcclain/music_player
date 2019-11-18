import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:music_player/progressbar.dart';

void main() => runApp(new HomePage());

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: StackBuilder()),
    );
  }
}

class StackBuilder extends StatefulWidget {
  StackBuilder({Key key}) : super(key: key);

  _StackBuilderState createState() => _StackBuilderState();
}

class _StackBuilderState extends State<StackBuilder>
    with TickerProviderStateMixin {
  AnimationController paneController;
  AnimationController playPauseController;
  AnimationController songCompletedController;
  Animation<double> paneAnimation;
  Animation<double> albumImageAnimation;
  Animation<double> albumImageBlurAnimation;
  Animation<Color> songContainerColorAnimation;
  Animation<Color> songContainerTextColorAnimation;
  Animation<double> songCompletedAnimation;

  bool isAnimCompleted = false;
  bool isSongPlaying = false;

  @override
  void initState() {
    super.initState();

    paneController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    songCompletedController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    paneAnimation = Tween<double>(begin: -200, end: 0.0)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    albumImageAnimation = Tween<double>(begin: 1.0, end: 0.5)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    albumImageBlurAnimation = Tween<double>(begin: 0.0, end: 5.0)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    songContainerColorAnimation =
        ColorTween(begin: Colors.black87, end: Colors.white.withOpacity(0.5))
            .animate(paneController);
    songContainerTextColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.black87)
            .animate(paneController);
    playPauseController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    songCompletedAnimation =
        Tween<double>(begin: 0.0, end: 400).animate(playPauseController);
  }

  animationInit() {
    if (isAnimCompleted) {
      paneController.reverse();
    } else {
      paneController.forward();
    }
    isAnimCompleted = !isAnimCompleted;
  }

  playsong() {
    if (isSongPlaying) {
      playPauseController.reverse();
    } else {
      playPauseController.forward();
    }
    isSongPlaying = !isSongPlaying;
  }

  Widget stackBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: albumImageAnimation.value,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('images/music.jpg'),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: albumImageBlurAnimation.value,
                  sigmaY: albumImageBlurAnimation.value),
              child: Container(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: paneAnimation.value,
          child: GestureDetector(
            onTap: () {
              animationInit();
            },
            child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                  color: songContainerColorAnimation.value,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Now Playing',
                        style: prefix0.TextStyle(
                            color: songContainerTextColorAnimation.value),
                      ),
                    ),
                    Text(
                      'Bad Banny-Amorfoda (Englsih Remix)',
                      style: prefix0.TextStyle(
                          color: songContainerTextColorAnimation.value,
                          fontSize: 16),
                    ),
                    Text(
                      'Connor Maynard, Anth',
                      style: prefix0.TextStyle(
                          color: songContainerTextColorAnimation.value,
                          fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: CustomPaint(
                          painter: ProgressBar(
                              songContainerTextColorAnimation.value,
                              songCompleted: songCompletedAnimation.value),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.skip_previous,
                            color: songContainerTextColorAnimation.value,
                            size: 40,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                playsong();
                              },
                              child: AnimatedIcon(
                                icon: AnimatedIcons.play_pause,
                                progress: playPauseController,
                                color: songContainerTextColorAnimation.value,
                                size: 40,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.skip_next,
                            color: songContainerTextColorAnimation.value,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, index) {
                          return Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                              'images/music.jpg'),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Another Song Name",
                                    style: prefix0.TextStyle(
                                        color: songContainerTextColorAnimation
                                            .value),
                                  ),
                                  Text(
                                    "Artist Name | 3:45",
                                    style: prefix0.TextStyle(
                                        color: songContainerTextColorAnimation
                                            .value),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: paneController,
      builder: (BuildContext context, widget) {
        return stackBody(context);
      },
    );
  }
}
