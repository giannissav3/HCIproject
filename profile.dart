import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  // Dummy list of images for the carousel
  List<String> images = ['imagepath', 'imagepath', 'image path'];

  void onPhotoCapture(String photoPath) {
    print('Before updating state: $images');
    setState(() {
      images.insert(
          0, photoPath); // Insert the new photo at the beginning of the list
    });
    print('After updating state: $images');
  }

  @override
  Widget build(BuildContext context) {
    print('Building ProfilePage with images: $images');
    var colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: colorScheme.surfaceVariant,
          child: const Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Username',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.checkroom)),
                    Tab(icon: Icon(Icons.people)),
                    Tab(icon: Icon(Icons.settings)),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildClosetPage(context),
                      Center(
                        child: Text('Friends Page'),
                      ),
                      Center(
                        child: Text('Settings Page'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClosetPage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: false,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: images.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: FileImage(File(item)),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
