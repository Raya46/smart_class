import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_class/component/AddDevicePage.dart';
import 'package:smart_class/component/AudioPage.dart';
import 'package:smart_class/component/CameraPage.dart';
import 'package:smart_class/global/Color.dart';
import 'package:smart_class/page/DashboardPage.dart';
import 'package:smart_class/page/ProfilePage.dart';
import 'package:smart_class/page/SettingPage.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentTab = 0;
  final List<Widget> screens = [
    const DashboardPage(),
    const SettingPage(),
    const ProfilePage(),
    const AudioPage()
  ];

  openLoading(BuildContext context, [bool mounted = true]) async {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // The loading indicator
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Loading...')
                  ],
                ),
              ),
            );
          });
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      Navigator.of(context).pop();
  }
  

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashboardPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 24.0,
        ),
        onPressed: () async {
          await openLoading(context);
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDevicePage()),
            );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const DashboardPage();
                            currentTab = 0;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            currentTab == 0
                                ? ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (Rect bounds) {
                                      return LinearDown().createShader(bounds);
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.home,
                                          size: 24.0,
                                          color: base,
                                        ),
                                        Text(
                                          'Home',
                                          style: GoogleFonts.inter(color: base,fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        size: 24.0,
                                        color: base,
                                      ),
                                      Text(
                                        'Home',
                                        style: GoogleFonts.inter(color: base,fontSize: 12),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const SettingPage();
                            currentTab = 1;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            currentTab == 1
                                ? ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (Rect bounds) {
                                      return LinearDown().createShader(bounds);
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.accessibility,
                                          size: 24.0,
                                          color: base,
                                        ),
                                        Text(
                                          'Accessibility',
                                          style: GoogleFonts.inter(
                                              color: base,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Icon(
                                        Icons.accessibility,
                                        size: 24.0,
                                        color: base,
                                      ),
                                      Text(
                                        'Accessibility',
                                        style: GoogleFonts.inter(
                                            color: base,
                                            fontSize: 12),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const CameraPage();
                        currentTab = 2;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        currentTab == 2
                            ? ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearDown().createShader(bounds);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.camera_alt_sharp,
                                      size: 24.0,
                                      color: base,
                                    ),
                                    Text(
                                      'Camera',
                                      style: GoogleFonts.inter(
                                          color: base,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Icon(
                                    Icons.camera_alt_sharp,
                                    size: 24.0,
                                    color: base,
                                  ),
                                  Text(
                                    'Camera',
                                    style: GoogleFonts.inter(
                                        color: base,
                                        fontSize: 12),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfilePage();
                        currentTab = 3;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        currentTab == 3
                            ? ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearDown().createShader(bounds);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 24.0,
                                      color: base,
                                    ),
                                    Text(
                                      'Profile',
                                      style: GoogleFonts.inter(
                                          color: base,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 24.0,
                                    color: base,
                                  ),
                                  Text(
                                    'Profile',
                                    style: GoogleFonts.inter(
                                        color: base,
                                        fontSize: 12),
                                  ),
                                ],
                              )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
