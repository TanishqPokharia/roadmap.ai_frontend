import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/editable_roadmap_section.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key, required this.roadmap});
  final Roadmap roadmap;

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  File? _bannerImage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final screenWidth = context.screenWidth;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              title: Text('Create Post'),
              backgroundColor: colorScheme.surface,
              surfaceTintColor: colorScheme.surface,
              floating: true,
              actions: [
                FilledButton.icon(
                  onPressed: () {
                    // No functionality, just showing a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Publishing functionality removed'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  icon: Icon(Icons.publish),
                  label: Text('Publish'),
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
              ],
            ),

            // Content
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Banner Image Selection
                  GestureDetector(
                    onTap: () {
                      // No functionality, just showing a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Image selection functionality removed',
                          ),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    },
                    child: Center(
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(12),
                          dashPattern: [6, 6],
                          color: Colors.grey,
                          strokeWidth: 3,
                        ),
                        child: Container(
                          height: screenHeight * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: colorScheme.surface,
                          ),
                          width: screenWidth / 2,
                          child: _bannerImage != null
                              ? Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: _bannerImage != null
                                          ? Image.file(
                                              _bannerImage!,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_photo_alternate,
                                                  size: 48,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Select Banner Image',
                                                  style: textTheme.bodyLarge!
                                                      .copyWith(
                                                        color: Colors
                                                            .grey
                                                            .shade700,
                                                      ),
                                                ),
                                              ],
                                            ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16,
                                        child: IconButton(
                                          icon: Icon(Icons.edit, size: 16),
                                          onPressed: () {
                                            // No functionality, just showing a snackbar
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Image editing functionality removed',
                                                ),
                                                backgroundColor: Colors.orange,
                                              ),
                                            );
                                          },
                                          padding: EdgeInsets.zero,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Select Banner Image',
                                      style: textTheme.bodyLarge!.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Post Title
                  Center(
                    child: SizedBox(
                      width: screenWidth / 2,
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Post Title',
                          hintText: 'Enter a catchy title for your roadmap',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          // No functionality, title changes aren't persisted
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Post Description
                  Center(
                    child: SizedBox(
                      width: screenWidth / 2,
                      child: TextFormField(
                        controller: _descriptionController,
                        minLines: 4,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Describe what this roadmap is about',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Roadmap Editor Section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Roadmap Content',
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Customize the roadmap before sharing',
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ]),
              ),
            ),

            // Roadmap Section - Using SliverToBoxAdapter with a simple display version
            // SliverPadding(
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth / 4),
            //   sliver: SliverToBoxAdapter(
            //     child: EditableRoadmapSection(roadmap: widget.roadmap),
            //   ),
            // ),

            // Bottom padding
            SliverPadding(
              padding: EdgeInsets.only(bottom: 32),
              sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
          ],
        ),
      ),
    );
  }
}
