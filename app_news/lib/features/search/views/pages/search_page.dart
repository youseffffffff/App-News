import 'package:app_news/core/utils/app_colors.dart';
import 'package:app_news/core/views/widgets/app_bar_widget.dart';
import 'package:app_news/core/views/widgets/news_Items_widget.dart';
import 'package:app_news/core/views/widgets/news_item_widget.dart';
import 'package:app_news/features/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchCubit>(context);
    TextEditingController _searchController = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: AppBarWidget(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
          hasPaddingBetween: true,
        ),
        title: Text(
          'Search',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            BlocBuilder<SearchCubit, SearchState>(
              bloc: cubit,
              builder: (context, state) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: state is SearchLoading
                          ? colorScheme.primary.withOpacity(0.4)
                          : colorScheme.outlineVariant.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search articles...',
                      hintStyle: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: colorScheme.onSurfaceVariant,
                        size: 22,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: state is SearchLoading
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: () async {
                                  if (_searchController.text.isNotEmpty) {
                                    await cubit.searchArticles(
                                      _searchController.text,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please enter a search query',
                                          style: TextStyle(
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  minimumSize: const Size(36, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: Text(
                                  'search',
                                  style: textTheme.labelLarge?.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: NewsItems(cubit: cubit),
            ),
          ],
        ),
      ),
    );
  }
}
