import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/physics.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  CurvedAnimation? curve;
  String report = "Generating report";
  bool isPlaying = true;

  final con_controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    con_controller.stop();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    curve = CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void dispose() {
    controller.dispose();
    con_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color navColor = ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.surfaceTint,
        0);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarContrastEnforced: true,
          systemNavigationBarColor: navColor,
          statusBarColor: navColor,
          systemNavigationBarDividerColor: navColor,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
        child: Stack(children: [
          Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              "Your Activity",
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DraggableCard(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.fastLinearToSlowEaseIn,
                                height: 150,
                                width: 150,
                                decoration:
                                    BoxDecoration(color: Colors.transparent),
                                child: Center(
                                  child: Image.asset(
                                    "assets/final.png",
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Text(
                    textAlign: TextAlign.start,
                    report,
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: DefaultTextStyle(
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation: false,

                      onFinished: () {
                        setState(() {
                          report = "Result";
                          controller.forward();
                          debugPrint("Done");
                        });
                      },
                      //pause: Duration(seconds: 0),
                      animatedTexts: [
                        TypewriterAnimatedText(' '),
                        TypewriterAnimatedText('Please wait...'),
                        TypewriterAnimatedText(' '),
                        TypewriterAnimatedText(' '),
                        TypewriterAnimatedText(' '),
                        TypewriterAnimatedText(' '),
                        TypewriterAnimatedText(' '),
                        TypewriterAnimatedText('Found the result 📋'),
                        TypewriterAnimatedText(
                            'Based on our analysis, your plant is showing below average temperature, humidity, and soil moisture. Tomato plants prefer warm temperatures, high humidity, and consistent moisture levels in the soil. When these conditions are not met, the plant may struggle to grow and produce healthy fruits\n \nTo improve the current plant conditions we recommend the following tasks to do. \n\n👉🏾 Covering the tomato plants with a light fabric or row cover can also help protect them from cold temperatures.\n\n👉🏾 You can increase humidity levels by misting the tomato plants with water or by placing a tray of water near the plants.\n\n👉🏾 Water the tomato plants regularly and deeply to ensure that the soil stays moist.\n\n\nWe hope you find these information useful, you can let us know below if you want'),
                        // TypewriterAnimatedText(
                        //     'We hope we have helped with our report'),
                      ],
                    ),
                  ),
                ),
                FadeTransition(
                    opacity: curve!,
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 2, 10),
                            child: TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      "We are sorry",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    content: Text(
                                      "Tell us what went wrong bu submitting a report, your opinion means a great deal to us",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Report",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              label: Text(
                                textAlign: TextAlign.start,
                                "Not helpful",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 10, 10, 10),
                            child: TextButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  action: SnackBarAction(
                                    label: '🎊🥳',
                                    onPressed: () {
                                      setState(() {
                                        con_controller.play();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          action: SnackBarAction(
                                            label: 'Yes!',
                                            onPressed: () {
                                              setState(() {
                                                con_controller.stop();
                                              });
                                            },
                                          ),
                                          content: Text('Stop the celebration'),
                                        ));
                                      });
                                    },
                                  ),
                                  content:
                                      Text('YEY Thank you for the feedback'),
                                ));
                              },
                              icon: const Icon(Icons.keyboard_arrow_up_rounded),
                              label: Text(
                                textAlign: TextAlign.start,
                                "Helpful",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: con_controller,
            shouldLoop: false,
            gravity: 1.0,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            minBlastForce: 10,
            maxBlastForce: 100,
            blastDirectionality: BlastDirectionality.explosive,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              Theme.of(context).colorScheme.tertiary,
            ],
          )
        ]));
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({required this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  var _dragAlignment = Alignment.center;

  Animation<Alignment>? _animation;

  final _spring = const SpringDescription(
    mass: 7,
    stiffness: 1200,
    damping: 0.7,
  );

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  void _runAnimation(Offset velocity, Size size) {
    _animation = _controller!.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0.0, 1.0, _normalizeVelocity(velocity, size));

    _controller!.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() => _dragAlignment = _animation!.value));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanStart: (details) => _controller!.stop(canceled: true),
      onPanUpdate: (details) => setState(
        () => _dragAlignment += Alignment(
          details.delta.dx / (size.width / 2),
          details.delta.dy / (size.height / 2),
        ),
      ),
      onPanEnd: (details) =>
          _runAnimation(details.velocity.pixelsPerSecond, size),
      child: Align(
        alignment: _dragAlignment,
        child: widget.child,
      ),
    );
  }
}
