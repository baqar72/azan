import 'package:flutter/material.dart';

// class SearchableDropdown<T> extends StatefulWidget {
//   final List<T> items; // Generic list of items
//   final String hintText; // Hint text for the search field
//   final ValueChanged<T> onItemSelected; // Callback when item is selected
//   final String Function(T) itemToString; // Function to define how to display each item
//   final bool enableSearchIcon; // Whether to show search icon or not
//   final Widget? leadingWidget; // Optional leading widget
//   final double? width; // Custom width
//   final TextEditingController? controller; // Custom controller for input field
//   final BoxDecoration? boxDecoration; // Custom decoration for the container
//   final TextInputType? keyboardType; // Optional keyboard type
//   final TextStyle? hintStyle; // Custom hint text style
//   final ValueChanged<String>? onChanged;
//
//   const SearchableDropdown({super.key,
//     required this.items,
//     required this.onItemSelected,
//     required this.itemToString, // Function to convert T to String for display
//     this.hintText = "Search...",
//     this.enableSearchIcon = true,
//     this.leadingWidget,
//     this.width,
//     this.controller,
//     this.boxDecoration,
//     this.keyboardType,
//     this.hintStyle, this.onChanged,
//   });
//
//   @override
//   _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
// }
//
// class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
//   final TextEditingController _internalController = TextEditingController();
//   late TextEditingController _controller;
//   List<T> _filteredItems = [];
//   bool _showSuggestions = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller ?? _internalController;
//   }
//
//   // Filter the items based on search query
//   void _getSuggestions(String query) {
//     widget.onChanged!(query);
//     setState(() {
//       if (query.isEmpty) {
//         _filteredItems = [];
//         _showSuggestions = false;
//       } else {
//         _filteredItems = widget.items
//             .where((item) => widget
//             .itemToString(item)
//             .toLowerCase()
//             .contains(query.toLowerCase()))
//             .toList();
//         _showSuggestions = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Custom Search Input Field UI
//         Container(
//           width: widget.width ?? double.infinity,
//           height: 50,
//           padding: const EdgeInsets.all(15),
//           decoration: widget.boxDecoration ??
//               BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 gradient: RadialGradient(
//                   colors: [
//                     const Color(0xFFFFFFFF).withOpacity(0.1),
//                     const Color(0xFFFFFFFF).withOpacity(0.0224),
//                     const Color(0xFFFFFFFF).withOpacity(0.0),
//                   ],
//                   radius: 8.0,
//                 ),
//                 border: Border.all(
//                   color: Colors.white70,
//                   width: 1,
//                 ),
//               ),
//           child: Row(
//             children: [
//               if (widget.leadingWidget != null) widget.leadingWidget!,
//               const SizedBox(width: 10),
//               Expanded(
//                 child: TextFormField(
//                   keyboardType: widget.keyboardType,
//                   controller: _controller,
//                   onChanged: _getSuggestions,
//                   decoration: InputDecoration(
//                     hintText: widget.hintText,
//                     hintStyle: widget.hintStyle,
//                     border: InputBorder.none, // Remove default border
//                   ),
//                   style: const TextStyle(color: Colors.white, fontSize: 15),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (_showSuggestions)
//           Container(
//             constraints: const BoxConstraints(maxHeight: 200), // Limit dropdown height
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _filteredItems.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(widget.itemToString(_filteredItems[index])),
//                   onTap: () {
//                     widget.onItemSelected(_filteredItems[index]);
//                     setState(() {
//                       _controller.text =
//                           widget.itemToString(_filteredItems[index]);
//                       _showSuggestions = false;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     if (widget.controller == null) {
//       _internalController.dispose();
//     }
//     super.dispose();
//   }
// }

///new

