import Foundation

//: ## Step 1
//: Create an enumeration for the value of a playing card. The values are: `ace`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `jack`, `queen`, and `king`. Set the raw type of the enum to `Int` and assign the ace a value of `1`.

enum Rank: Int, CustomStringConvertible {
    var description: String {
        switch self {
        case .ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten:
            return "\(self.rawValue)"
        case .jack:
            return "11"
        case .queen:
            return "12"
        case .king:
            return "13"
        }
        
    }
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    
    static var allRanks: [Rank] {
        get {
            return [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
        }
    }
}

//: ## Step 2
//: Once you've defined the enum as described above, take a look at this built-in protocol, [CustomStringConvertible](https://developer.apple.com/documentation/swift/customstringconvertible) and make the enum conform to that protocol. Make the face cards return a string of their name, and for the numbered cards, simply have it return that number as a string.

// Done


//: ## Step 3
//: Create an enum for the suit of a playing card. The values are `hearts`, `diamonds`, `spades`, and `clubs`. Use a raw type of `String` for this enum (this will allow us to get a string version of the enum cases for free, no use of `CustomStringConvertible` required).


enum Suit: String {
    case hearts = "Hearts"
    case diamonds = "Diamonds"
    case spades = "Spades"
    case clubs = "Clubs"
    
    static var allSuits: [Suit] {
        get {
            return [hearts, diamonds, spades, clubs]
        }
    }
}

//: ## Step 4
//: Using the two enums above, create a `struct` called `Card` to model a single playing card. It should have constant properties for each constituent piece (one for suit and one for rank).

struct Card {
    let suit: Suit
    let rank: Rank
}


//: ## Step 5
//: Make the card also conform to `CustomStringConvertible`. When turned into a string, a card's value should look something like this, "ace of spades", or "3 of diamonds".

extension Card: CustomStringConvertible {
    var description: String {
        return "\(self.rank) of \(self.suit)"
    }
}

//: ## Step 6
//: Create a `struct` to model a deck of cards. It should be called `Deck` and have an array of `Card` objects as a constant property. A custom `init` function should be created that initializes the array with a card of each rank and suit. You'll want to iterate over all ranks, and then over all suits (this is an example of _nested `for` loops_). See the next 2 steps before you continue with the nested loops.


struct Deck {
    let cards: [Card]
    
    
    init() {
        var cards: [Card] = []
        for suit in Suit.allSuits {
            for rank in Rank.allRanks {
                let newCard = Card(suit: suit, rank: rank)
                cards.append(newCard)
            }
        }
        self.cards = cards
    }
    func drawCard() -> Card {
        let card = cards[Int.random(in: 0...51)]
        return card
    }
}


//: ## Step 7
//: In the rank enum, add a static computed property that returns all the ranks in an array. Name this property `allRanks`. This is needed because you can't iterate over all cases from an enum automatically.

// Done

//: ## Step 8
//: In the suit enum, add a static computed property that returns all the suits in an array. Name this property `allSuits`.

// Done


//: ## Step 9
//: Back to the `Deck` and the nested loops. Now that you have a way to get arrays of all rank values and all suit values, create 2 `for` loops in the `init` method, one nested inside the other, where you iterate over each value of rank, and then iterate over each value of suit. See an example below to get an idea of how this will work. Imagine an enum that contains the 4 cardinal directions, and imagine that enum has a property `allDirections` that returns an array of them.
//: ```
//: for direction in Compass.allDirections {
//:
//:}
//:```

// Done

//: ## Step 10
//: These loops will allow you to match up every rank with every suit. Make a `Card` object from all these pairings and append each card to the `cards` property of the deck. At the end of the `init` method, the `cards` array should contain a full deck of standard playing card objects.


// Done


//: ## Step 11
//: Add a method to the deck called `drawCard()`. It takes no arguments and it returns a `Card` object. Have it draw a random card from the deck of cards and return it.
//: - Callout(Hint): There should be `52` cards in the deck. So what if you created a random number within those bounds and then retrieved that card from the deck? Remember that arrays are indexed from `0` and take that into account with your random number picking.

// Done



//: ## Step 12
//: Create a protocol for a `CardGame`. It should have two requirements:
//: * a gettable `deck` property
//: * a `play()` method

protocol CardGame {
    var deck: Deck { get }
    func play()
}



//: ## Step 14
//: Create a class called `HighLow` that conforms to the `CardGame` protocol. It should have an initialized `Deck` as a property, as well as an optional delegate property of type `CardGameDelegate`.
class HighLow: CardGame {
    var deck: Deck = Deck()
    
