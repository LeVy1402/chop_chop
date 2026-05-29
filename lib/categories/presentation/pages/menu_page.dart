import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Menu', style: context.h3Md.copyWith(color: Colors.white)),
      centerTitle: true,
      backgroundColor: context.primary,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_basket, color: Colors.white),
        ),
      ],
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.toc_outlined, color: Colors.white),
      ),
    ),
    backgroundColor: context.background,
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.separated(
        itemBuilder: (context, index) => _buildMenuItem(context),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 3,
      ),
    ),
  );

  Widget _buildMenuItem(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: context.primary,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1544025162-d76694265947',
          ),
        ),
        const SizedBox(width: 10),
        Text('Coffee', style: context.h3Md),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ],
    ),
  );
}
