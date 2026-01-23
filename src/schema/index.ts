import * as user from './user';
import * as admin from './admin';
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
import * as sub_contractor from './sub_contractor';
import * as unit from './unit';
import * as vendor from './vendor';
import * as vendor_supply_management from './vendor_supply_management';
import * as enums from './enums';
import * as location from './location';
import * as inventory_manager from './inventory_manager';

export * from './user';
export * from './admin';
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
export * from './sub_contractor';
export * from './unit';
export * from './vendor';
export * from './vendor_supply_management';
export * from './enums';
export * from './location';
export * from './inventory_manager';

export const allModels = {
  ...user,
  ...admin,
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
  ...sub_contractor,
  ...unit,
  ...vendor,
  ...vendor_supply_management,
  ...enums,
  ...location,
  ...inventory_manager,
};
