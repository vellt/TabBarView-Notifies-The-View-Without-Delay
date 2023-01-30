import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tab UI',
      theme: ThemeData.dark(),
      home: TabUI(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// It's a simple GetX Controller, where I can track the current index.
class IndexController extends GetxController {
  int index = 0;

  /// to the change and update of the index value
  change({required int newValue}) {
    index = newValue;
    update();
  }
}

/// It's the main view, where I demonstrate the ability of TabView to notify the view with the correct index without delay
class TabUI extends StatelessWidget {
  // I made an object from the IndexController, so now I can get everything from it
  IndexController indexController = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // I defined below 3 tabs and 3 TabBarView's children, so you have to add value 3 to the length
      length: 3,
      child: Builder(builder: (context) {
        // I made an object from DefaultTabController of the Context, which I can achieve the animation event
        var _ = DefaultTabController.of(context);
        // When You are scrolling on the TabBarView, this animation event will be triggered
        _?.animation!.addListener(() {
          // I rounded the current value of the Index, it's a very important step
          int temp = _.animation!.value.round();
          if (indexController.index != temp) {
            // Here I will change the current value to another, which will update the view
            indexController.change(newValue: temp);
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text("The refreshed index is:"),
            actions: [
              GetBuilder<IndexController>(
                init: indexController,
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Center(
                      child: Text(
                        "${_.index}",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              TabBar(
                onTap: (value) {
                  // When You tap a Tab's element, this onTap event will be triggered
                  if (indexController.index != value) {
                    // Here I will change the current value to another, which will update the view
                    indexController.change(newValue: value);
                  }
                },
                tabs: const [
                  Tab(child: Text("0", style: TextStyle(fontSize: 20))),
                  Tab(child: Text("1", style: TextStyle(fontSize: 20))),
                  Tab(child: Text("2", style: TextStyle(fontSize: 20))),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("0", style: TextStyle(fontSize: 50))),
                    Center(child: Text("1", style: TextStyle(fontSize: 50))),
                    Center(child: Text("2", style: TextStyle(fontSize: 50))),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
