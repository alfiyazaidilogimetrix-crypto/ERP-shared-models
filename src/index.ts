import prisma from "./config/prisma";
export * from "./schema/user";
export * from "./schema/admin";
export * from "./schema/mail";
export * from "./schema/otp";
export * from "./lib/tools";
export * from "./lib/env";

export { prisma };
export default prisma;
