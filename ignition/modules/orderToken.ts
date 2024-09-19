import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const orderTokenModule = buildModule("orderTokenModule", (m) => {

  const OrderToken = m.contract("OrderToken");

  return { OrderToken };
});

export default orderTokenModule;
