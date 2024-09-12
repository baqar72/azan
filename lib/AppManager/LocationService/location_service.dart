import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _currentAddress = '';

  Future<void> _getCurrentLocation() async {
    // Request permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // Handle permission denied
      return;
    }
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    // Optionally, use reverse geocoding to get the address
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    setState(() {
      _currentAddress = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get User Location'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _getCurrentLocation,
            child: Text('Use Current Location'),
          ),
          if (_currentAddress.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Location: $_currentAddress',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}



class LocationService {
  // Method to get the current position (latitude and longitude)
  Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        // If permission is denied, return null
        return null;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  // Method to reverse geocode the position (convert coordinates to address)
  Future<String> getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    } catch (e) {
      print("Error getting address: $e");
      return "Unknown location";
    }
  }

  // Method to get coordinates from a user-provided address (forward geocoding)
  Future<Location?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return locations[0];  // Return the first matched location
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting coordinates from address: $e");
      return null;
    }
  }
}


class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _addressController = TextEditingController();
  final LocationService _locationService = LocationService();
  String _searchResult = '';

  Future<void> _searchLocationByAddress() async {
    String address = _addressController.text;
    if (address.isEmpty) {
      setState(() {
        _searchResult = "Please enter an address";
      });
      return;
    }

    Location? location = await _locationService.getCoordinatesFromAddress(address);
    if (location != null) {
      setState(() {
        _searchResult = "Latitude: ${location.latitude}, Longitude: ${location.longitude}";
      });
    } else {
      setState(() {
        _searchResult = "Location not found.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Location by Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Enter an address',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchLocationByAddress,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_searchResult.isNotEmpty)
              Text(
                _searchResult,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

//for searching

class LocationSearch extends StatefulWidget {
  const LocationSearch({super.key});

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  // Mock data, replace with actual API or database data
  final List<String> _allLocations = [
    "Sarfarazganj, Uttar Pradesh, India",
    "Rajmahal, Jharkhand, India",
    "undefined, Jharkhand, India",
  ];

  // Method to filter suggestions
  void _getSuggestions(String query) {
    setState(() {
      if (query.isEmpty) {
        _suggestions = [];
        _showSuggestions = false;
      } else {
        _suggestions = _allLocations
            .where((location) =>
            location.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _showSuggestions = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _getSuggestions,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            if (_showSuggestions)
              ListView.builder(
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_suggestions[index]),
                    onTap: () {
                      setState(() {
                        _controller.text = _suggestions[index];
                        _showSuggestions = false;
                      });
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}


