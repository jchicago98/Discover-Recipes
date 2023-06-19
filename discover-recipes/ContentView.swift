import SwiftUI

struct ContentView: View {
    @State private var meals: [Meal] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(meals) { meal in
                    NavigationLink(destination: RecipeDetailView(recipe: meal)) {
                        RecipeCell(recipe: meal)
                    }
                }
            }
            .navigationTitle("Discover Recipes")
            .onAppear {
                fetchMeals()
            }
        }
    }

    private func fetchMeals() {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let response = try JSONDecoder().decode(MealsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.meals = response.meals
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct RecipeCell: View {
    var recipe: Meal

    var body: some View {
        HStack {
            if let imageUrl = URL(string: recipe.image) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                }
            } else {
                Color.gray
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
            }
        }
    }
}

struct RecipeDetailView: View {
    var recipe: Meal
    @State private var recipeInfo: RecipeInfo?

    var body: some View {
           ScrollView {
               VStack {
                   if let imageUrl = URL(string: recipe.image) {
                       AsyncImage(url: imageUrl) { image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                       } placeholder: {
                           Color.gray
                       }
                   } else {
                       Color.gray
                   }

                   Text(recipe.name)
                       .font(.title)
                       .padding()

                   if let recipeInfo = recipeInfo {
                       Text("Ingredients")
                           .font(.headline)
                           .padding()

                       ForEach(0..<recipeInfo.ingredients.count, id: \.self) { index in
                           Text("\(recipeInfo.ingredients[index]) - \(recipeInfo.measurements[index])")
                               .padding(.horizontal)
                       }

                       Text(recipeInfo.instructions)
                           .multilineTextAlignment(.leading)
                           .padding()
                   } else {
                       Text("Loading recipe...")
                           .multilineTextAlignment(.leading)
                           .padding()
                           .onAppear {
                               fetchRecipeInfo()
                           }
                   }

                   Spacer()
               }
               .padding()
           }
           .navigationTitle(recipe.name)
       
    }
    
    private func fetchRecipeInfo() {
        let recipeURLString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(recipe.idMeal)"
        guard let recipeURL = URL(string: recipeURLString) else {
            return
        }
        
        URLSession.shared.dataTask(with: recipeURL) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RecipeInfoResponse.self, from: data)
                DispatchQueue.main.async {
                    self.recipeInfo = response.meals.first?.filteredRecipeInfo()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }

}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


extension RecipeInfo {
    func filteredRecipeInfo() -> RecipeInfo {
        let filteredIngredients = ingredients.filter { !$0.isEmpty }
        let filteredMeasurements = measurements.filter { !$0.isEmpty }
        
        return RecipeInfo(
            idMeal: idMeal,
            strInstructions: strInstructions,
            strIngredient1: filteredIngredients[safe: 0],
            strIngredient2: filteredIngredients[safe: 1],
            strIngredient3: filteredIngredients[safe: 2],
            strIngredient4: filteredIngredients[safe: 3],
            strIngredient5: filteredIngredients[safe: 4],
            strIngredient6: filteredIngredients[safe: 5],
            strIngredient7: filteredIngredients[safe: 6],
            strIngredient8: filteredIngredients[safe: 7],
            strIngredient9: filteredIngredients[safe: 8],
            strIngredient10: filteredIngredients[safe: 9],
            strIngredient11: filteredIngredients[safe: 10],
            strIngredient12: filteredIngredients[safe: 11],
            strIngredient13: filteredIngredients[safe: 12],
            strIngredient14: filteredIngredients[safe: 13],
            strIngredient15: filteredIngredients[safe: 14],
            strIngredient16: filteredIngredients[safe: 15],
            strIngredient17: filteredIngredients[safe: 16],
            strIngredient18: filteredIngredients[safe: 17],
            strIngredient19: filteredIngredients[safe: 18],
            strIngredient20: filteredIngredients[safe: 19],
            strMeasure1: filteredMeasurements[safe: 0],
            strMeasure2: filteredMeasurements[safe: 1],
            strMeasure3: filteredMeasurements[safe: 2],
            strMeasure4: filteredMeasurements[safe: 3],
            strMeasure5: filteredMeasurements[safe: 4],
            strMeasure6: filteredMeasurements[safe: 5],
            strMeasure7: filteredMeasurements[safe: 6],
            strMeasure8: filteredMeasurements[safe: 7],
            strMeasure9: filteredMeasurements[safe: 8],
            strMeasure10: filteredMeasurements[safe: 9],
            strMeasure11: filteredMeasurements[safe: 10],
            strMeasure12: filteredMeasurements[safe: 11],
            strMeasure13: filteredMeasurements[safe: 12],
            strMeasure14: filteredMeasurements[safe: 13],
            strMeasure15: filteredMeasurements[safe: 14],
            strMeasure16: filteredMeasurements[safe: 15],
            strMeasure17: filteredMeasurements[safe: 16],
            strMeasure18: filteredMeasurements[safe: 17],
            strMeasure19: filteredMeasurements[safe: 18],
            strMeasure20: filteredMeasurements[safe: 19]
        )
    }
}

struct Meal: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    var id: String { idMeal }
    var name: String { strMeal }
    var image: String { strMealThumb }
}

struct MealsResponse: Decodable {
    let meals: [Meal]
}

struct RecipeInfo: Decodable {
    let idMeal: String
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    var instructions: String { strInstructions }
    
    var ingredients: [String] {
        let ingredientArray = [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ]
        
        let ingredients = ingredientArray.compactMap { $0 }
        return ingredients
    }
    
    var measurements: [String] {
        let measurementArray = [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
            strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        ]
        
        let measurements = measurementArray.compactMap { $0 }
        return measurements
    }
}




struct RecipeInfoResponse: Decodable {
    let meals: [RecipeInfo]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

