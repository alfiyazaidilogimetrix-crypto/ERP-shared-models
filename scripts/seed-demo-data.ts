import 'dotenv/config';
import { prisma } from '../src/index';

async function seedDemoData() {
  console.log('🔄 Seeding comprehensive construction data for Company #1...');
  
  const company = await prisma.company.findFirst();
  if (!company) {
    console.error('❌ No company found. Please run create-admin.ts first.');
    return;
  }
  const company_id = company.id;

  const adminUser = await prisma.user.findFirst({
    where: { email: 'admin@erp.com' }
  });
  const user_id = adminUser ? adminUser.id : 1;

  // 1. Units of Measurement
  console.log('📏 Setting up units of measurement...');
  const unitBag = await prisma.unit.upsert({
    where: { id: 1 },
    update: {},
    create: { name: 'Bags' }
  });
  const unitMT = await prisma.unit.upsert({
    where: { id: 2 },
    update: {},
    create: { name: 'Metric Ton (MT)' }
  });
  const unitCum = await prisma.unit.upsert({
    where: { id: 3 },
    update: {},
    create: { name: 'Cubic Meter (Cum)' }
  });

  // 2. Categories
  console.log('🏷️ Creating categories...');
  const catHighway = await prisma.category.upsert({
    where: { id: 1 },
    update: {},
    create: { name: 'Highway Pavement & Earthwork' }
  });
  const catStructures = await prisma.category.upsert({
    where: { id: 2 },
    update: {},
    create: { name: 'Bridges & Culverts' }
  });

  // 3. Materials
  console.log('🧱 Creating materials master...');
  let matCement = await prisma.material.findFirst({ where: { material_code: 'MAT-CEM-01' } });
  if (!matCement) {
    matCement = await prisma.material.create({
      data: {
        name: 'OPC 53 Grade Cement',
        material_code: 'MAT-CEM-01',
        unitId: unitBag.id,
      }
    });
  }

  let matSteel = await prisma.material.findFirst({ where: { material_code: 'MAT-STL-01' } });
  if (!matSteel) {
    matSteel = await prisma.material.create({
      data: {
        name: 'TMT Rebar Fe550D (16mm-32mm)',
        material_code: 'MAT-STL-01',
        unitId: unitMT.id,
      }
    });
  }

  let matAggregates = await prisma.material.findFirst({ where: { material_code: 'MAT-AGG-01' } });
  if (!matAggregates) {
    matAggregates = await prisma.material.create({
      data: {
        name: 'Crushed Stone Aggregate 20mm',
        material_code: 'MAT-AGG-01',
        unitId: unitCum.id,
      }
    });
  }

  let matBitumen = await prisma.material.findFirst({ where: { material_code: 'MAT-BIT-01' } });
  if (!matBitumen) {
    matBitumen = await prisma.material.create({
      data: {
        name: 'Bitumen VG-40 Grade',
        material_code: 'MAT-BIT-01',
        unitId: unitMT.id,
      }
    });
  }

  // 4. Warehouses
  console.log('🏭 Creating warehouses...');
  let warehouseMain = await prisma.warehouse.findFirst({
    where: { company_id, name: 'Central Yard & Batching Plant' }
  });
  if (!warehouseMain) {
    warehouseMain = await prisma.warehouse.create({
      data: {
        name: 'Central Yard & Batching Plant',
        pincode: '110001',
        state: 'Delhi',
        district: 'Central',
        company_id,
        address: 'Main Highway Camp, Km 18',
      }
    });
  }

  // 5. Projects
  console.log('🛣️ Creating infrastructure projects...');
  let project1 = await prisma.project.findFirst({ where: { project_code: 'NH48-EXP-P4' } });
  if (!project1) {
    project1 = await prisma.project.create({
      data: {
        project_name: 'NH-48 6-Lane Expressway Expansion (Pkg 04)',
        project_code: 'NH48-EXP-P4',
        budget: '450000000', // ₹45 Crore
        client: 'National Highways Authority of India (NHAI)',
        description: 'Widening of 4-lane corridor to 6-lane access-controlled highway including 2 major bridges and 6 vehicular underpasses.',
        progress: 42,
        status: 'IN_PROGRESS',
        start_date: new Date('2024-01-15'),
        end_date: new Date('2025-12-31'),
        total_length: '24.5 km',
        total_chainage: ['Ch. 00+000', 'Ch. 05+000', 'Ch. 12+500', 'Ch. 18+200', 'Ch. 24+500'],
        company_id,
        state: 'Haryana',
        district: 'Gurugram',
      }
    });
  }

  let project2 = await prisma.project.findFirst({ where: { project_code: 'UEC-SEC62' } });
  if (!project2) {
    project2 = await prisma.project.create({
      data: {
        project_name: 'Urban Elevated Corridor (Sector 62 to 74)',
        project_code: 'UEC-SEC62',
        budget: '280000000', // ₹28 Crore
        client: 'State Urban Development Authority',
        description: 'Elevated viaduct with pre-cast segmental box girders and integrated multi-modal interchange ramp.',
        progress: 68,
        status: 'IN_PROGRESS',
        start_date: new Date('2023-08-01'),
        end_date: new Date('2025-06-30'),
        total_length: '8.2 km',
        total_chainage: ['Ch. 00+000', 'Ch. 04+100', 'Ch. 08+200'],
        company_id,
        state: 'Uttar Pradesh',
        district: 'Noida',
      }
    });
  }

  // 6. Stocks
  console.log('📦 Populating warehouse inventory stocks...');
  let stockRecord = await prisma.stock.findFirst({
    where: { warehouse_id: warehouseMain.id, project_id: project1.id }
  });
  if (!stockRecord) {
    stockRecord = await prisma.stock.create({
      data: {
        warehouse_id: warehouseMain.id,
        project_id: project1.id,
        company_id,
        stockMaterials: {
          create: [
            { material_id: matCement.id, quantity: 420, current_stock: 420, minimum_threshold_quantity: 500, status: 'LOW_STOCK' },
            { material_id: matSteel.id, quantity: 65, current_stock: 65, minimum_threshold_quantity: 20, status: 'IN_STOCK' },
            { material_id: matAggregates.id, quantity: 1850, current_stock: 1850, minimum_threshold_quantity: 400, status: 'IN_STOCK' },
            { material_id: matBitumen.id, quantity: 28, current_stock: 28, minimum_threshold_quantity: 50, status: 'LOW_STOCK' },
          ]
        }
      }
    });
  }

  // 7. Machinery & Equipment
  console.log('🚜 Adding heavy construction machines...');
  let machine1 = await prisma.machine.findFirst({ where: { name: 'Hydraulic Excavator CAT 320D', project_id: project1.id } });
  if (!machine1) {
    machine1 = await prisma.machine.create({
      data: {
        name: 'Hydraulic Excavator CAT 320D',
        type: 'EXCAVATOR',
        is_owned: true,
        machine_count: 1,
        rent_per_hour: '2200',
        purchase_cost: '8500000',
        company_id,
        project_id: project1.id,
      }
    });
  }

  let machine2 = await prisma.machine.findFirst({ where: { name: 'Tata Tipper 1618 (10-Wheeler)', project_id: project1.id } });
  if (!machine2) {
    machine2 = await prisma.machine.create({
      data: {
        name: 'Tata Tipper 1618 (10-Wheeler)',
        type: 'TIPPER',
        is_owned: true,
        machine_count: 3,
        rent_per_hour: '1200',
        purchase_cost: '3200000',
        company_id,
        project_id: project1.id,
      }
    });
  }

  let machine3 = await prisma.machine.findFirst({ where: { name: 'Komatsu Motor Grader GD535', project_id: project1.id } });
  if (!machine3) {
    machine3 = await prisma.machine.create({
      data: {
        name: 'Komatsu Motor Grader GD535',
        type: 'GRADER',
        is_owned: false,
        machine_count: 1,
        rent_per_hour: '2800',
        purchase_cost: '9200000',
        company_id,
        project_id: project1.id,
      }
    });
  }

  // 8. Activities
  console.log('📋 Creating site activities...');
  let actEarthwork = await prisma.activity.findFirst({ where: { name: 'Sub-Grade Compaction & Embankment' } });
  if (!actEarthwork) {
    actEarthwork = await prisma.activity.create({
      data: { name: 'Sub-Grade Compaction & Embankment', unitId: unitCum.id }
    });
  }

  let actCulvert = await prisma.activity.findFirst({ where: { name: 'RCC Box Culvert Raft Casting' } });
  if (!actCulvert) {
    actCulvert = await prisma.activity.create({
      data: { name: 'RCC Box Culvert Raft Casting', unitId: unitCum.id }
    });
  }

  let actGSB = await prisma.activity.findFirst({ where: { name: 'Granular Sub-Base (GSB) Layer Laying' } });
  if (!actGSB) {
    actGSB = await prisma.activity.create({
      data: { name: 'Granular Sub-Base (GSB) Layer Laying', unitId: unitCum.id }
    });
  }

  // 9. Diesel Consumption Logs
  console.log('⛽ Logging fuel dispensing records...');
  const existingDiesel = await prisma.diesel_consumption.count({ where: { company_id } });
  if (existingDiesel === 0) {
    await prisma.diesel_consumption.createMany({
      data: [
        {
          machine_id: machine1.id,
          activity_id: actEarthwork.id,
          project_id: project1.id,
          company_id,
          diesel_used_liters: 145,
          hours_used: 8,
          operator_name: 'Rajesh Kumar',
          date: new Date('2026-11-01'),
          issued_by: user_id,
          remarks: 'Excavation between Ch. 03+200 and 04+100',
        },
        {
          machine_id: machine1.id,
          activity_id: actEarthwork.id,
          project_id: project1.id,
          company_id,
          diesel_used_liters: 152,
          hours_used: 8,
          operator_name: 'Rajesh Kumar',
          date: new Date('2026-11-02'),
          issued_by: user_id,
          remarks: 'Borrow area excavation',
        },
        {
          machine_id: machine2.id,
          activity_id: actGSB.id,
          project_id: project1.id,
          company_id,
          diesel_used_liters: 95,
          hours_used: 7,
          operator_name: 'Amit Singh',
          date: new Date('2026-11-02'),
          issued_by: user_id,
          remarks: 'Material haulage to paving stretch',
        },
        {
          machine_id: machine3.id,
          activity_id: actGSB.id,
          project_id: project1.id,
          company_id,
          diesel_used_liters: 120,
          hours_used: 7,
          operator_name: 'Sunil Sharma',
          date: new Date('2026-11-03'),
          issued_by: user_id,
          remarks: 'GSB surface leveling & grading',
        },
      ]
    });
  }

  // 10. DPR (Daily Progress Reports)
  console.log('📊 Creating DPR daily site progress entries...');
  const existingDPR = await prisma.dPR.count({ where: { company_id } });
  if (existingDPR === 0) {
    await prisma.dPR.create({
      data: {
        date: new Date('2026-11-02'),
        project_id: project1.id,
        company_id,
        submitted_by: user_id,
        entries: {
          create: [
            {
              site: 'LHS',
              chainage_from: '04+100',
              chainage_to: '04+600',
              category_id: catHighway.id,
              activity_id: actEarthwork.id,
              material_id: matAggregates.id,
              unit_id: unitCum.id,
              length: 500,
              width: 12,
              depth: 0.3,
              quantity: 1800,
              plan_quantity: 1600,
              difference: 200,
              work_description: 'Sub-grade embankment compaction LHS'
            },
            {
              site: 'BHS',
              chainage_from: '07+200',
              chainage_to: '07+230',
              category_id: catStructures.id,
              activity_id: actCulvert.id,
              material_id: matCement.id,
              unit_id: unitCum.id,
              length: 30,
              width: 8,
              depth: 0.5,
              quantity: 120,
              plan_quantity: 120,
              difference: 0,
              work_description: 'Box culvert base slab raft cast'
            }
          ]
        }
      }
    });
  }

  // 11. Vendors & Procurement
  console.log('🤝 Creating vendor and procurement records...');
  let vendorCement = await prisma.vendor.findFirst({ where: { vendor_name: 'Ultratech Building Solutions Pvt Ltd' } });
  if (!vendorCement) {
    vendorCement = await prisma.vendor.create({
      data: {
        vendor_name: 'Ultratech Building Solutions Pvt Ltd',
        contact_number: '+91 9988776655',
        address: 'Barakhamba Road, Connaught Place, New Delhi',
        company_id,
        status: 'ACTIVE',
        vendor_type: 'MATERIAL_SUPPLIER',
        bankDetails: {
          create: {
            bank_name: 'HDFC Bank',
            branch_name: 'Connaught Place',
            account_number: '918273645120',
            ifsc_code: 'HDFC0001234',
          }
        }
      }
    });
  }

  let pr1 = await prisma.pR.findFirst({ where: { pr_code: 'PR-2026-0041' } });
  if (!pr1) {
    pr1 = await prisma.pR.create({
      data: {
        pr_code: 'PR-2026-0041',
        project_id: project1.id,
        company_id,
        user_id,
        status: 'SUBMITTED',
        pr_type: 'PROCUREMENT',
        remarks: 'Urgent requisition for upcoming bridge pier deck concrete pour',
        material_items: {
          create: [
            {
              material_id: matCement.id,
              quantity: '800',
              required_date: new Date('2026-11-15'),
            },
            {
              material_id: matSteel.id,
              quantity: '45',
              required_date: new Date('2026-11-15'),
            }
          ]
        }
      }
    });
  }

  let po1 = await prisma.pO.findFirst({ where: { po_code: 'PO-2026-0812' } });
  if (!po1 && pr1 && vendorCement) {
    po1 = await prisma.pO.create({
      data: {
        po_code: 'PO-2026-0812',
        pr_id: pr1.id,
        project_id: project1.id,
        company_id,
        vendor_id: vendorCement.id,
        total_amount: '1240000',
        po_status: 'ISSUED',
        shipping_address: 'NH-48 Site Camp, Km 18 Stone, Gurugram',
        order_items: {
          create: [
            {
              material_id: matCement.id,
              quantity: '800',
              rate: '410',
              amount: '328000',
            }
          ]
        }
      }
    });
  }

  console.log('✅ Demo ERP construction dataset created successfully!');
}

seedDemoData()
  .catch((e) => {
    console.error('❌ Seeding error:', e);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
