async function main() {
    const HLXtokenAddress = "0xa4F8B6B8a372A53a423a869CD614Ea76Ac737F67";
    const recepientAddress = '0x2C0067c5F6024CF9b6A62eDb6631B2826eFa0073';

    const transfer_entry = await ethers.getContractFactory("TransferEntry");
    

    //const transfer_entry_contract = await transfer_entry.deploy(HLXtokenAddress);   
    const transfer_entry_contract = await transfer_entry.attach(
      "0xCB5B28A79317d62e858fb2bC9ef65227c9A5eF45" // The deployed contract address
    );

    const token_Address = await transfer_entry_contract.getTokenAddress();
    const token_balance = await transfer_entry_contract.getTokenBalance();
//    await transfer_entry_contract.approve(15);

    const HLXContractFactory = await ethers.getContractFactory("HLXToken");
    const HLXContract = await HLXContractFactory.attach(HLXtokenAddress);
    await  HLXContract.approve(transfer_entry_contract.address, 15);  
    await transfer_entry_contract.send(15, recepientAddress);

    const contract_balance = await transfer_entry_contract.getContractBalance();

    //  await transfer_entry_contract.send(1);
    console.log("Contract deployed to address:", transfer_entry_contract.address);
    console.log("HLX token_balance :", token_balance);
    console.log("Contract token_balance :", contract_balance);

    /*
    // contract address 0x8A17Fde135342D351dc0e876e9f188763a7EefFe
    const transfer_entry = await ethers.getContractFactory("HLXToken");
    const transfer_entry_contract = await transfer_entry.deploy();   
    console.log("Contract deployed to address:", transfer_entry_contract.address);
    0xa4F8B6B8a372A53a423a869CD614Ea76Ac737F67
    */
  }
 
 main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });