import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(dummyRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeCell(recipe: recipe)
                    }
                }
            }
            .navigationTitle("Discover Recipes")
        }
    }
}

struct RecipeCell: View {
    var recipe: Recipe

    var body: some View {
        HStack {
            Image(recipe.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.category)
                    .font(.subheadline)
            }
        }
    }
}

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        VStack {
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(recipe.name)
                .font(.title)
                .padding()
            Text(recipe.instructions)
                .multilineTextAlignment(.leading)
                .padding()
            Spacer()
        }
        .navigationTitle(recipe.name)
    }
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let imageName: String
    let instructions: String
}

let dummyRecipes: [Recipe] = [
    Recipe(name: "Apple Pie", category: "Dessert", imageName: "apple_pie", instructions: "This is how you make an apple pie"),
    Recipe(name: "Chocolate Cake", category: "Dessert", imageName: "chocolate_cake", instructions: "This is how you make a chocolate cake"),
    Recipe(name: "Vanilla Cupcakes", category: "Dessert", imageName: "vanilla_cupcakes", instructions: "This is how you make vanilla cupcakes")
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
