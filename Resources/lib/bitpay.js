function BitPay() {

}
BitPay.prototype.init = function () {}

//pass a custom config object, or use the Ti.App.xml file
BitPay.configure = function (config) {
    if (config != undefined) {
        this.API_URL = config.API_URL
        this.API_KEY = config.API_KEY
        this.API_CURRENCY = config.API_CURRENCY
    } else {
        //defaults from Ti.App.xml
        this.API_URL = Ti.App.Properties.getString('bitpayapi')
        this.API_KEY = Ti.App.Properties.getString('bitpayapikey')
        this.API_CURRENCY = Ti.App.Properties.getString('bitpaycurrency')
    }
}

BitPay.createButton = function(){
    var btn = Titanium.UI.createImageView({
        top:10,
        width:'30%',
        image:'/images/bitpaybutton.png'
    });
    return btn;
}

BitPay.getCurrency = function () {
    return this.API_CURRENCY
}

BitPay.getAPIKey = function () {
    return this.API_KEY
}

BitPay.getAPI = function () {
    return this.API_URL
}

BitPay.remote = function (method, url) {
    var xhr_remote = Titanium.Network.createHTTPClient({
        validatesSecureCertificate: true,
    });
    xhr_remote.open(method, url);
    return xhr_remote;

}

BitPay.sendTransaction = function (item) {

    var that = this
    var xhr = this.remote("POST", this.getAPI());
    item.currency = this.getCurrency()
    item.app_api_key = this.getAPIKey()
    xhr.send(item)
    xhr.onerror = function () {
        var errd = Titanium.UI.createAlertDialog({
            title: 'Error',
            message: this.responseText,
            buttonNames: ['OK']
        })
        errd.show();
    }

    xhr.onload = function () {
        var response = JSON.parse(this.responseText)
        if (response.status == 'success') {
            if (that.isAndroid()) {
                that.showAndroidModal(response)
            } else {
                that.showIOSModal(response)
            }
        } else {
            var errd = Titanium.UI.createAlertDialog({
                title: 'Error',
                message: response.msg,
                buttonNames: ['OK']
            })
            errd.show();
        }
    }
}


BitPay.showAndroidModal = function (obj) {
    Titanium.Platform.openURL(obj.invoice_url)
}

BitPay.showIOSModal = function (obj) {

    var bitpayWebview = Titanium.UI.createWebView({
        url: obj.invoice_url,
    });
    console.log('bitpayWebview.url', bitpayWebview.url)

    var bitpayWebwin = Titanium.UI.createWindow({
        top: 20,
        backgroundColor: '#5E7DE4',
        layout: 'vertical',
    });

    var headerView = Titanium.UI.createView({
        height: 40,
        left: 0,
        right: 0,
        backgroundColor: '#0A2047'
    });
    bitpayWebwin.add(headerView)

    var closeLbl = Titanium.UI.createLabel({
        left: 20,
        color: '#fff',
        text: 'Close'
    });
    headerView.add(closeLbl)

    var transLbl = Titanium.UI.createLabel({
        right: 10,
        color: '#fff',
        font: {
            fontSize: 12
        },
        text: obj.invoice_id
    });
    headerView.add(transLbl)

    closeLbl.addEventListener('click', function () {
        bitpayWebwin.close();
    });

    bitpayWebwin.add(bitpayWebview)
    bitpayWebwin.open({
        modal: true
    })
    bitpayWebwin.addEventListener('close',function(){
        clearInterval(invoiceResponse);
        
    })

    var invoiceResponse = setInterval(checkInvoiceStatus, 3000);

    function checkInvoiceStatus() {
        //console.log('html',bitpayWebview.html.toString());
        var bpstring = bitpayWebview.html.toString()
        console.log('here')
        var pos = bpstring.indexOf('This invoice has been paid.')
        if (pos != -1) {
            //paid, lets lose this
            stopInvoiceStatus()
        }

        //This invoice has been paid.
    }

    function stopInvoiceStatus() {
        console.log('FOUND LETS CLOSE')

        clearInterval(invoiceResponse);
        var cartMsg = Titanium.UI.createAlertDialog({
            title:'Transaction Complete',
            message:'Thank you for your purchase.  Please check your email for details.',
            buttonNames:['OK']
        });
        cartMsg.show()
        cartMsg.addEventListener('click',function(){
            bitpayWebwin.close()
        })
       
        
    }




    //This invoice has been paid.


}


//platform detection
BitPay.isAndroid = function () {
    var isAndroid = false;
    var isIOS = false;
    var isSimulator = false;

    if (Titanium.Platform.model == 'Simulator') {
        isSimulator = true;
    }
    if (Titanium.Platform.osname == 'android') {
        isAndroid = true;
        isIphone = false;
        isIphone5 = false;
        isIpad = false;
    }
    if (Titanium.Platform.osname == 'iphone' || Titanium.Platform.osname == 'ipad') {
        isIOS = true;
        isAndroid = false;
        isIphone = false;
        isIpad = true;
    }

    if (Titanium.Platform.osname == 'iphone') {
        isAndroid = false;
        isIphone = true;
        isIpad = false;
    }

    if (Titanium.Platform.osname == 'ipad') {
        isAndroid = false;
        isIphone = false;
        isIpad = true;
    }
    return isAndroid
} //end isAndroid

module.exports = BitPay;