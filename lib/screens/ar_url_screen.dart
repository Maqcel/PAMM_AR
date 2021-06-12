import 'package:flutter/material.dart';

import 'ar_screen.dart';

class ArFromUrlScreen extends StatefulWidget {
  @override
  _ArFromUrlScreenState createState() => _ArFromUrlScreenState();
}

class _ArFromUrlScreenState extends State<ArFromUrlScreen> {
  final TextEditingController imageUrlController = TextEditingController();
  late bool isImagePassed;
  late bool isValid;

  @override
  void initState() {
    isImagePassed = false;
    isValid = true;
    super.initState();
  }

  @override
  void dispose() {
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    imageUrlController.text.isNotEmpty
        ? setState(() {
            isImagePassed = true;
          })
        : setState(() {
            isImagePassed = false;
          });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 5.0,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Paste Url for travel!',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(
                    child: imageUrlController.text.isNotEmpty
                        ? Image.network(
                            imageUrlController.text,
                            fit: BoxFit.cover,
                            errorBuilder: (context, url, error) {
                              isValid = false;
                              return Row(
                                children: [
                                  Text('Image error, wrong url!'),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Icon(Icons.error_outline),
                                ],
                              );
                            },
                          )
                        : Text('Image preview'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: imageUrlController,
                    decoration: InputDecoration(
                      labelText: "Image url",
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                color: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Travel to AR!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              onTap: () {
                if (isImagePassed && isValid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArScreen(
                        imageUrl: imageUrlController.text,
                        name: 'Desired place!',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isImagePassed
                            ? 'Url has no image in it!'
                            : 'You forgot to paste the url!',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
