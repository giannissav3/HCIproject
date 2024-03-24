import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Friend> friends = [];
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    // friends with placeholder images
    friends.add(Friend(
      name: 'Alice',
      photos: List.generate(
        2,
        (index) => Photo(placeholder: PlaceholderWidget(), rating: 4),
      ),
    ));
    friends.add(Friend(
      name: 'Bob',
      photos: List.generate(
        2,
        (index) => Photo(placeholder: PlaceholderWidget(), rating: 3),
      ),
    ));
    friends.add(Friend(
      name: 'Charlie',
      photos: List.generate(
        2,
        (index) => Photo(placeholder: PlaceholderWidget(), rating: 5),
      ),
    ));
    friends.add(Friend(
      name: 'David',
      photos: List.generate(
        2,
        (index) => Photo(placeholder: PlaceholderWidget(), rating: 2),
      ),
    ));
    friends.add(Friend(
      name: 'Eva',
      photos: List.generate(
        2,
        (index) => Photo(placeholder: PlaceholderWidget(), rating: 4),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<Friend> filteredFriends = friends
        .where((friend) =>
            friend.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Style App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: FriendSearchDelegate(friends),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    searchText = value;
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                itemCount: filteredFriends.length,
                itemBuilder: (context, index) {
                  return _buildFriendPage(filteredFriends[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendPage(Friend friend) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: Colors.grey, // Customize the background color if needed
          child: Center(
            child: Text(
              friend.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            itemCount: friend.photos.length,
            itemBuilder: (context, index) {
              return _buildPhotoCard(friend.photos[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoCard(Photo photo) {
    return Card(
      margin: EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: photo.placeholder,
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Rate:'),
              SizedBox(width: 4),
              Text('${photo.rating}/5'),
            ],
          ),
        ],
      ),
    );
  }
}

class Photo {
  final Widget placeholder;
  int rating;

  Photo({required this.placeholder, required this.rating});
}

class Friend {
  final String name;
  List<Photo> photos;

  Friend({required this.name, required this.photos});
}

class PlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey,
      child: Center(
        child: Icon(
          Icons.person,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FriendSearchDelegate extends SearchDelegate<String> {
  final List<Friend> friends;

  FriendSearchDelegate(this.friends);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    List<Friend> filteredFriends = friends
        .where(
            (friend) => friend.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredFriends.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredFriends[index].name),
          onTap: () {
            close(context, filteredFriends[index].name);
          },
        );
      },
    );
  }
}
