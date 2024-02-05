DELETE FROM book;
ALTER TABLE book AUTO_INCREMENT = 1001;

DELETE FROM category;
ALTER TABLE category AUTO_INCREMENT = 1001;

INSERT INTO `category` (`name`) VALUES ('Best Sellers'),('Classics'),('Romance'),('Science Fiction'),('Mystery-Thriller'),('Fantasy'),('Horror'),('History');

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('2AM Thoughts', 'Makenzie Campbell', '', 1119, 0, TRUE, FALSE, 1001);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Pearl', 'John Steinbeck', '', 1059, 0, TRUE, FALSE, 1001);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Last Train To Istanbul', 'Ayse Kulin', '', 1099, 0, TRUE, FALSE, 1001);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('For Whom the Bell Tolls', 'Makenzie Campbell', '', 1239, 0, TRUE, FALSE, 1001);

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Book Thief', 'Markus Zusak', '', 4, 0, TRUE, FALSE, 1002);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Outsiders', 'S E Hinton', '', 5, 0, TRUE, FALSE, 1002);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Lord of the Files', 'William Golding', '', 148, 0, TRUE, FALSE, 1002);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The One and Only Ruby', 'Katherine Applegate', '', 1413, 0, TRUE, FALSE, 1002);

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('A Court of Thorns and Roses', 'Sarah J Maas', '', 1177, 0, TRUE, FALSE, 1003);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Twisted Love', 'Ana Huang', '', 125, 0, TRUE, FALSE, 1003);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Things We Never Got Over', 'Lucy Score', '', 789, 0, TRUE, FALSE, 1003);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Ugly Love', 'Colleen Hoover', '', 3, 0, TRUE, FALSE, 1003);

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Imagine Me', 'Tahereh Mafi', '', 888, 0, TRUE, FALSE, 1004);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Martian', 'Andy Weir', '', 705, 0, TRUE, FALSE, 1004);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Dune', 'Frank Herbert', '', 713, 0, TRUE, FALSE, 1004);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Midnight Library', 'Matt Haig', '', 9, 0, TRUE, FALSE, 1004);

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('All In', 'Jennifer Lynn Barnes', '', 918, 0, TRUE, FALSE, 1005);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('We Were Liars', 'E Lockhart', '', 79, 0, TRUE, FALSE, 1005);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Escape Room', 'Maren Stoffels', '', 459, 0, TRUE, FALSE, 1005);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Fear', 'Natasha Preston', '', 693, 0, TRUE, FALSE, 1005);

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The City of Ember', 'Jeanne DuPrau', '', 399, 0, TRUE, FALSE, 1006);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Amari and the Night Brothers', 'B B Alston', '', 678, 0, TRUE, FALSE, 1006);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('A Wrinkle in Time', 'Madeleine L''Engle', '', 268, 0, TRUE, FALSE, 1006);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Girl Who Drank the Moon', 'Kelly Barnhill', '', 675, 0, TRUE, FALSE, 1006);

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Body', 'Stephen King', '', 798, 0, TRUE, FALSE, 1007);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Home Before Dark', 'Riley Sager', '', 1179, 0, TRUE, FALSE, 1007);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Does It Hurt', 'H D Carlton', '', 1529, 0, TRUE, FALSE, 1007);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Run on Red', 'Noelle W Ihli', '', 1131, 0, TRUE, FALSE, 1007);

INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Spare', 'Prince Harry the Duke of Sussex', '', 2443, 0, TRUE, FALSE, 1008);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('Night', 'Elie Wiesel', '', 792, 0, TRUE, FALSE, 1008);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Art of War', 'Sun Tzu', '', 109, 0, TRUE, FALSE, 1008);
INSERT INTO `book` (title, author, description, price, rating, is_public, is_featured, category_id) VALUES ('The Trial of the Century', 'Gregg Jarrett, Don Yaeger', '', 2069, 0, TRUE, FALSE, 1008);

