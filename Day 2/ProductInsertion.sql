INSERT INTO Products (product_name, category, base_price, current_price, stock_quantity, min_stock_threshold)
VALUES 
-- ==========================================
-- 1. DAIRY & BREAD (15 Items)
-- ==========================================
('Amul Taaza Toned Fresh Milk 500ml', 'Dairy', 28.00, 28.00, 120, 20),
('Amul Gold Full Cream Milk 500ml', 'Dairy', 34.00, 34.00, 100, 15),
('Amul Salted Butter 100g', 'Dairy', 60.00, 60.00, 80, 15),
('Amul Pasteurised Butter 500g', 'Dairy', 275.00, 275.00, 40, 10),
('Amul Malai Paneer 200g', 'Dairy', 95.00, 95.00, 60, 12),
('Mother Dairy Classic Dahi 400g', 'Dairy', 50.00, 50.00, 75, 15),
('Amul Masti Spiced Chaach 200ml', 'Dairy', 15.00, 15.00, 150, 25),
('Amul Cheese Slices 200g (10 Slices)', 'Dairy', 140.00, 140.00, 50, 10),
('Britannia White Sandwich Bread 400g', 'Bakery', 45.00, 45.00, 90, 15),
('Modern 100% Whole Wheat Bread 400g', 'Bakery', 65.00, 65.00, 70, 10),
('Britannia Brown Bread 400g', 'Bakery', 55.00, 55.00, 60, 10),
('Amul Fresh Cream 250ml', 'Dairy', 67.00, 67.00, 45, 8),
('Epigamia Greek Yogurt Strawberry 85g', 'Dairy', 60.00, 60.00, 30, 5),
('Amul Unsalted Butter 200g', 'Dairy', 120.00, 120.00, 35, 8),
('Milky Mist Paneer 200g', 'Dairy', 105.00, 105.00, 50, 10),

-- ==========================================
-- 2. BEVERAGES & COLD DRINKS (15 Items)
-- ==========================================
('Coca-Cola Original Taste 750ml', 'Beverages', 40.00, 40.00, 110, 20),
('Thums Up Soft Drink 750ml', 'Beverages', 40.00, 40.00, 120, 20),
('Sprite Aerated Drink 750ml', 'Beverages', 40.00, 40.00, 90, 15),
('Real Fruit Power Orange Juice 1L', 'Beverages', 130.00, 130.00, 50, 10),
('Tropicana 100% Mixed Fruit Juice 1L', 'Beverages', 145.00, 145.00, 45, 8),
('Red Bull Energy Drink 250ml', 'Beverages', 125.00, 125.00, 80, 15),
('Monster Energy Drink 350ml', 'Beverages', 110.00, 110.00, 60, 10),
('Nescafe Classic Instant Coffee 50g', 'Beverages', 185.00, 185.00, 70, 12),
('Tata Tea Gold Premium Black Tea 500g', 'Beverages', 310.00, 310.00, 50, 10),
('Society Tea Powder 250g', 'Beverages', 155.00, 155.00, 40, 8),
('Bisleri Packaged Drinking Water 1L', 'Beverages', 20.00, 20.00, 200, 30),
('Paper Boat Aamras Mango Juice 200ml', 'Beverages', 35.00, 35.00, 100, 20),
('Paper Boat Anardana Juice 200ml', 'Beverages', 35.00, 35.00, 80, 15),
('Bournvita Chocolate Health Drink 500g', 'Beverages', 240.00, 240.00, 40, 8),
('Horlicks Classic Malt Health Drink 500g', 'Beverages', 260.00, 260.00, 35, 8),