class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items; // Static list of items if needed
  final String hintText; // Hint text for the search field
  final ValueChanged<T> onItemSelected; // Callback when item is selected
  final String Function(T) itemToString; // Function to define how to display each item
  final bool enableSearchIcon; // Whether to show search icon or not
  final Widget? leadingWidget; // Optional leading widget
  final double? width; // Custom width
  final TextEditingController? controller; // Custom controller for input field
  final BoxDecoration? boxDecoration; // Custom decoration for the container
  final TextInputType? keyboardType; // Optional keyboard type
  final TextStyle? hintStyle; // Custom hint text style
  final Future<List<T>> Function(String)? onChanged; // Asynchronous callback for search

  const SearchableDropdown({
    super.key,
    required this.onItemSelected,
    required this.itemToString, // Function to convert T to String for display
    this.items = const [], // Default empty list
    this.hintText = "Search...",
    this.enableSearchIcon = true,
    this.leadingWidget,
    this.width,
    this.controller,
    this.boxDecoration,
    this.keyboardType,
    this.hintStyle,
    this.onChanged,
  });

  @override
  _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final TextEditingController _internalController = TextEditingController();
  late TextEditingController _controller;
  List<T> _filteredItems = [];
  bool _showSuggestions = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? _internalController;
  }

  // Fetch suggestions asynchronously based on search query
  Future<void> _getSuggestions(String query) async {
    setState(() {
      _isLoading = true;
    });

    // Check if the onChanged callback is provided
    if (widget.onChanged != null) {
      final fetchedItems = await widget.onChanged!(query); // Fetch data from API
      print("fetched $fetchedItems");

      setState(() {
        _filteredItems = fetchedItems; // Update the list with fetched items
        _showSuggestions = fetchedItems.isNotEmpty;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Search Input Field UI
        Container(
          width: widget.width ?? double.infinity,
          // height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
          decoration: widget.boxDecoration ?? BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: RadialGradient(
              colors: [
                const Color(0xFFFFFFFF).withOpacity(0.1),
                const Color(0xFFFFFFFF).withOpacity(0.0224),
                const Color(0xFFFFFFFF).withOpacity(0.0),
              ],
              radius: 8.0,
            ),
            border: Border.all(
              color: Colors.white70,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              if (widget.leadingWidget != null) widget.leadingWidget!,
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  keyboardType: widget.keyboardType,
                  controller: _controller,
                  onChanged: _getSuggestions,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: widget.hintStyle,
                    border: InputBorder.none, // Remove default border
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        ),
        if (_showSuggestions)
          Container(
            constraints: const BoxConstraints(maxHeight: 200), // Limit dropdown height
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.itemToString(_filteredItems[index]),style: TextStyle(color: Colors.white),),
                  onTap: () {
                    widget.onItemSelected(_filteredItems[index]);
                    setState(() {
                      _controller.text = widget.itemToString(_filteredItems[index]);
                      _showSuggestions = false;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }
}



// class SearchableDropdown<T> extends StatefulWidget {
//   final List<T> items; // Generic list of items
//   final String hintText; // Hint text for the search field
//   final ValueChanged<T> onItemSelected; // Callback when item is selected
//   final String Function(T) itemToString; // Function to define how to display each item
//   final bool enableSearchIcon; // Whether to show search icon or not
//
//   const SearchableDropdown({super.key,
//     required this.items,
//     required this.onItemSelected,
//     required this.itemToString, // Function to convert T to String for display
//     this.hintText = "Search...",
//     this.enableSearchIcon = true,
//   });
//
//   @override
//   _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
// }
//
// class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
//   final TextEditingController _controller = TextEditingController();
//   List<T> _filteredItems = [];
//   bool _showSuggestions = false;
//
//   // Filter the items based on search query
//   void _getSuggestions(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _filteredItems = [];
//         _showSuggestions = false;
//       } else {
//         _filteredItems = widget.items
//             .where((item) => widget
//             .itemToString(item)
//             .toLowerCase()
//             .contains(query.toLowerCase()))
//             .toList();
//         _showSuggestions = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: _controller,
//           onChanged: _getSuggestions,
//           decoration: InputDecoration(
//             prefixIcon: widget.enableSearchIcon ? const Icon(Icons.search) : null,
//             hintText: widget.hintText,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//         ),
//         if (_showSuggestions)
//           Container(
//             constraints: const BoxConstraints(maxHeight: 200), // Limit dropdown height
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _filteredItems.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(widget.itemToString(_filteredItems[index])),
//                   onTap: () {
//                     widget.onItemSelected(_filteredItems[index]);
//                     setState(() {
//                       _controller.text =
//                           widget.itemToString(_filteredItems[index]);
//                       _showSuggestions = false;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }
// }
