
# E-Commerce App

## Overview

The Movies App is a Flutter application that leverages [The Movie Database (TMDb) API](https://www.themoviedb.org/) to provide information about popular movies, top-rated movies, and user-selected favorites. The app features a user-friendly interface with two main screens: the home screen and the details screen.

## Features

- **Home Screen:**
  - Displays popular movies, top-rated movies, and user-selected favorites.
  - Allows users to switch between categories seamlessly.

- **Details Screen:**
  - Provides detailed information about a selected movie.
  - Includes movie title, release date, overview, and more.

## Screenshots

<img src="https://github.com/Kunal645/movies_app/assets/89443555/7c59f8ae-3b40-4d08-87c7-677fbd153cf9" alt="Screenshot" height="400">
<img src="https://github.com/Kunal645/movies_app/assets/89443555/adf8e193-bf53-48d9-997a-2c1ce92808c6" alt="Screenshot" height="400">
<img src="https://github.com/Kunal645/movies_app/assets/89443555/210c1fb1-17ee-4a51-951d-8666bab9763a" alt="Screenshot" height="400">
<img src="https://github.com/Kunal645/movies_app/assets/89443555/a7081b0d-6710-4e11-aa84-f608369d96de" alt="Screenshot" height="400">

## Dependencies

- [get](https://pub.dev/packages/get)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [fluttertoast](https://pub.dev/packages/fluttertoast)
- [http](https://pub.dev/packages/http)

## Getting Started

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/movies_app.git
    ```

2. Install dependencies:

    ```bash
    flutter pub get
    ```

3. Add your API key:

    Obtain Authorization token from [TMDb](https://www.themoviedb.org/) and add it to the `lib/networking/networking.dart` file:

    ```dart
    class Networking {
      var token = = 'YOUR_TOKEN';
    }
    ```

4. Run the app:

    ```bash
    flutter run
    ```

## Contributing

Contributions are welcome! If you find any issues or have suggestions, feel free to open an issue or create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to customize the sections according to your specific project details and needs. Don't forget to update the placeholders like `your-username` and `YOUR_TMDB_API_KEY`. Add additional sections or details if necessary.

Feedback and Suggestions are Welcome!
I'd love to hear your thoughts on this design. Your feedback and suggestions are highly valuable as I continue refining and improving this concept. Let me know what you think!