-- ==========================================
-- 3. PACKAGED SNACKS & MUNCHIES (15 Items)
-- ==========================================
('Lay''s India''s Magic Masala Chips 50g', 'Snacks', 20.00, 20.00, 180, 25),
('Lay''s Cream & Onion Chips 50g', 'Snacks', 20.00, 20.00, 160, 25),
('Kurkure Masala Munch 85g', 'Snacks', 20.00, 20.00, 150, 20),
('Doritos Cheese Nachos 60g', 'Snacks', 30.00, 30.00, 90, 15),
('Pringles Original Potato Chips 107g', 'Snacks', 115.00, 115.00, 50, 10),
('Haldiram''s Nagpur Bhujia Sev 150g', 'Snacks', 55.00, 55.00, 110, 15),
('Haldiram''s All in One Namkeen 200g', 'Snacks', 68.00, 68.00, 85, 12),
('Britannia Good Day Cashew Biscuits 120g', 'Snacks', 30.00, 30.00, 130, 20),
('Parle-G Gold Biscuits 1kg', 'Snacks', 140.00, 140.00, 60, 10),
('Oreo Chocolate Cream Biscuits 120g', 'Snacks', 40.00, 40.00, 100, 15),
('Cadbury Dairy Milk Silk 60g', 'Snacks', 80.00, 80.00, 90, 15),
('KitKat 4 Finger Chocolate 38g', 'Snacks', 30.00, 30.00, 140, 20),
('Snickers Peanut Chocolate Bar 45g', 'Snacks', 50.00, 50.00, 100, 15),
('Haldiram''s Soan Papdi 250g', 'Snacks', 90.00, 90.00, 40, 8),
('Act II Instant Popcorn Butter 60g', 'Snacks', 20.00, 20.00, 120, 20),

-- ==========================================
-- 4. INSTANT FOOD & NOODLES (10 Items)
-- ==========================================
('Maggi 2-Minute Masala Noodles 280g ( Pack of 4 )', 'Instant Food', 56.00, 56.00, 150, 25),
('Yippee! Magic Masala Noodles 240g', 'Instant Food', 48.00, 48.00, 100, 15),
('Knorr Cup-a-Soup Tomato 26g', 'Instant Food', 35.00, 35.00, 80, 12),
('Top Ramen Curry Noodles 280g', 'Instant Food', 60.00, 60.00, 70, 10),
('Bambino Roasted Vermicelli 400g', 'Instant Food', 45.00, 45.00, 60, 10),
('MTR Instant Khatta Dhokla Mix 200g', 'Instant Food', 75.00, 75.00, 40, 8),
('Gits Rava Dosa Instant Mix 200g', 'Instant Food', 80.00, 80.00, 35, 8),
('Knorr Chinese Schezwan Noodle 240g', 'Instant Food', 55.00, 55.00, 60, 10),
('Maggi Oats Masala Noodles 290g', 'Instant Food', 100.00, 100.00, 50, 10),
('MTR Instant Idli Mix 500g', 'Instant Food', 135.00, 135.00, 45, 8),

-- ==========================================
-- 5. PANTRY STAPLES & OILS (15 Items)
-- ==========================================
('Aashirvaad Shuddh Chakki Atta 5kg', 'Pantry', 245.00, 245.00, 60, 10),
('Fortune Sunlite Sunflower Oil 1L', 'Pantry', 145.00, 145.00, 80, 15),
('Fortune Kachi Ghani Mustard Oil 1L', 'Pantry', 160.00, 160.00, 70, 12),
('Tata Salt Vacuum Evaporated 1kg', 'Pantry', 28.00, 28.00, 150, 25),
('Madhur Pure & Hygienic Sugar 1kg', 'Pantry', 55.00, 55.00, 100, 20),
('Daawat Rozana Super Basmati Rice 5kg', 'Pantry', 380.00, 380.00, 40, 8),
('Fortune Unpolished Toor Dal 1kg', 'Pantry', 165.00, 165.00, 65, 10),
('Tata Sampann Moong Dal Split 500g', 'Pantry', 75.00, 75.00, 50, 10),
('Catch Red Chilli Powder 100g', 'Pantry', 52.00, 52.00, 90, 15),
('Catch Turmeric Powder 100g', 'Pantry', 38.00, 38.00, 90, 15),
('MDH Everest Garam Masala 100g', 'Pantry', 98.00, 98.00, 80, 12),
('Amul Pure Cow Ghee 500ml', 'Pantry', 325.00, 325.00, 45, 8),
('Saffola Gold Blended Edible Oil 1L', 'Pantry', 170.00, 170.00, 55, 10),
('Everest Chhole Masala 100g', 'Pantry', 82.00, 82.00, 70, 10),
('Catch Cumin Seeds (Jeera) 100g', 'Pantry', 85.00, 85.00, 60, 10),

