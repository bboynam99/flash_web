
async function getAmount4Farm(index, account, tokenAddress, poolAddress) {
    console.log('index: '+ index + '; account: ' + account + '; tokenAddress: ' + tokenAddress + '; poolAddress: ' + poolAddress);
    let balanceAmount = '0';
    let code = 0;
    if (index == '0') {
        tronWeb.trx.getUnconfirmedBalance(account).then(result => {
            balanceAmount = result;
        }).catch(e => {
                console.log('getUnconfirmedBalance error:' + JSON.stringify(e));
                code = 1;
               });
    } else {
        let tokenObj = await tronWeb.contract().at(tokenAddress);
        balanceAmount = await tokenObj.balanceOf(account).call().catch(e => {
            console.log('getAmount4Farm balanceOf error:' + JSON.stringify(e));
            code = 1;
        });
    }

    let poolObj = await tronWeb.contract().at(poolAddress);
    let depositedAmount = await poolObj.balanceOf(account).call().catch(e => {
        console.log('getAmount4Farm balanceOf error:' + JSON.stringify(e));
        code = 1;
    });
    let harvestedAmount = await poolObj.earned(account).call().catch(e => {
        console.log('getAmount4Farm earned error:' + JSON.stringify(e));
        code = 1;
    });

     if (code == 1) {
         return;
     }

    setTokenAmount4Farm(index, tokenAddress, balanceAmount, depositedAmount, harvestedAmount);
 }


async function allowance4Farm(tokenType, stakeAmount, account, tokenAddress, poolAddress) {
    console.log('allowance4Farm tokenType: ' + tokenType + '; stakeAmount: ' + stakeAmount);
    console.log('allowance4Farm account: ' + account + '; tokenAddress: ' + tokenAddress + '; poolAddress: ' + poolAddress);
    let tokenObj = await tronWeb.contract().at(tokenAddress);
    let code = 0;
    let result = await tokenObj.allowance(account, poolAddress).call().catch(e => {
         console.log('allowance4Farm error:' + JSON.stringify(e));
         code = 1;
    });

    if (code == 1) {
        return;
    }
    setAllowance4Farm(tokenType, stakeAmount, tokenAddress, poolAddress, result);
}

async function approve4Farm(tokenType, stakeAmount, tokenAddress, poolAddress) {
    let tokenObj = await tronWeb.contract().at(tokenAddress);
    let code = 0;
    let result = await tokenObj.approve(poolAddress, '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff').send({
        feeLimit: 10000000
    }).catch(e => {
        console.log('approve4Farm error:' + JSON.stringify(e));
        code = 1;
   });

    if (code == 1) {
        return;
    }

    setStake4Farm(tokenType, stakeAmount, poolAddress);
}


async function stake4Farm(tokenType, amount, poolAddress) {
    console.log('stake4Farm tokenType: ' + tokenType + '; amount: ' + amount + '; poolAddress: ' + poolAddress);
    let poolObj = await tronWeb.contract().at(poolAddress);
    let code = 0;
    let result = '';
    if (tokenType == '1') {
        result = await poolObj.stake().send({
         callValue: amount.toString(),
         feeLimit: 10000000
        }).catch(e => {
            console.log('stake4Farm error:' + JSON.stringify(e));
            code = 1;
        });
    } else {
        result = await poolObj.stake(amount.toString()).send({
        feeLimit: 10000000
       }).catch(e => {
            console.log('stake4Farm error:' + JSON.stringify(e));
            code = 1;
       });
    }

    if (code == 1) {
        return;
    }

    console.log("stake4Farm result: " + result);
    setHash4Farm(1, result);
}


async function withdraw4Farm(amount, poolAddress) {
    let poolObj = await tronWeb.contract().at(poolAddress);
    let code = 0;
    let result = await poolObj.withdraw(amount.toString()).send({feeLimit: 10000000}).catch(e => {
        console.log('withdraw4Farm error:' + JSON.stringify(e));
        code = 1;
    });

    if (code == 1) {
        return;
    }

    console.log("withdraw4Farm result: " + result);
    setHash4Farm(2, result);
}

async function getReward4Farm(poolAddress) {
    let poolObj = await tronWeb.contract().at(poolAddress);
    let code = 0;
    let result = await poolObj.getReward().send({feeLimit: 10000000}).catch(e => {
        console.log('getReward4Farm error:' + JSON.stringify(e));
        code = 1;
    });

    console.log("getReward4Farm result: " + result);
    setHash4Farm(3, result);
}


