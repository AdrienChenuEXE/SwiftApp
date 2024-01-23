# Réponses aux questions


## Etape 2 : App-Basics

### Liste d’item
#### Exercice 1
1. On obtient l’erreur Initializer 'init(_:rowContent:)' requires that 'String' conform to 'Identifiable’. Cette erreur se déclanche car on ne peut pas itérer sur un objet qui n’a pas d’identifiants. Pour résoudre cette erreur on doit définir un moyen d’identifier le type String avec :
```swift
extension String: Identifiable {
    public var id: String {
        return self
    }
}
```

### Fonction d’ajout
#### Exercice 2 
1. Par rapport à l'exemple précédents, les changements sont :
```swift
ForEach(loot, id: \.self) { item in
    Text(item)
}
```
2. On utilise le `ForEach` pour obtenir un attribut `id` qui sert d’identifiant. Ainsi, à partir de maintenat pour afficher les `loot`, on itère à l’aide de leur identifiant que l’on définit directement deans le `ForEach` à l’aide de l’identifiant `ìd`. On sépare alors le bouton du `ForEach` du click, sinon il y aurait un nouveau bouton à chaque itération.

#### Exercice 3
1. Non, le code ne marche pas car la variable n’est pas encore réactive avec l’affichage lorsque on l’a modifie, cela est du au fait qu'elle n'a pas de `@State`. Il suffit donc d'ajouter @State devant la variable pour corriger cela.

2. A présent, la variable possède un état, l’UI peut donc se mettre à jour réactivement.


## Etape 4 : Ajout-Item
### Créer l’inventaire
#### Exercice 1
1. L’objet inventaire n’ayant pas d'`ObservableObject` dans la view `ContentView`, son changement n’est donc pas détecté. Il faut donc lui ajouter l’attribut `StateObject` pour que l'état soir retrouvé à chaque modifiaction de l’object. De plus, il faut  pouvoir envoyer les modifications de l’objet `loot` à la vue principale `ContentView` lorsque il est modifié. Pour cela, on ajoute `@Publisher` 	

#### Exercice 2
1. Ce message apparait car un objet avec le même identifiant existe deja, puisque nous ajoutons le même objet.


