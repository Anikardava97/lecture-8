import Foundation

//ბიბლიოთეკის სიმულაცია:
/*
 1. შევქმნათ Class Book.
 
 Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
 Designated Init.
 Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
 Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
 */

class Book {
    static var counter = 0
    
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(title: String, author: String) {
        Book.counter += 1
        self.bookID = Book.counter
        self.title = title
        self.author = author
        self.isBorrowed = false
    }
    
    func borrowBook () {
        if isBorrowed {
            print("Sorry, the book \"\(title)\" with ID \(bookID) is already borrowed.")
        } else {
            isBorrowed = true
            print("The book \"\(title)\" with ID \(bookID) has been borrowed.")
        }
    }
    
    func returnBook () {
        if isBorrowed {
            isBorrowed = false
            print("The book \"\(title)\" with ID \(bookID) has been returned.")
        } else {
            print("The book is not borrowed")
        }
    }
}

/*
 2. შევქმნათ Class Owner
 Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
 Designated Init.
 Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
 Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.
 */

class Owner {
    static var counter = 0
    
    var ownerID: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(name: String) {
        Owner.counter += 1
        self.ownerID = Owner.counter
        self.name = name
        self.borrowedBooks = []
    }
    
    func borrowBook(book: Book) {
        if !book.isBorrowed {
            borrowedBooks.append(book)
            book.borrowBook()
            print("\(name) borrowed the book \"\(book.title)\" with ID \(book.bookID)")
        } else {
            print ("\name) can't borrow the book  \"\(book.title)\" with ID \(book.bookID), because it is already borrowed.")
        }
    }
    func returnBook(book: Book) {
        if let index = borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {
            borrowedBooks.remove(at: index)
            book.returnBook()
            print("\(name) has returned the book - \"\(book.title)\"")
        } else {
            print("\(name) can't return the book - \"\(book.title)\", because book is not borrowed")
        }
    }
}

/*
 3. შევქმნათ Class Library
 Properties: Books Array, Owners Array.
 Designated Init.
 Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
 Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
 Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
 Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
 Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
 Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
 Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.
 */

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init() {
        self.books = []
        self.owners = []
    }
    
    func addBook(book: Book) {
        books.append(book)
        print("The book \"\(book.title)\" has been added to library")
    }
    
    func addOwner(owner: Owner) {
        owners.append(owner)
        print("\(owner.name) has become a new member of library")
    }
    
    func booksAvailable() -> [Book] {
        books.filter { !$0.isBorrowed }
    }
    
    func booksBorrowed() -> [Book] {
        books.filter { $0.isBorrowed }
    }
    
    func findOwnerWithID(ownerID: Int)  -> Owner? {
        owners.first { $0.ownerID == ownerID }
    }
    
    func findBorrowedBooksBySpecificOwner(owner: Owner) -> [Book] {
        owner.borrowedBooks
    }
    
    func allowOwnerToBorrowBookIfItIsAvailable(owner: Owner, book: Book) {
        owner.borrowBook(book: book)
    }
}

/*
 4. გავაკეთოთ ბიბლიოთეკის სიმულაცია.
 შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.
 დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში
 წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.
 დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.
 */

let library = Library()

let book1 = Book(title: "Ulysses", author: "James Joyce")
let book2 = Book(title: "The Name of the Rose", author: "Umberto Eco")
let book3 = Book(title: "Submission", author: "Michel Houellebecq")
let book4 = Book(title: "The Magic Mountain", author: "Thomas Mann")

let owner1 = Owner(name: "Ani Kardava")
let owner2 = Owner(name: "Nana Jimsheleishvili")

library.addBook(book: book1)
library.addBook(book: book2)
library.addBook(book: book3)

library.addOwner(owner: owner1)
library.addOwner(owner: owner2)

owner1.borrowBook(book: book1)
owner1.borrowBook(book: book3)
owner2.borrowBook(book: book2)
owner2.borrowBook(book: book4)

