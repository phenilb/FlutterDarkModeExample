import 'package:dark_mode_example/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //bool toggleValue = false;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    bool current = themeChange.darkTheme;
    print("current $current");

    return Scaffold(
      appBar: AppBar(
        title: const Text("DarkModeExample"),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            )
          ],
        ),
        child: Drawer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Dark Mode"),
              GestureDetector(
                onHorizontalDragStart: (_) {
                  setState(() {
                    themeChange.darkTheme = !current;
                    //toggleValue = !toggleValue
                  });
                  print("themeChange.darkTheme = ${themeChange.darkTheme}");
                },
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color: toggleValue ? Colors.green[400] : Colors.white,
                    color: themeChange.darkTheme ? Colors.green[400] : Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 1),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AnimatedPositioned(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              //toggleValue = !toggleValue;
                              themeChange.darkTheme = !current;
                            });
                            print("themeChange.darkTheme = ${themeChange.darkTheme}");
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: themeChange.darkTheme
                                ? Container(
                                    height: 25,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: Colors.white, shape: BoxShape.circle),
                                    key: UniqueKey(),
                                  )
                                : Container(
                                    height: 25,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: Colors.black, shape: BoxShape.circle),
                                    key: UniqueKey(),
                                  ),
                          ),
                        ),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        top: -2.5,
                        left: themeChange.darkTheme ? 30 : 0,
                        right: themeChange.darkTheme ? 0 : 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          elevation: 5,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("This is some text"),
              ElevatedButton(
                onPressed: () {},
                child: const Text("PRESS THIS"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
