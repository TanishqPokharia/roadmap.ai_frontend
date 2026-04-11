import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/common/toast/success.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/create_post/create_post_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/editable_roadmap_tree.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key, required this.roadmapMetaData});
  final RoadmapMetadata roadmapMetaData;

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  FilePickerResult? _bannerImage;
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
    final createPostNotifier = createPostProvider(widget.roadmapMetaData.id);
    final createPostState = ref.watch(createPostNotifier);
    final notifier = ref.read(createPostNotifier.notifier);

    ref.listen(createPostNotifier, (_, next) {
      if (next is AsyncError) {
        showErrorToast(context: context, error: "${next.error}");
      }

      if (next is AsyncData && next.value?.isUploaded == true) {
        context.pop();
        showSuccessToast(
          context: context,
          success: "Post created successfully!",
        );
      }
    });

    if (!kIsWeb && Platform.isAndroid) {
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
                  createPostState.maybeWhen(
                    loading: () => SizedBox(
                      width: 100,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onPressed: () {},
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: colorScheme.onPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                    orElse: () => SizedBox(
                      width: 100,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onPressed: () {
                          _validateAndCreatePost(context, notifier);
                        },
                        iconAlignment: IconAlignment.end,
                        icon: Icon(Icons.publish),
                        label: Text('Publish'),
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
                      onTap: () async => await _selectBannerImage(notifier),
                      child: Center(
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            radius: Radius.circular(12),
                            dashPattern: [6, 6],
                            color: Colors.grey,
                            strokeWidth: 3,
                          ),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorScheme.surface,
                            ),
                            child: createPostState.value?.bannerImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child:
                                        createPostState.value?.bannerImage !=
                                            null
                                        ? kIsWeb
                                              ? Image.network(
                                                  createPostState
                                                      .value!
                                                      .bannerImage!
                                                      .files
                                                      .first
                                                      .path!,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                )
                                              : Image.memory(
                                                  createPostState
                                                      .value!
                                                      .bannerImage!
                                                      .files
                                                      .first
                                                      .bytes!,
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
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                              ),
                                            ],
                                          ),
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
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Post Title',
                        labelStyle: textTheme.bodyLarge,
                        hintText: 'Enter a catchy title for your roadmap',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Post Description
                    TextFormField(
                      controller: _descriptionController,
                      minLines: 4,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textTheme.bodyLarge,
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
                    SizedBox(height: 24),

                    // Roadmap Editor Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 16),
                  ]),
                ),
              ),

              // Roadmap Section - Using SliverToBoxAdapter with a simple display version
              SliverToBoxAdapter(
                child: createPostState.maybeWhen(
                  data: (data) {
                    if (data.roadmap != null) {
                      return EditableRoadmapTree(
                        roadmap: data.roadmap!,
                        isProgressEditable: false,
                        isCustomizable: true,
                        shrinkWrap: true,
                      );
                    }
                    return SizedBox(
                      height: screenHeight * 0.3,
                      child: Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                          color: colorScheme.primary,
                          size: 30,
                        ),
                      ),
                    );
                  },
                  orElse: () => Center(
                    child: Text(
                      'Error loading roadmap data',
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  ),
                  loading: () => SizedBox(
                    height: screenHeight * 0.3,
                    child: Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                        color: colorScheme.primary,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),

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

    return Scaffold(
      body: switch (createPostState) {
        AsyncLoading() => Center(child: CircularProgressIndicator()),
        _ => Form(
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
                  SizedBox(
                    height: screenHeight * 0.03,
                    child: FilledButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          notifier.createPost(
                            _titleController.text,
                            _descriptionController.text,
                          );
                          return;
                        }
                        showErrorToast(
                          context: context,
                          error: "Please fill all required fields.",
                        );
                      },

                      icon: Icon(Icons.publish),
                      label: Text('Publish', style: textTheme.bodyLarge),
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
                      onTap: () async {
                        final image = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                        );

                        if (image == null) {
                          if (context.mounted) {
                            showErrorToast(
                              context: context,
                              error: "No image selected",
                            );
                          }
                          return;
                        }
                        notifier.setBannerImage(image);
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
                            child: createPostState.value?.bannerImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child:
                                        createPostState.value?.bannerImage !=
                                            null
                                        ? kIsWeb
                                              ? Image.network(
                                                  createPostState
                                                      .value!
                                                      .bannerImage!
                                                      .files
                                                      .first
                                                      .path!,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                )
                                              : Image.memory(
                                                  createPostState
                                                      .value!
                                                      .bannerImage!
                                                      .files
                                                      .first
                                                      .bytes!,
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
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                              ),
                                            ],
                                          ),
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
                            labelStyle: textTheme.bodyLarge,
                            hintText: 'Enter a catchy title for your roadmap',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
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
                            labelStyle: textTheme.bodyLarge,
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
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 4),
                sliver: SliverToBoxAdapter(
                  child: createPostState.maybeWhen(
                    data: (data) {
                      if (data.roadmap != null) {
                        return EditableRoadmapTree(
                          roadmap: data.roadmap!,
                          isProgressEditable: false,
                          isCustomizable: true,
                          shrinkWrap: true,
                        );
                      }
                      return SizedBox(
                        height: screenHeight * 0.3,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.primary,
                          ),
                        ),
                      );
                    },
                    orElse: () => Center(
                      child: Text(
                        'Error loading roadmap data',
                        style: textTheme.bodyMedium!.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ),
                    loading: () => SizedBox(
                      height: screenHeight * 0.3,
                      child: Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                          color: colorScheme.primary,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom padding
              SliverPadding(
                padding: EdgeInsets.only(bottom: 32),
                sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
              ),
            ],
          ),
        ),
      },
    );
  }

  Future<void> _selectBannerImage(CreatePostNotifier notifier) async {
    final image = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (image == null) {
      if (mounted) {
        showErrorToast(context: context, error: "No image selected");
      }
      return;
    }
    _bannerImage = image;
    notifier.setBannerImage(image);
  }

  void _validateAndCreatePost(
    BuildContext context,
    CreatePostNotifier notifier,
  ) {
    if (_bannerImage == null) {
      showErrorToast(context: context, error: "Please select banner image");
      return;
    }
    if (_formKey.currentState!.validate()) {
      notifier.createPost(_titleController.text, _descriptionController.text);
    } else {
      showErrorToast(
        context: context,
        error: "Please fill all required fields.",
      );
    }
  }
}
