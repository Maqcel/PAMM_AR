import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as color;
import 'package:vector_math/vector_math_64.dart';

class ArScreen extends StatefulWidget {
  final String imageUrl;
  final String name;
  ArScreen({required this.imageUrl, required this.name});

  @override
  _ArScreenState createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          iconTheme: IconThemeData(color: color.Colors.black87),
          backgroundColor: color.Colors.white,
          centerTitle: true,
          title: Text(
            widget.name,
            style: TextStyle(
              color: color.Colors.black87,
            ),
          ),
        ),
        body: Container(
          child: ARKitSceneView(
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty(image: widget.imageUrl),
      doubleSided: true,
    );
    final sphere = ARKitSphere(
      materials: [material],
      radius: 1,
    );

    final node = ARKitNode(
      geometry: sphere,
      position: Vector3.zero(),
      eulerAngles: Vector3.zero(),
    );
    this.arkitController.add(node);
  }
}
