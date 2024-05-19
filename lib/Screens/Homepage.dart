import 'dart:convert';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:ebookapp/widget/AppTabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  ScrollController? _scrollController;
  List popularBooks=[];

  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20,top: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    AssetImage(
                      "assets/images/menu.png",
                    ),
                    color: Colors.black,
                    size: 24,
                  ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      ImageIcon(
                        AssetImage(
                          "assets/images/notification.png",
                        ),
                        color: Colors.black,
                        size: 22,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Popular Books ",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: Container(
                    height: 180,
                    child: PageView.builder(
                        controller: PageController(viewportFraction: 0.8),
                        itemCount: popularBooks==null?0:popularBooks.length,
                        itemBuilder: (_, i) {
                          return Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(popularBooks[i]["imageLink"]),
                              fit: BoxFit.fill),
                            ),
                          );
                        }),
                  ))
                ],
              ),
            ),
            Expanded(child:
            NestedScrollView(
              controller:_scrollController ,
              headerSliverBuilder: (BuildContext context,bool isScroll){
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    bottom: PreferredSize(preferredSize: const Size.fromHeight(50),
                      child:Container(
                        margin: const EdgeInsets.only(bottom: 20,left: 20),
                        child: TabBar(
                         // indicatorPadding: EdgeInsets.all(0),
                          //indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: const EdgeInsets.only(right: 10),
                          controller: _tabController,
                          isScrollable: false,
                          indicator: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(color: Colors.grey.withOpacity(0.2),
                            blurRadius:7,
                            offset: const Offset(0,0))
                          ]
                          ),
                          tabs: [
                            AppTabs(color: Colors.yellow.shade700, text: "New"),
                            AppTabs(color: Colors.red.shade400, text: "Popular"),
                            AppTabs(color: Colors.blue.shade400, text: "Trending"),

                          ],
                        ),
                      ),),
                  )
                ];

              }, body: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(itemCount: popularBooks==null?0:popularBooks.length,
                    itemBuilder: (_,i){
                      return Container(
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0,0),
                              color: Colors.grey.withOpacity(0.2),
                            )]
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(popularBooks[i]["bookslist"]),
                                        fit: BoxFit.fill),)
                                ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star,size: 24,color: Colors.amber.shade700,),
                                      SizedBox(width: 5,),
                                      Text(popularBooks[i]["rating"],style: TextStyle(color: Colors.red.shade400),),
                                    ],
                                  ),
                                  Text(popularBooks[i]["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Text(popularBooks[i]["author"],style: TextStyle(fontSize: 16,color: Colors.grey.shade500),),
                                  Container(width: 50,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                      child: Text(popularBooks[i]["year"],style: TextStyle(fontSize: 13.5,color: Colors.white),)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ListView.builder(itemCount: popularBooks==null?0:popularBooks.length,
                    itemBuilder: (_,i){
                      return Container(
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0,0),
                              color: Colors.grey.withOpacity(0.2),
                            )]
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                  width: 90,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(popularBooks[i]["bookslist"]),
                                        fit: BoxFit.fill),)
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star,size: 24,color: Colors.amber.shade700,),
                                      SizedBox(width: 5,),
                                      Text(popularBooks[i]["rating"],style: TextStyle(color: Colors.red.shade400),),
                                    ],
                                  ),
                                  Text(popularBooks[i]["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Text(popularBooks[i]["author"],style: TextStyle(fontSize: 16,color: Colors.grey.shade500),),
                                  Container(width: 50,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.blue,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Text(popularBooks[i]["year"],style: TextStyle(fontSize: 13.5,color: Colors.white),)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ListView.builder(itemCount: popularBooks==null?0:popularBooks.length,
                    itemBuilder: (_,i){
                      return Container(
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0,0),
                              color: Colors.grey.withOpacity(0.2),
                            )]
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                  width: 90,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(popularBooks[i]["bookslist"]),
                                        fit: BoxFit.fill),)
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star,size: 24,color: Colors.amber.shade700,),
                                      SizedBox(width: 5,),
                                      Text(popularBooks[i]["rating"],style: TextStyle(color: Colors.red.shade400),),
                                    ],
                                  ),
                                  Text(popularBooks[i]["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Text(popularBooks[i]["author"],style: TextStyle(fontSize: 16,color: Colors.grey.shade500),),
                                  Container(width: 50,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.blue,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Text(popularBooks[i]["year"],style: TextStyle(fontSize: 13.5,color: Colors.white),)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
            ))


          ],
        ),
      ),
    );
  }
}
