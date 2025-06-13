const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 5000;

// Enable CORS for all requests
app.use(cors());
// Serve static files (like images) from the uploads directory
app.use('/uploads', express.static('uploads'));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

const fs = require('fs');
const path = require('path');

// Helper to read a JSON data file
function readData(file) {
  return JSON.parse(fs.readFileSync(path.join(__dirname, 'data', file)));
}

// GET Hotels List
app.get('/get_hotels_list', (req, res) => {
  res.json(readData('hotels.json'));
});

// GET Reservations
app.get('/get_reservations', (req, res) => {
  res.json(readData('reservations.json'));
});

// GET Wishlist, filter by email if provided
app.get('/get_wishlist', (req, res) => {
  const data = readData('wishlist.json');
  const email = req.query.email;
  if (email) {
    res.json(data.filter(item => item.email === email));
  } else {
    res.json(data);
  }
});

// GET Users List, filter out requester if email provided
app.get('/get_users', (req, res) => {
  const data = readData('users.json');
  const email = req.query.email;
  if (email) {
    res.json(data.filter(user => user.email !== email));
  } else {
    res.json(data);
  }
});

// GET Inbox List, filter out requester if email provided
app.get('/get_inboxlist', (req, res) => {
  const data = readData('inboxlist.json');
  const email = req.query.email;
  if (email) {
    res.json(data.filter(user => user.email !== email));
  } else {
    res.json(data);
  }
});

// Default route
app.get('/', (req, res) => {
  res.send('Hotel backend API running!');
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

// ...other requires and routes

const USERS_FILE = path.join(__dirname, 'data', 'users.json');

// Helper to write user data
function writeUsers(data) {
  fs.writeFileSync(USERS_FILE, JSON.stringify(data, null, 2));
}

app.post('/register', (req, res) => {
 console.log('Register request:', req.body);
  const { name, email, password } = req.body;
  let users = readData('users.json');
  if (users.find(u => u.email === email)) {
    return res.status(200).send("Email");
  }
  const newUser = {
    id: (users.length + 1).toString(),
    name,
    email,
    profile_picture: "default.jpg", // Or handle profile pic upload
    password // Don't store plaintext in production!
  };
  users.push(newUser);
  writeUsers(users);
  return res.status(200).send("Success");
});

app.post('/login', express.urlencoded({extended: true}), (req, res) => {
  const { email, password } = req.body;
  const users = readData('users.json');
  const user = users.find(u => u.email === email && u.password === password);
  if (user) {
    // Structure matches expected Flutter response
    res.json({
      status: "Success",
      id: user.id,
      name: user.name,
      profile_picture: user.profile_picture
    });
  } else {
    res.json({ status: "Invalid" });
  }
});


app.post('/send_password_reset', express.urlencoded({extended: true}), (req, res) => {
  const { email } = req.body;
  const users = readData('users.json');
  const user = users.find(u => u.email === email);
  if (!user) {
    return res.json({ status: "invalid" });
  }

  // Here, you would send an email. For demo, just respond with "success".
  // You can use nodemailer for real email functionality.
  // Simulate success:
  return res.json({ status: "success" });
});

app.post('/wish_list_check', express.urlencoded({extended: true}), (req, res) => {
  const { email, listing_id } = req.body;
  const wishlist = readData('wishlist.json');
  const found = wishlist.some(item => item.email === email && item.listing_id == listing_id);
  res.json({ found });
});

const multer = require('multer');
//const path = require('path');


const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Make sure this folder exists
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    const uniqueName = `${Date.now()}-${Math.round(Math.random() * 1E9)}${ext}`;
    cb(null, uniqueName);
  }
});
const upload = multer({ storage: storage });

app.post('/update_profilepic', upload.single('profile_picture'), (req, res) => {
  const { email } = req.body;
  if (!req.file) {
    return res.status(400).json({ status: "Failed", message: "No image uploaded" });
  }

  // Update user's profile_picture in your user storage (JSON, DB, etc.)
  const users = readData('users.json');
  const userIndex = users.findIndex(u => u.email === email);
  if (userIndex === -1) {
    return res.status(404).json({ status: "Failed", message: "User not found" });
  }
  users[userIndex].profile_picture = req.file.filename;
  fs.writeFileSync('./data/users.json', JSON.stringify(users, null, 2));

  res.json({ status: "Success", profile_picture: req.file.filename });
});

app.post('/add_feedback', (req, res) => {
  // Handle feedback saving here (to a JSON file, database, etc.)
  res.json({ status: "success" });
});

app.post('/addto_wishlist', express.json(), (req, res) => {
  const { email, listing_id } = req.body;
  let wishlist = readData('wishlist.json');
  // Check if already in wishlist
  if (wishlist.some(item => item.email === email && item.listing_id == listing_id)) {
    return res.json({ status: "already_exists" });
  }
  wishlist.push({ email, listing_id });
  fs.writeFileSync(path.join(__dirname, 'data', 'wishlist.json'), JSON.stringify(wishlist, null, 2));
  res.json({ status: "success" });
});

app.post('/removefrom_wishlist', express.json(), (req, res) => {
  const { email, listing_id } = req.body;
  let wishlist = readData('wishlist.json');
  const newWishlist = wishlist.filter(item => !(item.email === email && item.listing_id == listing_id));
  fs.writeFileSync(path.join(__dirname, 'data', 'wishlist.json'), JSON.stringify(newWishlist, null, 2));
  res.json({ status: "success" });
});

// Path: (add this near your other app.post routes)

app.post('/make_reservations', express.urlencoded({extended: true}), (req, res) => {
  const {
    hotel_email,
    customer_email,
    hotel_name,
    check_in_date,
    check_out_date,
    duration,
    adults,
    childrens,
    rooms,
    totalprice,
    paymentmode
  } = req.body;

  // Load existing reservations
  let reservations = readData('reservations.json');

  // If you want to check for existing bookings by customer & hotel:
  const alreadyBooked = reservations.some(r =>
    r.hotel_email === hotel_email &&
    r.customer_email === customer_email &&
    r.check_in_date === check_in_date &&
    r.check_out_date === check_out_date
  );
  if (alreadyBooked) {
    return res.send("Booked");
  }

  // Build new reservation object
  const newReservation = {
    id: (reservations.length + 1).toString(),
    hotel_email,
    customer_email,
    hotel_name,
    check_in_date,
    check_out_date,
    duration,
    adults,
    childrens,
    rooms,
    totalprice,
    paymentmode
  };

  // Save to file
  reservations.push(newReservation);
  fs.writeFileSync(path.join(__dirname, 'data', 'reservations.json'), JSON.stringify(reservations, null, 2));

  // Respond to client
  res.send("Success");
});