import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/Drawer/drawerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.put(CustomDrawerController());

    return Drawer(
      child: SafeArea( // Use SafeArea to remove the status bar from view
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero, // Remove padding from the ListView
            children: [
              SizedBox(height: 10,),
              // Custom user account header
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage("https://media.istockphoto.com/id/1409155424/photo/head-shot-portrait-of-millennial-handsome-30s-man.webp?a=1&b=1&s=612x612&w=0&k=20&c=Q5Zz9w0FulC0CtH-VCL8UX2SjT7tanu5sHNqCA96iVw="),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Obx(() => Text(
                            customDrawerController.userName.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Roboto', // Apply Roboto font
                            ),
                          )),
                          Obx(() => Text(
                            customDrawerController.email.value,
                            // style: MyTextTheme.smallGCN,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColor.greyLight,
                thickness: 1.4,
                endIndent: 10,
                indent: 10,
              ),
              // ListTiles
              _buildListTile(
                  context, "Dashboard", "asset/dashboard.png", () {
                    // Get.toNamed(AppRoutes.dashboardRoute);
              }
              ),
              _buildListTile(
                  context, "Support Center", "asset/supportCentre.png", () {}
              ),
              _buildListTile(
                  context, "Widgets", "asset/widgets.png", () {}
              ),
              Obx(() => _buildListTile(
                context,
                "Notifications",
                "asset/notification.png",
                    () {},
                customDrawerController.notificationCount.value,
              )),
              Divider(
                color: AppColor.greyLight,
                thickness: 1.4,
                endIndent: 10,
                indent: 10,
              ),
              Obx(() => _buildListTile(
                context,
                "Leaderboard",
                "asset/leaderboard.png",
                    () {
                  // Get.toNamed(AppRoutes.leaderboardRoute);
                },
                customDrawerController.leaderboardCount.value,
              )),

              _buildListTile(
                  context, "Reminders", "asset/reminders.png", () {}
              ),
              Obx(() => _buildListTile(
                context,
                "Missed Prayers",
                "asset/missedPrayer.png",
                    () {},
                customDrawerController.missedPrayersCount.value,
              )),
              _buildListTile(
                  context, "Peer Circle", "asset/peerCircle.png", () {}
              ),
              Divider(
                color: AppColor.greyLight,
                thickness: 1.4,
                endIndent: 10,
                indent: 10,
              ),
              _buildListTile(
                  context, "Language", "asset/translate.png", () {}
              ),
              Obx(() => ListTile(
                leading: Image.asset("asset/darkMode.png"),
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                  ),
                ),
                dense: true, // Reduce spacing
                contentPadding: EdgeInsets.symmetric(horizontal: 12), // Reduce padding
                trailing: Switch(
                  value: customDrawerController.isDarkMode.value,
                  onChanged: (value) {
                    customDrawerController.toggleDarkMode(value);
                    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              )),
              _buildListTile(
                  context, "Settings", "asset/gear.png", () {}
              ),
              _buildListTile(
                  context, "F&Q", "asset/fAndQ.png", () {}
              ),
              _buildListTile(
                  context, "Feedback", "asset/feedback.png", () {}
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create the ListTiles with reduced padding, small and bold text
  Widget _buildListTile(BuildContext context, String title, String icon, VoidCallback onTap, [int? count]) {
    return ListTile(
      leading: Image.asset(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12, // Smaller text
          fontFamily: 'Roboto', // Roboto font
        ),
      ),
      dense: true, // Reduce spacing
      contentPadding: EdgeInsets.symmetric(horizontal: 12), // Reduce padding
      trailing: count != null && count > 0
          ? CircleAvatar(
        radius: 10,
        backgroundColor: Colors.orange,
        child: Text(
          count.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      )
          : null,
      onTap: onTap,
    );
  }
}
