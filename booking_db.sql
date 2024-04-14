create database smart_dashboard_db;
use smart_dashboard_db;

create table Permissions (
	permission_id int not null auto_increment,
    title varchar(255),
    description varchar(255),
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    primary key(permission_id)
);

create table Addresses (
	address_id int not null auto_increment,
    country varchar(255),
    city varchar(255),
    postal_code varchar(50),
    street varchar(255),
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    primary key(address_id)
);

create table Roles (
	role_id int not null auto_increment,
    title varchar(255),
    description varchar(255),
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    primary key(role_id)
);

create table Roles_permissions (
	role_permission_id int not null auto_increment,
    role_id int,
    permission_id int,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    primary key(role_permission_id),
    foreign key(role_id) references Roles(role_id),
    foreign key(permission_id) references Permissions(permission_id)
);

create table Users (
	user_id int not null auto_increment,
    role_id int,
    address_id int,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255),
    password varchar(255),
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    primary key(user_id),
    foreign key(role_id) references Roles(role_id),
    foreign key(address_id) references Addresses(address_id)
);

create table Rooms (
    room_id int not null auto_increment,
    name varchar(255),
    capacity int,
    air_quality float,
    noise_level float,
    building varchar(255),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    primary key(room_id)
);

create table Slots (
    slot_id int not null auto_increment,
    from_time timestamp,
    to_time timestamp,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    primary key(slot_id)
);

create table Rooms_slots (
    room_slot_id int not null auto_increment,
    room_id int,
    slot_id int,
    active bit default 1,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    primary key(room_slot_id),
    foreign key(room_id) references Rooms(room_id),
    foreign key(slot_id) references Slots(slot_id)
);

create table Reservations (
    reservation_id int not null auto_increment,
    room_id int,
    user_id int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    primary key(reservation_id),
    foreign key(room_id) references Rooms(room_id),
    foreign key(user_id) references Users(user_id)
);

insert into Permissions (title, description)
values
("view_room", "allows the user to view a room"),
("add_room", "allows the user to add a new room"),
("add_slots", "allows the user to add a new room"),
("remove_room", "allows the user to remove a room"),
("book_room", "allows the user to book a room");

insert into Roles (title, description) 
values 
("student", "basic permissions for student to manage their profiles and view booked rooms"),
("professor", "permissions to manage their profile and book rooms"),
("admin", "full permissions to allow admin user to manage their profile and rooms");

insert into Roles_permissions (role_id, permission_id) 
values 
(1, 1), (2, 1), (2, 5), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5);

insert into Rooms (name, capacity, air_quality, noise_level, building)
values
("S105", 40, 16.2, 19.3, "Stokes"),
("X24", 30, 17.5, 20.3, "Lonsdale"),
("Q29", 30, 17.5, 10.3, "DCU Business School"),
("H50", 40, 17.5, 40.3, "Nursing"),
("S108", 40, 10.5, 26.3, "Stokes"),
("Q70", 30, 13.5, 24.3, "DCU Business School"),
("Q78", 30, 12.5, 30.3, "DCU Business School");

insert into Slots (from_time, to_time)
values
("2024-04-15 10:00:00", "2024-04-15 12:00:00"), ("2024-04-15 12:00:00", "2024-04-15 14:00:00"),
("2024-04-15 14:00:00", "2024-04-15 16:00:00"), ("2024-04-15 16:00:00", "2024-04-15 18:00:00"),
("2024-04-16 10:00:00", "2024-04-16 12:00:00"), ("2024-04-16 12:00:00", "2024-04-16 14:00:00"),
("2024-04-16 14:00:00", "2024-04-16 16:00:00"), ("2024-04-16 16:00:00", "2024-04-16 18:00:00"),
("2024-04-17 10:00:00", "2024-04-17 12:00:00"), ("2024-04-17 12:00:00", "2024-04-17 14:00:00"),
("2024-04-17 14:00:00", "2024-04-17 16:00:00"), ("2024-04-17 16:00:00", "2024-04-17 17:00:00"),
("2024-04-18 10:00:00", "2024-04-18 12:00:00"), ("2024-04-18 12:00:00", "2024-04-18 14:00:00"),
("2024-04-18 14:00:00", "2024-04-18 16:00:00"), ("2024-04-18 16:00:00", "2024-04-18 17:00:00");

insert into Rooms_slots(room_id, slot_id)
values
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8),
(1, 9), (1, 10), (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8),
(2, 9), (2, 10), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8),
(3, 9), (3, 10), (3, 11), (3, 12), (3, 13), (3, 14), (3, 15), (3, 16),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8),
(4, 9), (4, 10), (4, 11), (4, 12), (4, 13), (4, 14), (4, 15), (4, 16),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8),
(5, 9), (5, 10), (5, 11), (5, 12), (5, 13), (5, 14), (5, 15), (5, 16),
(6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8),
(6, 9), (6, 10), (6, 11), (6, 12), (6, 13), (6, 14), (6, 15), (6, 16),
(7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7), (7, 8),
(7, 9), (7, 10), (7, 11), (7, 12), (7, 13), (7, 14), (7, 15), (7, 16);
