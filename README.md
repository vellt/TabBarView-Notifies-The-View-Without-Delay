# TabBarView notifies the View without delay⏱️

I encountered an interesting problem throgh a project, with many open issues on the Web, such as: 

- [TabController notifies correct index with a delay (after the tab scroll animation ends) #88875](https://github.com/flutter/flutter/issues/88875)
 
- [TabController listener triggers with delay on swipe #89371](https://github.com/flutter/flutter/issues/89371)

- [Describe how to listen for page updates in TabBar and TabBarView when using DefaultTabController #53155](https://github.com/flutter/flutter/issues/53155)

I demonstrate the ability of TabBarView to notify the view with the correct index without delay. ✅ <br>
Documentation in the [the rows of the code](https://github.com/vellt/TabBarView-Notifies-The-View-Without-Delay/blob/main/lib/main.dart). ✍️ 
The soul of the project: 

```dart
// indexController.change() comes from IndexController, which is declared in main.dart.

var _ = DefaultTabController.of(context);
_?.animation!.addListener(() {
  indexController.change(newValue:(_.indexIsChanging)?_.index:_.animation!.value.round());
});

```

🎥 Here is a **preview GIF**, where you can see, how it works:

<img title="" src="https://github.com/vellt/TabBarView-Notifies-The-View-Without-Delay/blob/main/1675099977893.gif?raw=true" alt="https://github.com/vellt/TabBarView-Notifies-The-View-Without-Delay/blob/main/1675099977893.gif?raw=true" width="328">
