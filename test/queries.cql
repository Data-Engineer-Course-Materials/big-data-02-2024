create keyspace my_keyspace
    with replication = {
        'class': 'SimpleStrategy',
        'replication_factor': 1
        };

create table if not exists my_keyspace.user(
                                               first_name text,
                                               second_name text,
                                               PRIMARY KEY ( first_name, second_name )
);

insert into my_keyspace.user(first_name, second_name) values('Steve', 'Jobs');
insert into my_keyspace.user(first_name, second_name) values('Bill', 'Gates');

delete second_name from my_keyspace.user where first_name = 'Steve';

alter table my_keyspace.user add (
    phone text
    );

update my_keyspace.user set phone = '123' where first_name = 'Steve' and second_name = 'Jobs';
insert into my_keyspace.user(first_name, second_name) values('Bill', 'Gates');

delete phone from my_keyspace.user where first_name = 'Steve' and second_name = 'Jobs';

delete from my_keyspace.user where first_name = 'Steve';

CREATE TYPE my_keyspace.address (
                                    street text,
                                    city text,
                                    state text,
                                    zip_code int);


alter table my_keyspace.user add (
    addresses2 map<text, frozen<map<text, text>>>
    );

update my_keyspace.user
set addresses2 = addresses2 + {'home': {'street': 'Lenina','city':'Moscow','state':'Moscow','zip_code':'700000'}}
where first_name = 'Bill' and second_name = 'Gates';

