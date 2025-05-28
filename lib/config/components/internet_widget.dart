import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class InternetWidget extends StatefulWidget {
  const InternetWidget({super.key});

  @override
  State<InternetWidget> createState() => _InternetWidgetState();
}

class _InternetWidgetState extends State<InternetWidget> {
  @override
  Widget build(BuildContext context) {
   final double width = MediaQuery.of(context).size.width;
   final double height = MediaQuery.of(context).size.height;
    return  SizedBox(
      height: MediaQuery.of(context).size.height*.35,
      width:MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          "No Internet connection "
              .text
              .center
              .bold
              .size(19)
              .fontFamily("Quicksand")
              .maxLines(3)
              .make(),
          "Please check your internet connection \n and try again"
              .text
              .center
              .size(19)
              .fontFamily("Quicksand")
              .maxLines(2)
              .make(),
          SizedBox(height:20),
          Icon(
            Icons
                .signal_cellular_connected_no_internet_0_bar,
            color:Colors.red,
            size: 20,
          ),
          SizedBox(height:10),
          Container(
            height: height * 0.04,
            width: width * 0.2,
            decoration: BoxDecoration(
                border: Border.all(
                    color:Colors.red,
                    width: 2),
                borderRadius:
                BorderRadius.circular(20)),
            child: Center(
                child: Text("Refresh"))
            ,
          )
        ],
      ),
    );
  }
}
