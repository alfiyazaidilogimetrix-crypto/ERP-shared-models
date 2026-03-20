import * as user from './user';
import * as mail from './mail';
import * as otp from './otp';
import * as file from './file';
import * as project from './project';
import * as dpr from './dpr';
import * as grn from './grn';
import * as po from './po';
import * as pr from './pr';
import * as category from './category';
import * as chainage from './chainage';
import * as diesel from './diesel';
import * as labour from './labour';
import * as material from './material';
import * as modules from './modules';
import * as permission from './permission';
import * as role from './role';
import * as unit from './unit';
import * as vendor from './vendor';
import * as vendor_supply_management from './vendor_supply_management';
import * as enums from './enums';
import * as location from './location';
import * as invoice from './invoice';
import * as activity from './activity';
import * as labour_attendance from './labour_attendance';
import * as stock from './stock';
import * as prgrn from './pr-grn';
import * as material_boq from './material_boq';
import * as workscope from './workscope';
import * as sub_contractor_work_order from './sub_contractor_work_order';
import * as project_type from './ProjectType';
import * as project_category from './project_category';
import * as work_order_items from './work_order_items';

export * from './user';
export * from './mail';
export * from './otp';
export * from './file';
export * from './project';
export * from './dpr';
export * from './grn';
export * from './po';
export * from './pr';
export * from './category';
export * from './chainage';
export * from './diesel';
export * from './labour';
export * from './material';
export * from './modules';
export * from './permission';
export * from './role';
export * from './unit';
export * from './vendor';
export * from './vendor_supply_management';
export * from './enums';
export * from './location';
export * from './invoice';
export * from './activity';
export * from './labour_attendance';
export * from './stock';
export * from './pr-grn';
export * from './material_boq';
export * from './workscope';
export * from './sub_contractor_work_order';
export * from './ProjectType';
export * from './project_category';
export * from './work_order_items';

export const allModels = {
  ...user,
  ...mail,
  ...otp,
  ...file,
  ...project,
  ...dpr,
  ...grn,
  ...po,
  ...pr,
  ...category,
  ...chainage,
  ...diesel,
  ...labour,
  ...material,
  ...modules,
  ...permission,
  ...role,
  ...unit,
  ...vendor,
  ...vendor_supply_management,
  ...enums,
  ...location,
  ...invoice,
  ...activity,
  ...labour_attendance,
  ...stock,
  ...prgrn,
  ...material_boq,
  ...workscope,
  ...sub_contractor_work_order,
  ...project_type,
  ...project_category,
  ...work_order_items,
};
