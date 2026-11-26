import 'dotenv/config';
import { prisma } from '../src/index';

const ALL_MODULES = [
  'Dashboard',
  'Project Operations',
  'Project',
  'Project Type',
  'Category',
  'Activity',
  'Material',
  'Material BOQ',
  'Workscope',
  'Machine',
  'Master Data',
  'Master Creation',
  'Resource Management',
  'Diesel Consumption',
  'Diesel Stock',
  'Diesel Supplier',
  'Diesel Inward',
  'Material Stock',
  'Vendor & Procurement',
  'Vendor',
  'PR',
  'PO',
  'GRN',
  'PR Approval',
  'Finance & Accounts',
  'Subcontractor',
  'Billing',
  'Labour Management',
  'Labour Attendance',
  'DPR',
  'Stock',
  'Warehouse',
  'Planning & Tracking',
  'Analytics & Insights',
  'Monitoring',
  'Geo Mapping',
  'Material Reconciliation',
  'Issue',
  'System Administration',
  'Module Management',
  'Permission Management',
  'Role Management',
  'User Management',
  'User',
  'Role',
  'Permission',
  'Module',
  'Company',
  'Role & Permissions',
  'Tender',
  'Inventory',
  'All'
];

async function createAdmin() {
  console.log('🔄 Connecting to database...');
  await prisma.$connect();
  console.log('✅ Connected to database.');

  // 1. Create or ensure all modules exist
  console.log('📦 Setting up modules...');
  const moduleRecords = [];
  for (const moduleName of ALL_MODULES) {
    let mod = await prisma.module.findFirst({
      where: { Name: moduleName },
    });
    if (!mod) {
      mod = await prisma.module.create({
        data: {
          Name: moduleName,
          description: `${moduleName} Module`,
        },
      });
    }
    moduleRecords.push(mod);
  }
  console.log(`✅ Ensured ${moduleRecords.length} modules.`);

  // 2. Create or find Admin permission with all actions
  console.log('🔐 Setting up permissions...');
  let adminPermission = await prisma.permission.findFirst({
    where: { title: 'Full Admin Access' },
    include: { modules: true },
  });

  if (!adminPermission) {
    adminPermission = await prisma.permission.create({
      data: {
        title: 'Full Admin Access',
        description: 'Complete create, read, update, delete permissions for all modules',
        action: ['create', 'read', 'update', 'delete'],
        modules: {
          connect: moduleRecords.map((m) => ({ id: m.id })),
        },
      },
      include: { modules: true },
    });
  } else {
    // Ensure all modules are connected
    adminPermission = await prisma.permission.update({
      where: { id: adminPermission.id },
      data: {
        modules: {
          set: moduleRecords.map((m) => ({ id: m.id })),
        },
      },
      include: { modules: true },
    });
  }
  console.log('✅ Admin permission ready.');

  // 3. Create or find Admin role
  console.log('👑 Setting up Admin role...');
  let adminRole = await prisma.role.findFirst({
    where: { name: 'ADMIN' },
    include: { permissions: true },
  });

  if (!adminRole) {
    adminRole = await prisma.role.create({
      data: {
        name: 'ADMIN',
        description: 'Administrator with full system privileges',
        permissions: {
          connect: [{ id: adminPermission.id }],
        },
      },
      include: { permissions: true },
    });
  } else {
    adminRole = await prisma.role.update({
      where: { id: adminRole.id },
      data: {
        permissions: {
          set: [{ id: adminPermission.id }],
        },
      },
      include: { permissions: true },
    });
  }
  console.log('✅ Admin role ready.');

  // 4. Create or update Admin User
  const adminEmail = process.env.ADMIN_EMAIL || 'admin@erp.com';
  const adminPassword = process.env.ADMIN_PASSWORD || 'Admin@123';
  const adminName = process.env.ADMIN_NAME || 'Super Admin';

  const hashedPassword = await Bun.password.hash(adminPassword, {
    algorithm: 'bcrypt',
    cost: 12,
  });

  const existingUser = await prisma.user.findUnique({
    where: { email: adminEmail },
  });

  let user;
  if (existingUser) {
    user = await prisma.user.update({
      where: { id: existingUser.id },
      data: {
        name: adminName,
        password: hashedPassword,
        original_password: adminPassword,
        emailVerified: true,
        roleId: adminRole.id,
      },
    });
    console.log(`✅ Admin user updated: ${adminEmail}`);
  } else {
    user = await prisma.user.create({
      data: {
        name: adminName,
        email: adminEmail,
        password: hashedPassword,
        original_password: adminPassword,
        emailVerified: true,
        roleId: adminRole.id,
      },
    });
    console.log(`✅ Admin user created: ${adminEmail}`);
  }

  console.log('\n=============================================');
  console.log('🎉 ADMIN CREDENTIALS CREATED SUCCESSFULLY:');
  console.log('---------------------------------------------');
  console.log(`Email:    ${adminEmail}`);
  console.log(`Password: ${adminPassword}`);
  console.log(`Role:     ADMIN`);
  console.log('=============================================\n');
}

createAdmin()
  .catch((err) => {
    console.error('❌ Error creating admin user:', err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
