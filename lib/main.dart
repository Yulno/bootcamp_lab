import 'package:flutter/material.dart'; 
import 'dart:math'; 
 
void main() { 
  runApp(const MyApp()); 
} 
 
class MyApp extends StatelessWidget { 
  const MyApp({super.key}); 
 
  
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'Flutter Demo', 
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), 
        useMaterial3: true, 
      ), 
      home: const MyHomePage(title: 'Flutter Demo Home Page'), 
    ); 
  } 
} 
 
class MyHomePage extends StatefulWidget { 
  const MyHomePage({super.key, required this.title}); 
 
  final String title; 
 
  @override 
  State<MyHomePage> createState() => _MyHomePageState(); 
} 
 

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackgroundContainer(
        child: Stack(
          children: [
            const Center(
              child: Text( 
                    'Will you be my valentine?', 
                    style: TextStyle (
                    fontFamily: 'Campana',
                    fontSize: 48,
                    color: Colors.white),
                  ), 
            ),
            Positioned(
              left: (MediaQuery.of(context).size.width / 2) - 100,
              top: (MediaQuery.of(context).size.height / 2) + 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.purple,
                    width: 4,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('Yes',
                  style: TextStyle (
                    fontFamily: 'Campana',
                    fontSize: 36,
                    color: Colors.white),),
                ),
              ),
            ),
            RandomPositionedButton(
              initialLeft: (MediaQuery.of(context).size.width / 2) + 50,
              initialTop: (MediaQuery.of(context).size.height / 2) + 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.purple,
                    width: 4,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text('No!!!!!',
                  style: TextStyle (
                    fontFamily: 'Campana',
                    fontSize: 36,
                    color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


 
class AnimatedBackgroundContainer extends StatefulWidget { 
  final Widget? child; 
  final List<Color>? colors; 
  final List<Alignment>? alignments; 
  final Duration duration; 
 
  const AnimatedBackgroundContainer({ 
    this.child, 
    this.colors, 
    this.alignments, 
    this.duration = const Duration(seconds: 2), 
    super.key, 
  }); 
 
  @override 
  _AnimatedBackgroundContainerState createState() => 
      _AnimatedBackgroundContainerState(); 
} 
 
class _AnimatedBackgroundContainerState 
    extends State<AnimatedBackgroundContainer> { 
  late final List<Color> colorList = widget.colors ?? 
      [ 
        Colors.red, 
        Colors.blue, 
        Colors.green, 
        Colors.yellow, 
      ]; 
  late final List<Alignment> alignmentList = widget.alignments ?? 
      [ 
        Alignment.bottomLeft, 
        Alignment.bottomRight, 
        Alignment.topRight, 
        Alignment.topLeft, 
      ]; 
  int index = 0; 
  Color bottomColor = Colors.red; 
  Color topColor = Colors.yellow; 
  Alignment begin = Alignment.bottomLeft; 
  Alignment end = Alignment.topRight; 
 
  @override 
  void initState() { 
    super.initState(); 
 
    Future.delayed(const Duration(milliseconds: 500), () { 
      setState(() { 
        bottomColor = Colors.blue; 
      }); 
    }); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: AnimatedContainer( 
        duration: widget.duration, 
        onEnd: () { 
          setState(() { 
            index = index + 1; 
            bottomColor = colorList[index % colorList.length]; 
            topColor = colorList[(index + 1) % colorList.length]; 
          }); 
        }, 
        decoration: BoxDecoration( 
          gradient: LinearGradient( 
            begin: begin, 
            end: end, 
            colors: [ 
              bottomColor, 
              topColor, 
            ], 
          ), 
        ), 
        child: widget.child, 
      ), 
    ); 
  } 
} 
 
 
 
 
class RandomPositionedButton extends StatefulWidget { 
  final Widget? child; 
  final Duration duration; 
 
  final double initialLeft; 
 
  final double initialTop; 
 
  const RandomPositionedButton({ 
    this.duration = const Duration(seconds: 1), 
    this.child, 
    this.initialLeft = 0, 
    this.initialTop = 0, 
    super.key, 
  }); 
 
  @override
State<RandomPositionedButton> createState() => _RandomPositionedButtonState(); 
} 
 
class _RandomPositionedButtonState extends State<RandomPositionedButton> { 
  late double top = widget.initialTop; 
 
  late double left = widget.initialLeft; 
 
  void _randomizePosition() { 
    setState(() { 
    
      top = Random().nextDouble() * (MediaQuery.of(context).size.height - 50); // ограничения, чтобы кнопка не вылетала за экран; 
      left = Random().nextDouble() * (MediaQuery.of(context).size.width + 50 ); // ограничения, чтобы кнопка не вылетала за экран; 
    }); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return AnimatedPositioned( 
      top: top, 
      left: left, 
      width: 100, 
      height: 100, 
      duration: widget.duration, 
      child: GestureDetector( 
        onTap: _randomizePosition, 
        child: widget.child, 
      ), 
    ); 
  } 
}
