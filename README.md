## Overview

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will be able to get "shipped" by an admin. Each user role will have access to some or all CRUD functionality for application models.

## Bulk Discount Project


### General Goals

Merchants add bulk discount rates for all of their inventory. These apply automatically in the shopping cart, and adjust the order_items price upon checkout.

### Project Criteria

1. Merchants need full CRUD functionality on bulk discounts, and will be accessed a link on the merchant's dashboard.

2. You will implement a percentage based discount:
5% discount on 20 or more items

3. A merchant can have multiple bulk discounts in the system.

4. When a user adds enough value or quantity of a single item to their cart, the bulk discount will automatically show up on the cart page.

5. A bulk discount from one merchant will only affect items from that merchant in the cart.

6. A bulk discount will only apply to items which exceed the minimum quantity specified in the bulk discount. (eg, a 5% off 5 items or more does not activate if a user is buying 1 quantity of 5 different items; if they raise the quantity of one item to 5, then the bulk discount is only applied to that one item, not all of the others as well)

7. When there is a conflict between two discounts, the greater of the two will be applied.

8. Final discounted prices should appear on the orders show page.

## Instructions

For usage on your local machine follow the instructions listed below:

```
git clone git@github.com:BJSherman80/monster_shop_2005.git
```
```
cd monster_shop_2005
```
```
bundle install
```
```
rake db:{drop,create,migrate,seed}
```
```
rails server
```

## Heroku Link

[Monster Discount](https://monster-final-dfl.herokuapp.com/registration)
