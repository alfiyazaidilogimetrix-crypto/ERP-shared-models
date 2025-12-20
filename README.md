# erp-shared-models

This is a shared library containing the Prisma database connection and Zod schemas for the project microservices.

## Dependencies

- **Runtime**: Bun
- **Database**: PostgreSQL (via Prisma)

## Setup

1. **Install Dependencies**:
   ```sh
   bun install
   ```
2. **Setup Environment**:
   Ensure you have a `.env` file with `DATABASE_URL`.
   ```sh
   DATABASE_URL="postgresql://user:password@localhost:5432/mydb"
   ```
3. **Generate Client**:
   ```sh
   bun db:generate
   ```

## Usage in Other Services

To use this package in another service (e.g., specific microservice), you can install it relative to its path or strictly as a workspace dependency.

### Method 1: Local Path Installation (Recommended for Monorepos/Local Dev)

In your consuming service directory:

```sh
bun add "file:../path/to/erp-shared-models"
```
*Replace `../path/to/erp-shared-models` with the actual relative path.*

### Method 2: Bun Link

1. In this `erp-shared-models` directory:
   ```sh
   bun link
   ```
2. In your consuming service directory:
   ```sh
   bun link erp-shared-models
   ```

### Importing

Once installed, you can import the Prisma client and schemas:

```typescript
import { prisma, userRegisterSchema } from "erp-shared-models"; 

// Use Prisma
const user = await prisma.user.findFirst();

// Use Schemas
const result = userRegisterSchema.safeParse(inputData);
```

## Available Scripts

- `bun db:generate`: Regenerate the Prisma client.
- `bun db:migrate:dev`: Run migrations (use this carefully from a central place).
- `bun db:push`: Push schema changes to DB without history.
- `bun db:studio`: Open Prisma Studio.

