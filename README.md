# Enote Store - Stationery Inventory Management System

Enote Store is a comprehensive **ASP.NET Web Forms** application built for managing a stationery inventory system. It features a complete two-sided architecture consisting of a secure **Admin Panel** for inventory management and a modern **Customer Storefront** for browsing and purchasing premium stationery items.

## Technologies Used
- **Backend**: C# with ASP.NET Web Forms (.NET Framework)
- **Database**: Microsoft SQL Server (ADO.NET SqlClient)
- **Frontend**: HTML5, CSS3, JavaScript, jQuery, and Bootstrap 4
- **Architecture**: Role-Based Access Control (Admin vs. User), Master/Content Page structures

## Key Features

### User/Customer Side
- **Authentication**: Secure User Registration and Login.
- **Storefront**: Dynamic Home Page offering categorized grid layouts and featured stationery products with uniform image sizing constraints.
- **Shop Catalog `Shop.aspx`**: Browse products dynamically pulled from the database. Includes real-time search, price filtering, and latest/price sorting.
- **Product Details `ShopDetail.aspx`**: Carousel views and detailed attributes of products along with direct "Add to Cart" integration.
- **Shopping Cart `Cart.aspx`**: Session-managed cart pulling directly from the `Cart` database table natively calculating subtotals.
- **Checkout Flow `Checkout.aspx`**: Robust checkout module that captures delivery information, pushes transaction logs into the `Payment` table, safely populates the `Orders` database log with unique Order IDs, and dynamically clears the user's cart upon success via native Bootstrap modals.
- **Contact Us**: Directly pipes customer service requests to the database backend.

### Admin Panel
- **Role-Based Authorization**: Master pages strictly enforce access control to limit inventory actions exclusively to assigned `Admin` profiles.
- **Analytics Dashboard**: Aggregates real-time business statistics dynamically via SQL (Total Customers, Total Products, Total Orders, Total Revenue) on page load.
- **Categories & Subcategories**: Full CRUD operations for creating product categories with dependent, dynamically-binding dropdowns for Subcategories.
- **Product Management**: Robust interface to Add/Edit/Delete stationery products including managed Image Uploads stored securely within the file system (`/Images/Product/`) and tracked in the DB.

## Database Schema (Key Tables)
The system relies on an integrated relational SQL Server Database featuring:
- `Users` / `Roles` - Managing credential storage and authorization access limits.
- `Category` / `SubCategory` - Hierarchical tagging constraints for stationery classification.
- `Product` - Defines product details, price, descriptions, and linked image schemas.
- `Cart` - Ephemeral storage tracking user session quantities prior to purchase.
- `Payment` - Tracks captured checkout details.
- `Orders` - Long-term invoice transaction logs tying `Product`, `User`, and `Payment` datasets.
- `Contact` - Stores incoming customer messages.

## Setup & Installation

1. **Prerequisites**: Ensure you have Visual Studio (2019/2022) with "ASP.NET and web development" workloads installed, along with local SQL Server Setup (SQL Server Express / SSMS).
2. **Clone / Download**: Download the repository locally into your desired workspace directory.
3. **Database Configuration**:
   - Locate your database SQL script (`SQLQuery3.sql` or similar).
   - Execute the schema queries into your local SQL instance to initialize tables.
   - Update the ADO.NET Connection String located in your `Utils.cs` or `Web.config` files corresponding to your local Data Source block.
4. **Build the Project**: Open `Stationery_Inventory.sln` inside Visual Studio. Clean and Rebuild the solution. 
5. **Run Locally**: Press `IIS Express (F5)` or hit start inside Visual Studio to deploy the framework to your local browser environment.

## Design Decisions & Improvements
- Native browser `alert()` pop-ups have been refactored and replaced throughout the user experience with center-screen animated Bootstrap Modals via jQuery for a significantly more premium shopping experience.
- The UI heavily adopts uniform visual grids leveraging native CSS (`object-fit: cover`) bounds meaning the Admin holds zero responsibility for pre-cropping upload images perfectly. All user panels will automatically adapt asymmetrical photography seamlessly.

---
*Developed by Dhruvi @2026 for the Enote project.*