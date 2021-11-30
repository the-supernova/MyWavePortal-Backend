const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log(`Deployed WavePortal at ${waveContract.address}`);
    console.log(`Contract deployed by ${owner.address}`);

    let waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    let waveTxn = await waveContract.wave('Sup?');
    await waveTxn.wait();

    // waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave('Another message!');
    await waveTxn.wait();

    // waveCount = await waveContract.getTotalWaves();

    // waveTxn = await waveContract.connect(randomPerson).wave();
    // await waveTxn.wait();

    // waveCount = await waveContract.getTotalWaves();

    // let [maxWallet, maxWaves] = await waveContract.getMaxWaves();
    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
};

const runMain = async () => {   
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
};

runMain();