-- ==========================================
-- 6. FRESH PRODUCE (FRUITS & VEG) (15 Items)
-- ==========================================
('Fresh Hybrid Tomato 1kg', 'Produce', 38.00, 38.00, 90, 15),
('Fresh Potato (Aloo) 1kg', 'Produce', 32.00, 32.00, 120, 20),
('Fresh Red Onion (Pyaz) 1kg', 'Produce', 42.00, 42.00, 110, 20),
('Fresh Robusta Banana 1 Dozen', 'Produce', 60.00, 60.00, 50, 10),
('Fresh Shimla Apple 1kg', 'Produce', 180.00, 180.00, 35, 8),
('Fresh Green Capsicum 250g', 'Produce', 25.00, 25.00, 60, 10),
('Fresh Coriander Bunch (Dhaniya) 100g', 'Produce', 18.00, 18.00, 70, 15),
('Fresh Lemon (Nimbu) 250g', 'Produce', 35.00, 35.00, 65, 10),
('Fresh Green Chilli 100g', 'Produce', 15.00, 15.00, 80, 15),
('Fresh Garlic (Lahsun) 200g', 'Produce', 50.00, 50.00, 55, 10),
('Fresh Ginger (Adrak) 200g', 'Produce', 40.00, 40.00, 60, 10),
('Fresh Hybrid Cucumber 500g', 'Produce', 28.00, 28.00, 50, 10),
('Fresh Pomegranate (Anar) 500g', 'Produce', 120.00, 120.00, 30, 5),
('Fresh Orange 1kg', 'Produce', 90.00, 90.00, 40, 8),
('Fresh Tender Coconut 1 Piece', 'Produce', 55.00, 55.00, 45, 8),

-- ==========================================
-- 7. PERSONAL CARE & HYGIENE (10 Items)
-- ==========================================
('Dettol Original Bathing Soap 125g ( Pack of 3 )', 'Personal Care', 155.00, 155.00, 60, 10),
('Dove Cream Beauty Bathing Bar 100g', 'Personal Care', 72.00, 72.00, 80, 12),
('Colgate Strong Teeth Toothpaste 200g', 'Personal Care', 110.00, 110.00, 90, 15),
('Sensodyne Rapid Relief Toothpaste 80g', 'Personal Care', 210.00, 210.00, 40, 8),
('Head & Shoulders Smooth & Silky Shampoo 180ml', 'Personal Care', 190.00, 190.00, 50, 10),
('Clinic Plus Strong & Long Shampoo 340ml', 'Personal Care', 215.00, 215.00, 45, 8),
('Nivea Soft Light Moisturizing Cream 100ml', 'Personal Care', 220.00, 220.00, 35, 8),
('Dettol Antiseptic Liquid 250ml', 'Personal Care', 130.00, 130.00, 50, 10),
('Wild Stone Edge Pocket Perfume 18ml', 'Personal Care', 70.00, 70.00, 60, 10),
('Whisper Choice Ultra Wings Sanitary Pads (12 Packs)', 'Personal Care', 115.00, 115.00, 70, 12),

-- ==========================================
-- 8. HOUSEHOLD & CLEANING (5 Items)
-- ==========================================
('Vim Dishwash Gel Lemon 250ml', 'Household', 62.00, 62.00, 85, 12),
('Surf Excel Easy Wash Detergent Powder 1kg', 'Household', 140.00, 140.00, 70, 10),
('Colin Glass and Surface Cleaner 500ml', 'Household', 110.00, 110.00, 40, 8),
('Harpic Power Plus Toilet Cleaner 500ml', 'Household', 105.00, 105.00, 60, 10),
('Goodknight Gold Flash Mosquito Repellent Refill 45ml', 'Household', 85.00, 85.00, 75, 12);
GO
