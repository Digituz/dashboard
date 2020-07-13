# Creating New Features

Creating new features involve a good number of different assets (files):

- New files to represent the entities (usually TypeScript classes)
- New files to define the services that support each entity
- New files to define the controllers (API endpoints) for each entity
- New files to define the SQL commands to migrate the database
- Changes to existing files like the `app.module.ts`

As such, a document like this one might help you visualize the work you have ahead of you.

## Summary

In this document, you will see examples talking about `sales-order`, which is a real-world feature that this project supports. In the following sections, summarized below, you will see the step by step required to build a similar feature module.

The sections that you will find here are:

- Creating the New Feature Module
- Defining Entities

## Creating the New Feature Module

To implement a new feature, the first thing you will have to do is to create the feature module that supports it:

```bash
nest g module sales-order
```

This command generates a directory called `sales-order` inside the `src` directory with a single file: `sales-order.module.ts`. Nothing much to see on that file now, but you will make changes to it soon.

## Defining Entities

Defining entities in this project resumes to creating TypeScript files that export classes (entities). To be able to persist these entities, you will also have to create migration files (that contain SQL instructions to create tables), but you will do this in the next section.

To create an entity, in this case a `SaleOrder` entity, you can create a file called `sale-order.entity.ts` inside the `sales-order` directory. Inside this file, you can add something like:

```typescript

```