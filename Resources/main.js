var win;
var BitPay = require('lib/bitpay');
BitPay.configure({
    ENV: 'dev'
})

exports.getMain = function () {
    //clear the clipboard just in case

    win = Titanium.UI.createWindow({
        backgroundColor: '#fff',
        navTintColor: "fff",
    });

    var headerView = Titanium.UI.createView({
        top: 0,
        left: 0,
        right: 0,
        height: 60,
        backgroundColor: '#2C418B'
    })
    win.add(headerView)

    var hlabel = Titanium.UI.createLabel({
        top: 25,
        color: '#fff',
        text: 'My Store',
        font: {
            fontSize: 18,
            fontWeight: 'bold'
        }
    })
    headerView.add(hlabel)

    var buyBtnBTC = Titanium.UI.createLabel({
        top: 200,
        width: 200,
        height: 40,
        color: '#fff',
        backgroundColor: '#2C418B',
        text: 'Buy with Bitcoin',
        textAlign: 'center',
        borderRadius: 10,
        font: {
            fontSize: 12
        }
    })
    win.add(buyBtnBTC)

    var buyBtnBCH = Titanium.UI.createLabel({
        top: 250,
        width: 200,
        height: 40,
        color: '#fff',
        backgroundColor: '#2C418B',
        text: 'Buy with Bitcoin Cash',
        textAlign: 'center',
        borderRadius: 10,
        font: {
            fontSize: 12
        }
    })
    win.add(buyBtnBCH)

    var buyBtnWeb = Titanium.UI.createLabel({
        top: 300,
        width: 250,
        height: 40,
        color: '#fff',
        backgroundColor: '#2C418B',
        text: 'Let user choose (webview presentation only)',
        textAlign: 'center',
        borderRadius: 10,
        font: {
            fontSize: 12
        }
    })
    win.add(buyBtnWeb)


    //paymentLbl and its functionality is just a demo placeholder to open a webview
    var paymentLbl = Titanium.UI.createLabel({
        top: 350,
        left: 10,
        right: 10,
        height: 'auto',
        color: '#2C418B',
        backgroundColor: '#fff',
        text: '<url will appear here></url>',
        textAlign: 'center',
        font: {
            fontSize: 12
        }
    })
    win.add(paymentLbl)

    paymentLbl.addEventListener('click', function () {
        if (this.text != '<url will appear here></url>') {
            Titanium.Platform.openURL(this.text)
        }
    })

    //paymentLbl and its functionality is just a demo placeholder to open a webview
    var walletLbl = Titanium.UI.createLabel({
        bottom: 0,
        left: 0,
        right: 0,
        height: 60,
        color: '#fff',
        backgroundColor: '#2C418B',
        text: 'OPEN IN WALLET',
        textAlign: 'center',
        font: {
            fontSize: 20
        },
        _link: null,
    })
    win.add(walletLbl)

    walletLbl.addEventListener('click', function () {
        if (this._link != null) {
            Titanium.Platform.openURL(this._link)
        }
    })

    paymentLbl.addEventListener('click', function () {
        if (this.text != '<url will appear here></url>') {
            Titanium.Platform.openURL(this.text)
        }
    })


    /***BITPAY BUTTON LOGIC***/
    buyBtnBTC.addEventListener('click', function () {
        doCheckout('BTC')
    })
    buyBtnBCH.addEventListener('click', function () {
        doCheckout('BCH')
    })
    buyBtnWeb.addEventListener('click', function () {
        doCheckout('-')
    })

    function doCheckout(crypto = 'BTC', callback = false) {
        var BitPayResponse
        //this is where you can pass your item to the function or define directly
        //set the cryptocurrency support by creating an array
        if (!callback) {
            hlabel.text = 'Generating....'
            var item = {
                'sku': 'item_sku',
                'description': 'description goes here',
                'price': parseFloat(1.00), //pass your price
            }
            //use the 'crypto' variable that was passed to specify which crypto currency you want to use
            BitPay.sendTransaction(item, crypto)
        }

        //wait for the status to be set
        BitPayResponse = BitPay.getLastTransaction()
        if (BitPayResponse == null) {
            setTimeout(function () {
                doCheckout(crypto, true)
            }, 1000);

        } else {
            hlabel.text = 'My Store'
            BitPay.clearLastTransaction()
            //now you have a response and can access like so

            //to open in a wallet on the users device, use the following
            var walletLink
            switch (crypto) {
                case 'BTC':
                    walletLink = BitPayResponse.paymentCodes.BTC.BIP72b
                    walletLbl._link = walletLink
                    walletLbl.touchEnabled = true
                    walletLbl.text = 'OPEN IN WALLET'

                    break;
                case 'BCH':
                    walletLink = BitPayResponse.paymentCodes.BCH.BIP72b
                    walletLbl._link = walletLink
                    walletLbl.touchEnabled = true
                    walletLbl.text = 'OPEN IN WALLET'

                    break;
                case '-':
                    walletLink = BitPayResponse.url
                    walletLbl.touchEnabled = true
                    walletLbl._link = BitPayResponse.url
                    walletLbl.text = 'OPEN IN WEBVIEW'

                    break;

            }

            //use THIS to show the actual link so a user can copy and paste into their preferred wallet
            //this was set in the bitpay module
            var cryptoUrl = BitPayResponse.url
            paymentLbl.text = cryptoUrl

        }
    }

    /*********/

    return win

};
