import 'package:avagaman/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {
  final String? message;
  const LoadingDialogWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CustomLoader(),
            // CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            // ),
          ),
          Text("$message, Please Wait.....")
        ],
      ),
    );
  }
}
