import 'package:flutter/material.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Painter'),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        painter: MyCustomPainter(),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;

    // canvas.drawLine(Offset(0, 0), Offset(width, height), paint);
    // canvas.drawCircle(Offset(width * 0.5, height * 0.5), 40, paint);
    // canvas.drawRect(Rect.fromLTRB(10, 20, width * 0.5, height * 0.5), paint);

    Path path = Path();
    path.addPolygon([
      Offset(0, height * 0.5),
      Offset(width * 0.1, height * 0.2),
      Offset(width * 0.2, height * 0.3),
      Offset(width * 0.4, height * 0.5),
      Offset(width * 0.6, height * 0.7),
    ], true);
    canvas.drawPath(path, paint);
    // path.addPath(path, Offset(0, 0.5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
