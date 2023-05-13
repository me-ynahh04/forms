CREATE DATABASE IF NOT EXISTS `ynahDB`;
USE `ynahDB`;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_Order` (IN `c_id` INT, IN `o_date` INT, IN `o_total` INT, IN `items_table OrderItemsType` INT)   BEGIN
  INSERT INTO Orders (customer_id, order_date, total_price)
  VALUES (c_id, o_date, o_total);
  
  SET @last_order_id = LAST_INSERT_ID();
  
  INSERT INTO Order_Items (order_id, product_id, quantity, price)
  SELECT @last_order_id, product_id, quantity, price
  FROM items_table;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `Calculate_Total_Price` (`o_id` INT) RETURNS DECIMAL(10,0)  BEGIN
  DECLARE total_price DECIMAL(10, 2);
  
  SELECT SUM(quantity * price) INTO total_price
  FROM Order_Items
  WHERE order_id = o_id;
  
  RETURN total_price;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `phone_number`, `address`) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-1234', '123 Main St'),
(2, 'Jane', 'Doe', 'janedoe@example.com', '555-5678', '456 Maple Ave'),
(3, 'Bob', 'Smith', 'bobsmith@example.com', '555-2468', '789 Elm St'),
(4, 'Alice', 'Jones', 'alicejones@example.com', '555-1357', '321 Oak St'),
(5, 'David', 'Lee', 'davidlee@example.com', '555-3698', '555 Pine St'),
(6, 'Mary', 'Johnson', 'maryjohnson@example.com', '555-7890', '987 Cedar St'),
(7, 'Tom', 'Williams', 'tomwilliams@example.com', '555-3579', '654 Birch Ave'),
(8, 'Samantha', 'Smith', 'samanthasmith@example.com', '555-4680', '234 Elm St'),
(9, 'Mike', 'Brown', 'mikebrown@example.com', '555-2468', '456 Oak St'),
(10, 'Julia', 'Wilson', 'juliawilson@example.com', '555-7890', '789 Cedar St');

-- --------------------------------------------------------

--
-- Stand-in structure for view `customer_orders_view`
-- (See below for the actual view)
--
CREATE TABLE `customer_orders_view` (
`customer_id` int(11)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`email` varchar(100)
,`phone_number` varchar(20)
,`address` varchar(100)
,`order_id` int(11)
,`order_date` date
,`total_price` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `first_name`, `last_name`, `job_title`, `hire_date`, `salary`) VALUES
(1, 'John', 'Doe', 'Manager', '2020-01-01', '5000.00'),
(2, 'Jane', 'Doe', 'Supervisor', '2020-02-01', '4000.00'),
(3, 'Mark', 'Smith', 'Team Lead', '2020-03-01', '3500.00'),
(4, 'Emily', 'Davis', 'Developer', '2020-04-01', '3000.00'),
(5, 'David', 'Johnson', 'Developer', '2020-05-01', '3000.00'),
(6, 'Jessica', 'Garcia', 'Developer', '2020-06-01', '3000.00'),
(7, 'Michael', 'Brown', 'QA', '2020-07-01', '2500.00'),
(8, 'Ashley', 'Wilson', 'QA', '2020-08-01', '2500.00'),
(9, 'Chris', 'Jones', 'Intern', '2020-09-01', '2000.00'),
(10, 'Alex', 'Lee', 'Intern', '2020-10-01', '2000.00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_price`) VALUES
(1, 1, '2022-02-14', '85.50'),
(2, 2, '2022-02-12', '110.00'),
(3, 3, '2022-02-10', '32.75'),
(4, 4, '2022-02-09', '67.25'),
(5, 5, '2022-02-06', '48.00'),
(6, 6, '2022-02-05', '105.00'),
(7, 7, '2022-02-03', '78.50'),
(8, 8, '2022-02-02', '93.75'),
(9, 9, '2022-02-01', '62.00'),
(10, 10, '2022-01-30', '25.50');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 2, '20.00'),
(2, 1, 2, 1, '50.00'),
(3, 1, 3, 3, '10.00'),
(4, 2, 2, 2, '50.00'),
(5, 2, 4, 1, '100.00'),
(6, 2, 5, 1, '0.50'),
(7, 3, 3, 1, '10.00'),
(8, 3, 5, 2, '0.50'),
(9, 3, 6, 1, '15.00'),
(10, 4, 1, 1, '20.00');

