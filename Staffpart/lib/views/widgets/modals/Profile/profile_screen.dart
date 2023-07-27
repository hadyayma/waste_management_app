import 'dart:io';
import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/modals/Profile/staff_profile_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _bioController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: AppColor.primary,
        ),
        body: Center(
          child: Text('Please log in to view the profile.'),
        ),
      );
    }

    _setStaffActiveStatus(true);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('staff')
          .where('uid', isEqualTo: currentUser.uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColor.primaryExtraSoft,
              color: AppColor.primary,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.data?.docs.isEmpty ?? true) {
          return Center(
            child: Text('Staff member not found'),
          );
        }

        final staffDocs = snapshot.data!.docs;

        final staffData = staffDocs[0].data();
        final staff = Staff(
          docId: staffDocs[0].id,
          photoURL: staffData['photoURL'] ?? '',
          department: staffData['department'] ?? '',
          firstname: staffData['firstname'] ?? '',
          lastname: staffData['lastname'] ?? '',
          email: staffData['email'] ?? '',
          address: staffData['address'] ?? '',
          uid: staffData['uid'] ?? '',
          phone: staffData['phone']?.toString() ?? '' ,
          bio: staffData['bio'] ?? '',
          isActive: staffData['isActive'] ?? true,
        );

        _bioController.text = staff.bio ?? '';
        bool _isActive = staff.isActive ?? true; // Add this line

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            backgroundColor: AppColor.primary,
            actions: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                },
              ),
            ],
          ),
          endDrawer: Align(
            alignment: Alignment.centerRight,
            child: Drawer(
              backgroundColor: AppColor.whiteSoft,
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('${staff.firstname} ${staff.lastname}'),
                    accountEmail: Text(staff.email!),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(staff.photoURL!),
                      backgroundColor: AppColor.primaryExtraSoft,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primarySoft,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.image,),
                    title: Text('Change Image'),
                    onTap: () {
                      _updateProfileImage(staff);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: _signOut,
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColor.primaryExtraSoft,
                  height: 250,
                  child: Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(staff.photoURL!),
                      backgroundColor: AppColor.primaryExtraSoft,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       CircleAvatar(
                      //         radius: 50,
                      //         backgroundImage: NetworkImage(staff.photoURL!),
                      //         backgroundColor: AppColor.whiteSoft,
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 16),
                      // Active Status
                      ListTile(
                        leading: Icon(
                          _isActive ? Icons.check_circle : Icons.cancel,
                          color: _isActive ? Colors.green : Colors.grey,
                        ),
                        title: Text(
                          _isActive ? 'Active' : 'Not Active',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // FullName
                      Text(
                        '${staff.firstname} ${staff.lastname}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${staff.department}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      // Bio
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Bio:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20,),
                            IconButton(
                              onPressed: _isEditing
                                  ? () => _saveBio(staff.docId!)
                                  : () => setState(() => _isEditing = true),
                              icon: Icon(
                                _isEditing ? Icons.save : Icons.edit,
                                color: _isEditing ? AppColor.primarySoft : AppColor.primarySoft,
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      _isEditing
                          ? TextFormField(
                        controller: _bioController,
                        cursorColor: AppColor.primarySoft,
                        style: TextStyle(
                          color: Colors.black,
                        ), // Set the color of the entered text
                        decoration: InputDecoration(
                          hintText: 'Enter your bio',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.primary, // Set the color of the underline
                              width: 1.0, // Set the thickness of the underline
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.primarySoft, // Set the color of the underline when the TextFormField is focused
                              width: 2.0, // Set the thickness of the underline when the TextFormField is focused
                            ),
                          ),
                        ),
                      )
                          : Text(
                        staff.bio!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      // Email
                      Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        staff.email!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      // Phone
                      Text(
                        'Phone:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        staff.phone!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      // Address
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        staff.address!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveBio(String docId) async {
    String bio = _bioController.text.trim();

    try {
      await FirebaseFirestore.instance
          .collection('staff')
          .doc(docId)
          .update({'bio': bio});
      setState(() {
        _isEditing = false;
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bio updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print('Error saving bio: $error');
    }
  }

  void _signOut() async {
    _setStaffActiveStatus(false);
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  void _setStaffActiveStatus(bool isActive) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('staff')
            .doc(currentUser.uid)
            .update({'isActive': isActive});
      } catch (error) {
        print('Error updating active status: $error');
      }
    }
  }

  Future<void> _updateProfileImage(Staff staff) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // TODO: Upload the image file to your preferred storage solution and get the public URL
      // For example, if you are using Firebase Storage, you can use the FirebaseStorage package:
      // 1. Upload the file
      final storageRef = FirebaseStorage.instance.ref().child('profile_images').child(staff.uid!);
      final uploadTask = storageRef.putFile(imageFile);

      // 2. Await the completion of the upload task
      final snapshot = await uploadTask;

      // 3. Get the download URL
      if (snapshot.state == TaskState.success) {
        final downloadURL = await snapshot.ref.getDownloadURL();

        // Update the profile image URL in Firestore
        await FirebaseFirestore.instance
            .collection('staff')
            .doc(staff.docId)
            .update({'photoURL': downloadURL});

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile image updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('Error uploading profile image');
      }
    }
  }
}
