import 'package:flutter/material.dart';

class PixelizedStadiumBorder extends OutlinedBorder {
  const PixelizedStadiumBorder({
    this.borderRadius = BorderRadius.zero,
    BorderSide side = BorderSide.none,
    this.pixelSize = 5.0,
    this.pixelRadius = 20.0
  }) : super(side: side);

  final BorderRadiusGeometry borderRadius;
  final pixelSize;
  final pixelRadius;

  @override
  OutlinedBorder copyWith({BorderSide? side}) =>
      PixelizedStadiumBorder(side: side ?? this.side);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final Radius radius = Radius.circular(rect.shortestSide / 2.0);
    final RRect borderRect = RRect.fromRectAndRadius(rect, radius);
    final RRect adjustedRect = borderRect.deflate(side.strokeInset);
    return Path()..addRRect(adjustedRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Radius radius = Radius.circular(rect.shortestSide / 2.0);
    return Path()..addRRect(RRect.fromRectAndRadius(rect, radius));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final pixelPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = pixelSize
      ..strokeCap = StrokeCap.square
      ..isAntiAlias = false;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        canvas.drawLine(Offset(pixelRadius, 0),
            Offset(rect.topRight.dx - pixelRadius, 0), pixelPaint);
        canvas.drawLine(
            Offset(pixelRadius, rect.bottomLeft.dy),
            Offset(rect.topRight.dx - pixelRadius, rect.bottomRight.dy),
            pixelPaint);

        canvas.drawLine(Offset(rect.topRight.dx, pixelRadius),
            Offset(rect.bottomRight.dx, rect.bottomLeft.dy-pixelRadius), pixelPaint);
        canvas.drawLine(Offset(0, pixelRadius),
            Offset(0, rect.bottomLeft.dy-pixelRadius), pixelPaint);
        arcBres(
            pixelPaint,
            canvas,
            Offset(rect.topLeft.dx + pixelRadius-pixelSize/2, pixelRadius-pixelSize/2),
            pixelRadius,
            4);
        arcBres(
            pixelPaint,
            canvas,
            Offset(rect.topRight.dx - pixelRadius-pixelSize/2, pixelRadius-pixelSize/2),
            pixelRadius,
            1);
        arcBres(
            pixelPaint,
            canvas,
            Offset(rect.bottomLeft.dx + pixelRadius-pixelSize/2,
                rect.bottomLeft.dy - pixelRadius-pixelSize/2),
            pixelRadius,
            2);
        arcBres(
            pixelPaint,
            canvas,
            Offset(rect.bottomRight.dx - pixelRadius-pixelSize/2,
                rect.bottomRight.dy - pixelRadius-pixelSize/2),
            pixelRadius,
            3);
    }
  }

  void drawPixels(Paint pixelPaint, Canvas canvas, double xc, double yc,
      double x, double y, int part) {
    switch (part) {
      case 1:
        {
          canvas.drawRect(
              Rect.fromPoints(Offset(xc + x, yc - y),
                  Offset(xc + x + pixelSize, yc - y + pixelSize)),
              pixelPaint);
          canvas.drawRect(
              Rect.fromPoints(Offset(xc + y, yc - x),
                  Offset(xc + y + pixelSize, yc - x + pixelSize)),
              pixelPaint);
        }
      case 2:
        {
          canvas.drawRect(
              Rect.fromPoints(Offset(xc - x, yc + y),
                  Offset(xc - x + pixelSize, yc + y + pixelSize)),
              pixelPaint);
          canvas.drawRect(
              Rect.fromPoints(Offset(xc - y, yc + x),
                  Offset(xc - y + pixelSize, yc + x + pixelSize)),
              pixelPaint);
        }
      case 3:
        {
          canvas.drawRect(
              Rect.fromPoints(Offset(xc + x, yc + y),
                  Offset(xc + x + pixelSize, yc + y + pixelSize)),
              pixelPaint);
          canvas.drawRect(
              Rect.fromPoints(Offset(xc + y, yc + x),
                  Offset(xc + y + pixelSize, yc + x + pixelSize)),
              pixelPaint);
        }
      case 4:
        {
          canvas.drawRect(
              Rect.fromPoints(Offset(xc - x, yc - y),
                  Offset(xc - x + pixelSize, yc - y + pixelSize)),
              pixelPaint);
          canvas.drawRect(
              Rect.fromPoints(Offset(xc - y, yc - x),
                  Offset(xc - y + pixelSize, yc - x + pixelSize)),
              pixelPaint);
        }
    }
  }

  void arcBres(
      Paint pixelPaint, Canvas canvas, Offset corner, double r, int part) {
    double xc = corner.dx;
    double yc = corner.dy;
    double x = 0;
    double y = r;
    double d = 3 - 2 * r;
    drawPixels(pixelPaint, canvas, xc, yc, x, y, part);
    while (y >= x) {
      // for each pixel we will
      // draw all eight pixels

      x += pixelSize;

      // check for decision parameter
      // and correspondingly
      // update d, x, y
      if (d > 0) {
        y -= pixelSize;
        d = d + 4 * (x - y)  + 10;
      } else {
        d = d + 4 * x + 6;
      }
      drawPixels(pixelPaint, canvas, xc, yc, x, y, part);
    }
  }

  @override
  ShapeBorder scale(double t) => PixelizedStadiumBorder(side: side.scale(t));
}