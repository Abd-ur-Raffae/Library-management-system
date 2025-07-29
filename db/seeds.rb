# Clear existing data (optional - remove if you want to keep existing data)
puts "Clearing existing data..."
BookRequest.destroy_all
Borrowing.destroy_all
Book.destroy_all
Author.destroy_all
Member.destroy_all
User.destroy_all

puts "Creating users..."

# Create librarian users
librarian1 = User.create!(
  email: 'librarian@library.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'librarian'
)

librarian2 = User.create!(
  email: 'admin@library.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'librarian'
)

# Create member users
member1 = User.create!(
  email: 'john.doe@email.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'member'
)

member2 = User.create!(
  email: 'jane.smith@email.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'member'
)

member3 = User.create!(
  email: 'bob.wilson@email.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'member'
)

puts "Created #{User.count} users"

puts "Creating authors..."

authors_data = [
  {
    name: "J.K. Rowling",
    biography: "British author best known for the Harry Potter series.",
    birth_date: Date.new(1965, 7, 31),
    nationality: "British"
  },
  {
    name: "George Orwell",
    biography: "English novelist and essayist, journalist and critic.",
    birth_date: Date.new(1903, 6, 25),
    nationality: "British"
  },
  {
    name: "Jane Austen",
    biography: "English novelist known for her wit and social commentary.",
    birth_date: Date.new(1775, 12, 16),
    nationality: "British"
  },
  {
    name: "Stephen King",
    biography: "American author of horror, supernatural fiction, suspense, and fantasy novels.",
    birth_date: Date.new(1947, 9, 21),
    nationality: "American"
  },
  {
    name: "Agatha Christie",
    biography: "English writer known for her detective novels.",
    birth_date: Date.new(1890, 9, 15),
    nationality: "British"
  },
  {
    name: "Mark Twain",
    biography: "American writer, humorist, entrepreneur, publisher, and lecturer.",
    birth_date: Date.new(1835, 11, 30),
    nationality: "American"
  }
]

authors = authors_data.map { |data| Author.create!(data) }
puts "Created #{Author.count} authors"

puts "Creating books..."

books_data = [
  # J.K. Rowling books
  {
    title: "Harry Potter and the Philosopher's Stone",
    author: authors[0],
    isbn: "9780747532699",
    publication_year: 1997,
    genre: "Fantasy",
    description: "The first book in the Harry Potter series.",
    available: true
  },
  {
    title: "Harry Potter and the Chamber of Secrets",
    author: authors[0],
    isbn: "9780747538493",
    publication_year: 1998,
    genre: "Fantasy",
    description: "The second book in the Harry Potter series.",
    available: true
  },
  {
    title: "Harry Potter and the Prisoner of Azkaban",
    author: authors[0],
    isbn: "9780747542155",
    publication_year: 1999,
    genre: "Fantasy",
    description: "The third book in the Harry Potter series.",
    available: false
  },

  # George Orwell books
  {
    title: "1984",
    author: authors[1],
    isbn: "9780451524935",
    publication_year: 1949,
    genre: "Dystopian Fiction",
    description: "A dystopian social science fiction novel.",
    available: true
  },
  {
    title: "Animal Farm",
    author: authors[1],
    isbn: "9780451526342",
    publication_year: 1945,
    genre: "Political Satire",
    description: "An allegorical novella about farm animals.",
    available: false
  },

  # Jane Austen books
  {
    title: "Pride and Prejudice",
    author: authors[2],
    isbn: "9780141439518",
    publication_year: 1813,
    genre: "Romance",
    description: "A romantic novel of manners.",
    available: true
  },
  {
    title: "Sense and Sensibility",
    author: authors[2],
    isbn: "9780141439662",
    publication_year: 1811,
    genre: "Romance",
    description: "A novel about the Dashwood sisters.",
    available: true
  },

  # Stephen King books
  {
    title: "The Shining",
    author: authors[3],
    isbn: "9780307743657",
    publication_year: 1977,
    genre: "Horror",
    description: "A horror novel about the Overlook Hotel.",
    available: true
  },
  {
    title: "It",
    author: authors[3],
    isbn: "9781501142970",
    publication_year: 1986,
    genre: "Horror",
    description: "A horror novel about a shape-shifting entity.",
    available: false
  },

  # Agatha Christie books
  {
    title: "Murder on the Orient Express",
    author: authors[4],
    isbn: "9780062693662",
    publication_year: 1934,
    genre: "Mystery",
    description: "A detective novel featuring Hercule Poirot.",
    available: true
  },
  {
    title: "And Then There Were None",
    author: authors[4],
    isbn: "9780062073488",
    publication_year: 1939,
    genre: "Mystery",
    description: "A mystery novel about ten strangers on an island.",
    available: true
  },

  # Mark Twain books
  {
    title: "The Adventures of Tom Sawyer",
    author: authors[5],
    isbn: "9780486400778",
    publication_year: 1876,
    genre: "Adventure",
    description: "A novel about a young boy's adventures.",
    available: true
  },
  {
    title: "Adventures of Huckleberry Finn",
    author: authors[5],
    isbn: "9780486280615",
    publication_year: 1884,
    genre: "Adventure",
    description: "A novel about Huck Finn's journey down the Mississippi.",
    available: true
  }
]

