import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/create_post/create_post_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/editable_roadmap_tree.dart';
import 'package:toastification/toastification.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key, required this.roadmapMetaData});
  final RoadmapMetadata roadmapMetaData;

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
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
    final createPostNotifier = createPostNotifierProvider(
      widget.roadmapMetaData.id,
    );
    final createPostState = ref.watch(createPostNotifier);
    final notifier = ref.read(createPostNotifier.notifier);

    ref.listen(createPostNotifier, (_, next) {
      if (next is AsyncError) {
        toastification.show(
          type: ToastificationType.error,
          title: Text('Error'),
          description: Text("${next.error}"),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }

      if (next is AsyncData && next.value?.isUploaded == true) {
        context.pop();
        toastification.show(
          type: ToastificationType.success,
          title: Text('Success'),
          description: Text("Post created successfully!"),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    });

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
                  FilledButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          notifier.isBannerSelected()) {
                        notifier.createPost(
                          _titleController.text,
                          _descriptionController.text,
                        );
                        return;
                      }
                      toastification.show(
                        type: ToastificationType.error,
                        title: Text('Validation Error'),
                        description: Text("Please fill all required fields."),
                        autoCloseDuration: const Duration(seconds: 2),
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
                      onTap: () async {
                        final image = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                        );

                        if (image == null) {
                          toastification.show(
                            title: Text('Error'),
                            description: Text('No image selected'),
                            backgroundColor: Colors.orange,
                            autoCloseDuration: Duration(seconds: 2),
                          );
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
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:
                                            createPostState
                                                    .value
                                                    ?.bannerImage !=
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
                                                  backgroundColor:
                                                      Colors.orange,
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
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
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
}
