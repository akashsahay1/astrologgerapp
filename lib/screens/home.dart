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
        return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [                                
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                            Icon(Icons.person),
                                            SizedBox(width: 10.0),
                                            Text(
                                                "Hi Akash",
                                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            IconButton(
                                                icon: Icon(Icons.notifications_outlined),
                                                onPressed: () {},
                                            ),
                                        ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    const Text(
                                        'Find a best astrologer!',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2A1052),
                                            height: 1.2,
                                        ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Row(
                                            children: [
                                                Icon(Icons.search, color: Colors.grey[600]),
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                    child: TextField(
                                                        decoration: InputDecoration(
                                                            hintText: 'Search for astrologist',
                                                            hintStyle: TextStyle(color: Colors.grey[400]),
                                                            border: InputBorder.none,
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    padding: const EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xFF2A1052),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: const Icon(Icons.search, color: Colors.white, size: 20.0),
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                            ),                            
                        ),
                        Expanded(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: MediaQuery.of(context).size.height * 0.4,
                                ),
                                child: _astrologers.isEmpty && _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : ListView.separated(
                                    controller: _scrollController,
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    itemCount: _astrologers.length + (_hasMoreData ? 1 : 0),
                                    separatorBuilder: (context, index) => const SizedBox(height: 15.0),
                                    itemBuilder: (context, index) {
                                        if (index == _astrologers.length) {
                                            return Center(
                                                child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: CircularProgressIndicator(),
                                                ),
                                            );
                                        }

                                        final astrologer = _astrologers[index];
                                        //print(astrologer);
                                        return Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 241, 255, 239),
                                                borderRadius: BorderRadius.circular(16),
                                                boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.withAlpha(1),
                                                        blurRadius: 10,
                                                        offset: const Offset(0, 5),
                                                    ),
                                                ],
                                            ),
                                            child: Row(
                                                children: [
                                                    Row(
                                                        children: [
                                                            Container(
                                                                padding: EdgeInsets.all(10.0),
                                                                width: 60.0,
                                                                height: 60.0,                                                                
                                                                decoration: BoxDecoration(
                                                                    color: Colors.amber,
                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                ),
                                                                child: Image.network(
                                                                    'https://trueastrologgers.avenuxtechspire.com/${astrologer.avatar}', 
                                                                    width: 50.0,
                                                                    height: 50.0,
                                                                    fit: BoxFit.cover,
                                                                    

                                                                ),
                                                            ),
                                                            SizedBox(width: 10.0),
                                                            Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                    Text(
                                                                        '${astrologer.firstName} ${astrologer.lastName}',
                                                                        style: TextStyle(
                                                                            fontSize: 18.0,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Colors.deepPurple
                                                                        ),
                                                                    ),
                                                                    Text(astrologer.astroType)
                                                                ],
                                                            )
                                                        ],
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                        children: [
                                                            Column(
                                                                children: [
                                                                    Row(
                                                                        children: [
                                                                            Text("₹27 / min", style: TextStyle(color: Colors.black),)
                                                                        ],
                                                                    ), 
                                                                    const SizedBox(height: 20),
                                                                    Row(
                                                                        children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color(0xFF2A1052),
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                child: Icon(
                                                                                    Icons.phone,
                                                                                    color: Colors.white,
                                                                                    size: 16,
                                                                                ),
                                                                            ),
                                                                            const SizedBox(width: 8),
                                                                            Container(
                                                                                padding: const EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.grey[300],
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                child: Icon(
                                                                                    Icons.chat_bubble_outline,
                                                                                    color: Colors.black,
                                                                                    size: 16,
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    )
                                                                ],
                                                            )
                                                                                                                       
                                                            
                                                        ],
                                                    ),
                                                ],
                                            ),
                                        );
                                    },
                                ),
                            ),
                        ),                        
                    ]
                )
            )
        );
    }

}