owner1.returnBook(book: book1)
owner2.returnBook(book: book4)

print("\nBorrowed Books:")
for book in library.booksBorrowed() {
    print("\(book.title) with (ID: \(book.bookID))")
}

print("\nAvailable Books:")
for book in library.booksAvailable() {
    print("\(book.title) with (ID: \(book.bookID))")
}

print("\nBorrowed Books by \(owner1.name):")
for book in library.findBorrowedBooksBySpecificOwner(owner: owner1) {
    print("\(book.title) with (ID: \(book.bookID))")
}


// ავაწყოთ პატარა E-commerce სისტემა:
/*
 1. შევქმნათ Class Product,
 შევქმნათ შემდეგი properties productID (უნიკალური იდენტიფიკატორი Int), String name, Double price.
 შევქმნათ Designated Init.
 */

class Product {
    static var counter = 0
    var productID: Int
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        Product.counter += 1
        self.productID = Product.counter
        self.name = name
        self.price = price
    }
}

/*
 2. შევქმნათ Class Cart
 Properties: cartID(უნიკალური იდენტიფიკატორი Int), Product-ების Array სახელად items.
 შევქმნათ Designated Init.
 Method იმისათვის რომ ჩვენს კალათაში დავამატოთ პროდუქტი.
 Method იმისათვის რომ ჩვენი კალათიდან წავშალოთ პროდუქტი მისი აიდით.
 Method რომელიც დაგვითვლის ფასს ყველა იმ არსებული პროდუქტის რომელიც ჩვენს კალათაშია.
 */

class Cart {
    static var counter = 0
    var cartID: Int
    var items: [Product]
    
    init() {
        Cart.counter += 1
        self.cartID = Cart.counter
        self.items = []
    }
    
    func addProductToMyCart(_ product: Product) {
        items.append(product)
        print("Product \"\(product.name)\" added to cart \(cartID)")
    }
    
    func removeProductFromMyCart(withID productID: Int) {
        if let index = items.firstIndex(where: { $0.productID == productID }) {
            let removedProduct = items.remove(at: index)
            print("\(removedProduct.name) removed from cart \(cartID)")
        } else {
            print("Product with ID \(productID) not found in the cart \(cartID)")
        }
    }
    
    func totalPrice () -> Double {
        let totalPrice = items.reduce(0.0) { $0 + $1.price }
        return totalPrice
    }
    
    func clearCart() {
        items.removeAll()
    }
}

/*
 3. შევქმნათ Class User
 Properties: userID(უნიკალური იდენტიფიკატორი Int), String username, Cart cart.
 Designated Init.
 Method რომელიც კალათაში ამატებს პროდუქტს.
 Method რომელიც კალათიდან უშლის პროდუქტს.
 Method რომელიც checkout (გადახდის)  იმიტაციას გააკეთებს დაგვითვლის თანხას და გაასუფთავებს ჩვენს shopping cart-ს.
 */

class User {
    static var counter = 0
    var userID: Int
    var username: String
    var cart: Cart
    
    init(username: String, cart: Cart) {
        User.counter += 1
        self.userID = User.counter
        self.username = username
        self.cart = cart
    }
    
    func addProduct(_ product:Product) {
        cart.addProductToMyCart(product)
    }
    
    func removeProduct(withID productID: Int) {
        cart.removeProductFromMyCart(withID: productID)
    }
    
    func checkout() {
        let total = cart.totalPrice()
        
        if total > 0 {
            print("\(username): Total price is \(total)Gel ")
            cart.clearCart()
        }
    }
}

