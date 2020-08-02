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