import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:udhaarkaroapp/constants/colors.dart';

class CircularLoader extends StatelessWidget {

  final int load;
  final bool bgContainer;
  final Color color;
  CircularLoader({this.load, this.bgContainer = true, this.color = blueColor});

  @override
  Widget build(BuildContext context) {
    return (load == 1) ?
    Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: (bgContainer) ? Colors.black.withOpacity(0.3) : Colors.transparent,
      child: SpinKitCircle(
        color: color,
        size: 60.0,
      ),
    ) :
    Text("");
  }
}


class FoldingCubeLoader extends StatelessWidget {

  final int load;
  final bool bgContainer;
  final Color color;
  FoldingCubeLoader({this.load, this.bgContainer = true, this.color = blueColor});

  @override
  Widget build(BuildContext context) {
    return (load == 1) ?
    Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: (bgContainer) ? Colors.black.withOpacity(0.3) : Colors.transparent,
      child: SpinKitFoldingCube(
        color: color,
        size: 60.0,
      ),
    ) :
    Text("");
  }
}