/*
 4. გავაკეთოთ იმიტაცია და ვამუშაოთ ჩვენი ობიექტები ერთად.
 შევქმნათ რამოდენიმე პროდუქტი.
 შევქმნათ 2 user-ი, თავისი კალათებით,
 დავუმატოთ ამ იუზერებს კალათებში სხვადასხვა პროდუქტები,
 დავბეჭდოთ price ყველა item-ის ამ იუზერების კალათიდან.
 და ბოლოს გავაკეთოთ სიმულაცია ჩექაუთის, დავაბეჭდინოთ იუზერების გადასხდელი თანხა და გავუსუფთაოთ კალათები.
 */

let product1 = Product(name: "Royal Cheeseburger", price: 7.0)
let product2 = Product(name: "Double Cheeseburger", price: 5.0)
let product3 = Product(name: "French Fries", price: 4.0)
let product4 = Product(name: "Coca-Cola", price: 3.0)

let cart1 = Cart()
let cart2 = Cart()

let userA = User(username: "Ani", cart: cart1)
let userB = User(username: "Nana", cart: cart2)

userA.addProduct(product1)
userA.addProduct(product4)

userB.addProduct(product2)
userB.addProduct(product3)
userB.addProduct(product4)

cart1.totalPrice()
cart2.totalPrice()

userA.checkout()
userB.checkout()

// კალათას ვეღარ ვასუფთავებ :)











/*
1. Class-ი სახელით Animal, with properties: name, species, age. ამ class აქვს:
Designated init ამ properties ინიციალიზაციისთვის.
Method makeSound() რომელიც დაგვი-print-ავს ცხოველის ხმას.
*/

class Animal {
    var name: String
    var species: String
    var age: Int
    
    init(name: String, species: String, age: Int) {
        self.name = name
        self.species = species
        self.age = age
    }
    
    func makeSound() {
        print("Animal 🔊")
    }
}

/*
2. Animal-ის child class სახელად Mammal (ძუძუმწოვრები).
დამატებითი String property -> furColor.
Override method makeSound() სადაც აღწერთ შესაბამის ხმას.
Init-ი -> სახელით, ასაკით, ბეწვის ფერით.
convenience init -> სახელით, ბეწვის ფერით.
 */


/*
3. Animal-ის child class: Bird.
დამატებითი Bool property: canFly.
Override method makeSound() სადაც ავღწერ შესაბამის ხმას.
Init -> სახელით, ასაკით, შეუძლია თუ არა ფრენა.
convenience init -> სახელით, შეუძლია თუ არა ფრენა.
*/

/*
4. Animal-ის child class: Reptile.
დამატებითი Bool property: isColdBlooded.
Override method makeSound() სადაც ავღწერ შესაბამის ხმას.
Failable Init თუ რეპტილიას ასაკი ნაკლებია 0-ზე ვაბრუნებთ nil-ს.
*/

/*
5. Mammal-ის child class: Lion.
დამატებით String property: maneColor.
Override მეთოდი makeSound() სადაც ავღწერ შესაბამის ხმას.
*/

/*
6. Bird-ის child class: Eagle.
დამატებით Double property: wingspan.
Override მეთოდი makeSound() სადაც ავღწერ შესაბამის ხმას.
*/

/*
7. Reptil-ის child class: Snake.
დამატებით Double property: length.
Override მეთოდი makeSound() სადაც ავღწერ შესაბამის ხმას.
*/

/*
8. აბსტრაქციისათვის Animal class დავუმატოთ required init() შიგნით აღწერილი fatal error-ით სადაც ვიტყვით რომ Animal class არის აბსტრაქტული და არ უნდა იყოს მისი შექმნა პირდაპირ შესაძლებელი.
*/

/*
9. შევქმნათ ზოოპარკის ცხოველების Array, დავამატოთ მასში სხვადასხვა სახის ცხოველები: 2-2 Mammal, Bird, Reptile ასევე შევქმნათ 1-1 Lion, Eagle, Snake.
*/

/*
10. დავბეჭდოთ ჩვენი Array-იდან, ყველა ცხოველის სახელი, სახეობა, ასაკი, და ასე გამოვიძახოთ makeSound მეთოდი.
*/
 
