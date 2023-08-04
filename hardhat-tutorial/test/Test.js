//import { ethers } from "ethers";
//import { expect } from "chai";
//import { TroopFactory } from "./contracts/TroopFactory.sol";

const { expect } = require("chai");

describe("TroopFactory", () => {
  let troopFactory;

  beforeEach(async () => {
    troopFactory = await ethers.getContractFactory("TroopFactory");
  });

  it("should generate a random number between 0 and 10,000", async () => {
    const troop = await troopFactory.deploy({
      args: ["Ranger", 2, 100, 5],
    });
    const randomNumber = await troop.call("_generateRngHit");
    expect(randomNumber).to.be.between(0, 10000);
  });
});