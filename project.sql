create database project;

create table customer(Cust_ID int primary key, Cust_first_name varchar(20),Cust_last_name varchar(20), Cust_address varchar(50), Cust_email varchar(20), Cust_Phone bigint); 
insert into customer values(1,'Rajiv','Malhotra','Kolkata,lane 5', 'rajjiv5@gmail.com',9185641234); 
insert into customer values(2,'Rahul','Mahajan','Mumbai,lane 2', 'rahul@gmail.com',9845313558); 
insert into customer values(3,'Mansi','Khanvilkar','Pune, plot 4 ', 'manu@gmail.com',9489651232); 
insert into customer values(4,'Angela','Jones','delhi,lane 6', 'angie@gmail.com',9856445521); 
insert into customer values(5,'Kajol','Gupta','Haryana,plot 1', 'kajol02@gmail.com',9479362456); 

create table order_delivery(cust_ID int, delivery_address varchar(50),order_ID int);

DELIMITER $$   
CREATE TRIGGER trigger_n AFTER INSERT  
ON customer FOR EACH ROW  
BEGIN  
	insert into order_delivery values(new.Cust_ID, new.Cust_address,new.Cust_ID);
END$$  
DELIMITER ; 

select * from order_delivery;


create table Pizza(Pizza_ID int, PizzaName char(25),PizzaDescription varchar(100),Cost int); 
create table pizza_order(order_time time, PizzaID int, PizzaName char(25) ,Cost int);

DELIMITER $$   
CREATE TRIGGER trigger_new AFTER INSERT  
ON Pizza FOR EACH ROW  
BEGIN  
	insert into pizza_order (order_time, PizzaID, PizzaName, Cost) values(CURTIME(), new.Pizza_ID , new.PizzaName,new.Cost);
END$$  
DELIMITER ;  

insert INTO Pizza values(1,'Chicken Golden Delight','Barbeque chicken with a topping of golden corn loaded with extra cheese.',250);
insert INTO Pizza values(2,'Non Veg Supreme','Black Olives, Onions,Mushrooms, Pepper BBQ Chicken, Peri-Peri Chicken',400);
insert INTO Pizza values(3,'Mexican Green Wave','Loaded with onions,capsicum,tomatoes and jalapeno with Mexican herbs.',200);
insert INTO Pizza values(4,'Peppy Paneer','Chunky paneer with crisp capsicum and spicy red pepper - quite a mouthful!',300);
insert INTO Pizza values(5,'Veg Extravaganza','Corn,black olives,onions,capsicum,mushrooms,tomatoes,jalapeno with cheese.',400);

select * from pizza_order;

select * from order_delivery,pizza_order order by cust_ID;
create table ORDER_INFO as select * from order_delivery,pizza_order order by cust_ID; 
select * from ORDER_INFO;


create table payment(payID int auto_increment, paytime time, paymode varchar(25) not null, oid int,PRIMARY KEY(payID),
					FOREIGN KEY(oid)  references customer(Cust_ID));
                    
insert into payment (paytime,paymode,oid) values (curtime(),'GPAY',1);
insert into payment (paytime,paymode,oid) values (curtime(),'COD',2);
insert into payment (paytime,paymode,oid) values (curtime(),'UPI',3);
insert into payment (paytime,paymode,oid) values (curtime(),'CARD',4);
insert into payment (paytime,paymode,oid) values (curtime(),'PAYTM',5);

select * from payment;                  
                     
create table delivery_boy(db_id int, db_name varchar(50), db_phone bigint not null,
			 delivery_Start_time time,delivery_End_time time,Remarks varchar(50),UNIQUE(db_phone),PRIMARY KEY(db_id));
             
             
insert into delivery_boy (db_id,db_name,db_phone,delivery_Start_time,delivery_End_time) values(1,'Manish',9978324567,'12:16','12:31');
insert into delivery_boy(db_id,db_name,db_phone,delivery_Start_time,delivery_End_time) values(2,'Suraj',9968324567,'14:13','14:33');
insert into delivery_boy (db_id,db_name,db_phone,delivery_Start_time,delivery_End_time)values(3,'Suyash',9478324567,'17:54','18:12');
insert into delivery_boy(db_id,db_name,db_phone,delivery_Start_time,delivery_End_time) values(4,'Sanjay',9978324167,'12:40','13:00');
insert into delivery_boy(db_id,db_name,db_phone,delivery_Start_time,delivery_End_time) values(5,'Sanath',9978314567,'10:06','10:41');

select * from delivery_boy;
select * from order_delivery,delivery_boy where Cust_ID=db_id;
 
 
delimiter $$
CREATE trigger  delivery BEFORE INSERT ON delivery_boy
       FOR EACH ROW
       BEGIN
           IF timediff(new.delivery_End_time,NEW.delivery_Start_time)<'00:30:00' THEN SET NEW.Remarks = 'ON-TIME delivery';
           ELSE SET NEW.Remarks='Late delivery';
           END IF;
       END$$;
 delimiter ;
 
 
create table Toppings(ToppingID int,ToppingName char(25),Cost int); 
insert INTO Toppings values(1,'Mushrooms',20);
insert INTO Toppings values(2,'Onions',30);
insert INTO Toppings values(3,'Peppers',40);
insert INTO Toppings values(4,'Chicken',50);
insert INTO Toppings values(5,'Pineapple',35);

select *from Toppings;
select * from Pizza,Toppings where Pizza_ID=ToppingID;

drop table Pizza;
drop table pizza_order;
drop table order_delivery;
drop table customer;
drop table payment; 
drop table ORDER_INFO;
drop table delivery_boy;
drop table toppings;
