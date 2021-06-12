import 'package:flutter/material.dart';
import 'package:new_ar/components/custom_drawer.dart';
import 'package:new_ar/config/firebase_paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ar_screen.dart';

class HomeScreen extends StatelessWidget {
  final CollectionReference places =
      FirebaseFirestore.instance.collection(Paths.places);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 5.0,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Travel anywhere!',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: places.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Couldn\'t fetch places from the database :(');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<QueryDocumentSnapshot> listData = snapshot.data!.docs;
              return ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> json = listData[index].data();
                  return Card(
                    child: ListTile(
                      title: Text(
                        json['name'] as String,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        json['country'] as String,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArScreen(
                              imageUrl: json['image_url'] as String,
                              name: json['name'] as String,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
