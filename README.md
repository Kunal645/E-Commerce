# E-Commerce App

Welcome to the E-Commerce App repository! 🛒

This Flutter-based mobile application revolutionizes the online shopping experience by providing users with a sleek and intuitive platform to discover, browse, and purchase a wide range of products. Powered by Flutter, this app offers cross-platform compatibility, ensuring seamless performance on both iOS and Android devices.

## Features:

- **Dynamic Home Screen:** Explore ongoing sales and promotions with eye-catching banners, discover product categories, and browse recent additions to the inventory.
  
- **Category-Specific Screens:** Dive deeper into specific product categories to find exactly what you're looking for.
  
- **Product Details:** View comprehensive product pages featuring high-quality images, detailed descriptions, ratings, and pricing information.
  
- **Cart Management:** Seamlessly manage your shopping cart, adjust quantities, and monitor total prices with real-time updates.
  
- **Wishlist Functionality:** Save your favorite products for future reference and easy access.
  
- **Profile Management:** Personalize your shopping experience by managing your profile details, including name, address, email, and phone number.

## Local Data Storage:

This app utilizes Hive, a lightweight and fast NoSQL database, for efficient local data storage. Hive ensures optimal performance and responsiveness, providing users with a seamless shopping experience across all devices. Manage your cart items, wishlist preferences, and profile information with ease, thanks to Hive's powerful features.

## Installation:

1. Clone the repository: git clone https://github.com/Kunal645/E-Commerce.git
2. Navigate to the project directory: cd E-Commerce
3. Install dependencies: flutter pub get
4. Run the app: flutter run

## Contributing:

Contributions are welcome! Whether you're fixing a bug, implementing a new feature, or improving documentation, your contributions help make this project better for everyone. Please refer to the [Contribution Guidelines](CONTRIBUTING.md) for more details.

## License:
This project is licensed under the [MIT License](LICENSE).

## Mock-up:
 
Check out the mock-up for all screens in one frame :  
 ![Frame 242 (1)](https://github.com/Kunal645/E-Commerce/assets/89443555/f3f98365-5b7a-4a81-8dcb-ff4dea274207)

# E-Commerce App

## Overview:
Welcome to the E-Commerce App repository! 🛒

The E-Commerce App is a Flutter-based mobile application that revolutionizes the online shopping experience by providing users with a sleek and intuitive platform to discover, browse, and purchase a wide range of products. Powered by Flutter, this app offers cross-platform compatibility, ensuring seamless performance on both iOS and Android devices.

## Features:
- **Dynamic Home Screen:** Explore ongoing sales and promotions with eye-catching banners, discover product categories, and browse recent additions to the inventory.
- **Category-Specific Screens:** Dive deeper into specific product categories to find exactly what you're looking for.
- **Product Details:** View comprehensive product pages featuring high-quality images, detailed descriptions, ratings, and pricing information.
- **Cart Management:** Seamlessly manage your shopping cart, adjust quantities, and monitor total prices with real-time updates.
- **Wishlist Functionality:** Save your favorite products for future reference and easy access.
- **Profile Management:** Personalize your shopping experience by managing your profile details, including name, address, email, and phone number.

## Mock-up:
Check out the mock-up for all screens in one frame: ![Frame 242 (1)](https://github.com/Kunal645/E-Commerce/assets/89443555/f3f98365-5b7a-4a81-8dcb-ff4dea274207)

## Local Data Storage:
This app utilizes Hive, a lightweight and fast NoSQL database, for efficient local data storage. Hive ensures optimal performance and responsiveness, providing users with a seamless shopping experience across all devices. Manage your cart items, wishlist preferences, and profile information with ease, thanks to Hive's powerful features.

## Installation:
1. Clone the repository: `git clone https://github.com/Kunal645/E-Commerce.git`
2. Navigate to the project directory: `cd E-Commerce`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Contributing:
Contributions are welcome! Whether you're fixing a bug, implementing a new feature, or improving documentation, your contributions help make this project better for everyone. Please refer to the [Contribution Guidelines](CONTRIBUTING.md) for more details.

## License:
This project is licensed under the [MIT License](LICENSE).


# Movies App

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


