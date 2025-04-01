import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:news_app/src/features/authentication/presentation/pages/login_screen.dart';
import 'package:news_app/src/features/authentication/presentation/pages/signup_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _handleSignOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Out"),
        content: Text("Are you sure you want to sign out"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      context.read<AuthBloc>().add(UserLoggedOut());
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => SignupScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return CircularProgressIndicator();
          } else if (state is Authenticated) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Profile Page",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image(
                            image: NetworkImage(state.user.photoUrl ?? ""),
                            height: 70,
                            width: 70,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.displayName ?? "No name",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              state.user.email ?? "No email",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTiles(
                      iconData: Icons.person,
                      title: "My Profile",
                      onPress: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTiles(
                      iconData: Icons.settings,
                      title: "Settings",
                      onPress: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTiles(
                      iconData: Icons.notifications,
                      title: "Notification",
                      onPress: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTiles(
                      iconData: Icons.language,
                      title: "Language",
                      onPress: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTiles(
                      iconData: Icons.question_answer,
                      title: "FAQ",
                      onPress: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTiles(
                      iconData: Icons.app_blocking_outlined,
                      title: "About App",
                      onPress: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileTiles(
                        iconData: Icons.logout,
                        title: "Log Out",
                        onPress: _handleSignOut)
                  ],
                ),
              ),
            );
          } else if (state is AuthError) {
            return Text(state.errorMessage);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ProfileTiles extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onPress;

  const ProfileTiles({
    super.key,
    required this.iconData,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onPress(),
      leading: Icon(
        iconData,
        size: 32,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      ),
    );
  }
}
