import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_talks/Widgets/widget.dart';
import 'package:up_talks/services/database.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  late QuerySnapshot<Map<String, dynamic>> searchSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch(){
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  // createChatroomandStartConvo(String userName){
  //
  //   List<String> users = [userName, myName];
  //   databaseMethods.createChatRoom(chatRoomId, chatRoomMap)
  // }

  Widget searchList(){
    return searchSnapshot != null ?  ListView.builder(
      itemCount:searchSnapshot.docs.length ,
        shrinkWrap: true,
        itemBuilder: (context, index){
        return SearchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email"],
        );
        }) :Container();
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "Search Username",
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 15,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                      searchTextEditingController.clear();
                    },
                    child: Container(
                      height: 400,
                      width: 40,
                      child: Icon(
                          Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      )
    );
  }
}

class SearchTile extends StatelessWidget {

  final String userName;
  final String userEmail;
  SearchTile({required this.userName, required this.userEmail});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Text("Message"),
            ),
          ),
        ],
      ),
    );
  }
}

