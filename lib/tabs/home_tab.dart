import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  Widget _buildBodyBack() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            )
          ],
        )
      ],
    );
  }
}