    //var delegate: CardGameDelegate?

    func play() {
        let card1 = deck.drawCard()
        let card2 = deck.drawCard()
        
        print("Started a new game of High Low")
        print("Player 1 drew a \(card1.description)")
        print("Player 2 drew a \(card2.description)")
        
        //delegate?.gameDidStart(game: cardGame)
        //delegate?.game(player1DidDraw: card1, player2DidDraw: card2)
        
        if card1.rank == card2.rank {
            print("Round ends in a tie with \(card1.description)")
        } else if card1.rank < card2.rank {
            print("Player 2 wins with \(card2.description)")
        } else {
            print("Player 1 wins with \(card1.description)")
        }
    }
}



//: ## Step 15
//: As part of the protocol conformance, implement a method called `play()`. The method should draw 2 cards from the deck, one for player 1 and one for player 2. These cards will then be compared to see which one is higher. The winning player will be printed along with a description of the winning card. Work will need to be done to the `Suit` and `Rank` types above, so see the next couple steps before continuing with this step.

// Done


//: ## Step 16
//: Take a look at the Swift docs for the [Comparable](https://developer.apple.com/documentation/swift/comparable) protocol. In particular, look at the two functions called `<` and `==`.

// Done


//: ## Step 17
//: Make the `Rank` type conform to the `Comparable` protocol. Implement the `<` and `==` functions such that they compare the `rawValue` of the `lhs` and `rhs` arguments passed in. This will allow us to compare two rank values with each other and determine whether they are equal, or if not, which one is larger.


extension Rank: Comparable {
    
    // compare left hand side and right hand side
    static func ==(lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    static func <(lhs: Rank, rhs: Rank) -> Bool {
        if lhs.rawValue != rhs.rawValue {
            return lhs.rawValue < rhs.rawValue
        } else if lhs.rawValue != rhs.rawValue {
            return lhs.rawValue < rhs.rawValue
        } else {
            return lhs.rawValue < rhs.rawValue
        }
    }
}


//: Step 18
//: Make the `Card` type conform to the `Comparable` protocol. Implement the `<` and `==` methods such that they compare the ranks of the `lhs` and `rhs` arguments passed in. For the `==` method, compare **both** the rank and the suit.

extension Card: Comparable {
    
    // compare left hand side and right hand side
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
    
    static func <(lhs: Card, rhs: Card) -> Bool {
        if lhs.rank != rhs.rank {
            return lhs.rank < rhs.rank
        } else if lhs.rank != rhs.rank {
            return lhs.rank < rhs.rank
        } else {
            return lhs.rank < rhs.rank
        }
    }
}



//: ## Step 19
//: Back to the `play()` method. With the above types now conforming to `Comparable`, you can write logic to compare the drawn cards and print out 1 of 3 possible message types:
//: * Ends in a tie, something like, "Round ends in a tie with 3 of clubs."
//: * Player 1 wins with a higher card, e.g. "Player 1 wins with 8 of hearts."
//: * Player 2 wins with a higher card, e.g. "Player 2 wins with king of diamonds."









// STRETCH GOALS

protocol CardGameDelegate {
    func gameDidStart(game: CardGame)
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)
}


class CardGameTracker: CardGameDelegate {
    func gameDidStart(game: CardGame) {
        print("Started a new game of High Low")
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 drew a \(card1.description)")
        print("Player 2 drew a \(card2.description)")
    }

}



//let newGame = HighLow(delegate: CardGameTracker())

let newGame = HighLow()
newGame.play()
