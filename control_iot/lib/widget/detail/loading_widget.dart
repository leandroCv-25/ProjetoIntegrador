import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          SizedBox(height: 16),
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage("assets/images/logo.png"),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 16),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.purple),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