--
-- Triggers `order_items`
--

-- Trigger to update the total price in the Orders Table after an Order_Items record is deleted.
-- The trigger will subtract the old quantity and price from the total price
DELIMITER $$
CREATE TRIGGER `trg_order_items_delete` AFTER DELETE ON `order_items` FOR EACH ROW BEGIN
    UPDATE Orders
    SET total_price = total_price - (OLD.quantity * OLD.price)
    WHERE order_id = OLD.order_id;
END
$$
DELIMITER ;

-- Trigger to update the total price in the Orders Table after an Order_Items record is inserted
-- This will add the quantity and price to the total price.
DELIMITER $$
CREATE TRIGGER `trg_order_items_insert` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
    UPDATE Orders
    SET total_price = total_price + (NEW.quantity * NEW.price)
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;

-- Trigger to update the total_price column in the Orders Table after an Order_Items record is updated
-- The trigger will subtract the old quantity and price from the total price and add the new quantity and price to the total price.
DELIMITER $$
CREATE TRIGGER `trg_order_items_update` AFTER UPDATE ON `order_items` FOR EACH ROW BEGIN
    UPDATE Orders
    SET total_price = total_price - (OLD.quantity * OLD.price) + (NEW.quantity * NEW.price)
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `order_items_view`
-- (See below for the actual view)
--
CREATE TABLE `order_items_view` (
`order_id` int(11)
,`product_id` int(11)
,`product_name` varchar(50)
,`quantity` int(11)
,`price` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category`, `description`, `price`) VALUES
(1, 'iPhone 12', 'Electronics', 'The latest iPhone model', '999.99'),
(2, 'Samsung Galaxy S21', 'Electronics', 'The latest Samsung Galaxy model', '799.99'),
(3, 'MacBook Pro', 'Electronics', 'A high-end laptop from Apple', '1499.99'),
(4, 'iPad', 'Electronics', 'A tablet computer from Apple', '499.99'),
(5, 'Nike Air Max', 'Footwear', 'A popular running shoe from Nike', '129.99'),
(6, 'Adidas Ultraboost', 'Footwear', 'A popular running shoe from Adidas', '139.99'),
(7, 'Levi', 'Clothing', 'A classic pair of jeans from Levi', '79.99'),
(8, 'Ralph Lauren Polo', 'Clothing', 'A popular polo shirt from Ralph Lauren', '49.99'),
(9, 'H&M T-shirt', 'Clothing', 'A basic T-shirt from H&M', '9.99'),
(10, 'Zara Dress', 'Clothing', 'A stylish dress from Zara', '59.99');

-- --------------------------------------------------------

--
-- Stand-in structure for view `products_by_category_view`
-- (See below for the actual view)
--
CREATE TABLE `products_by_category_view` (
`category` varchar(50)
,`num_products` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `customer_orders_view`
--
DROP TABLE IF EXISTS `customer_orders_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_orders_view`  AS SELECT `c`.`customer_id` AS `customer_id`, `c`.`first_name` AS `first_name`, `c`.`last_name` AS `last_name`, `c`.`email` AS `email`, `c`.`phone_number` AS `phone_number`, `c`.`address` AS `address`, `o`.`order_id` AS `order_id`, `o`.`order_date` AS `order_date`, `o`.`total_price` AS `total_price` FROM (`customers` `c` join `orders` `o` on(`c`.`customer_id` = `o`.`customer_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `order_items_view`
--
DROP TABLE IF EXISTS `order_items_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_items_view`  AS SELECT `o`.`order_id` AS `order_id`, `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `oi`.`quantity` AS `quantity`, `oi`.`price` AS `price` FROM ((`orders` `o` join `order_items` `oi` on(`o`.`order_id` = `oi`.`order_id`)) join `products` `p` on(`oi`.`product_id` = `p`.`product_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `products_by_category_view`
--
DROP TABLE IF EXISTS `products_by_category_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `products_by_category_view`  AS SELECT `products`.`category` AS `category`, count(0) AS `num_products` FROM `products` GROUP BY `products`.`category``category`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