books = books_data.map { |data| Book.create!(data) }
puts "Created #{Book.count} books"

puts "Creating members..."

members_data = [
  {
    name: "John Doe",
    email: "john.doe@email.com",
    phone: "+1-555-0101",
    address: "123 Main St, Anytown, USA",
    membership_date: Date.current - 6.months,
    membership_type: "adult",
    active: true
  },
  {
    name: "Jane Smith",
    email: "jane.smith@email.com",
    phone: "+1-555-0102",
    address: "456 Oak Ave, Somewhere, USA",
    membership_date: Date.current - 3.months,
    membership_type: "student",
    active: true
  },
  {
    name: "Bob Wilson",
    email: "bob.wilson@email.com",
    phone: "+1-555-0103",
    address: "789 Pine Rd, Elsewhere, USA",
    membership_date: Date.current - 1.month,
    membership_type: "senior",
    active: true
  },
  {
    name: "Alice Johnson",
    email: "alice.johnson@email.com",
    phone: "+1-555-0104",
    address: "321 Elm St, Nowhere, USA",
    membership_date: Date.current - 2.months,
    membership_type: "faculty",
    active: true
  }
]

members = members_data.map { |data| Member.create!(data) }
puts "Created #{Member.count} members"

puts "Creating sample borrowings..."

# Create some borrowings for books that are marked as unavailable
borrowings_data = [
  {
    book: books.find { |b| b.title == "Harry Potter and the Prisoner of Azkaban" },
    member: members[0],
    borrowed_date: Date.current - 10.days,
    due_date: Date.current + 4.days,
    status: 'borrowed'
  },
  {
    book: books.find { |b| b.title == "Animal Farm" },
    member: members[1],
    borrowed_date: Date.current - 20.days,
    due_date: Date.current - 6.days,
    status: 'overdue'
  },
  {
    book: books.find { |b| b.title == "It" },
    member: members[2],
    borrowed_date: Date.current - 15.days,
    due_date: Date.current + 1.day,
    status: 'borrowed'
  }
]

borrowings_data.each { |data| Borrowing.create!(data) }
puts "Created #{Borrowing.count} borrowings"

puts "Creating sample book requests..."

# Create some pending book requests
requests_data = [
  {
    book: books.find { |b| b.title == "1984" },
    requested_by: member1,
    requested_date: Date.current - 2.days,
    needed_by_date: Date.current + 7.days,
    reason: "Need this book for my literature class assignment on dystopian fiction.",
    status: 'pending'
  },
  {
    book: books.find { |b| b.title == "Pride and Prejudice" },
    requested_by: member2,
    requested_date: Date.current - 1.day,
    needed_by_date: Date.current + 10.days,
    reason: "Want to read this classic novel for my book club discussion.",
    status: 'pending'
  },
  {
    book: books.find { |b| b.title == "The Shining" },
    requested_by: member3,
    requested_date: Date.current - 3.days,
    needed_by_date: Date.current + 5.days,
    reason: "Interested in reading Stephen King's horror novels.",
    status: 'pending'
  }
]

requests_data.each { |data| BookRequest.create!(data) }
puts "Created #{BookRequest.count} book requests"

puts "\n" + "="*50
puts "SEED DATA CREATION COMPLETE!"
puts "="*50
puts "Summary:"
puts "- #{User.count} users (2 librarians, 3 members)"
puts "- #{Author.count} authors"
puts "- #{Book.count} books"
puts "- #{Member.count} members"
puts "- #{Borrowing.count} borrowings"
puts "- #{BookRequest.count} pending book requests"
puts "\nLogin credentials:"
puts "Librarian: librarian@library.com / password123"
puts "Admin: admin@library.com / password123"
puts "Member 1: john.doe@email.com / password123"
puts "Member 2: jane.smith@email.com / password123"
puts "Member 3: bob.wilson@email.com / password123"
puts "="*50
