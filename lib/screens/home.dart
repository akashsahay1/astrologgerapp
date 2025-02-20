// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fapp/models/astrologer.dart';

class Home extends StatefulWidget {
    const Home({super.key});

    @override
    HomeState createState() => HomeState();
}

class HomeState extends State<Home>{
    
    final List<Astrologer> _astrologers = [];
    int _currentPage = 1;
    bool _isLoading = false;
    bool _hasMoreData = true;
    final ScrollController _scrollController = ScrollController();

    @override
    void initState() {
        super.initState();
        _fetchAstrologers();
        _scrollController.addListener(_scrollListener);
    }

    @override
    void dispose() {
        _scrollController.dispose();
        super.dispose();
    }

    void _scrollListener() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
            if (!_isLoading && _hasMoreData) {
                _fetchAstrologers();
            }
        }
    }

    Future<void> _fetchAstrologers() async {
        if (_isLoading) return;

        setState(() {
            _isLoading = true;
        });

        try {
            final response = await http.get(
                Uri.parse('https://trueastrologgers.avenuxtechspire.com/getastrologgers?page=$_currentPage')
            );

            if (response.statusCode == 200) {
                final jsonData = json.decode(response.body);
                final astrologersData = jsonData['astrologgers'];
                
                final List<Astrologer> newAstrologers = (astrologersData['data'] as List)
                    .map((item) => Astrologer.fromJson(item))
                    .toList();

                setState(() {
                    _astrologers.addAll(newAstrologers);
                    _currentPage++;
                    _hasMoreData = _currentPage <= astrologersData['last_page'];
                    _isLoading = false;
                });
            } else {
                setState(() {
                    _isLoading = false;
                });
                // Handle error
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to load astrologers'))
                );
            }
        } catch (e) {
            setState(() {
                _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.toString()}'))
            );
        }
    }  

    @override
    Widget build(BuildContext context) {
        // return Scaffold(
        //     backgroundColor: Colors.white,
        //     body: SafeArea(
        //         child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //                 Padding(
        //                     padding: EdgeInsets.all(16.0),
        //                     child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [                                
        //                             Row(
        //                                 mainAxisSize: MainAxisSize.max,
        //                                 children: [
        //                                     GestureDetector(
        //                                         onTap: () {
                                                  
        //                                         },
        //                                         child: Icon(Icons.person)
        //                                     ),
        //                                     SizedBox(width: 10.0),
        //                                     Text(
        //                                         "Hi Akash",
        //                                         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        //                                     ),
        //                                     Spacer(),
        //                                     IconButton(
        //                                         icon: Icon(Icons.notifications_outlined),
        //                                         onPressed: () {},
        //                                     ),
        //                                 ],
        //                             ),
        //                             const SizedBox(height: 16.0),
        //                             const Text(
        //                                 'Find a best astrologer!',
        //                                 style: TextStyle(
        //                                     fontSize: 28.0,
        //                                     fontWeight: FontWeight.bold,
        //                                     color: Color(0xFF2A1052),
        //                                     height: 1.2,
        //                                 ),
        //                             ),
        //                             const SizedBox(height: 16.0),
        //                             Container(
        //                                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                                 decoration: BoxDecoration(
        //                                     color: Colors.grey[100],
        //                                     borderRadius: BorderRadius.circular(12.0),
        //                                 ),
        //                                 child: Row(
        //                                     children: [
        //                                         Icon(Icons.search, color: Colors.grey[600]),
        //                                         const SizedBox(width: 8.0),
        //                                         Expanded(
        //                                             child: TextField(
        //                                                 decoration: InputDecoration(
        //                                                     hintText: 'Search for astrologist',
        //                                                     hintStyle: TextStyle(color: Colors.grey[400]),
        //                                                     border: InputBorder.none,
        //                                                 ),
        //                                             ),
        //                                         ),
        //                                         Container(
        //                                             padding: const EdgeInsets.all(8.0),
        //                                             decoration: BoxDecoration(
        //                                                 color: const Color(0xFF2A1052),
        //                                                 borderRadius: BorderRadius.circular(8.0),
        //                                             ),
        //                                             child: const Icon(Icons.search, color: Colors.white, size: 20.0),
        //                                         ),
        //                                     ],
        //                                 ),
        //                             ),
        //                         ],
        //                     ),                            
        //                 ),
        //                 Expanded(
        //                     child: ConstrainedBox(
        //                         constraints: BoxConstraints(
        //                             minHeight: MediaQuery.of(context).size.height * 0.4,
        //                         ),
        //                         child: _astrologers.isEmpty && _isLoading
        //                         ? Center(child: CircularProgressIndicator())
        //                         : ListView.separated(
        //                             controller: _scrollController,
        //                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                             itemCount: _astrologers.length + (_hasMoreData ? 1 : 0),
        //                             separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        //                             itemBuilder: (context, index) {
        //                                 if (index == _astrologers.length) {
        //                                     return Center(
        //                                         child: Padding(
        //                                             padding: const EdgeInsets.all(16.0),
        //                                             child: CircularProgressIndicator(),
        //                                         ),
        //                                     );
        //                                 }

        //                                 final astrologer = _astrologers[index];
        //                                 //print(astrologer);
        //                                 return Container(
        //                                     padding: const EdgeInsets.all(10),
        //                                     decoration: BoxDecoration(
        //                                         color: const Color.fromARGB(255, 241, 255, 239),
        //                                         borderRadius: BorderRadius.circular(16),
        //                                         boxShadow: [
        //                                             BoxShadow(
        //                                                 color: Colors.grey.withAlpha(1),
        //                                                 blurRadius: 10,
        //                                                 offset: const Offset(0, 5),
        //                                             ),
        //                                         ],
        //                                     ),
        //                                     child: Row(
        //                                         children: [
        //                                             Row(
        //                                                 children: [
        //                                                     Container(
        //                                                         padding: EdgeInsets.all(10.0),
        //                                                         width: 60.0,
        //                                                         height: 60.0,                                                                
        //                                                         decoration: BoxDecoration(
        //                                                             color: Colors.amber,
        //                                                             borderRadius: BorderRadius.circular(5.0),
        //                                                         ),
        //                                                         child: Image.network(
        //                                                             'https://trueastrologgers.avenuxtechspire.com/${astrologer.avatar}', 
        //                                                             width: 50.0,
        //                                                             height: 50.0,
        //                                                             fit: BoxFit.cover,
                                                                    

        //                                                         ),
        //                                                     ),
        //                                                     SizedBox(width: 10.0),
        //                                                     Column(
        //                                                         mainAxisAlignment: MainAxisAlignment.start,
        //                                                         crossAxisAlignment: CrossAxisAlignment.start,
        //                                                         children: [
        //                                                             Text(
        //                                                                 '${astrologer.firstName} ${astrologer.lastName}',
        //                                                                 style: TextStyle(
        //                                                                     fontSize: 18.0,
        //                                                                     fontWeight: FontWeight.w600,
        //                                                                     color: Colors.deepPurple
        //                                                                 ),
        //                                                             ),
        //                                                             Text(astrologer.astroType)
        //                                                         ],
        //                                                     )
        //                                                 ],
        //                                             ),
        //                                             Spacer(),
        //                                             Row(
        //                                                 children: [
        //                                                     Column(
        //                                                         children: [
        //                                                             Row(
        //                                                                 children: [
        //                                                                     Text("₹27 / min", style: TextStyle(color: Colors.black),)
        //                                                                 ],
        //                                                             ), 
        //                                                             const SizedBox(height: 20),
        //                                                             Row(
        //                                                                 children: [
        //                                                                     Container(
        //                                                                         padding: const EdgeInsets.all(8),
        //                                                                         decoration: BoxDecoration(
        //                                                                             color: const Color(0xFF2A1052),
        //                                                                             borderRadius: BorderRadius.circular(8),
        //                                                                         ),
        //                                                                         child: Icon(
        //                                                                             Icons.phone,
        //                                                                             color: Colors.white,
        //                                                                             size: 16,
        //                                                                         ),
        //                                                                     ),
        //                                                                     const SizedBox(width: 8),
        //                                                                     Container(
        //                                                                         padding: const EdgeInsets.all(8),
        //                                                                         decoration: BoxDecoration(
        //                                                                             color: Colors.grey[300],
        //                                                                             borderRadius: BorderRadius.circular(8),
        //                                                                         ),
        //                                                                         child: Icon(
        //                                                                             Icons.chat_bubble_outline,
        //                                                                             color: Colors.black,
        //                                                                             size: 16,
        //                                                                         ),
        //                                                                     ),
        //                                                                 ],
        //                                                             )
        //                                                         ],
        //                                                     )
                                                                                                                       
                                                            
        //                                                 ],
        //                                             ),
        //                                         ],
        //                                     ),
        //                                 );
        //                             },
        //                         ),
        //                     ),
        //                 ),                        
        //             ]
        //         )
        //     )
        // );

        final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

        void openDrawer() {
            scaffoldKey.currentState?.openDrawer();
        }

        return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                title: const Text(
                    'Dashboard',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                    ),
                ),
                automaticallyImplyLeading: false,
                leading: IconButton(
                    icon: const Icon(Icons.menu_rounded),
                    onPressed: openDrawer,
                    tooltip: 'Menu',
                ),
                actions: [
                    IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {},
                        tooltip: 'Notifications',
                    ),
                    const SizedBox(width: 8),
                ],
            ),
            body: SafeArea(
                child: Center(
                    child: Text(
                        "Dashboard",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                        ),
                    ),
                )
            ),
            drawer: Drawer(
                width: 300.0,
                backgroundColor: Colors.white,
                elevation: 1,
                child: Column(
                    children: [
                        // Header section with profile info
                        Container(
                            padding: const EdgeInsets.only(top: 80.0, bottom: 24.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [const Color.fromARGB(255, 1, 163, 12), const Color.fromARGB(255, 0, 160, 19)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                ),
                            ),
                            child: Column(
                                children: [
                                // Profile picture
                                    Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(color: Colors.white, width: 2),
                                            boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black.withAlpha(1),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 3),
                                                ),
                                            ],
                                        ),
                                        child: const Icon(
                                            Icons.person,
                                            size: 45,
                                            color: Color(0xFF2A3990),
                                        ),
                                    ),
                                    const SizedBox(height: 16),
                                    // User info
                                    const Text(
                                        'Welcome, Akash',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                        ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(2),
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                            'Premium Customer',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    
                        // Navigation items
                        Expanded(
                            child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                    const SizedBox(height: 8),
                                    _buildDrawerItem(
                                        icon: Icons.dashboard_outlined,
                                        title: 'Dashboard',
                                        isSelected: true,
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                    _buildDrawerItem(
                                        icon: Icons.account_circle_outlined,
                                        title: 'My Profile',
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                    _buildDrawerItem(
                                        icon: Icons.history_outlined,
                                        title: 'Transaction History',
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                    _buildDrawerItem(
                                        icon: Icons.credit_card_outlined,
                                        title: 'Payment Methods',
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                    _buildDrawerItem(
                                        icon: Icons.settings_outlined,
                                        title: 'Settings',
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                    _buildDrawerItem(
                                        icon: Icons.support_agent_outlined,
                                        title: 'Support',
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                    const Divider(height: 32, thickness: 1),
                                    _buildDrawerItem(
                                        icon: Icons.help_outline,
                                        title: 'Help & FAQ',
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                    _buildDrawerItem(
                                    icon: Icons.logout_outlined,
                                    title: 'Logout',
                                    textColor: const Color(0xFFE53935),
                                    iconColor: const Color(0xFFE53935),
                                    onTap: () {
                                        Navigator.pop(context);
                                        // Add logout logic
                                    },
                                ),
                                ],
                            ),
                        ),
                        
                        // Footer
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(
                                        'App Version 1.2.4',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                        ),
                                    ),
                                    Text(
                                        '© 2025 YourCompany',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

}

Widget _buildDrawerItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  bool isSelected = false,
  Color? textColor,
  Color? iconColor,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? const Color(0xFF2A3990)
            : iconColor ?? const Color(0xFF424242),
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? const Color(0xFF2A3990)
              : textColor ?? const Color(0xFF424242),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          fontSize: 15,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      dense: true,
      visualDensity: const VisualDensity(horizontal: -1, vertical: -1),
      onTap: onTap,
    ),
  );
}