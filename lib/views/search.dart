import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_talks/Widgets/widget.dart';
import 'package:up_talks/helper/constants.dart';
import 'package:up_talks/services/database.dart';

import 'conversation_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  late QuerySnapshot<Map<String, dynamic>> searchSnapshot;

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


  createChatroomandStartConvo({required String userName})
  {

    if(userName != Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatroomId" : chatRoomId,
      };

      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen(),
          ));
    }
    else{
      print("you cannot text yourself");
    }
  }

  Widget SearchTile({required String userName, required String userEmail}) {
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
              createChatroomandStartConvo(userName: userName);
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
                      height: 40,
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



getChatRoomId(String a, String b) {
  if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else{
    return "$a\_$b";
  }
}

