// lib/screens/home.dart
import 'dart:ffi';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<Map<String, dynamic>> astrologers = [
  {
    'name': 'Dr. Sharma',
    'specialty': 'Vedic Astrology',
    'rating': 4.8,
    'price': 25.0,
    'image': 'assets/images/astrologer1.png',
  },
  {
    'name': 'Maya Gupta',
    'specialty': 'Numerology',
    'rating': 4.6,
    'price': 20.0,
    'image': 'assets/images/astrologer2.png',
  },
  {
    'name': 'John Doe',
    'specialty': 'Tarot Reading',
    'rating': 4.9,
    'price': 30.0,
    'image': 'assets/images/astrologer3.png',
  },
  {
    'name': 'Dr. Sharma',
    'specialty': 'Vedic Astrology',
    'rating': 4.8,
    'price': 25.0,
    'image': 'assets/images/astrologer1.png',
  },
  {
    'name': 'Maya Gupta',
    'specialty': 'Numerology',
    'rating': 4.6,
    'price': 20.0,
    'image': 'assets/images/astrologer2.png',
  },
  {
    'name': 'John Doe',
    'specialty': 'Tarot Reading',
    'rating': 4.9,
    'price': 30.0,
    'image': 'assets/images/astrologer3.png',
  },
  {
    'name': 'Dr. Sharma',
    'specialty': 'Vedic Astrology',
    'rating': 4.8,
    'price': 25.0,
    'image': 'assets/images/astrologer1.png',
  },
  {
    'name': 'Maya Gupta',
    'specialty': 'Numerology',
    'rating': 4.6,
    'price': 20.0,
    'image': 'assets/images/astrologer2.png',
  },
  {
    'name': 'John Doe',
    'specialty': 'Tarot Reading',
    'rating': 4.9,
    'price': 30.0,
    'image': 'assets/images/astrologer3.png',
  },
  {
    'name': 'Dr. Sharma',
    'specialty': 'Vedic Astrology',
    'rating': 4.8,
    'price': 25.0,
    'image': 'assets/images/astrologer1.png',
  },
  {
    'name': 'Maya Gupta',
    'specialty': 'Numerology',
    'rating': 4.6,
    'price': 20.0,
    'image': 'assets/images/astrologer2.png',
  },
  {
    'name': 'John Doe',
    'specialty': 'Tarot Reading',
    'rating': 4.9,
    'price': 30.0,
    'image': 'assets/images/astrologer3.png',
  },
  {
    'name': 'Dr. Sharma',
    'specialty': 'Vedic Astrology',
    'rating': 4.8,
    'price': 25.0,
    'image': 'assets/images/astrologer1.png',
  },
  {
    'name': 'Maya Gupta',
    'specialty': 'Numerology',
    'rating': 4.6,
    'price': 20.0,
    'image': 'assets/images/astrologer2.png',
  },
  {
    'name': 'John Doe',
    'specialty': 'Tarot Reading',
    'rating': 4.9,
    'price': 30.0,
    'image': 'assets/images/astrologer3.png',
  },
  // Add more astrologers as needed
];

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          	backgroundColor: Colors.white,
          	body: SafeArea(
              	child: SingleChildScrollView(
                  	scrollDirection: Axis.vertical,
                  	child: Padding(
                      	padding: const EdgeInsets.all(16.0),
                      	child:  Column(
                          	crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisSize: MainAxisSize.min,
                          	children: [                              	
                              	Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(Icons.person), 
                                    SizedBox(width: 10.0,),                                   
                                    Text("Hi Akash", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),), 
                                    Spacer(),                                   
                                    IconButton(
                                        icon: Icon(Icons.notifications_outlined), 
                                        onPressed: () => (
                                      
                                        )
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16.0), 
                                const Text(
                                  'Find a best\nastrologer for you!',
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
                                const SizedBox(height: 16.0), 
                                Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A1052),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Why Astrologist',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Padding(
                                              padding: EdgeInsets.only(right: 30.0), 
                                              child: Text(
                                                'Lorem ipsum dolor sit amet, con sectetur adipiscing',
                                                style: TextStyle(
                                                  color: Colors.white.withValues(alpha: 0.7),
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                              ),
                                              child: const Text(
                                                'Read more',
                                                style: TextStyle(
                                                  color: Color(0xFF2A1052),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/icon/appicon.png',
                                        width: 80.0,
                                        height: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                const Text(
                                    'Top Astrologers',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2A1052),
                                    ),
                                ),
                                const SizedBox(height: 16.0),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: astrologers.length,
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) => const SizedBox(height: 15.0),
                                    itemBuilder: (context, index){
                                        final astrologger = astrologers[index];
                                        return _AstrologistCard(
                                            imageIndex: index + 1,
                                            name: astrologger['name'], 
                                            specialty: astrologger['specialty'], 
                                            rating: astrologger['rating'], 
                                            price: astrologger['price'], 
                                            image: astrologger['image']
                                        );
                                    },
                                )
                          	] 
                      	) 
                  	),
              	),
           	),
      	);
  	}
}

class _AstrologistCard extends StatelessWidget {
  final int imageIndex;
  final String name;
  final String specialty;
  final double rating;
  final double price;
  final String image;

  const _AstrologistCard({
    required this.imageIndex,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
            Row(                
                children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=$imageIndex'),
                        radius: 25,
                    ),
                    SizedBox(width: 10.0,),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                name, 
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepPurple
                                ),                               
                            ),
                            Text(
                                specialty
                            )
                        ],
                    )
                ],
            ),  
            Spacer(),              
            Row(
                children: [
                    _SmallButton(
                        icon: Icons.phone,
                        color: const Color(0xFF2A1052),
                        onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    _SmallButton(
                        icon: Icons.chat_bubble_outline,
                        color: Colors.grey[300]!,
                        onPressed: () {},
                    ),
                ],
            ),
        ],
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _SmallButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color == const Color(0xFF2A1052) ? Colors.white : Colors.black,
        size: 16,
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xFF2A1052) : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF2A1052) : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}