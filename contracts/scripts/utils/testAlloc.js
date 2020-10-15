const addresses = require('../../utils/addresses');
const { ethers, getNamedAccounts } = require("@nomiclabs/buidler");

async function main() {
  const sGovernor = ethers.provider.getSigner('0x52BEBd3d7f37EC4284853Fd5861Ae71253A7F428');
  const vault = (await ethers.getContractAt("IVault", addresses.mainnet.VaultProxy)).connect(sGovernor);
  await vault.allocate({ gasLimit: 2000000 });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
