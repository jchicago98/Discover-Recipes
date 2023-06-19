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

    var body: some View {
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
            Text(recipe.idMeal)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
        .navigationTitle(recipe.name)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
