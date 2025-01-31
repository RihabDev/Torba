import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time
import 'package:intl/intl.dart'; // For formatting time

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text(
          'Community Feed',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}

class Post {
  final String username;
  final String content;
  final String avatar;
  final int likes;
  final String postTime;
  final String? image; // Optional image for posts
  final List<String> reactions;

  Post({
    required this.username,
    required this.content,
    required this.avatar,
    required this.likes,
    required this.postTime,
    this.image, // Image can be null
    required this.reactions,
  });
}

final List<Post> posts = [
  Post(
    username: 'Mohamed Ali',
    content: 'Application behya barcha 3awnetni fi el zara3',
    avatar: 'assets/images/user1.jpg',
    likes: 12,
    postTime: '2 hours ago',
    reactions: ['Like'],
    image: 'assets/images/post1.jpg',
  ),
  Post(
    username: 'Nadhem Ahmed',
    content: 'chkoun jareb l analyse mtaa torba ?',
    avatar: 'assets/images/user2.jpg',
    likes: 8,
    postTime: '5 hours ago',
    reactions: ['Like'],
    image: null, // Text-only post
  ),
  Post(
    username: 'Nejia Ben Salem',
    content: 'haja jdida f tounes vraimenet bravo',
    avatar: 'assets/images/user3.jpg',
    likes: 15,
    postTime: '1 day ago',
    reactions: ['Like'],
    image: 'assets/images/post2.png', // Post with an image
  ),
];

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final timeAgo = DateFormat('yMMMd').format(DateTime.now());

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post.avatar),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  post.username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  post.postTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            // Display image if available
            if (post.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  post.image!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up, color: Colors.green),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 4),
                    Text('${post.likes} Likes'),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
            const Divider(),
            // Show reactions
            Row(
              children: [
                for (var reaction in post.reactions)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text(reaction),
                      backgroundColor: Colors.green.shade200,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
