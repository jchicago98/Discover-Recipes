# Discover-Recipes
Discover Recipes: Your Gateway to Culinary Creations!

Discover Recipes is a captivating iOS app that opens the door to a world of culinary delights. Explore an extensive collection of recipes, focusing on the Dessert category, sorted alphabetically for effortless browsing.

Key Features:
- Browse Dessert Category: Uncover a diverse array of dessert recipes, presented in a convenient alphabetical list.

- Detailed Recipe View: Dive into the details of each recipe, including the meal name, step-by-step instructions, and a comprehensive list of ingredients with precise measurements.

- Inspire Your Culinary Adventure: Embark on a journey of culinary creativity, discovering new dessert favorites and gaining inspiration to unleash your inner chef.

- Engaging User Experience: Enjoy a visually pleasing design, seamless navigation, and an intuitive interface that enhances your recipe exploration.

With Discover Recipes, the world of culinary wonders is at your fingertips. Whether you're a seasoned chef or an aspiring home cook, this app will elevate your cooking game, impress your loved ones, and awaken your taste buds to a universe of delectable desserts.


## Features

- Fetches dessert recipes from an external API.
- Displays a list of recipes with images and names.
- Allows users to select a recipe to view its details.
- Shows recipe details, including the recipe name, image, ingredients, and instructions.
- Provides placeholder images for recipes without a valid image URL.
- Supports asynchronous image loading and caching.
- Uses SwiftUI for building the user interface.
- Follows the Model-View-ViewModel (MVVM) architectural pattern.

## Requirements

- Xcode 12 or later
- iOS 14 or later
- Swift 5

## Installation

1. Clone the repository:
```
git clone https://github.com/your-username/recipe-app.git
```

2. Open the project in Xcode.

3. Build and run the app on the iOS Simulator or a physical device.

API
The app fetches dessert recipes from the TheMealDB API. It uses the following API endpoints:

```
List of dessert recipes: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
Recipe details: https://themealdb.com/api/json/v1/1/lookup.php?i={recipeId}
```


