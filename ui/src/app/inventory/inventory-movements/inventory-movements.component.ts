import { Component, OnInit } from '@angular/core';
import { Inventory } from '../inventory.entity';
import { ActivatedRoute } from '@angular/router';
import { InventoryService } from '../inventory.service';

@Component({
  selector: 'app-inventory-movements',
  templateUrl: './inventory-movements.component.html',
  styleUrls: ['./inventory-movements.component.scss'],
})
export class InventoryMovementsComponent implements OnInit {
  loading: boolean = true;
  inventory: Inventory;

  constructor(private route: ActivatedRoute, private inventoryService: InventoryService) {}

  ngOnInit(): void {
    const id = this.route.snapshot.params.id;

    this.inventoryService.loadInventory(id).subscribe((inventory) => {
      this.inventory = inventory;
      this.loading = false;
    });
  }
}
