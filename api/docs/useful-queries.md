Query to update the current position of a product (its inventory, actually) based on all the movements.

```sql
with sum_of_movements as (
    select im.inventory_id, sum(im.amount) amount
        from inventory_movement im
        group by im.inventory_id
)
update inventory i
set current_position = sum_of_movements.amount
from sum_of_movements
where sum_of_movements.inventory_id  = i.id;
```

Random dates for sale_orders:

```sql
with random_date as (
    select id, timestamp '2020-07-01 20:00:00' + random() * (timestamp '2020-08-04 20:00:00' - timestamp '2020-07-01 10:00:00') as date from sale_order
)
update sale_order s
set creation_date = random_date.date
from random_date
where random_date.id  = s.id;
```